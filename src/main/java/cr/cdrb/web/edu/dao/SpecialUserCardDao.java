/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.commons.db.builder.SqlserverSelectBuilder;
import cr.cdrb.web.edu.model.Special_User_Card;
import cr.cdrb.web.edu.model.Special_User_Exam;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class SpecialUserCardDao {
    @Resource(name = "db1")
    private DbUtilsPlus db;
    public Map<Integer, List<Special_User_Card>> getSpecialUserCardPaging(int page, int rows, String sort, String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select u.*,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname,d.treename from edu_special_user_card u \n" +
                        "INNER JOIN EMPLOYEE e on u.pid=e.EM_IDCARD \n" +
                        "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n" +
                        "INNER JOIN B_UNIT b on b.u_id=p.dw_id \n" +
                        "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id")
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Special_User_Card>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql,param).toString());
        map.put(total, db.queryBeanList(Special_User_Card.class, querySql,param));
        return map;
    }
    
    public Map<Boolean, String> insertSpecialUserCard(Special_User_Card card) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_special_user_card where pid=?";
        Integer count = Integer.parseInt(db.queryArray(sql,card.getPid())[0].toString());
        if(count<=0){
            sql = "insert into edu_special_user_card(pid,name,sex,card_no,archives_no,award_unit,companyid,optuserid,optusername,optdate) values(?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'))";
            db.insert(sql,card.getPid(),card.getName(),card.getSex(),card.getCard_no(),card.getArchives_no(),card.getAward_unit(),card.getCompanyid(),card.getOptuserid(),card.getOptusername(),card.getOptdate());
            resultMap.put(true, "保存成功！");
        }else{
            resultMap.put(false, "保存失败，该身份证号[ "+card.getPid()+" ]用户数据已经存在！");
        }
        return resultMap;
    }
    
    public Map<Boolean, String> updateSpecialUserCard(Special_User_Card card) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "update edu_special_user_card set card_no=?,archives_no=?,award_unit=? where pid=?";
        db.update(sql,card.getCard_no(),card.getArchives_no(),card.getAward_unit(),card.getPid());
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }
    
    public Special_User_Card getSpecialUserCardByPid(String pid) throws Exception {
        String sql = "select * from edu_special_user_card where pid=?";
        Special_User_Card card = db.queryBean(Special_User_Card.class, sql, pid);
        return card;
    }
    
    public Map<Boolean, String> deleteSpecialUserCard(String pid) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "delete from edu_special_user_card where pid=?";
        db.update(sql, pid);
        resultMap.put(true, "删除成功！");
        return resultMap;
    }
    
    public Map<Integer, List<Special_User_Exam>> getSpecialUserExamPaging(int page, int rows, String sort, String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        ISelectBuilder builder = new OracleSelectBuilder()
//                .select("a.*,b.objname equipment_name")
                .from("select a.*,b.objname equipment_name from edu_special_user_exam a left join EDU_DIC_SPECIAL_EQUIPMENT b on a.equipment_code=b.code")
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Special_User_Exam>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql,param).toString());
        map.put(total, db.queryBeanList(Special_User_Exam.class, querySql,param));
        return map;
    }
    
    public Special_User_Exam getSpecialUserExamById(String id) throws Exception {
        String sql = "select * from edu_special_user_exam where id=?";
        Special_User_Exam exam = db.queryBean(Special_User_Exam.class, sql, id);
        return exam;
    }
    
    public Map<Boolean, String> deleteSpecialUserExam(String id) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "delete from edu_special_user_exam where id=?";
        db.update(sql, id);
        resultMap.put(true, "删除成功！");
        return resultMap;
    }
    
    public Map<Boolean, String> insertSpecialUserExam(Special_User_Exam exam) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_special_user_exam where equipment_code=? and pid=?";
        Integer count = Integer.parseInt(db.queryArray(sql,exam.getEquipment_code(),exam.getPid())[0].toString());
        if(count<=0){
            sql = "insert into edu_special_user_exam(pid,equipment_code,valid_begin_date,valid_end_date,hand_uesr) values(?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?)";
            db.insert(sql,exam.getPid(),exam.getEquipment_code(),exam.getValid_begin_date(),exam.getValid_end_date(),exam.getHand_uesr());
            resultMap.put(true, "保存成功！");
        }else{
            resultMap.put(false, "保存失败，该作业项目代号[ "+exam.getEquipment_code()+" ]已经存在！");
        }
        return resultMap;
    }
    
    public Map<Boolean, String> updateSpecialUserExam(Special_User_Exam exam) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "update edu_special_user_exam set equipment_code=?,valid_begin_date=to_date(?,'yyyy-mm-dd'),valid_end_date=to_date(?,'yyyy-mm-dd'),hand_uesr=? where id=?";
        db.update(sql,exam.getEquipment_code(),exam.getValid_begin_date(),exam.getValid_end_date(),exam.getHand_uesr(),exam.getId());
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }
}
