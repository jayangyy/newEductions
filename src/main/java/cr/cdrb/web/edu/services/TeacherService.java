/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.TeacherDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.Teacher;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class TeacherService {
    @Resource
    private TeacherDao dao;
    
    public DataModel getTeachersPaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Teacher>> teachersPaging = dao.getTeachersPaging(page, rows , sort, order, filterRules, search, param);
        Integer key;
        key = (Integer)teachersPaging.keySet().toArray()[0];
        return new DataModel().withData(teachersPaging.get(key), key);
    }
     
    public DataModel insertTeacher(Teacher data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = dao.insertTeacher(data);
        return setResultModel(resultMap);
    }
    private DataModel setResultModel(Map<Boolean, String> resultMap){
        Boolean key;
        key = (Boolean)resultMap.keySet().toArray()[0];
        if(key)
            return new DataModel().withInfo(resultMap.get(key));
        else
            return new DataModel().withErr(resultMap.get(key));
    }
    
    public DataModel updateTeacher(Teacher data) throws Exception {
        Map<Boolean, String> resultMap = dao.updateTeacher(data);
        return setResultModel(resultMap);
    }
    
    public DataModel deleteTeacher(String pid) throws Exception {
        Map<Boolean, String> resultMap = dao.deleteTeacher(pid);
        return setResultModel(resultMap);
    }
    
    public DataModel getTeacherByPid(String pid) throws Exception {
        return new DataModel().withData(dao.getTeacherByPid(pid));
    }
    
    public DataModel getZZTeachers(String zjcid) throws Exception {
        return new DataModel().withData(dao.getZZTeachers(zjcid));
    }
}
