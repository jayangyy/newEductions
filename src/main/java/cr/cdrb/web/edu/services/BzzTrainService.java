/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.BzzTrainDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.EduBzzTrain;
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
public class BzzTrainService {
    @Resource
    private BzzTrainDao dao;
    
    public DataModel getDataPaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<EduBzzTrain>> entityPaging = dao.getDataPaging(page, rows , sort, order, filterRules, search, param);
        Integer key;
        key = (Integer)entityPaging.keySet().toArray()[0];
        return new DataModel().withData(entityPaging.get(key), key);
    }
    public DataModel getDataById(int id) throws Exception{
        return new DataModel().withData(dao.getDataById(id));
    }
    public DataModel delDataById(int id) throws SQLException, Exception {
        Map<Boolean, String> resultMap = dao.delDataById(id);
        return setResultModel(resultMap);
    }
    public DataModel addData(EduBzzTrain data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = dao.addData(data);
        return setResultModel(resultMap);
    }
    public DataModel upData(EduBzzTrain data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = dao.upData(data);
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
    public DataModel getLxPaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Map<String,Object>>> entityPaging = dao.getLxPaging(page, rows , sort, order, filterRules, search, param);
        Integer key;
        key = (Integer)entityPaging.keySet().toArray()[0];
        return new DataModel().withData(entityPaging.get(key), key);
    }
    
    public DataModel getAllBzz(String dwid,String year) throws SQLException, Exception {
        return new DataModel().withData(dao.getAllBzz(dwid,year));
    }
}
