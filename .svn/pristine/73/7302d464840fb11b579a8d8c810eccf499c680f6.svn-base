/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.Edunewpost;
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
public class EduNewPostNDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    public Map<Integer, List<Edunewpost>> getDataPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String temp = search.equals("true") ? "b.name" : "d.treename";
        String _from = "select a.*,"+temp+" dworbm,b.u_id dwid from edu_new_post_n a INNER JOIN EMPLOYEE e on a.userpid=e.EM_IDCARD INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID INNER JOIN B_UNIT b on b.u_id=p.dw_id INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy("to_char(ll_begindate,'YYYYMM') desc,username asc")
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Edunewpost>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(Edunewpost.class, querySql, param));
        return map;
    }

    public Edunewpost getDataById(int id) throws SQLException, Exception {
        String sql = "select * from edu_new_post_n where id=?";
        return db.queryBean(Edunewpost.class, sql, id);
    }

    public Map<Boolean, String> delDataById(int id) throws SQLException, Exception {
        String sql = "delete from edu_new_post_n where id=?";
        db.update(sql, id);
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "删除成功！");
        return resultMap;
    }

    public Map<Boolean, String> addData(Edunewpost data) throws SQLException, Exception {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_new_post_n where userpid=? and new_post=?";
        Integer count = Integer.parseInt(db.queryArray(sql, data.getUserpid(), data.getNew_post())[0].toString());
        if (count <= 0) {
            sql = "insert into edu_new_post_n(username,usersex,usereduback,userpid,workshop,bz,old_post,new_post,pxlb,pxxs,crh,study_no,study_date,aq_begindate,aq_enddate,aq_classno,aq_address"
                    + ",aq_study_hour,aq_cj,aq_khyj,aq_fzr,aq_sj_url,aq_cj_cj,aq_cj_fzr,aq_cj_khyj,aq_bz_cj,aq_bz_fzr,aq_bz_khyj,ll_begindate,ll_enddate,ll_classno,ll_address,ll_study_hour,ll_cj"
                    + ",ll_sj_url,sz_pactno,sz_begindate,sz_enddate,sz_teacher_name,sz_address,sz_study_hour,sz_cj,sz_sj_url,fzdw,fzrq,dzl_no,dzl_date,companyid,filepath) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd')"
                    + ",?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?,to_date(?,'yyyy-mm-dd'),?,?)";
            db.insert(sql, 
                    data.getUsername(),data.getUsersex(),data.getUsereduback(),data.getUserpid(),data.getWorkshop(),data.getBz(),data.getOld_post(),data.getNew_post(),data.getPxlb(),data.getPxxs()
                    ,data.getCrh(),data.getStudy_no(),data.getStudy_date(),data.getAq_begindate(),data.getAq_enddate(),data.getAq_classno(),data.getAq_address(),data.getAq_study_hour(),data.getAq_cj()
                    ,data.getAq_khyj(),data.getAq_fzr(),data.getAq_sj_url(),data.getAq_cj_cj(),data.getAq_cj_fzr(),data.getAq_cj_khyj(),data.getAq_bz_cj(),data.getAq_bz_fzr(),data.getAq_bz_khyj()
                    ,data.getLl_begindate(),data.getLl_enddate(),data.getLl_classno(),data.getLl_address(),data.getLl_study_hour(),data.getLl_cj(),data.getLl_sj_url(),data.getSz_pactno(),data.getSz_begindate()
                    ,data.getSz_enddate(),data.getSz_teacher_name(),data.getSz_address(),data.getSz_study_hour(),data.getSz_cj(),data.getSz_sj_url(),data.getFzdw(),data.getFzrq(),data.getDzl_no()
                    ,data.getDzl_date(),data.getCompanyid(),data.getFilepath()
            );
            resultMap.put(true, "添加成功！");
        } else {
            resultMap.put(false, "添加失败，该身份证号[ " + data.getUserpid()+ " ]学习职名[ " + data.getNew_post() + " ]数据已经存在！");
        }
        return resultMap;
    }

    public Map<Boolean, String> upData(Edunewpost data) throws SQLException, Exception {
        String sql = "update edu_new_post_n set username=?,usersex=?,usereduback=?,userpid=?,workshop=?,bz=?,old_post=?,new_post=?,pxlb=?,pxxs=?,crh=?,study_no=?,study_date=to_date(?,'yyyy-mm-dd')"
                + ",aq_begindate=to_date(?,'yyyy-mm-dd'),aq_enddate=to_date(?,'yyyy-mm-dd'),aq_classno=?,aq_address=?,aq_study_hour=?,aq_cj=?,aq_khyj=?,aq_fzr=?,aq_sj_url=?,aq_cj_cj=?,aq_cj_fzr=?"
                + ",aq_cj_khyj=?,aq_bz_cj=?,aq_bz_fzr=?,aq_bz_khyj=?,ll_begindate=to_date(?,'yyyy-mm-dd'),ll_enddate=to_date(?,'yyyy-mm-dd'),ll_classno=?,ll_address=?,ll_study_hour=?,ll_cj=?"
                + ",ll_sj_url=?,sz_pactno=?,sz_begindate=to_date(?,'yyyy-mm-dd'),sz_enddate=to_date(?,'yyyy-mm-dd'),sz_teacher_name=?,sz_address=?,sz_study_hour=?,sz_cj=?,sz_sj_url=?,fzdw=?"
                + ",fzrq=to_date(?,'yyyy-mm-dd'),dzl_no=?,dzl_date=to_date(?,'yyyy-mm-dd'),filepath=? where id=?";
        db.update(sql, 
                    data.getUsername(),data.getUsersex(),data.getUsereduback(),data.getUserpid(),data.getWorkshop(),data.getBz(),data.getOld_post(),data.getNew_post(),data.getPxlb(),data.getPxxs()
                    ,data.getCrh(),data.getStudy_no(),data.getStudy_date(),data.getAq_begindate(),data.getAq_enddate(),data.getAq_classno(),data.getAq_address(),data.getAq_study_hour(),data.getAq_cj()
                    ,data.getAq_khyj(),data.getAq_fzr(),data.getAq_sj_url(),data.getAq_cj_cj(),data.getAq_cj_fzr(),data.getAq_cj_khyj(),data.getAq_bz_cj(),data.getAq_bz_fzr(),data.getAq_bz_khyj()
                    ,data.getLl_begindate(),data.getLl_enddate(),data.getLl_classno(),data.getLl_address(),data.getLl_study_hour(),data.getLl_cj(),data.getLl_sj_url(),data.getSz_pactno(),data.getSz_begindate()
                    ,data.getSz_enddate(),data.getSz_teacher_name(),data.getSz_address(),data.getSz_study_hour(),data.getSz_cj(),data.getSz_sj_url(),data.getFzdw(),data.getFzrq(),data.getDzl_no()
                    ,data.getDzl_date(),data.getFilepath(),data.getId()
        );       
        Map<Boolean, String> resultMap = new HashMap<>();
        resultMap.put(true, "编辑成功！");
        return resultMap;
    }
}
