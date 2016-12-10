/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.EmployeeDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.DicSystem;
import cr.cdrb.web.edu.model.Employee;
import cr.cdrb.web.edu.model.UnifyPost;
import cr.cdrb.web.edu.model.WorkType;
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
public class EmployeeService {
    @Resource
    private EmployeeDao dao;
    
    public DataModel getAllSystem() throws SQLException, Exception {
        List<DicSystem> entitys = dao.getAllSystem();
        return new DataModel().withData(entitys);
    }
    public DataModel getAllGzBySystemId(String sysid) throws SQLException, Exception {
        List<WorkType> entitys = dao.getAllGzBySystemId(sysid);
        return new DataModel().withData(entitys);
    }
    public DataModel getAllGwByGzId(String gzid) throws SQLException, Exception {
        List<UnifyPost> entitys = dao.getAllGwByGzId(gzid);
        return new DataModel().withData(entitys);
    }
    public DataModel getEmployeePaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Employee>> entityPaging = dao.getEmployeePaging(page, rows , sort, order, filterRules, search, param);
        Integer key;
        key = (Integer)entityPaging.keySet().toArray()[0];
        return new DataModel().withData(entityPaging.get(key), key);
    }
    public DataModel setGzgw(String uids,String gz,String gw) throws SQLException, Exception {
        Map<Boolean, String> resultMap = dao.setGzgw(uids,gz,gw);
        return setResultModel(resultMap);
    }
    public DataModel getEmployeeByPid(String pid) throws SQLException, Exception {
        return new DataModel().withData(dao.getEmployeeByPid(pid));
    }
    private DataModel setResultModel(Map<Boolean, String> resultMap){
        Boolean key;
        key = (Boolean)resultMap.keySet().toArray()[0];
        if(key)
            return new DataModel().withInfo(resultMap.get(key));
        else
            return new DataModel().withErr(resultMap.get(key));
    }
    public DataModel getStudent(String whereStr) throws SQLException{
        return new DataModel().withData(dao.getStudent(whereStr));
    }
}
