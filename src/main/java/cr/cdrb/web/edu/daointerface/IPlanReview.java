/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang 计划审批
 */
public interface IPlanReview {

    public Boolean addReview(EduReviews plan) throws SQLException;

    public Boolean updateReview(EduReviews plan) throws SQLException;

    public Boolean removeReview(String ids) throws SQLException;

    public Map<Integer, List<EduReviews>> getReviewPage(QueryModel pageModel) throws Throwable;

    public EduReviews getReviewById(String id) throws SQLException;

    public List<EduReviews> getReview(Object... params) throws SQLException;

    public Boolean authReview(EduReviews review) throws SQLException;
}
