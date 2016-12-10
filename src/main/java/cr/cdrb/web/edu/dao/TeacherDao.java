/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.Teacher;
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
public class TeacherDao {
    @Resource(name = "db1")
    private DbUtilsPlus db;
    public Map<Integer, List<Teacher>> getTeachersPaging(int page, int rows, String sort, String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select a.*,e.em_name name,(case when e.em_egender=1 THEN '男' else '女' end) as sex,e.em_birthday birthday,e.em_gw,e.em_gz,e.em_politicalstatus,e.em_graduatedfrom,e.em_sxzy,e.em_eduback,e.em_degree,b.system,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname,d.treename bmtreename from edu_teacher a \n" +
                        "INNER JOIN EMPLOYEE e on a.pid=e.EM_IDCARD \n" +
                        "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n" +
                        "INNER JOIN B_UNIT b on b.u_id=p.dw_id\n" +
                        "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id")
                .where(filterRules)
                .orderBy("dwname,xh,name")
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Teacher>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(Teacher.class, querySql, param));
        return map;
    }
    
    public Map<Boolean, String> insertTeacher(Teacher data) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_teacher where PID=?";
        Integer count = Integer.parseInt(db.queryArray(sql, data.getPid())[0].toString());
        if (count <= 0) {
            sql = "insert into edu_teacher(pid,edu_date,type,subject,jxjy_date,hire_date,memo,cert,prof,optuserid,optusername,optdate,iszz,isjpjz,iszdjz,zjjl,ll,sz,phone,mobile,xh) values(?,to_date(?,'yyyy-mm-dd'),?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?)";
            db.insert(sql, data.getPid(), data.getEdu_date(), data.getType(),data.getSubject(), data.getJxjy_date(), data.getHire_date(),data.getMemo(), data.getCert(),data.getProf(),data.getOptuserid(),data.getOptusername(),data.getOptdate(),data.getIszz(),data.getIsjpjz(),data.getIszdjz(),data.getZjjl(),data.getLl(),data.getSz(),data.getPhone(),data.getMobile(),data.getXh());
            //
            if(data.getIszz()==1){
                sql = "select count(1) from EDU_GROUP_MEMBERS where IDCARD=?";
                count = Integer.parseInt(db.queryArray(sql, data.getPid())[0].toString());
                if (count <= 0) {
                    sql = "insert into EDU_GROUP_MEMBERS(id,idcard,group_id) values(edu_group_members_seq.nextval,?,2)";
                    db.insert(sql,data.getPid());
                }
            }
            resultMap.put(true, "保存成功！");
        } else {
            resultMap.put(false, "保存失败，该用户[ " + data.getPid() + " ]数据已经存在！");
        }
        return resultMap;
    }
    
    public Map<Boolean, String> updateTeacher(Teacher data) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "update edu_teacher set edu_date=to_date(?,'yyyy-mm-dd'),type=?,subject=?,jxjy_date=to_date(?,'yyyy-mm-dd'),hire_date=to_date(?,'yyyy-mm-dd'),memo=?,cert=?,prof=?,iszz=?,isjpjz=?,iszdjz=?,zjjl=?,ll=?,sz=?,optuserid=?,optusername=?,optdate=to_date(?,'yyyy-mm-dd'),phone=?,mobile=?,xh=? where pid=?";
        db.update(sql,data.getEdu_date(), data.getType(),data.getSubject(), data.getJxjy_date(), data.getHire_date(),data.getMemo(), data.getCert(),data.getProf(),data.getIszz(),data.getIsjpjz(),data.getIszdjz(),data.getZjjl(),data.getLl(),data.getSz(),data.getOptuserid(),data.getOptusername(),data.getOptdate(),data.getPhone(),data.getMobile(),data.getXh(),data.getPid());
        sql = "select count(1) from EDU_GROUP_MEMBERS where IDCARD=?";
        Integer count = Integer.parseInt(db.queryArray(sql, data.getPid())[0].toString());
        if(data.getIszz()==1){
            if (count <= 0) {
                sql = "insert into EDU_GROUP_MEMBERS(id,idcard,group_id) values(edu_group_members_seq.nextval,?,2)";
                db.insert(sql,data.getPid());
            }
        }else if(data.getIszz()==0){
            if (count > 0) {
                sql = "delete from EDU_GROUP_MEMBERS where IDCARD=?";
                db.update(sql,data.getPid());
            }
        }
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }

    public Map<Boolean, String> deleteTeacher(String pid) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "delete from edu_teacher where pid=?";
        db.update(sql, pid);
        sql = "delete from EDU_GROUP_MEMBERS where IDCARD=?";
        db.update(sql,pid);
        resultMap.put(true, "删除成功！");
        return resultMap;
    }

    public Teacher getTeacherByPid(String pid) throws Exception {
        String sql = "select t.*,e.em_name name,(case when e.em_egender=1 THEN '男' else '女' end) as sex from edu_teacher t left join employee e on t.pid=e.em_idcard where pid=?";
        Teacher card = db.queryBean(Teacher.class, sql, pid);
        return card;
    }
    
    public List<Teacher> getZZTeachers(String zjcid) throws SQLException, Exception {
        String sql = "select '路局职教部门' tyname,1 tyid,a.*,e.em_name name,(case when e.em_egender=1 THEN '男' else '女' end) as sex,e.em_birthday birthday,e.em_gw,e.em_gz,e.em_politicalstatus,e.em_graduatedfrom,e.em_sxzy,e.em_eduback,e.em_degree,b.system,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname,d.treename bmtreename from edu_teacher a \n" +
            "INNER JOIN EMPLOYEE e on a.pid=e.EM_IDCARD \n" +
            "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n" +
            "INNER JOIN B_UNIT b on b.u_id=p.dw_id\n" +
            "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id\n" +
            "where b.u_id='"+zjcid+"' and iszz=1\n" +
            "union all\n" +
            "select '局级培训基地' tyname,2 tyid,a.*,e.em_name name,(case when e.em_egender=1 THEN '男' else '女' end) as sex,e.em_birthday birthday,e.em_gw,e.em_gz,e.em_politicalstatus,e.em_graduatedfrom,e.em_sxzy,e.em_eduback,e.em_degree,b.system,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname,d.treename bmtreename from edu_teacher a \n" +
            "INNER JOIN EMPLOYEE e on a.pid=e.EM_IDCARD \n" +
            "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n" +
            "INNER JOIN B_UNIT b on b.u_id=p.dw_id\n" +
            "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id\n" +
            "where b.name like '%基地' and b.u_id !='"+zjcid+"' and iszz=1\n" +
            "union all\n" +
            "select '基层站段' tyname,3 tyid,a.*,e.em_name name,(case when e.em_egender=1 THEN '男' else '女' end) as sex,e.em_birthday birthday,e.em_gw,e.em_gz,e.em_politicalstatus,e.em_graduatedfrom,e.em_sxzy,e.em_eduback,e.em_degree,b.system,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname,d.treename bmtreename from edu_teacher a \n" +
            "INNER JOIN EMPLOYEE e on a.pid=e.EM_IDCARD \n" +
            "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n" +
            "INNER JOIN B_UNIT b on b.u_id=p.dw_id\n" +
            "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id\n" +
            "where b.u_id !='"+zjcid+"' and b.name not like '%基地' and iszz=1\n" +
            "order by tyid";
        return db.queryBeanList(Teacher.class, sql);
    }
}
