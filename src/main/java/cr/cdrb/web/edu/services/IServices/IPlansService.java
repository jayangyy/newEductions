/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.eduplans.EduAbroadType;
import cr.cdrb.web.edu.domains.eduplans.EduHighspeedFlag;
import cr.cdrb.web.edu.domains.eduplans.EduPlanCost;
import cr.cdrb.web.edu.domains.eduplans.EduPlanSearch;
import cr.cdrb.web.edu.domains.eduplans.EduPlanTransfer;
import cr.cdrb.web.edu.domains.eduplans.EduPlans;
import cr.cdrb.web.edu.domains.eduplans.EduPlansTransDto;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import cr.cdrb.web.edu.domains.eduplans.EduSocTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduSocialExecunit;
import cr.cdrb.web.edu.domains.eduplans.EduSocialMainunit;
import cr.cdrb.web.edu.domains.eduplans.EduStationChannel;
import cr.cdrb.web.edu.domains.eduplans.EduStationTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduStationtPersons;
import cr.cdrb.web.edu.domains.eduplans.EduTeachesType;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Jayang
 *
 * 培训计划服务接口
 */
public interface IPlansService {
// <editor-fold desc="培训计划制定">

    /**
     *
     * @author Jayang 新增培训计划
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel addPlan(EduPlans plan) throws SQLException;

    /**
     *
     * @author Jayang 更细培训计划
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel updatePlan(EduPlans plan) throws SQLException;

    /**
     *
     * @author Jayang 获取培训计划分页
     * @param model 分页模型
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel getPlansPages(EduPlanSearch model) throws Throwable;

    /**
     *
     * @author Jayang 删除培训计划
     * @param ids 计划ID
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel removePlan(String ids) throws SQLException;

    /**
     *
     * @author Jayang 更细培训计划
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel overPlan(EduReviews review) throws SQLException;

    /**
     *
     * @author Jayang 更细培训计划
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel throwPlan(EduReviews review) throws SQLException;

    /**
     *
     * @author Jayang 获取培训计划
     * @param id 计划ID
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public EduPlans getPlan(String id) throws SQLException;

    /**
     *
     * @author Jayang 获取培训计划(包含主外键关系)
     * @param id 计划ID
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public EduPlans getPlanInclude(String id) throws SQLException;

    /**
     *
     * @author Jayang 获取培训计划列表
     * @param params
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public List<EduPlans> getPlans(Object... params) throws SQLException;

    // </editor-fold>
// <editor-fold desc="培训计划审批">
    /**
     *
     * @author Jayang 新增培训计划
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel addReview(EduReviews plan) throws SQLException;

    /**
     *
     * @author Jayang 处室移送
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel transOfficPlan(EduPlans plan) throws SQLException;

    /**
     *
     * @author Jayang 更细培训计划
     * @param plan 培训计划数据
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel updateReview(EduReviews plan) throws SQLException;

    /**
     *
     * @author Jayang 删除计划审批项
     * @param ids 审批ID号
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel removeReview(String ids) throws SQLException;

    /**
     *
     * @author Jayang 获取计划审批详细
     * @param pageModel 分页模型
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel getReviewPage(QueryModel pageModel) throws Throwable;

    /**
     *
     * @author Jayang 获取计划审批项
     * @param id 审批号
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public EduReviews getReview(String id) throws SQLException;

    /**
     *
     * @author Jayang 获取审核详细
     * @param params
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public List<EduReviews> getReviews(Object... params) throws SQLException;

    // </editor-fold>
    public List<EduProf> getProfs(Object... uids) throws SQLException;

    public DataModel getEmployeePage(QueryModel pageModel, String unit, String username) throws Throwable;

    public DataModel getTransPlanPage(EduPlanSearch pageModel) throws Throwable;

    /**
     *
     * @author Jayang 移送单位审核通过
     * @param review
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel authPassed(EduReviews review) throws SQLException;

    /**
     *
     * @author Jayang 移送单位再移送
     * @param review
     * @param transfers
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel authTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException;

    /**
     *
     * @author Jayang 回发拟稿人
     * @param review
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel authBacktop(EduReviews review) throws SQLException;

    /**
     *
     * @author Jayang 返上一级操作人
     * @param review
     * @param transfer
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel authBackuser(EduReviews review, EduPlanTransfer transfer) throws SQLException;

    /**
     *
     * @author Jayang 移送财务审核，只允许单人
     * @param cost 费用明细
     * @param plan 执行计划
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel transferFinance(EduPlanCost cost, EduPlans plan) throws SQLException;

    /**
     *
     * @author Jayang 获取培训班费用明细
     * @param plan_code 计划编号
     * @param cost_code 费用明细编号
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public EduPlanCost getFinanceInclude(String plan_code, String cost_code) throws SQLException;

    /**
     *
     * @author Jayang 培训班费用明细审核移交
     * @param review 跟踪记录
     * @param transfers 移交记录
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel financeTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers, String cost) throws SQLException;

    /**
     *
     * @author Jayang 费用明细审核
     * @param review 追踪记录
     * @param cost 费用明细
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel authFinance(EduReviews review, EduPlanCost cost) throws SQLException;

    /**
     *
     * @author Jayang 获取计划相关经费申请
     * @param plan_code
     * @return 执行结果
     * @throws java.sql.SQLException
     */
    public List<EduPlanCost> getFinances(String plan_code) throws SQLException;

    /**
     *
     * 获取培训类型
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduSocTraintype> getSocTypes(Object... parmas) throws SQLException;

    /**
     *
     * 获取干部培训主办单位
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduSocialMainunit> getSocMainunits(Object... parmas) throws SQLException;

    /**
     *
     * 获取干部培训承办单位
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduSocialExecunit> getSocExecunits(Object... parmas) throws SQLException;

    /**
     *
     * 获取干部培训高铁标注
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduHighspeedFlag> getSocHighFlages(Object... parmas) throws SQLException;

    /**
     *
     * 获取干部境（内外培训标识）
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduAbroadType> getAbroadTypes(Object... parmas) throws SQLException;

    /**
     *
     * 获取干干部自培训类型
     *
     * @param parmas
     * @return List<EduStationTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduStationTraintype> getAStatinTtypes(Object... parmas) throws SQLException;

    /**
     *
     * 获取干部自培训培训渠道
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduStationChannel> getStationChannels(Object... parmas) throws SQLException;

    /**
     *
     * 获取自培训培训对象类别
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduStationtPersons> getStationPersons(Object... parmas) throws SQLException;

    /**
     *
     * 获取自培训培训师资
     *
     * @param parmas
     * @return List<EduSocTraintype>
     * @throws java.sql.SQLException
     */
    public List<EduTeachesType> getStationTeaches(Object... parmas) throws SQLException;

    /**
     *
     * 审核通过（批量）
     *
     * @param plans
     * @param review
     * @param parmas
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel authPlans(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException;

    /**
     *
     * 返拟稿人（批量）
     *
     * @param plans
     * @param review
     * @param parmas
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel backTops(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException;

    /**
     *
     * 返拟上一级（批量）
     *
     * @param plans
     * @param review
     * @param parmas
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel bactUsers(List<EduPlansTransDto> plans, List<EduReviews> review, List<EduPlanTransfer> transfer) throws SQLException;

    /**
     *
     * 废弃计划（批量）
     *
     * @param plans
     * @param review
     * @param parmas
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel throwPlans(List<EduReviews> plans) throws SQLException;

    /**
     *
     * 单位内计划移交（批量）
     *
     * @param transfers
     * @param review
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel unitsTransBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException;

    /**
     *
     * 完结计划（批量）
     *
     * @param review 跟踪记录
     * @param plansStr 培训计划编号多个
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel overEduPlans(List<EduReviews> review, String plansStr, int isEdu) throws SQLException;

    /**
     *
     * 处室移送（批量）
     *
     * @param review
     * @param transfers
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public DataModel transfersBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException;
    
    
}
