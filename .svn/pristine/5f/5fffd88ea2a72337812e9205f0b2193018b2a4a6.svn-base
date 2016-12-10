/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

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
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 *
 * //培训计划
 */
public interface IEduPlansDao {

    public Boolean addPlan(EduPlans plan) throws SQLException;

    public Boolean updatePlan(EduPlans plan) throws SQLException;

    public Boolean removePlan(String ids) throws SQLException;

    public Map<Integer, List<EduPlansTransDto>> getPlansPage(EduPlanSearch pageModel) throws Throwable;

    public EduPlans getPlanById(String id) throws SQLException;

    public List<EduPlans> getPlans(Object... params) throws SQLException;

    public List<EduProf> getProfs(Object... uids) throws SQLException;

    public EduPlans getPlanInclude(String id) throws SQLException;

    public Boolean transferPlan(EduPlans plan) throws SQLException;

    public Boolean overPlan(EduReviews plan) throws SQLException;

    public Boolean throwPlan(EduReviews plan) throws SQLException;

    public Boolean hasPlanLoading(String plan_code) throws SQLException;

    public Map<Integer, List<EduPlansTransDto>> getTransPlanPage(EduPlanSearch pageModel) throws Throwable;

    public Boolean authReview(EduReviews review) throws SQLException;

    public Boolean updaeTransferStatus(EduPlanTransfer review) throws SQLException;

    public Boolean updaePlanStatus(EduPlans plan) throws SQLException;

    public EduPlanTransfer getTransferById(String code) throws SQLException;

    public Boolean unitsTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException;

    public Boolean authBacktop(EduReviews review) throws SQLException;

    public Boolean authBackuser(EduReviews review, EduPlanTransfer transfer) throws SQLException;

    public Boolean transferFinance(EduPlanCost cost, EduPlans plan) throws SQLException;

    public EduPlanCost getFinanceInclude(String plan_code, String cost_code) throws SQLException;

    public Boolean financeTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers, String cost) throws SQLException;

    public Boolean authFinance(EduReviews review, EduPlanCost cost) throws SQLException;

    public List<EduPlanCost> getFinancesByPlan(String plan_code, String cost_status) throws SQLException;

    public List<EduPlanCost> getHasFlag(String plan_code) throws SQLException;

    public EduPlanCost getPlanCost(String plan_code) throws SQLException;

    public Boolean canRemove(String plan_code) throws SQLException;

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
    public Boolean authPlans(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException;

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
    public Boolean backTops(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException;

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
    public Boolean bactUsers(List<EduPlansTransDto> plans, List<EduReviews> review, List<EduPlanTransfer> transfer) throws SQLException;

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
    public Boolean throwPlans(List<EduReviews> plans) throws SQLException;

    /**
     *
     * 单位内计划移交（批量）
     *
     * @param transfers
     * @param review
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public Boolean unitsTransBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException;

    /**
     *
     * 完结计划（批量）
     *
     * @param transfers
     * @param review
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public Boolean overPlans(List<EduReviews> review) throws SQLException;

    /**
     *
     * 查询是否有正在执行待办
     *
     * @param plancode
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public Boolean hasPlanLoadings(String plancode) throws SQLException;

    /**
     *
     * 查询是否盖章完成(职教，财务)
     *
     * @param plancode
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public List<EduPlanCost> getHasFlags(String plancode, String csid, String recid) throws SQLException;

    /**
     *
     * 处室移送(批量)
     *
     * @param plancode
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public Boolean transfersBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException;

    /**
     *
     * 获取移送记录
     *
     * @param tids 记录id集合
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public List<EduPlanTransfer> getTransfers(String tids) throws SQLException;
    
    /**
     *
     * 获取取已安排班级费用总额
     *
     * @param tids 记录id集合
     * @return Boolean
     * @throws java.sql.SQLException
     */
    public BigDecimal getPlanTotals(String tids) throws SQLException;
    

}
