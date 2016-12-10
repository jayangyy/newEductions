/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.educlass.EduClassDto;
import cr.cdrb.web.edu.domains.educlass.EduClassSearch;
import cr.cdrb.web.edu.domains.educlass.EduStudent;
import java.sql.SQLException;
import java.util.List;

/**
 * 学生报名及成绩服务
 *
 * @author Jayang
 */
public interface IEduStudentService {

    public DataModel addStudent(EduStudent student) throws SQLException;

    public DataModel updateStudent(EduStudent student) throws SQLException;

    public EduStudent getStudent(String stu_idcard, String classno, String id) throws SQLException;

    public EduStudent getStuScore(String id) throws SQLException;

    public DataModel removeStudents(String ids, String classno) throws SQLException;

    public DataModel scoreRecording(EduStudent student) throws SQLException;

    public DataModel addStudents(List<EduStudent> students) throws SQLException;

    public DataModel getStudentsPage(EduClassSearch pageModel) throws Throwable;

    public DataModel addStus(List<EduStudent> students, String stus, String classno, String unit) throws SQLException;

    public DataModel getEmployees(EduClassSearch student) throws Throwable;

    public List<EduClassDto> getStuClass(String idcard,String unit) throws SQLException;
}
