/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.Eud_New_Post;
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
public class EduNewPostDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    public Map<Integer, List<Eud_New_Post>> getDataPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String _from = "select t.*,em_name name,case when e.em_egender=1 THEN '男' else '女' end as sex,em_eduback xl from EDU_NEW_POST t left join employee e on t.idcard=e.em_idcard";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Eud_New_Post>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(Eud_New_Post.class, querySql, param));
        return map;
    }

    public Eud_New_Post getDataById(int id) throws SQLException, Exception {
        String sql = "select t.*,em_name name,case when e.em_egender=1 THEN '男' else '女' end as sex,em_eduback xl from EDU_NEW_POST t left join employee e on t.idcard=e.em_idcard where t.id=?";
        return db.queryBean(Eud_New_Post.class, sql, id);
    }

    public Map<Boolean, String> delDataById(int id) throws SQLException, Exception {
        String sql = "delete from EDU_NEW_POST where id=?";
        db.update(sql, id);
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "删除成功！");
        return resultMap;
    }

    public Map<Boolean, String> addData(Eud_New_Post data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_new_post where idcard=? and new_post=?";
        Integer count = Integer.parseInt(db.queryArray(sql, data.getIdcard(), data.getNew_post())[0].toString());
        if (count <= 0) {
            sql = "insert into edu_new_post(idcard,workshop,training_type,old_post,new_post,study_date,study_no,rljy_begindate,rljy_enddate,llpx_type,llpx_begindate,llpx_enddate,szpx_begindate,szpx_enddate,szpx_teacher,dzkscj_aq,dzkscj_ll,dzkscj_sz,dzl_date,dzl_no,crh,address1,studyhour1,address2,studyhour2,address3,studyhour3,classno,indenture,cjaqcj,bzaqcj,lzfzr,zjfzr,cjpxr,bzpxr,fzdw,fzrq,companyid,filepath) values(?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?,?)";
            db.insert(sql, data.getIdcard(), data.getWorkshop(), data.getTraining_type(), data.getOld_post(), data.getNew_post(), data.getStudy_date(), data.getStudy_no(), data.getRljy_begindate(), data.getRljy_enddate(), data.getLlpx_type(), data.getLlpx_begindate(), data.getLlpx_enddate(), data.getSzpx_begindate(), data.getSzpx_enddate(), data.getSzpx_teacher(), data.getDzkscj_aq(), data.getDzkscj_ll(), data.getDzkscj_sz(), data.getDzl_date(), data.getDzl_no(), data.getCrh(), data.getAddress1(), data.getStudyhour1(), data.getAddress2(), data.getStudyhour2(), data.getAddress3(), data.getStudyhour3(), data.getClassno(), data.getIndenture(), data.getCjaqcj(), data.getBzaqcj(), data.getLzfzr(), data.getZjfzr(), data.getCjpxr(), data.getBzpxr(), data.getFzdw(), data.getFzrq(),data.getCompanyid(),data.getFilepath());
            resultMap.put(true, "添加成功！");
        } else {
            resultMap.put(false, "添加失败，该身份证号[ " + data.getIdcard() + " ]学习职名[ " + data.getNew_post() + " ]数据已经存在！");
        }
        return resultMap;
    }

    public Map<Boolean, String> upData(Eud_New_Post data) throws SQLException, Exception {
        String sql = "update edu_new_post set workshop=?,training_type=?,old_post=?,new_post=?,study_date=to_date(?,'yyyy-mm-dd'),study_no=?,rljy_begindate=to_date(?,'yyyy-mm-dd'),rljy_enddate=to_date(?,'yyyy-mm-dd'),llpx_type=?,llpx_begindate=to_date(?,'yyyy-mm-dd'),llpx_enddate=to_date(?,'yyyy-mm-dd'),szpx_begindate=to_date(?,'yyyy-mm-dd'),szpx_enddate=to_date(?,'yyyy-mm-dd'),szpx_teacher=?,dzkscj_aq=?,dzkscj_ll=?,dzkscj_sz=?,dzl_date=to_date(?,'yyyy-mm-dd'),dzl_no=?,crh=?,address1=?,studyhour1=?,address2=?,studyhour2=?,address3=?,studyhour3=?,classno=?,indenture=?,cjaqcj=?,bzaqcj=?,lzfzr=?,zjfzr=?,cjpxr=?,bzpxr=?,fzdw=?,fzrq=to_date(?,'yyyy-mm-dd'),filepath=? where id=?";
        db.update(sql, data.getWorkshop(), data.getTraining_type(), data.getOld_post(), data.getNew_post(), data.getStudy_date(), data.getStudy_no(), data.getRljy_begindate(), data.getRljy_enddate(), data.getLlpx_type(), data.getLlpx_begindate(), data.getLlpx_enddate(), data.getSzpx_begindate(), data.getSzpx_enddate(), data.getSzpx_teacher(), data.getDzkscj_aq(), data.getDzkscj_ll(), data.getDzkscj_sz(), data.getDzl_date(), data.getDzl_no(), data.getCrh(), data.getAddress1(), data.getStudyhour1(), data.getAddress2(), data.getStudyhour2(), data.getAddress3(), data.getStudyhour3(), data.getClassno(), data.getIndenture(), data.getCjaqcj(), data.getBzaqcj(), data.getLzfzr(), data.getZjfzr(), data.getCjpxr(), data.getBzpxr(), data.getFzdw(), data.getFzrq(),data.getFilepath(), data.getId());       
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }
}
