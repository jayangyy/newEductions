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
import cr.cdrb.web.edu.model.EduBzzTrain;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.BzzTrainService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.Region;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/bzzms")
public class BzzTrainController {
    @Autowired
    BzzTrainService service;
    @Resource(name="configMap")
    private Map config;
    
    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        request.setAttribute("user", user);
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
        return "bzzms/list";
    }
    
    @RequestMapping(value = "edit")
    public String getEditPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        return "bzzms/edit";
    }
    
    @RequestMapping(value = "allDatas", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllDatas(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();
        String sort = StringUtils.isBlank(model.getSort()) ? "id" : model.getSort();
        String order = StringUtils.isBlank(model.getOrder()) ? "asc" : model.getOrder();
        List<String> param = new ArrayList<>();
        
//        String whereStr = "1=1";
        String whereStr = "substr(userpid,7,8)>= ?";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date now = new Date();
        now.setYear(now.getYear()-60);
        String temp = sdf.format(now);
        param.add(temp);
        
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
                    case "noequals":
                        whereStr += " and " + field + " != ?";
                        param.add(value);
                        break;
                    case "contains":
                        whereStr += " and " + field + " like ?";
                        param.add("%"+value+"%");
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
                        if(field.equals("iszjcuser")){
                            model.setSearch(value);
                        }
                        else if(field.equals("year")){
                            whereStr += " and (to_char(begindate,'YYYY') <= ? or begindate is null)";
                            param.add(value);
                        }
                        break;
                }
            }
        }
        return service.getDataPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray());
    }
    
    @RequestMapping(value = "getDataById", method = RequestMethod.GET)
    @ResponseBody
    public Object getDataById(int id) throws Exception {
        return service.getDataById(id);
    }
    
    @RequestMapping(value = "addData", method = RequestMethod.POST)
    @ResponseBody
    public Object addData(EduBzzTrain data) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        data.setCompanyid(user.getCompanyId());
        return service.addData(data);
    }
    
    @RequestMapping(value = "upData", method = RequestMethod.POST)
    @ResponseBody
    public Object upData(EduBzzTrain data) throws Exception {
        return service.upData(data);
    }
    
    @RequestMapping(value = "delDataById", method = RequestMethod.POST)
    @ResponseBody
    public Object delDataById(int id) throws Exception {
        return service.delDataById(id);
    }
    
    @RequestMapping(value = "UploadFile", method = RequestMethod.POST)
    public void Upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> mapLinkList = multipartRequest.getFileMap();
        MultipartFile file = null;
        for (String mf : mapLinkList.keySet()) {
            file = mapLinkList.get(mf);
        }
        if (file == null) {
            out.printf(JSON.toJSONString(new DataModel().withErr("上传失败，文件读取失败！")));
        } else {
            String path = multipartRequest.getParameterValues("filepath")[0];
            String filePath = (String) config.get("edubzzFilePath") + "/" + path;
            String isedit = multipartRequest.getParameterValues("isedit")[0];
            if(isedit.equals("true")){
                filePath = path.substring(0,path.lastIndexOf("/"));
            }
            File uploadDir = new File(filePath);
            if (!uploadDir.isDirectory()) {
                uploadDir.mkdir();
            }
            String fileName = file.getOriginalFilename();
            File targetFile = new File(filePath, fileName);
            if (!targetFile.exists()) {
                targetFile.mkdirs();
            }
            try {
                file.transferTo(targetFile);
                out.printf(JSON.toJSONString(new DataModel().withInfo(filePath+"/"+fileName)));
            } catch (IOException | IllegalStateException e) {
                out.printf(JSON.toJSONString(new DataModel().withErr("上传失败！"+ e.getMessage())));
            }
        }
    }
    
    @RequestMapping(value = "allLxDatas", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllLxDatas(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();
        String sort = StringUtils.isBlank(model.getSort()) ? "startdate" : model.getSort();
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
                        param.add("%"+value+"%");
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
                        if(field.equals("startdate")){
                            whereStr += " and to_char(startdate,'YYYYMMDD') > ?";
                            param.add(value);
                        }
                        break;
                }
            }
        }
        return service.getLxPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray());
    }

    
    @RequestMapping(value = "exportData", method = RequestMethod.GET)
    @ResponseBody
    public void exportData(String dwname,String dwid,String year,HttpServletResponse response) throws Exception {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("Sheet1");
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        HSSFCellStyle herderStyle = wb.createCellStyle();
        herderStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        herderStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        HSSFFont font = wb.createFont();
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font.setFontHeightInPoints((short)12);
        herderStyle.setFont(font);
        
        HSSFRow row = sheet.createRow((int)0);
        CreatExcelCell(row,0,"序号",herderStyle);
        CreatExcelCell(row,1,"车间",herderStyle);
        CreatExcelCell(row,2,"班组",herderStyle);
        CreatExcelCell(row,3,"姓名",herderStyle);
        CreatExcelCell(row,4,"职名",herderStyle);
        CreatExcelCell(row,5,"出生日期",herderStyle);
        CreatExcelCell(row,6,"文化程度",herderStyle);
        CreatExcelCell(row,7,"技能等级",herderStyle);
        CreatExcelCell(row,8,"任职培训",herderStyle);
        CreatExcelCell(row,13,"任职令",herderStyle);
        CreatExcelCell(row,15,"轮训记录",herderStyle);
        CreatExcelCell(row,24,"备注",herderStyle);
        
        row = sheet.createRow((int)1);
        CreatExcelCell(row,8,"培训地点",herderStyle);
        CreatExcelCell(row,9,"培训日期",herderStyle);
        CreatExcelCell(row,11,"总学时",herderStyle);
        CreatExcelCell(row,12,"考试成绩",herderStyle);
        CreatExcelCell(row,13,"下令日期",herderStyle);
        CreatExcelCell(row,14,"令号",herderStyle);
        CreatExcelCell(row,15,"培训日期",herderStyle);
        CreatExcelCell(row,17,"考试成绩",herderStyle);
        CreatExcelCell(row,18,"培训日期",herderStyle);
        CreatExcelCell(row,20,"考试成绩",herderStyle);
        CreatExcelCell(row,21,"培训日期",herderStyle);
        CreatExcelCell(row,23,"考试成绩",herderStyle);
        
        row = sheet.createRow((int)2);
        CreatExcelCell(row,9,"起始",herderStyle);
        CreatExcelCell(row,10,"结束",herderStyle);
        CreatExcelCell(row,15,"起始",herderStyle);
        CreatExcelCell(row,16,"结束",herderStyle);
        CreatExcelCell(row,18,"起始",herderStyle);
        CreatExcelCell(row,19,"结束",herderStyle);
        CreatExcelCell(row,21,"起始",herderStyle);
        CreatExcelCell(row,22,"结束",herderStyle);
        sheet.addMergedRegion(new Region((short)0, (short)8, (short)0, (short)12));
        sheet.addMergedRegion(new Region((short)0, (short)13, (short)0, (short)14));
        sheet.addMergedRegion(new Region((short)0, (short)15, (short)0, (short)23));
        sheet.addMergedRegion(new Region((short)1, (short)9, (short)1, (short)10));
        sheet.addMergedRegion(new Region((short)1, (short)15, (short)1, (short)16));
        sheet.addMergedRegion(new Region((short)1, (short)18, (short)1, (short)19));
        sheet.addMergedRegion(new Region((short)1, (short)21, (short)1, (short)22));
        sheet.addMergedRegion(new Region((short)0, (short)0, (short)2, (short)0));
        sheet.addMergedRegion(new Region((short)0, (short)1, (short)2, (short)1));
        sheet.addMergedRegion(new Region((short)0, (short)2, (short)2, (short)2));
        sheet.addMergedRegion(new Region((short)0, (short)3, (short)2, (short)3));
        sheet.addMergedRegion(new Region((short)0, (short)4, (short)2, (short)4));
        sheet.addMergedRegion(new Region((short)0, (short)5, (short)2, (short)5));
        sheet.addMergedRegion(new Region((short)0, (short)6, (short)2, (short)6));
        sheet.addMergedRegion(new Region((short)0, (short)7, (short)2, (short)7));
        sheet.addMergedRegion(new Region((short)1, (short)8, (short)2, (short)8));
        sheet.addMergedRegion(new Region((short)1, (short)11, (short)2, (short)11));
        sheet.addMergedRegion(new Region((short)1, (short)12, (short)2, (short)12));
        sheet.addMergedRegion(new Region((short)1, (short)13, (short)2, (short)13));
        sheet.addMergedRegion(new Region((short)1, (short)14, (short)2, (short)14));
        sheet.addMergedRegion(new Region((short)1, (short)17, (short)2, (short)17));
        sheet.addMergedRegion(new Region((short)1, (short)20, (short)2, (short)20));
        sheet.addMergedRegion(new Region((short)1, (short)23, (short)2, (short)23));
        sheet.addMergedRegion(new Region((short)0, (short)24, (short)2, (short)24));

        DataModel dm =  service.getAllBzz(dwid,year);
        List<Map<String,Object>> bzzs = (List<Map<String,Object>>)dm.getRows();
        for (int i = 0; i < bzzs.size(); i++) {            
            row = sheet.createRow((int)i+3);
            CreatExcelCell(row,0,(i+1)+"",style);
            String treename = bzzs.get(i).get("TREENAME").toString();
            String[] bmarr = treename.split("-");
            String cj = "";
            if(bmarr.length>1)
                cj = bmarr[bmarr.length-2];
            CreatExcelCell(row,1,cj,style);
            CreatExcelCell(row,2,bmarr[bmarr.length-1],style);
            CreatExcelCell(row,3,bzzs.get(i).get("EM_NAME")==null?"":bzzs.get(i).get("EM_NAME").toString(),style);
            CreatExcelCell(row,4,bzzs.get(i).get("EM_GZ")==null?"":bzzs.get(i).get("EM_GZ").toString(),style);
            CreatExcelCell(row,5,bzzs.get(i).get("EM_BIRTHDAY")==null?"":bzzs.get(i).get("EM_BIRTHDAY").toString().split(" ")[0],style);
            CreatExcelCell(row,6,bzzs.get(i).get("EM_EDUBACK")==null?"":bzzs.get(i).get("EM_EDUBACK").toString(),style);
            CreatExcelCell(row,7,bzzs.get(i).get("EM_JOBLEVEL")==null?"":bzzs.get(i).get("EM_JOBLEVEL").toString(),style);
            CreatExcelCell(row,8,bzzs.get(i).get("ADDRESS")==null?"":bzzs.get(i).get("ADDRESS").toString(),style);
            String begindate = bzzs.get(i).get("BEGINDATE")==null?"":bzzs.get(i).get("BEGINDATE").toString().split(" ")[0];
            CreatExcelCell(row,9,begindate,style);
            CreatExcelCell(row,10,bzzs.get(i).get("ENDDATE")==null?"":bzzs.get(i).get("ENDDATE").toString().split(" ")[0],style);
            CreatExcelCell(row,11,bzzs.get(i).get("STUDY_HOUR")==null?"":bzzs.get(i).get("STUDY_HOUR").toString(),style);
            CreatExcelCell(row,12,bzzs.get(i).get("CJ")==null?"":bzzs.get(i).get("CJ").toString(),style);
            CreatExcelCell(row,13,bzzs.get(i).get("DZLDATE")==null?"":bzzs.get(i).get("DZLDATE").toString().split(" ")[0],style);
            CreatExcelCell(row,14,bzzs.get(i).get("DZLH")==null?"":bzzs.get(i).get("DZLH").toString(),style);
            CreatExcelCell(row,24,bzzs.get(i).get("MEMO")==null?"":bzzs.get(i).get("MEMO").toString(),style);
            String pid = bzzs.get(i).get("EM_IDCARD").toString();
            QueryModel query = new QueryModel();
            query.setPage(1);
            query.setRows(3);
            query.setFilterRules("[{\"field\":\"stu_idcard\",\"op\":\"equals\",\"value\":\""+pid+"\"},{\"field\":\"startdate\",\"op\":\"custom\",\"value\":\""+begindate+"\"}]");
            DataModel dmlx = (DataModel)getAllLxDatas(query);
            List<Map<String,Object>> lxs = (List<Map<String,Object>>)dmlx.getRows();
            for (int j = 0; j < lxs.size(); j++) {
                CreatExcelCell(row,15+j*3,lxs.get(j).get("STARTDATE")==null?"":lxs.get(j).get("STARTDATE").toString().split(" ")[0],style);
                CreatExcelCell(row,16+j*3,lxs.get(j).get("ENDDATE")==null?"":lxs.get(j).get("ENDDATE").toString().split(" ")[0],style);
                CreatExcelCell(row,17+j*3,lxs.get(j).get("STU_PHY_POINTS")==null?"":lxs.get(j).get("STU_PHY_POINTS").toString(),style);
            }
        }

        response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(dwname+"-"+year+"-班组长培训情况.xls", "UTF-8"));
        response.setContentType("application/vnd.ms-excel;charset=gb2312");
        OutputStream os = new BufferedOutputStream(response.getOutputStream());
        wb.write(os);
        os.flush();
        os.close();
    }
    private void CreatExcelCell(HSSFRow row,int index,String value,HSSFCellStyle style){
        HSSFCell cell = row.createCell((int)index);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }
}
