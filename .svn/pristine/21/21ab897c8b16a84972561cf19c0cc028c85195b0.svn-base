/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.EduBzzTrain;
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
public class BzzTrainDao {
    @Resource(name = "db1")
    private DbUtilsPlus db;

    public Map<Integer, List<EduBzzTrain>> getDataPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String temp = search.equals("true") ? "b.name" : "d.treename";
        String _from = "select a.*,"+temp+" dworbm,e.em_name as username,case when e.em_egender=1 THEN '男' else '女' end as usersex,em_birthday as userbird,b.u_id as dwid,d.treename as bz from EDU_BZZ_TRAIN a INNER JOIN EMPLOYEE e on a.userpid=e.EM_IDCARD INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID INNER JOIN B_UNIT b on b.u_id=p.dw_id INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EduBzzTrain>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(EduBzzTrain.class, querySql, param));
        return map;
    }
    
    public EduBzzTrain getDataById(int id) throws SQLException, Exception {
        String sql = "select a.*,e.em_name as username from EDU_BZZ_TRAIN a INNER JOIN EMPLOYEE e on a.userpid=e.EM_IDCARD where id=?";
        return db.queryBean(EduBzzTrain.class, sql, id);
    }

    public Map<Boolean, String> delDataById(int id) throws SQLException, Exception {
        String sql = "delete from EDU_BZZ_TRAIN where id=?";
        db.update(sql, id);
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "删除成功！");
        return resultMap;
    }
    
    public Map<Boolean, String> addData(EduBzzTrain data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from EDU_BZZ_TRAIN where USERPID=?";
        Integer count = Integer.parseInt(db.queryArray(sql, data.getUserpid())[0].toString());
        if (count <= 0) {
            sql = "insert into EDU_BZZ_TRAIN(userpid,begindate,enddate,memo,filepath,classno,address,study_hour,cj,fzdw,fzdate,dzlh,dzldate,sjurl,companyid)"
                    + " values(?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?,to_date(?,'yyyy-mm-dd'),?,?)";
            db.insert(sql,
                    data.getUserpid(),data.getBegindate(),data.getEnddate(),data.getMemo(),data.getFilepath(),data.getClassno(),data.getAddress(),data.getStudy_hour()
                    ,data.getCj(),data.getFzdw(),data.getFzdate(),data.getDzlh(),data.getDzldate(),data.getSjurl(),data.getCompanyid()
            );
            resultMap.put(true, "添加成功！");
        } else {
            resultMap.put(false, "添加失败，该身份证号[ " + data.getUserpid()+ " ]数据已经存在！");
        }
        return resultMap;
    }

    public Map<Boolean, String> upData(EduBzzTrain data) throws SQLException, Exception {
        String sql = "update EDU_BZZ_TRAIN set begindate=to_date(?,'yyyy-mm-dd'),enddate=to_date(?,'yyyy-mm-dd'),memo=?,filepath=?,classno=?,address=?,study_hour=?,cj=?,fzdw=?"
                + ",fzdate=to_date(?,'yyyy-mm-dd'),dzlh=?,dzldate=to_date(?,'yyyy-mm-dd'),sjurl=? where id=?";
        db.update(sql, 
                    data.getBegindate(),data.getEnddate(),data.getMemo(),data.getFilepath(),data.getClassno(),data.getAddress(),data.getStudy_hour(),data.getCj(),data.getFzdw()
                ,data.getFzdate(),data.getDzlh(),data.getDzldate(),data.getSjurl(),data.getId()
        );       
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }
    
    public Map<Integer, List<Map<String,Object>>> getLxPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String _from = "select t.stu_idcard,t.stu_phy_points,c.startdate,c.enddate from EDU_STUDENTS t inner join edu_class c on t.class_no = c.classno where c.classtype='现任工班长'";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Map<String,Object>>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryMapList(querySql, param));
        return map;
    }
    
    public List<Map<String,Object>> getAllBzz(String dwid,String year) throws SQLException, Exception {
        String sql = "select d.treename,e.em_idcard,e.em_name,e.em_gz,e.em_birthday,e.em_eduback,e.em_joblevel,a.address,a.begindate,a.enddate,a.study_hour,a.cj,a.dzlh,a.dzldate,a.memo\n" +
                        "from edu_bzz_train a left join employee e on a.userpid=e.em_idcard \n" +
                        "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n" +
                        "INNER JOIN B_UNIT b on b.u_id=p.dw_id \n" +
                        "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id \n" +
                        "where b.u_id=? and to_char(begindate,'YYYYMMDD') like ?";
        return db.queryMapList(sql, dwid, year+"%");
    }
}
