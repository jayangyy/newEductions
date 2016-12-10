/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.FilterRule;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.model.Special_Job_Card;
import cr.cdrb.web.edu.model.Special_Job_Type;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.SpecialJobCardService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 *
 * @author milord
 */
@Controller
@RequestMapping("specialjob/")
public class SpecialJobCardController {

    @Resource(name="configMap")
    private Map config;
    private List<Special_Job_Type> sjtArr;
    @Autowired
    SpecialJobCardService service;
    
    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) throws Exception {
        sjtArr = service.getAllSpecialJobType();
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iseduuser = false;
        boolean iszjcuser = false;
        for (Role r : user.getRoles()) {
            if(r.getRolename().equals("ROLE_EDU"))
                iseduuser = true;
        }
        request.setAttribute("iseduuser", iseduuser);
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        request.setAttribute("usercompanyid", user.getCompanyId());
        return "specialjob/list";
    }
    @RequestMapping(value = "/")
    public String getUpPage() {
        return "specialjob/list";
    }
    
    @RequestMapping(value = "edit")
    public String getEditPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        request.setAttribute("usercompanyid", user.getCompanyId());
        return "specialjob/edit";
    }
    
    @RequestMapping(value = "allCards", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllCards(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();//model.getPage() - 1) * rows;
        String sort = StringUtils.isBlank(model.getSort()) ? "reviewdate" : model.getSort();
        String order = StringUtils.isBlank(model.getOrder()) ? "asc" : model.getOrder();
        List<String> param = new ArrayList<>();
        
        String whereStr = "1=1";
        List<FilterRule> frlist = JSON.parseArray(model.getFilterRules(), FilterRule.class);
        if (frlist != null) {
            for (FilterRule item : frlist) {
                String field = item.getField();
                String op = item.getOp();
                String value = item.getValue();
                switch (op) {
                    case "equals":
                        whereStr += " and " + field + " = ?";
                        param.add(value);
                        break;
                    case "contains":
                        whereStr += " and " + field + " like ?";
                        param.add("%" + value + "%");
                        break;
                    case "less":
                        whereStr += " and " + field + " > ?";
                        param.add(value);
                        break;
                    case "greater":
                        whereStr += " and " + field + " < ?";
                        param.add(value);
                        break;
                    case "custom":
                        if(field.equals("reviewdate")){
                            String[] temp = value.split("@");
                            String begindate = temp[0];
                            String enddate = temp.length==1?"":value.split("@")[1];
                            if(!begindate.equals("") && !enddate.equals("")){
                                whereStr += " and " + field + " between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd')";
                                param.add(begindate);
                                param.add(enddate);
                            }else if(!begindate.equals("")){
                                whereStr += " and " + field + " > to_date(?,'yyyy-mm-dd')";
                                param.add(begindate);
                            }else if(!enddate.equals("")){
                                whereStr += " and " + field + " < to_date(?,'yyyy-mm-dd')";
                                param.add(enddate);
                            }
                        }
                        break;
                }
            }
        }
        return JSON.toJSONString(service.getSpecialJobCardPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray()));
    }
    
    @RequestMapping(value = "validuser", method = RequestMethod.GET)
    @ResponseBody
    public Object getUserInfoByPid(String pid,boolean iszjcuser) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        return service.getUserInfoByPid(pid.toUpperCase(),user.getCompanyId(),iszjcuser);
    }
    
    @RequestMapping(value = "getUser", method = RequestMethod.GET)
    @ResponseBody
    public Object getUserByName(String name,boolean iszjcuser) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        return service.getUserByName(name,user.getCompanyId(),iszjcuser);
    }
    
    @RequestMapping(value = "addCard", method = RequestMethod.POST)
    @ResponseBody
    public Object insertSpecialJobCard(Special_Job_Card card) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        card.setOptuserid(user.getUsername());
        card.setOptusername(user.getWorkername());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        card.setOptdate(df.format(new Date()));
        card.setCompanyid(user.getCompanyId());
        return service.insertSpecialJobCard(card);
    }
    
    @RequestMapping(value = "card/{oldcardno}", method = RequestMethod.POST)
    @ResponseBody
    public Object updateSpecialJobCard(Special_Job_Card card, @PathVariable String oldcardno) throws Exception {
        return service.updateSpecialJobCard(card, oldcardno);
    }
    
    @RequestMapping(value = "card/{cardno}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteSpecialJobCard(@PathVariable String cardno) throws Exception {
        return service.deleteSpecialJobCard(cardno);
    }
    
    @RequestMapping(value = "card/{card_no}", method = RequestMethod.GET)
    @ResponseBody
    public Object getSpecialJobCardByCardNo(@PathVariable String card_no) throws Exception {
        return service.getSpecialJobCardByCardNo(card_no);
    }
    
    @RequestMapping(value = "sjtype", method = RequestMethod.GET)
    @ResponseBody
    public Object getSpecialJobType(String fcode) throws Exception {
        return service.getSpecialJobType(fcode);
    }
    
    @RequestMapping(value = "reviewcard", method = RequestMethod.POST)
    @ResponseBody
    public Object reviewSpecialJobCard(String cardnos, String reviewdate) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        return service.reviewSpecialJobCard(cardnos, reviewdate, user.getUsername().toUpperCase());
    }
    
    @RequestMapping(value = "getAllUnit", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllUnit() throws Exception {
        return service.getAllUnit((String) config.get("zjcunitid"));
    }
    
    @RequestMapping(value = "getDepartmentTree", method = RequestMethod.GET)
    @ResponseBody
    public Object getDepartmentTreeByDwid(String dwid) throws Exception {
        return service.getDepartmentTreeByDwid(dwid);
    }
    
    @RequestMapping(value = "importexcel", method = RequestMethod.POST)
//    @ResponseBody
    public void upload(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        EduUser user = UsersService.GetCurrentUser();
        String zjcunitid = (String) config.get("zjcunitid");
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        
        PrintWriter out = response.getWriter();
//        response.setContentType("application/json");
        Map<Boolean, String> resultMap = new HashMap<>();
        Special_Job_Card card;
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> mapLinkList = multipartRequest.getFileMap();
        MultipartFile file = null;
        for (String mf : mapLinkList.keySet()) {
            file = mapLinkList.get(mf);
        }
        if (file == null) {
            resultMap.put(false, "操作失败，excel文件读取失败！");
        } else {
            InputStream input = file.getInputStream();
            Workbook workBook;
            if (file.getOriginalFilename().contains(".xlsx")) {
                workBook = new XSSFWorkbook(input);
            } else {
                workBook = new HSSFWorkbook(input);
            }
            Sheet sheet = workBook.getSheetAt(0);
            if (sheet != null) {
                String errRowIndex = "";
                for (int i = 2; i < sheet.getPhysicalNumberOfRows(); i++) {
                    card = new Special_Job_Card();
                    Row row = sheet.getRow(i);
                    if (hasEmptyValue(row, 8)) {
                        errRowIndex += (i - 1) + ",";
                        continue;
                    }
                    
                    Special_Job_Type sjt = getSJTCodeByName(row.getCell(2).toString(), "");
                    if (sjt == null) {
                        errRowIndex += (i - 1) + ",";
                        continue;
                    }
                    card.setLbcode(sjt.getCode());
                    sjt = getSJTCodeByName(row.getCell(3).toString(), sjt.getCode());
                    if (sjt == null) {
                        errRowIndex += (i - 1) + ",";
                        continue;
                    }
                    card.setXmcode(sjt.getCode());
                    String pid = row.getCell(1).toString().toUpperCase();
                    DataModel dm = service.getUserInfoByPid(pid,user.getCompanyId(),iszjcuser);
                    EduUser _user = (EduUser) dm.getRows();
                    if (_user == null) {
                        errRowIndex += (i - 1) + ",";
                        continue;
                    }
                    
                    card.setName(_user.getWorkername());
                    card.setSex(_user.getSex());
                    
                    card.setCard_no(row.getCell(0).toString());
                    card.setPid(pid);
                    card.setCert_no("T"+pid);
                    card.setZylb(row.getCell(2).toString());
                    card.setZcxm(row.getCell(3).toString());
                    card.setFirstdate(row.getCell(4).toString());
                    card.setValid_begin_date(row.getCell(5).toString());
                    card.setValid_end_date(row.getCell(6).toString());
                    card.setReviewdate(row.getCell(7).toString());
                    dm = service.insertSpecialJobCard(card);
                    if(!dm.getResult())
                        errRowIndex += (i - 1) + ",";
                }
                if (!errRowIndex.equals("")) {
                    resultMap.put(true, "操作完成<br>其中第[" + errRowIndex.substring(0, errRowIndex.length() - 1) + "]条数据保存失败！<br>请检查导入数据<br>1：是否有空的值；<br>2：卡号是否已经存在；<br>3：用户作业类别与准操项目是否已经存在；<br>4：用户身份证号是否匹配；<br>5：导入用户是否属于本单位(职教处可导入所有单位用户)；<br>6：作业类别和准操项目是否输入错误；");
                } else {
                    resultMap.put(true, "操作完成！");
                }
                
            } else {
                resultMap.put(false, "操作失败，excel中第一页数据获取失败！");
            }
        }
//        return new DataModel().withInfo("1111111111");
        Boolean key = (Boolean) resultMap.keySet().toArray()[0];
        if (key) {
            out.printf(JSON.toJSONString(new DataModel().withInfo(resultMap.get(key))));
//            return new DataModel().withInfo(resultMap.get(key));
        } else {
            out.printf(JSON.toJSONString(new DataModel().withErr(resultMap.get(key))));
//            return new DataModel().withErr(resultMap.get(key));
        }
    }
    
    private boolean hasEmptyValue(Row row, int cellLength) {
        boolean result = false;
        for (int i = 0; i < cellLength; i++) {            
            Cell cell = row.getCell(i);            
            if (cell == null) {
                result = true;
                break;
            }
        }
        return result;
    }
    
    private Special_Job_Type getSJTCodeByName(String name, String fcode) {
        Special_Job_Type _entity = null;
        for (int i = 0; i < sjtArr.size(); i++) {
            if (sjtArr.get(i).getName().equals(name) && sjtArr.get(i).getParentcode().equals(fcode)) {
                _entity = sjtArr.get(i);
                break;
            }
        }
        return _entity;
    }
}
