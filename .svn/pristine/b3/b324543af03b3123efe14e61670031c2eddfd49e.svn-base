/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.commons.tools.DateUtil;
import cr.cdrb.web.edu.daointerface.IPlanReview;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 *
 * 培训计划审批
 */
@Repository
public class PlanReviewDao implements IPlanReview {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public Boolean addReview(EduReviews plan) throws SQLException {
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,idcard,current_unit,current_unitid,transfer_code,review_date)  values\n"
                + "  ('" + UUID.randomUUID() + "', ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String updaePlan = "update edu_plans set plan_status_cmt=? where plan_code=?";
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            oracle.sql.ROWID rowid = db.insert(insSql, plan.getPlan_code(), plan.getReviewer(), plan.getReview_status(), plan.getReview_cmt(), plan.getReview_url(), plan.getPlan_status_cmt(),plan.getIdcard(),plan.getCurrent_unit(),plan.getCurrent_unitid(),plan.getTransfer_code(),DateUtil.FormatDate(plan.getReview_date()));
            int i = (int) db.update(updaePlan,"由"+plan.getReviewer()+plan.getPlan_status_cmt()+"完成", plan.getPlan_code());
            conn.commit();
            conn.setAutoCommit(true);
            return !rowid.isNull() && i > 0;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean updateReview(EduReviews plan) throws SQLException {
        String updateSql = "update edu_plans_reviews plan_code = v_plan_code,reviewer = v_reviewer,review_status = v_review_status,review_cmt = v_review_cmt,review_url = v_review_url,plan_status_cmt = v_plan_status_cmt,review_date = v_review_date where review_dcode = v_review_dcode";
        return (int) db.update(updateSql, plan.getPlan_code(), plan.getReviewer(), plan.getReview_status(), plan.getReview_cmt(), plan.getReview_url(), plan.getPlan_status_cmt(), plan.getReview_date(), plan.getReview_dcode()) > 0;
    }

    @Override
    public Boolean removeReview(String ids) throws SQLException {
        String removeSql = "delete from eud_plan_reviews where plan_dcode=?";
        return (int) db.update(removeSql, ids) > 0;
    }

    @Override
    public Map<Integer, List<EduReviews>> getReviewPage(QueryModel pageModel) throws Throwable {
        List<Object> list = new ArrayList<Object>();
        String whereSql = "";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select plan_code, plan_name, plan_num, plan_periods, plan_sdate, plan_edate, plan_object, plan_cmt, plan_type, plan_executeunit, plan_unit, plan_situation, plan_execunitid, plan_unitid, plan_profid, plan_prof, plan_class, plan_status_cmt, plan_status from edu_plans")
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EduReviews>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql);
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(EduReviews.class, querySql, list.toArray()));
        return map;
    }

    @Override
    public EduReviews getReviewById(String id) throws SQLException {
        String querySql = "select review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt, review_date from edu_plans_reviews where review_dcode=?";
        return db.queryBean(EduReviews.class, querySql, id);
    }

    @Override
    public List<EduReviews> getReview(Object... params) throws SQLException {
        String querySql = "select review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt, review_date from edu_plans_reviews where review_dcode in(?)";
        return db.queryBeanList(EduReviews.class, querySql, params);
    }

    @Override
    public Boolean authReview(EduReviews review) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
