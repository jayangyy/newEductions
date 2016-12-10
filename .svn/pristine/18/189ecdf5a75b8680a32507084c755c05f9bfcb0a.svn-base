/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.EduClassDto;
import cr.cdrb.web.edu.domains.educlass.EduClassSearch;
import cr.cdrb.web.edu.domains.educlass.EduStudent;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.IServices.IEduClassService;
import cr.cdrb.web.edu.services.IServices.IEduStudentService;
import cr.cdrb.web.edu.services.UsersService;
import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang 2016-09-26 报名及成绩录入控制器
 */
@Controller
@RequestMapping("/stu")
public class EduStudentsController {

    @Autowired
    IEduStudentService stuService;
    @Resource(name = "configMap")
    java.util.HashMap configMap;
    @Autowired
    IEduClassService classService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView Index() {
        ModelAndView view = new ModelAndView();
        view.addObject("unit_name", UsersService.GetCurrentUser().getCompany());
        view.setViewName("/students/index");
        return view;
    }

    @RequestMapping(value = "/stuSelect", method = RequestMethod.GET)
    public ModelAndView stuSelect() {
        ModelAndView view = new ModelAndView();
        view.setViewName("/students/stuselectes");
        return view;
    }

    @RequestMapping(value = "/stuList", method = RequestMethod.GET)
    public ModelAndView stuList() {
        ModelAndView view = new ModelAndView();
        view.addObject("cur_unit", UsersService.GetCurrentUser().getCompany());
        view.setViewName("/students/studentlist");
        return view;
    }

    @RequestMapping(value = "/stuRecord", method = RequestMethod.GET)
    public ModelAndView stuRecord() {
        ModelAndView view = new ModelAndView();
        view.addObject("cur_unit", UsersService.GetCurrentUser().getCompany());
        view.setViewName("/students/scoreRecord");
        return view;
    }

    ///获取培训班数据
    @ResponseBody
    @RequestMapping(value = "/putStuSingal", method = RequestMethod.POST)
    public DataModel putStudent(EduStudent student) throws SQLException {
        return stuService.addStudent(student);
    }

    @ResponseBody
    @RequestMapping(value = "/putStus", method = RequestMethod.POST)
    public DataModel putStudents(String stus, String classno, String unit) throws SQLException {
        if (classno == null || "".equals(classno)) {
            throw new SQLException("未选择班级");
        }
        List<EduStudent> students = JSON.parseArray(stus, EduStudent.class);
        String ids = "";
        for (int i = 0; i < students.size(); i++) {
            if (i != students.size() - 1) {
                ids += students.get(i).getStu_idcard() + "','";
            } else {
                ids += students.get(i).getStu_idcard();
            }
        }
        return stuService.addStus(students, ids, classno, unit);
    }

    @ResponseBody
    @RequestMapping(value = "/pathcStu", method = RequestMethod.POST)
    public DataModel pathcStudent(EduStudent stu) throws SQLException {
        return stuService.updateStudent(stu);
    }

    @ResponseBody
    @RequestMapping(value = "/recordStu", method = RequestMethod.POST)
    public DataModel recordStudent(EduStudent stu) throws SQLException {
        return stuService.scoreRecording(stu);
    }

    @ResponseBody
    @RequestMapping(value = "/removeStu", method = RequestMethod.POST)
    public DataModel removeStu(String ids, String unit, String classno) throws SQLException {
        return stuService.removeStudents(ids, classno);
    }

    @ResponseBody
    @RequestMapping(value = "/getStu", method = RequestMethod.GET)
    public EduStudent getdStudent(String stu_idcard, String classno, String id) throws SQLException {
        return stuService.getStudent(stu_idcard,classno,id);
    }

    @ResponseBody
    @RequestMapping(value = "/getStus", method = RequestMethod.GET)
    public DataModel getStudents(EduClassSearch stu) throws SQLException, Throwable {
        return stuService.getStudentsPage(stu);
    }

    @ResponseBody
    @RequestMapping(value = "/getEmps", method = RequestMethod.GET)
    public DataModel getEmployees(EduClassSearch stu) throws SQLException, Throwable {
        return stuService.getEmployees(stu);
    }
    ///获取培训班数据

    @ResponseBody
    @RequestMapping(value = "/getClassPage", method = RequestMethod.GET)
    public DataModel getClassPage(QueryModel model) throws Throwable {
        EduUser user = UsersService.GetCurrentUser();
        //不限制能看所有单位编辑
        if (!UsersService.IsAdmin()) {
            if (!user.getCompanyId().equalsIgnoreCase(configMap.get("zjcunitid").toString())) {
                model.setSearch(model.getSearch() == null ? user.getCompany() : model.getSearch());
            }
        }
        return classService.getClassPages(model);
    }

    @ResponseBody
    @RequestMapping(value = "/getStuClasses", method = RequestMethod.GET)
    public List<EduClassDto> getStuClasses(String idcard, String unit) throws SQLException, Throwable {
        return stuService.getStuClass(idcard, unit);
    }
}
