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
import cr.cdrb.web.edu.model.Special_User_Card;
import cr.cdrb.web.edu.model.Special_User_Exam;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.DicSpecialEquipmentService;
import cr.cdrb.web.edu.services.SpecialJobCardService;
import cr.cdrb.web.edu.services.SpecialUserCardService;
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
@RequestMapping("specialuser/")
public class SpecialUserCardController {

    @Resource(name="configMap")
    private Map config;
    
    @Autowired
    SpecialUserCardService service;
    @Autowired
    DicSpecialEquipmentService ds;
    @Autowired
    SpecialJobCardService sjcs;
    
    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) throws Exception {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iseduuser = false;
        for (Role r : user.getRoles()) {
            if(r.getRolename().equals("ROLE_EDU"))
                iseduuser = true;
        }
        request.setAttribute("iseduuser", iseduuser);
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        request.setAttribute("usercompanyid", user.getCompanyId());
        return "specialuser/list";
    }
    @RequestMapping(value = "/")
    public String getUpPage() {
        return "specialuser/list";
    }
    
    @RequestMapping(value = "edit")
    public String getEditPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        return "specialuser/edit";
    }
    
    @RequestMapping(value = "editexam")
    public String getEditExamPage() {
        return "specialuser/editexam";
    }
    
    @RequestMapping(value = "allCards", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllCards(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();//model.getPage() - 1) * rows;
        String sort = StringUtils.isBlank(model.getSort()) ? "card_no" : model.getSort();
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
                        if("no".equals(field)){
                            whereStr += " and (pid like ? or card_no like ? or archives_no like ?)";
                            param.add("%" + value + "%");
                            param.add("%" + value + "%");
                            param.add("%" + value + "%");
                        }
                        break;
                }
            }
        }
        return JSON.toJSONString(service.getSpecialUserCardPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray()));
    }
    
    @RequestMapping(value = "card/{pid}", method = RequestMethod.GET)
    @ResponseBody
    public Object getSpecialUserCardByPid(@PathVariable String pid) throws Exception {
        return service.getSpecialUserCardByPid(pid.toUpperCase());
    }
    
    @RequestMapping(value = "addCard", method = RequestMethod.POST)
    @ResponseBody
    public Object insertSpecialUserCard(Special_User_Card card) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        card.setOptuserid(user.getUsername());
        card.setOptusername(user.getWorkername());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        card.setOptdate(df.format(new Date()));
        card.setCompanyid(user.getCompanyId());
        return service.insertSpecialUserCard(card);
    }
    
    @RequestMapping(value = "card", method = RequestMethod.POST)
    @ResponseBody
    public Object updateSpecialUserCard(Special_User_Card card) throws Exception {
        return service.updateSpecialUserCard(card);
    }
    
    @RequestMapping(value = "card/{pid}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteSpecialUserCard(@PathVariable String pid) throws Exception {
        return service.deleteSpecialUserCard(pid.toUpperCase());
    }
    
    @RequestMapping(value = "allExams", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllExams(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();//model.getPage() - 1) * rows;
        String sort = StringUtils.isBlank(model.getSort()) ? "id" : model.getSort();
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
                        break;
                }
            }
        }
        return JSON.toJSONString(service.getSpecialUserExamPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray()));
    }
    
    @RequestMapping(value = "exam/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object getSpecialUserExamById(@PathVariable String id) throws Exception {
        return service.getSpecialUserExamById(id);
    }
    
    @RequestMapping(value = "exam/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteSpecialUserExam(@PathVariable String id) throws Exception {
        return service.deleteSpecialUserExam(id);
    }
    
    @RequestMapping(value = "addExam", method = RequestMethod.POST)
    @ResponseBody
    public Object insertSpecialUserExam(Special_User_Exam exam) throws Exception {
        return service.insertSpecialUserExam(exam);
    }
    
    @RequestMapping(value = "editExam", method = RequestMethod.POST)
    @ResponseBody
    public Object updateSpecialUserExam(Special_User_Exam exam) throws Exception {
        return service.updateSpecialUserExam(exam);
    }
    
    @RequestMapping(value = "validcode", method = RequestMethod.GET)
    @ResponseBody
    public Object getSpecialEquipmentByCode(String code) throws Exception {
        return ds.getSpecialEquipmentByCode(code);
    }
    
    @RequestMapping(value = "importexcel", method = RequestMethod.POST)
    public void upload(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        EduUser user = UsersService.GetCurrentUser();
        String zjcunitid = (String) config.get("zjcunitid");
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        PrintWriter out = response.getWriter();
        Map<Boolean, String> resultMap = new HashMap<>();
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
                Special_User_Card card;
                Special_User_Exam exam;
                String pid="";
                for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
                    Row row = sheet.getRow(i);
                    if(row.getCell(0) != null && !"".equals(row.getCell(0).toString())){
                        if (hasEmptyValue(row,0, 3)) {
                            errRowIndex += (i - 1) + ",";
                            continue;
                        }
                        pid = row.getCell(0).toString().toUpperCase();
                        DataModel dm = sjcs.getUserInfoByPid(pid,user.getCompanyId(),iszjcuser);
                        EduUser _user = (EduUser) dm.getRows();
                        if (_user == null) {
                            errRowIndex += (i - 1) + ",";
                            continue;
                        }
                        card = new Special_User_Card();
                        card.setPid(pid);
                        card.setName(_user.getWorkername());
                        card.setSex(_user.getSex());
                        
                        card.setArchives_no(pid);
                        card.setCard_no(row.getCell(1).toString());
                        card.setAward_unit(row.getCell(2).toString());
                        dm = (DataModel) getSpecialUserCardByPid(pid);
                        Special_User_Card temp = (Special_User_Card) dm.getRows();
                        if (temp == null) 
                            insertSpecialUserCard(card);
                    }
                    if("".equals(pid))
                        continue;
                    if (hasEmptyValue(row,3, 7)) {
                        errRowIndex += (i - 1) + ",";
                        continue;
                    }
                    exam = new Special_User_Exam();
                    exam.setEquipment_code(row.getCell(3).toString());
                    exam.setPid(pid);
                    exam.setValid_begin_date(row.getCell(4).toString());
                    exam.setValid_end_date(row.getCell(5).toString());
                    exam.setHand_uesr(row.getCell(6).toString());
                    DataModel dm = (DataModel) insertSpecialUserExam(exam);
                    if(!dm.getResult())
                        errRowIndex += (i - 1) + ",";
                }
                if (!errRowIndex.equals("")) {
                    resultMap.put(true, "操作完成<br>其中第[" + errRowIndex.substring(0, errRowIndex.length() - 1) + "]条数据保存失败！<br>请检查导入数据<br>1：是否有空的值；<br>2：档案编号(身份证号码)是否匹配；<br>3：作业项目代号是否输入错误或已经存在；");
                } else {
                    resultMap.put(true, "操作完成！");
                }
                
            } else {
                resultMap.put(false, "操作失败，excel中第一页数据获取失败！");
            }
        }
        Boolean key = (Boolean) resultMap.keySet().toArray()[0];
        if (key) {
            out.printf(JSON.toJSONString(new DataModel().withInfo(resultMap.get(key))));
        } else {
            out.printf(JSON.toJSONString(new DataModel().withErr(resultMap.get(key))));
        }
    }
    
    private boolean hasEmptyValue(Row row,int beginIndex, int cellLength) {
        boolean result = false;
        for (int i = beginIndex; i < cellLength; i++) {            
            Cell cell = row.getCell(i);            
            if (cell == null) {
                result = true;
                break;
            }
        }
        return result;
    }
}
