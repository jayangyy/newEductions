/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.Edu_Study_Content;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

/**
 *
 * @author milord
 */
@Repository
public class EduStudyContentDao {
    
    @Resource(name = "db1")
    private DbUtilsPlus db;
    
    public Map<Integer, List<Edu_Study_Content>> getDataPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String _from = "select t.id,t.newpostid,t.orderno,case t.study_type when '安全Ⅰ' then '安Ⅰ（段级）' when '安全Ⅱ' then '安Ⅱ（车间）' when '安全Ⅲ' then '安Ⅲ' when '理论知识' then '理论' when '实作技能' then '实作' end study_type,t.study_content,t.teacher,t.study_hours,t.memo from edu_study_content t";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy("study_type asc,orderno desc")
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Edu_Study_Content>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(Edu_Study_Content.class, querySql, param));
        return map;
    }
    
    public Edu_Study_Content getDataById(int id) throws SQLException, Exception {
        String sql = "select * from EDU_STUDY_CONTENT where id=?";
        return db.queryBean(Edu_Study_Content.class, sql, id);
    }

    public Map<Boolean, String> delDataById(int id) throws SQLException, Exception {
        String sql = "delete from EDU_STUDY_CONTENT where id=?";
        db.update(sql, id);
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "删除成功！");
        return resultMap;
    }

    public Map<Boolean, String> addData(Edu_Study_Content data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "insert into EDU_STUDY_CONTENT(newpostid,orderno,study_type,study_content,teacher,study_hours,memo) values(?,?,?,?,?,?,?)";
        db.insert(sql,data.getNewpostid(),data.getOrderno(),data.getStudy_type(),data.getStudy_content(),data.getTeacher(),data.getStudy_hours(),data.getMemo());
        resultMap.put(true, "添加成功！");
        return resultMap;
    }

    public Map<Boolean, String> upData(Edu_Study_Content data) throws SQLException, Exception {
        String sql = "update EDU_STUDY_CONTENT set orderno=?,study_type=?,study_content=?,teacher=?,study_hours=?,memo=? where id=?";
        db.update(sql,data.getOrderno(),data.getStudy_type(),data.getStudy_content(),data.getTeacher(),data.getStudy_hours(),data.getMemo(),data.getId());       
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }

    public Map<Boolean, String> copyStudyContent(int fromid,int toid) throws SQLException, Exception {
        String sql = "insert into edu_study_content(newpostid,orderno,study_type,study_content,teacher,study_hours,memo) select "+toid+",orderno,study_type,study_content,teacher,study_hours,memo from edu_study_content where newpostid="+fromid;
        db.update(sql);
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "复制成功！");
        return resultMap;
    }
}
