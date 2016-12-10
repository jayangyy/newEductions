/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.SpecialUserCardDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.Special_User_Card;
import cr.cdrb.web.edu.model.Special_User_Exam;
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
public class SpecialUserCardService {
    @Resource
    private SpecialUserCardDao dao;
    
    public DataModel getSpecialUserCardPaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Special_User_Card>> cardsPaging = dao.getSpecialUserCardPaging(page, rows , sort, order, filterRules, search,param);
        Integer key;
        key = (Integer)cardsPaging.keySet().toArray()[0];
        return new DataModel().withData(cardsPaging.get(key), key);
    }
    
    public Object getSpecialUserCardByPid(String pid) throws Exception {
        return new DataModel().withData(dao.getSpecialUserCardByPid(pid));
    }
    
    public DataModel insertSpecialUserCard(Special_User_Card card) throws Exception {
        Map<Boolean, String> resultMap = dao.insertSpecialUserCard(card);
        return setResultModel(resultMap);
    }
    
    public DataModel updateSpecialUserCard(Special_User_Card card) throws Exception {
        Map<Boolean, String> resultMap = dao.updateSpecialUserCard(card);
        return setResultModel(resultMap);
    }
    
    public DataModel deleteSpecialUserCard(String pid) throws Exception {
        Map<Boolean, String> resultMap = dao.deleteSpecialUserCard(pid);
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
    
    public DataModel getSpecialUserExamPaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Special_User_Exam>> cardsPaging = dao.getSpecialUserExamPaging(page, rows , sort, order, filterRules, search,param);
        Integer key;
        key = (Integer)cardsPaging.keySet().toArray()[0];
        return new DataModel().withData(cardsPaging.get(key), key);
    }
    
    public Object getSpecialUserExamById(String id) throws Exception {
        return new DataModel().withData(dao.getSpecialUserExamById(id));
    }
    
    public DataModel deleteSpecialUserExam(String id) throws Exception {
        Map<Boolean, String> resultMap = dao.deleteSpecialUserExam(id);
        return setResultModel(resultMap);
    }
    
    public DataModel insertSpecialUserExam(Special_User_Exam exam) throws Exception {
        Map<Boolean, String> resultMap = dao.insertSpecialUserExam(exam);
        return setResultModel(resultMap);
    }
    
    public DataModel updateSpecialUserExam(Special_User_Exam exam) throws Exception {
        Map<Boolean, String> resultMap = dao.updateSpecialUserExam(exam);
        return setResultModel(resultMap);
    }
}
