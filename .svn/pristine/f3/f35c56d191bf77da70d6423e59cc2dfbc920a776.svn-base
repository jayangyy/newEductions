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
import cr.cdrb.web.edu.model.Teacher;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.TeacherService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
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
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author milord
 */
@Controller
@RequestMapping("teacher/")
public class TeacherController {

    @Resource(name = "configMap")
    private Map config;

    @Autowired
    TeacherService service;

    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) throws Exception {
        String zjcunitid = (String) config.get("zjcunitid");
        request.setAttribute("zjcunitid", zjcunitid);
        EduUser user = UsersService.GetCurrentUser();
        request.setAttribute("user", user);
//        boolean iseduuser = false;
//        for (Role r : user.getRoles()) {
//            if(r.getRolename().equals("ROLE_EDU"))
//                iseduuser = true;
//        }
//        request.setAttribute("iseduuser", iseduuser);
        request.setAttribute("zjcid", zjcunitid);
        boolean iszjcuser = false;
        if (user.getCompanyId().equals(zjcunitid)) {
            iszjcuser = true;
        }
        request.setAttribute("iszjcuser", iszjcuser);
        request.setAttribute("usercompanyid", user.getCompanyId());
        //isadmin
        boolean isadmin = false;
        DataModel dm = service.getTeacherByPid(user.getUsername());
        Teacher teacher = (Teacher) dm.getRows();
        if (teacher != null && teacher.getIszz() == 1) {
            isadmin = true;
        }
        request.setAttribute("isadmin", isadmin);
        return "teacher/list";
    }

    @RequestMapping(value = "edit")
    public String getEditPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iszjcuser = false;
        if (user.getCompanyId().equals(zjcunitid)) {
            iszjcuser = true;
        }
        request.setAttribute("iszjcuser", iszjcuser);
        return "teacher/edit";
    }

    @RequestMapping(value = "allTeachers", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllTeachers(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();
        String sort = StringUtils.isBlank(model.getSort()) ? "dwname" : model.getSort();
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
                        if(field.equals("subject"))
                        {
                            whereStr += " and (ll like ? or sz like ?)";
                            param.add("%" + value + "%");
                            param.add("%" + value + "%");
                        }
                        break;
                }
            }
        }
        return JSON.toJSONString(service.getTeachersPaging(page, rows, sort, order, whereStr, "", param.toArray()));
        
    }
    
    @RequestMapping(value = "addTeacher", method = RequestMethod.POST)
    @ResponseBody
    public Object insertSpecialJobCard(Teacher data) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        data.setOptuserid(user.getUsername());
        data.setOptusername(user.getWorkername());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        data.setOptdate(df.format(new Date()));
        return service.insertTeacher(data);
    }

    @RequestMapping(value = "editTeacher", method = RequestMethod.POST)
    @ResponseBody
    public Object updateTeacher(Teacher data) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        data.setOptuserid(user.getUsername());
        data.setOptusername(user.getWorkername());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        data.setOptdate(df.format(new Date()));
        return service.updateTeacher(data);
    }

    @RequestMapping(value = "teacher/{pid}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteTeacher(@PathVariable String pid) throws Exception {
        return service.deleteTeacher(pid);
    }
    
    @RequestMapping(value = "teacher/{pid}", method = RequestMethod.GET)
    @ResponseBody
    public Object getTeacherByPid(@PathVariable String pid) throws Exception {
        return service.getTeacherByPid(pid);
    }
    
    @RequestMapping(value = "exportData", method = RequestMethod.GET)
    @ResponseBody
    public void exportData(String type,String typename,String dwid,HttpServletResponse response) throws Exception {
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
        font.setFontHeightInPoints((short)14);
        herderStyle.setFont(font);
        
        if(type.equals("1")){
            HSSFRow row = sheet.createRow((int)0);
            
            HSSFCell cell = row.createCell((int)0);
            cell.setCellValue("序号");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)1);
            cell.setCellValue("分类");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)2);
            cell.setCellValue("单位(部门)名称");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)3);
            cell.setCellValue("姓名");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)4);
            cell.setCellValue("性别");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)5);
            cell.setCellValue("出生年月");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)6);
            cell.setCellValue("政治面貌");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)7);
            cell.setCellValue("职务/职称/职业资格");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)8);
            cell.setCellValue("毕业院校");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)9);
            cell.setCellValue("专业");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)10);
            cell.setCellValue("学历");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)11);
            cell.setCellValue("聘用(下令)时间");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)12);
            cell.setCellValue("备注");
            cell.setCellStyle(herderStyle);
            
            String zjcunitid = (String) config.get("zjcunitid");
            DataModel dm = service.getZZTeachers(zjcunitid);
            List<Teacher> teachers = (List<Teacher>)dm.getRows();
            
            String tempname = "";
            int tempstart=1;
            int tempend=1;
            boolean regionstatus=false;
            for (int i = 0; i < teachers.size(); i++) {
                Teacher teacher = teachers.get(i);
                row = sheet.createRow((int)i+1);
                cell = row.createCell((int)0);
                cell.setCellValue(i+1);
                cell.setCellStyle(style);
                
                if(!teacher.getTyname().equals(tempname)){
                    tempstart = i+1;
                    tempend = i+1;
                    regionstatus = false;
                    
                    tempname = teacher.getTyname();
                    cell = row.createCell((int)1);
                    cell.setCellValue(teacher.getTyname());
                    cell.setCellStyle(style);
                }else{
                    tempend++;
                }
                try{
                    Teacher nextteacher = teachers.get(i+1);
                    if(!nextteacher.getTyname().equals(teacher.getTyname()))
                        regionstatus = true;
                }catch(Exception e){
                    regionstatus = true;
                }
                
                if(regionstatus){
                    sheet.addMergedRegion(new Region((short)tempstart, (short)1, (short)tempend, (short)1));
                }
                cell = row.createCell((int)2);
                cell.setCellValue(teacher.getDwname());
                cell.setCellStyle(style);
                cell = row.createCell((int)3);
                cell.setCellValue(teacher.getName());
                cell.setCellStyle(style);
                cell = row.createCell((int)4);
                cell.setCellValue(teacher.getSex());
                cell.setCellStyle(style);
                cell = row.createCell((int)5);
                cell.setCellValue(teacher.getBirthday());
                cell.setCellStyle(style);
                cell = row.createCell((int)6);
                cell.setCellValue(teacher.getEm_politicalstatus());
                cell.setCellStyle(style);
                cell = row.createCell((int)7);
                cell.setCellValue(teacher.getEm_gz());
                cell.setCellStyle(style);
                cell = row.createCell((int)8);
                cell.setCellValue(teacher.getEm_graduatedfrom());
                cell.setCellStyle(style);
                cell = row.createCell((int)9);
                cell.setCellValue(teacher.getEm_sxzy());
                cell.setCellStyle(style);
                cell = row.createCell((int)10);
                cell.setCellValue(teacher.getEm_eduback());
                cell.setCellStyle(style);
                cell = row.createCell((int)11);
                cell.setCellValue(teacher.getEdu_date());
                cell.setCellStyle(style);
                cell = row.createCell((int)12);
                cell.setCellValue(teacher.getMemo());
                cell.setCellStyle(style);
            }
            sheet.setColumnWidth(1, 36*100);
            sheet.setColumnWidth(2, 36*240);
            sheet.setColumnWidth(5, 36*100);
            sheet.setColumnWidth(6, 36*100);
            sheet.setColumnWidth(7, 36*200);
            sheet.setColumnWidth(8, 36*100);
            sheet.setColumnWidth(9, 36*250);
            sheet.setColumnWidth(10, 36*80);
            sheet.setColumnWidth(11, 36*155);
            sheet.setColumnWidth(12, 36*130);
        }
        else if(type.equals("2")){
            HSSFRow row = sheet.createRow((int)0);
            
            HSSFCell cell = row.createCell((int)0);
            cell.setCellValue("序号");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)1);
            cell.setCellValue("系统");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)2);
            cell.setCellValue("执教专业");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)3);
            cell.setCellValue("姓名");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)4);
            cell.setCellValue("单位");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)5);
            cell.setCellValue("职务");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)6);
            cell.setCellValue("技术职称\n(技能等级)");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)7);
            cell.setCellValue("执教经历\n(成果及获奖情况，特、专长)");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)8);
            cell.setCellValue("承担课程");
            cell.setCellStyle(herderStyle);
            row = sheet.createRow((int)1);
            cell = row.createCell((int)8);
            cell.setCellValue("理论");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)9);
            cell.setCellValue("实作");
            cell.setCellStyle(herderStyle);
            
            sheet.addMergedRegion(new Region((short)0, (short)0, (short)1, (short)0));
            sheet.addMergedRegion(new Region((short)0, (short)1, (short)1, (short)1));
            sheet.addMergedRegion(new Region((short)0, (short)2, (short)1, (short)2));
            sheet.addMergedRegion(new Region((short)0, (short)3, (short)1, (short)3));
            sheet.addMergedRegion(new Region((short)0, (short)4, (short)1, (short)4));
            sheet.addMergedRegion(new Region((short)0, (short)5, (short)1, (short)5));
            sheet.addMergedRegion(new Region((short)0, (short)6, (short)1, (short)6));
            sheet.addMergedRegion(new Region((short)0, (short)7, (short)1, (short)7));
            sheet.addMergedRegion(new Region((short)0, (short)8, (short)0, (short)9));
            sheet.autoSizeColumn(7, true);
            
            DataModel dm = service.getTeachersPaging(1, 99999, "dwname", "asc", "isjpjz=1", "", new ArrayList<>().toArray());
            List<Teacher> teachers = (List<Teacher>)dm.getRows();
            for (int i = 0; i < teachers.size(); i++) {
                Teacher teacher = teachers.get(i);
                row = sheet.createRow((int)i+2);
                cell = row.createCell((int)0);
                cell.setCellValue(i+1);
                cell.setCellStyle(style);
                cell = row.createCell((int)1);
                cell.setCellValue(teacher.getSystem());
                cell.setCellStyle(style);
                cell = row.createCell((int)2);
                cell.setCellValue(teacher.getProf());
                cell.setCellStyle(style);
                cell = row.createCell((int)3);
                cell.setCellValue(teacher.getName());
                cell.setCellStyle(style);
                cell = row.createCell((int)4);
                cell.setCellValue(teacher.getDwname());
                cell.setCellStyle(style);
                cell = row.createCell((int)5);
                cell.setCellValue(teacher.getEm_gz());
                cell.setCellStyle(style);
                cell = row.createCell((int)6);
                cell.setCellValue(teacher.getEm_joblevel());
                cell.setCellStyle(style);
                cell = row.createCell((int)7);
                cell.setCellValue(teacher.getZjjl());
                cell.setCellStyle(style);
                cell = row.createCell((int)8);
                cell.setCellValue(teacher.getLl());
                cell.setCellStyle(style);
                cell = row.createCell((int)9);
                cell.setCellValue(teacher.getSz());
                cell.setCellStyle(style);
            }
            sheet.setColumnWidth(2, 36*100);
            sheet.setColumnWidth(6, 36*200);
            sheet.setColumnWidth(7, 36*380);
            sheet.setColumnWidth(8, 36*100);
            sheet.setColumnWidth(9, 36*100);
        }
        else if(type.equals("3")){
            HSSFRow row = sheet.createRow((int)0);
            
            HSSFCell cell = row.createCell((int)0);
            cell.setCellValue("序号");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)1);
            cell.setCellValue("姓名");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)2);
            cell.setCellValue("性别");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)3);
            cell.setCellValue("出生日期");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)4);
            cell.setCellValue("所在部门");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)5);
            cell.setCellValue("文化程度");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)6);
            cell.setCellValue("学历类别");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)7);
            cell.setCellValue("毕业学校");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)8);
            cell.setCellValue("所学专业");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)9);
            cell.setCellValue("职务");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)10);
            cell.setCellValue("技术职称(技能等级)");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)11);
            cell.setCellValue("担任课程");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)12);
            cell.setCellValue("专职人员从教时间");
            cell.setCellStyle(herderStyle);
            cell = row.createCell((int)13);
            cell.setCellValue("兼职教师聘任日期");
            cell.setCellStyle(herderStyle);
            
            DataModel dm = service.getTeachersPaging(1, 99999, "dwname", "asc", "iszdjz=1 and dwid='"+dwid+"'", "", new ArrayList<>().toArray());
            List<Teacher> teachers = (List<Teacher>)dm.getRows();
            for (int i = 0; i < teachers.size(); i++) {
                Teacher teacher = teachers.get(i);
                row = sheet.createRow((int)i+1);
                cell = row.createCell((int)0);
                cell.setCellValue(i+1);
                cell.setCellStyle(style);
                cell = row.createCell((int)1);
                cell.setCellValue(teacher.getName());
                cell.setCellStyle(style);
                cell = row.createCell((int)2);
                cell.setCellValue(teacher.getSex());
                cell.setCellStyle(style);
                cell = row.createCell((int)3);
                cell.setCellValue(teacher.getBirthday());
                cell.setCellStyle(style);
                cell = row.createCell((int)4);
                cell.setCellValue(teacher.getBmname());
                cell.setCellStyle(style);
                cell = row.createCell((int)5);
                cell.setCellValue(teacher.getEm_eduback());
                cell.setCellStyle(style);
                cell = row.createCell((int)6);
                cell.setCellValue(teacher.getEm_degree());
                cell.setCellStyle(style);
                cell = row.createCell((int)7);
                cell.setCellValue(teacher.getEm_graduatedfrom());
                cell.setCellStyle(style);
                cell = row.createCell((int)8);
                cell.setCellValue(teacher.getEm_sxzy());
                cell.setCellStyle(style);
                cell = row.createCell((int)9);
                cell.setCellValue(teacher.getEm_gz());
                cell.setCellStyle(style);
                cell = row.createCell((int)10);
                cell.setCellValue(teacher.getEm_joblevel());
                cell.setCellStyle(style);
                String v = "";
                if(!teacher.getLl().equals(""))
                    v+="理论："+teacher.getLl();
                if(!teacher.getSz().equals("")){
                    if(!v.equals(""))
                        v+="、";
                    v+="实作："+teacher.getSz();
                }
                cell = row.createCell((int)11);
                cell.setCellValue(v);
                cell.setCellStyle(style);
                cell = row.createCell((int)12);
                cell.setCellValue(teacher.getEdu_date());
                cell.setCellStyle(style);
                cell = row.createCell((int)13);
                cell.setCellValue(teacher.getHire_date());
                cell.setCellStyle(style);
            }
            sheet.setColumnWidth(3, 36*100);
            sheet.setColumnWidth(4, 36*140);
            sheet.setColumnWidth(5, 36*100);
            sheet.setColumnWidth(6, 36*100);
            sheet.setColumnWidth(7, 36*100);
            sheet.setColumnWidth(8, 36*180);
            sheet.setColumnWidth(9, 36*90);
            sheet.setColumnWidth(10, 36*200);
            sheet.setColumnWidth(11, 36*200);
            sheet.setColumnWidth(12, 36*190);
            sheet.setColumnWidth(13, 36*190);
        }
        
//        String path = "E:/"+typename+".xls";
//        try (FileOutputStream fout = new FileOutputStream(path)) {
//            wb.write(fout);
//        }

        response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(typename+".xls", "UTF-8"));
        response.setContentType("application/vnd.ms-excel;charset=gb2312");
        OutputStream os = new BufferedOutputStream(response.getOutputStream());
        wb.write(os);
        os.flush();
        os.close();
    }
}
