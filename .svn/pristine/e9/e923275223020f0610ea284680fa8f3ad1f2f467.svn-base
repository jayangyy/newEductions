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
import cr.cdrb.web.edu.domains.educlass.EduClassSearch;
import cr.cdrb.web.edu.model.Edu_Study_Content;
import cr.cdrb.web.edu.model.Edunewpost;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.EduClassService;
import cr.cdrb.web.edu.services.EduNewPostNService;
import cr.cdrb.web.edu.services.EduStudyContentService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
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
@RequestMapping("/edunewpost")
public class EduNewPostController {
    @Autowired
    EduNewPostNService service;
    @Autowired
    EduClassService ecs;
    @Autowired
    EduStudyContentService escs;
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
        return "edunewpost/nlist";
    }
    
    @RequestMapping(value = "edit")
    public String getEditPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        EduUser user = UsersService.GetCurrentUser();
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        return "edunewpost/nedit";
    }
    @RequestMapping(value = "/")
    public String getUpPage() {
        return "edunewpost/nedit";
    }
    
    @RequestMapping(value = "scedit")
    public String getScEditPage(HttpServletRequest request) {
        return "edunewpost/scedit";
    }
    
    @RequestMapping(value = "scsoonedit")
    public String getScSoonEditPage(HttpServletRequest request) {
        return "edunewpost/scsoonedit";
    }
    
    @RequestMapping(value = "allDatas", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllDatas(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();
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
                            whereStr += " and (to_char(fzrq,'YYYYMMDD') like ? or fzrq is null)";
                            param.add(value+"%");
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
    public Object addData(Edunewpost data) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        data.setCompanyid(user.getCompanyId());
        return service.addData(data);
    }
    
    @RequestMapping(value = "upData", method = RequestMethod.POST)
    @ResponseBody
    public Object upData(Edunewpost data) throws Exception {
        return service.upData(data);
    }
    
    @RequestMapping(value = "delDataById", method = RequestMethod.POST)
    @ResponseBody
    public Object delDataById(int id) throws Exception {
        return service.delDataById(id);
    }
    
    @RequestMapping(value = "allClass", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllClasses(String pxlb,String begindate,String enddate) throws Throwable {
        QueryModel model = new QueryModel();
        model.setFilterRules("classtype='"+pxlb+"' and STARTDATE >= to_date('"+begindate+"','yyyy-mm-dd') and  STARTDATE <= to_date('"+enddate+"','yyyy-mm-dd')");
        model.setSort("STARTDATE");
        model.setOrder("desc");
        model.setPage(1);
        model.setRows(20);
        return ecs.getClassPages(model);
    }
    
    @RequestMapping(value = "getStudentsCom", method = RequestMethod.GET)
    @ResponseBody
    public Object getStudentsCom(String pid,String classno) throws Throwable {
        List<Object> params = new ArrayList<>();
        EduClassSearch model = new EduClassSearch();
        model.setSelects("select * from EDU_STUDENTS");
        model.setFilterRules("stu_idcard=? and class_no=?");
        params.add(pid);
        params.add(classno);
        model.setParams(params);
        model.setSort("id");
        model.setOrder("asc");
        model.setPage(1);
        model.setRows(20);
        return service.getStudentsCom(model);
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
            String filePath = (String) config.get("edunewpostFilePath") + "/" + path;
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
    
    @RequestMapping(value = "getStudyContent", method = RequestMethod.GET)
    @ResponseBody
    public Object getStudyContent(QueryModel model) throws Exception{
        int rows = model.getRows();
        int page = model.getPage();
        String sort = StringUtils.isBlank(model.getSort()) ? "orderno" : model.getSort();
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
                        break;
                }
            }
        }
        return escs.getDataPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray());
    }
    
    @RequestMapping(value = "getStudyContentById", method = RequestMethod.GET)
    @ResponseBody
    public Object getStudyContentById(int id) throws Exception {
        return escs.getDataById(id);
    }
    
    @RequestMapping(value = "addStudyContentData", method = RequestMethod.POST)
    @ResponseBody
    public Object addData(Edu_Study_Content data) throws Exception {
        return escs.addData(data);
    }
    
    @RequestMapping(value = "upStudyContentData", method = RequestMethod.POST)
    @ResponseBody
    public Object upData(Edu_Study_Content data) throws Exception {
        return escs.upData(data);
    }
    
    @RequestMapping(value = "delStudyContentById", method = RequestMethod.POST)
    @ResponseBody
    public Object delStudyContentById(int id) throws Exception {
        return escs.delDataById(id);
    }
    
    @RequestMapping(value = "copyStudyContent", method = RequestMethod.POST)
    @ResponseBody
    public Object copyStudyContent(int fromid,int toid) throws Exception {
        return escs.copyStudyContent(fromid,toid);
    }
    
}
