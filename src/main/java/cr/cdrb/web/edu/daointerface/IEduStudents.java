/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.educlass.EduClassDto;
import cr.cdrb.web.edu.domains.educlass.EduClassSearch;
import cr.cdrb.web.edu.domains.educlass.EduStudent;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * 报名及成绩管理
 *
 * @author Jayang
 */
public interface IEduStudents {

    public Boolean addStudent(EduStudent student) throws SQLException;

    public Boolean updateStudent(EduStudent student) throws SQLException;

    public EduStudent getStudent(String stu_idcard, String classno, String id) throws SQLException;

    public Boolean removeStudents(String ids, String classno, String unit) throws SQLException;

    public Boolean scoreRecording(EduStudent student) throws SQLException;

    public Boolean addStudents(List<EduStudent> students) throws SQLException;

    public Map<Integer, List<EduStudent>> getStudentsPage(EduClassSearch pageModel) throws Throwable;

    public Map<Integer, List<EduStudent>> getStudentsCom(EduClassSearch pageModel) throws Throwable;

    public List<EduClassDto> getStuClass(String idcard, String unit) throws SQLException;

    //获取该单位该班级已报名人数
    public int getStusNum(String classno, String unit) throws SQLException;

}
