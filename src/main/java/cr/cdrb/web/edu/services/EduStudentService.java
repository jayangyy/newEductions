/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IEduClassDao;
import cr.cdrb.web.edu.daointerface.IEduStudents;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduClassDto;
import cr.cdrb.web.edu.domains.educlass.EduClassSearch;
import cr.cdrb.web.edu.domains.educlass.EduStudent;
import cr.cdrb.web.edu.domains.eduplans.EduPlanCost;
import cr.cdrb.web.edu.services.IServices.IEduStudentService;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang
 */
@Service
public class EduStudentService implements IEduStudentService {

    @Autowired
    IEduStudents studentDao;
    @Autowired
    IEduClassDao classDao;

    @Override
    public DataModel addStudent(EduStudent student) throws SQLException {
        return studentDao.addStudent(student) ? new DataModel().withInfo("添加成功") : new DataModel().withErr("添加失败");
    }

    @Override
    public DataModel updateStudent(EduStudent student) throws SQLException {
        return studentDao.updateStudent(student) ? new DataModel().withInfo("修改成功") : new DataModel().withErr("修改失败");
    }

    @Override
    public EduStudent getStudent(String stu_idcard, String classno, String id) throws SQLException {
        return studentDao.getStudent(stu_idcard, classno, id);
    }

    @Override
    public DataModel removeStudents(String ids, String classno) throws SQLException {
        return studentDao.removeStudents(ids, classno, null) ? new DataModel().withInfo("删除成功") : new DataModel().withErr("删除失败");
    }

    @Override
    public DataModel scoreRecording(EduStudent student) throws SQLException {
        EduStudent stu = studentDao.getStudent("", "", student.getId());
        if (stu == null) {
            throw new SQLException("未找到该报名记录！");
        }
        stu.setStu_phy_points(student.getStu_phy_points());
        stu.setStu_phy_url(student.getStu_phy_url());
        stu.setStu_prac_points(student.getStu_prac_points());
        stu.setStu_prac_url(student.getStu_prac_url());
        stu.setStu_sec_points(student.getStu_sec_points());
        stu.setStu_sec_url(student.getStu_sec_url());
        stu.setStu_bsec_points(student.getStu_bsec_points());
        stu.setStu_bsec_url(student.getStu_bsec_url());
        stu.setStu_bphy_points(student.getStu_bphy_points());
        return studentDao.scoreRecording(stu) ? new DataModel().withInfo("修改成功") : new DataModel().withErr("修改失败");
    }

    @Override
    public DataModel addStudents(List<EduStudent> students) throws SQLException {
        return studentDao.addStudents(students) ? new DataModel().withInfo("修改成功") : new DataModel().withErr("修改失败");
    }

    @Override
    public DataModel getStudentsPage(EduClassSearch pageModel) throws Throwable {
        Map<Integer, List<EduStudent>> resPaging = studentDao.getStudentsPage(pageModel);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public DataModel addStus(List<EduStudent> students, String stus, String classno, String unit) throws SQLException {
        //全单位删除
//        if (!studentDao.removeStudents(null, classno, unit)) {
//            throw new SQLException("删除失败!");
//        }
        //选择删除
//        if (!"".equals(stus)) {
//            if (!studentDao.removeStudents(stus, classno, null)) {
//                throw new SQLException("删除失败!");
//            }
//        }
        int stunums = students.size();
        EduClass eclass = classDao.getClassByNo(classno);//班级信息
        int hnums = studentDao.getStusNum(classno, unit);//已安排人数
        int endnum = eclass.getStudentnum() - hnums;
        if (stunums > eclass.getStudentnum()) {
            throw new SQLException("人数不能超过" + eclass.getStudentnum() + "人");
        }
        if (stunums > endnum) {
            throw new SQLException("人数超标，还能安排" + endnum + "人");
        }
        return addStudents(students);
    }

    @Override
    public DataModel getEmployees(EduClassSearch student) throws Throwable {

        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public EduStudent getStuScore(String id) throws SQLException {
        EduStudent stu = studentDao.getStudent("", "", id);
        return stu == null ? new EduStudent() : stu;
    }

    @Override
    public List<EduClassDto> getStuClass(String idcard, String unit) throws SQLException {
        return studentDao.getStuClass(idcard, unit);
    }
}
