/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.DicSystem;
import cr.cdrb.web.edu.model.Employee;
import cr.cdrb.web.edu.model.UnifyPost;
import cr.cdrb.web.edu.model.WorkType;
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
public class EmployeeDao {
    
    @Resource(name = "db1")
    private DbUtilsPlus db;

    public Map<Integer, List<Employee>> getEmployeePaging(int page, int rows, String sort, String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        String _from = "select em_id,em_name,em_number,case when em_egender=1 THEN '男' else '女' end as em_egender,em_birthday,em_workdate,em_eduback,em_degree,em_homeaddress,em_idcard,em_gw,em_gz,em_gpz,em_zjid,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname\n" +
                            "from employee t inner join v_position p on t.em_id=p.employee_id\n" +
                            "inner join b_unit b on b.u_id=p.dw_id\n" +
                            "inner join b_department d on d.dwxxbmbs=p.bm_id";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Employee>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(Employee.class, querySql, param));
        return map;
    }
    
    @Resource(name = "db4")
    private DbUtilsPlus db4;
    public List<DicSystem> getAllSystem() throws SQLException{
        String sql = "select 编号 id,系统名称 name from 系统";
        return db4.queryBeanList(DicSystem.class, sql);
    }
    
    public List<WorkType> getAllGzBySystemId(String sysid) throws SQLException{
        String sql = "select 编号 id,工种名称 name,系统编号 systemid,工种分类 type,单位编号 dwnum from 工种 where 单位编号=-1 and 系统编号=?";
        return db4.queryBeanList(WorkType.class, sql, sysid);
    }
    
    public List<UnifyPost> getAllGwByGzId(String gzid) throws SQLException{
        String sql = "select 编号 id,工种编号 gzid,岗位名称 name from 岗位 where 工种编号=?";
        return db4.queryBeanList(UnifyPost.class, sql, gzid);
    }
    
    public Map<Boolean, String> setGzgw(String uids,String gz,String gw) throws SQLException{
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "update employee set em_gw=?,em_gz=? where em_id=?";
        String[] emids = uids.split(",");
        for (int i = 0; i < emids.length; i++) {
            db.update(sql,gw,gz,emids[i]);
        }
        resultMap.put(true, "操作成功！");
        return resultMap;
    }
    
    public Employee getEmployeeByPid(String idcard) throws SQLException{
        String sql = "select sysdate em_tempdate,em_id,em_name,em_number,case when em_egender=1 THEN '男' else '女' end as em_egender,em_birthday,em_workdate,em_eduback,em_joblevel,em_rlrq,em_gzrq,em_from,em_degree,em_homeaddress,em_idcard,em_gw,em_gz,em_gpz,em_zjid,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname\n" +
                        "from employee t inner join v_position p on t.em_id=p.employee_id\n" +
                        "inner join b_unit b on b.u_id=p.dw_id\n" +
                        "inner join b_department d on d.dwxxbmbs=p.bm_id where em_idcard=?";
        return db.queryBean(Employee.class,sql,idcard);
    }
    
    public Object getStudent(String whereStr) throws SQLException{
        String sql = "select edu_students.STU_CER_DATE from edu_students,edu_class where edu_students.CLASS_NO = edu_class.CLASSNO "+whereStr +" order by STU_CER_DATE";
        return db.queryMapList(sql);
    }
}
