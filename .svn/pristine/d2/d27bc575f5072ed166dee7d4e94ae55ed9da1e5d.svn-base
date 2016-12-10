/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.EDU_TRAINING_EXPENSE;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

/**
 *
 * @author milord
 */
@Repository
public class EduTrainingExpenseDao {
    @Resource(name = "db1")
    private DbUtilsPlus db;
    
    public Map<Integer, List<EDU_TRAINING_EXPENSE>> getDataPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String _from = "select * from EDU_TRAINING_EXPENSE";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EDU_TRAINING_EXPENSE>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(EDU_TRAINING_EXPENSE.class, querySql, param));
        return map;
    }
    
    public List<EDU_TRAINING_EXPENSE> getDataByWhere(String whereStr,String gp) throws SQLException, Exception {
        String sql = "select * from EDU_TRAINING_EXPENSE where "+whereStr+" order by id";
        if(!StringUtils.isBlank(gp))
            sql = "select " + gp + " from EDU_TRAINING_EXPENSE where "+whereStr+" group by " + gp +" order by " + gp;
        return db.queryBeanList(EDU_TRAINING_EXPENSE.class, sql);
    }

    public EDU_TRAINING_EXPENSE getDataById(int id) throws SQLException, Exception {
        String sql = "select * from EDU_TRAINING_EXPENSE where id=?";
        return db.queryBean(EDU_TRAINING_EXPENSE.class, sql, id);
    }
    
    public Map<Boolean, String> delDataById(int id) throws SQLException, Exception {
        String sql = "delete from EDU_TRAINING_EXPENSE where id=?";
        db.update(sql, id);
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "删除成功！");
        return resultMap;
    }

    public Map<Boolean, String> addData(EDU_TRAINING_EXPENSE data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "insert into EDU_TRAINING_EXPENSE(TYPE,POSTTYPE,UNIT,JN_MIN_EXPENSE,JN_MAX_EXPENSE,JW_MIN_EXPENSE,JW_MAX_EXPENSE,MEMO,PARENTID,TYPECODE) values(?,?,?,?,?,?,?,?,?,?)";
        db.insert(sql, data.getType(), data.getPosttype(), data.getUnit(), data.getJn_min_expense(), data.getJn_max_expense(), data.getJw_min_expense(), data.getJw_max_expense(), data.getMemo(),data.getParentid(),data.getTypecode());
        resultMap.put(true, "添加成功！");
        return resultMap;
    }

    public Map<Boolean, String> upData(EDU_TRAINING_EXPENSE data) throws SQLException, Exception {
        String sql = "update EDU_TRAINING_EXPENSE set TYPE=?,POSTTYPE=?,UNIT=?,JN_MIN_EXPENSE=?,JN_MAX_EXPENSE=?,JW_MIN_EXPENSE=?,JW_MAX_EXPENSE=?,MEMO=?,TYPECODE=?,PARENTID=? where id=?";
        db.update(sql, data.getType(), data.getPosttype(), data.getUnit(), data.getJn_min_expense(), data.getJn_max_expense(), data.getJw_min_expense(), data.getJw_max_expense(), data.getMemo(), data.getTypecode(), data.getParentid(), data.getId());       
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }
}
