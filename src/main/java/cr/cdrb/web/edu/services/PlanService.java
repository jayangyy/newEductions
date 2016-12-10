/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.EmployeeDao;
import cr.cdrb.web.edu.daointerface.IEduClassDao;
import cr.cdrb.web.edu.daointerface.IEduPlansDao;
import cr.cdrb.web.edu.daointerface.IPlanReview;
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
import cr.cdrb.web.edu.domains.eduplans.EduReviewSimpleStatus;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import cr.cdrb.web.edu.domains.eduplans.EduSocTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduSocialExecunit;
import cr.cdrb.web.edu.domains.eduplans.EduSocialMainunit;
import cr.cdrb.web.edu.domains.eduplans.EduStationChannel;
import cr.cdrb.web.edu.domains.eduplans.EduStationTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduStationtPersons;
import cr.cdrb.web.edu.domains.eduplans.EduTeachesType;
import cr.cdrb.web.edu.model.Employee;
import cr.cdrb.web.edu.services.IServices.IPlansService;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang 培训计划服务类
 */
@Service
public class PlanService implements IPlansService {

    @Autowired
    IEduPlansDao plansDao;
    @Autowired
    IPlanReview reviewDao;
    @Autowired
    EmployeeDao employeeDao;
    @Autowired
    IEduClassDao classDao;
    @Resource(name = "configMap")
    java.util.HashMap configMap;

    @Override

    // <editor-fold desc="培训计划制定">
    public DataModel addPlan(EduPlans plan) throws SQLException {
        return plansDao.addPlan(plan) ? new DataModel().withInfo("新增计划成功") : new DataModel().withErr("新增计划失败");
    }

    @Override
    public DataModel updatePlan(EduPlans plan) throws SQLException {
        EduPlans plan1 = plansDao.getPlanById(plan.getPlan_code());
        if (plan1 == null) {
            throw new SQLException("未找到该计划！");
        }
        if (!plan1.getAdd_user().equalsIgnoreCase(UsersService.GetCurrentUser().getUsername())) {
            throw new SQLException("你没有修改此计划权限！");
        }
        if (plansDao.hasPlanLoading(plan.getPlan_code())) {
            throw new SQLException("存在待办计划未完成，不能完结！");
        }
        if (plansDao.hasPlanLoading(plan.getPlan_code())) {
            return new DataModel().withErr("还有待办未完成，不能修改计划！");
        } else {
            return plansDao.updatePlan(plan) ? new DataModel().withInfo("修改计划成功") : new DataModel().withErr("修改计划失败");
        }
    }

    @Override
    public DataModel getPlansPages(EduPlanSearch model) throws Throwable {
        Map<Integer, List<EduPlansTransDto>> resPaging = plansDao.getPlansPage(model);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public DataModel removePlan(String ids) throws SQLException {
        EduPlans plan1 = plansDao.getPlanById(ids);
        if (plan1 == null) {
            throw new SQLException("未找到该计划！");
        }
        if (!plan1.getAdd_user().equalsIgnoreCase(UsersService.GetCurrentUser().getUsername())) {
            throw new SQLException("你没有删除此计划权限！");
        }
        if (plansDao.canRemove(ids)) {
            throw new SQLException("该计划已进入审批流程，不能删除！");
        }
        return plansDao.removePlan(ids) ? new DataModel().withInfo("删除计划成功") : new DataModel().withErr("删除计划失败,稍后重试!");
    }

    @Override
    public EduPlans getPlan(String id) throws SQLException {
        return plansDao.getPlanById(id);
    }
    // </editor-fold>

    // <editor-fold desc="培训计划审核">
    @Override
    public DataModel addReview(EduReviews plan) throws SQLException {
        return reviewDao.addReview(plan) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel updateReview(EduReviews plan) throws SQLException {
        return reviewDao.updateReview(plan) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel removeReview(String ids) throws SQLException {
        return reviewDao.removeReview(ids) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");

    }

    @Override
    public DataModel getReviewPage(QueryModel pageModel) throws Throwable {
        Map<Integer, List<EduReviews>> resPaging = reviewDao.getReviewPage(pageModel);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public EduReviews getReview(String id) throws SQLException {
        return reviewDao.getReviewById(id);
    }

    @Override
    public List<EduReviews> getReviews(Object... params) throws SQLException {
        return reviewDao.getReview(params);
    }
    // </editor-fold>

    @Override
    public List<EduProf> getProfs(Object... uids) throws SQLException {
        return plansDao.getProfs(uids);
    }

    @Override
    public EduPlans getPlanInclude(String id) throws SQLException {
        return plansDao.getPlanInclude(id);
    }

    @Override
    public List<EduPlans> getPlans(Object... id) throws SQLException {
        return plansDao.getPlans(id);
    }

    @Override
    public DataModel transOfficPlan(EduPlans plan) throws SQLException {
        EduPlans plan1 = plansDao.getPlanById(plan.getPlan_code());
        List<EduPlanTransfer> list = plan.getPlantranfers();
        for (EduPlanTransfer trans : list) {
            if (trans.getTransfer_to_idcard().equals(plan1.getAdd_user())) {
                throw new SQLException("不能移交给拟稿人！");
            }
        }
        return plansDao.transferPlan(plan) ? new DataModel().withInfo("操作成功") : new DataModel().withErr("操作失败");
    }

    @Override
    public DataModel getEmployeePage(QueryModel pageModel, String unit, String username) throws Throwable {
        String whereSql = " 1=1 ";
        List<String> params = new ArrayList<String>();
        if (unit != null) {
            if (unit.length() > 0) {
                whereSql += "  and dwname=?";
                params.add(unit);
            }
        }
        if (username != null) {
            if (username.length() > 0) {
                whereSql += " and em_name like '%" + username + "%'";
                //  params.add("%"+ username+"%");
            }
        }
        pageModel.setFilterRules(whereSql);
        Map<Integer, List<Employee>> resPaging = employeeDao.getEmployeePaging(pageModel.getPage(), pageModel.getRows(), pageModel.getSort(), pageModel.getOrder(), pageModel.getFilterRules(), pageModel.getSearch(), params.toArray());
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public DataModel overPlan(EduReviews review) throws SQLException {
//还有待办事项，不能完结
        if (plansDao.hasPlanLoading(review.getPlan_code())) {
            throw new SQLException("存在待办事项，不能完结！");
        }
//职教/财务盖章才能算通过
        List<EduPlanCost> ilist = plansDao.getHasFlag(review.getPlan_code());
//        for (EduPlanCost item : ilist) {
//            if (item.getCost_persons() <= 0) {
//                throw new SQLException("没有必要部门签章，无法完结！");
//            }
//        }
        return plansDao.overPlan(review) ? new DataModel().withInfo("操作成功") : new DataModel().withErr("操作失败");
    }

    @Override
    public DataModel throwPlan(EduReviews review) throws SQLException {
        return plansDao.throwPlan(review) ? new DataModel().withInfo("操纵成功") : new DataModel().withErr("操作失败");
    }

    @Override
    public DataModel getTransPlanPage(EduPlanSearch pageModel) throws Throwable {
        Map<Integer, List<EduPlansTransDto>> resPaging = plansDao.getTransPlanPage(pageModel);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public DataModel authPassed(EduReviews review) throws SQLException {
        EduPlanTransfer transfer = plansDao.getTransferById(review.getTransfer_code());
        if (transfer == null) {
            throw new SQLException("未找到移交记录");
        }
        if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
            throw new SQLException("已完成,不能修改！");
        }
        EduPlans plan = plansDao.getPlanById(review.getPlan_code());
        if (plan == null) {
            throw new SQLException("未找到计划");
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
            throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
        }
        return plansDao.authReview(review) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel authTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException {
        if (!(review.size() > 0 && transfers.size() > 0)) {
            throw new SQLException("参数不能为空！");
        }
        EduPlanTransfer transfer = plansDao.getTransferById(review.get(0).getTransfer_code());
        if (transfer == null) {
            throw new SQLException("未找到移交记录");
        }
        if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
            throw new SQLException("已完成,不能修改！");
        }
        EduPlans plan = plansDao.getPlanById(review.get(0).getPlan_code());
        if (plan == null) {
            throw new SQLException("未找到计划");
        }
        for (EduPlanTransfer trans : transfers) {
            if (plan.getAdd_user().equals(trans.getTransfer_to_idcard())) {
                throw new SQLException("不能直接移交拟稿人" + trans.getTransfer_to_user() + "，请去掉拟稿人选择！");
            }
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
            throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
        }
        return plansDao.unitsTransfer(review, transfers) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel authBacktop(EduReviews review) throws SQLException {
        EduPlanTransfer transfer = plansDao.getTransferById(review.getTransfer_code());
        if (transfer == null) {
            throw new SQLException("未找到移交记录");
        }
        if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
            throw new SQLException("已完成,不能修改！");
        }
        EduPlans plan = plansDao.getPlanById(review.getPlan_code());
        if (plan == null) {
            throw new SQLException("未找到计划");
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
            throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
        }
        return plansDao.authBacktop(review) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel authBackuser(EduReviews review, EduPlanTransfer transfer) throws SQLException {
        EduPlanTransfer transfers = plansDao.getTransferById(review.getTransfer_code());
        if (transfers == null) {
            throw new SQLException("未找到移交记录");
        }
        if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
            throw new SQLException("已完成，废弃，或由处室完结,不能修改！");
        }
        EduPlans plan = plansDao.getPlanById(review.getPlan_code());
        if (plan == null) {
            throw new SQLException("未找到计划");
        }
        if (plan.getAdd_user().equals(transfer.getTransfer_to_idcard())) {
            throw new SQLException("不能直接移交拟稿人，请选择返拟稿人操作！");
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
            throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
        }
        return plansDao.authBackuser(review, transfer) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel transferFinance(EduPlanCost cost, EduPlans plan) throws SQLException {
        EduPlans plan1 = plansDao.getPlanById(plan.getPlan_code());
        List<EduPlanTransfer> list = plan.getPlantranfers();
        for (EduPlanTransfer trans : list) {
            if (trans.getTransfer_to_idcard().equals(plan1.getAdd_user())) {
                throw new SQLException("不能移交给拟稿人，请使用返拟稿人操作！");
            }
        }
        if (plan1.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats()) {
            throw new SQLException("此计划已废弃，不能在做财务移交以及建班！");
        }
        //计划人数已安排完，不能提交申请
        int persons = classDao.getPersonNum(plan1.getPlan_code(), "");
        if (persons == plan1.getPlan_num()) {
            throw new SQLException("培训班总人数已达到该计划培训总人数" + persons + "人，不能再建班！");
        }
        int endnum = plan1.getPlan_num() - persons;
        if (cost.getCost_persons() > endnum) {
            throw new SQLException("人数超标，还能安排" + endnum + "人！");
        }
        if (plan1.getPlan_days() < cost.getCost_days()) {
            throw new SQLException("培训班天数不能大于" + plan1.getPlan_days() + "！");
        }
        ///培训班经费不能超过预算
        BigDecimal total = plansDao.getPlanTotals(plan.getPlan_code());
        //剩余可分配经费
        BigDecimal endfees = plan1.getTotal_fees().subtract(total);
        if (cost.getTotal_cost().compareTo(endfees) == 1) {
            throw new SQLException("费用超过费用标准，总经费：" + plan1.getTotal_fees().doubleValue() + ",已分配：" + total.doubleValue() + ",可分配费用:" + endfees.doubleValue());
        }
        return plansDao.transferFinance(cost, plan) ? new DataModel().withInfo("操作成功") : new DataModel().withErr("操作失败");
    }

    @Override
    public EduPlanCost getFinanceInclude(String plan_code, String cost_code) throws SQLException {
        return plansDao.getFinanceInclude(plan_code, cost_code);
    }

    @Override
    public DataModel financeTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers, String cost) throws SQLException {
        if (!(review.size() > 0 && transfers.size() > 0)) {
            throw new SQLException("参数不能为空！");
        }
//        EduPlanTransfer transfer = plansDao.getTransferById(review.get(0).getTransfer_code());
//        if (transfer == null) {
//            throw new SQLException("未找到移交记录");
//        }
//        if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
//            throw new SQLException("已完成,不能修改！");
//        }
        EduPlans plan = plansDao.getPlanById(review.get(0).getPlan_code());
        if (plan == null) {
            throw new SQLException("未找到计划");
        }

        for (EduPlanTransfer trans : transfers) {
            if (plan.getAdd_user().equals(trans.getTransfer_to_idcard())) {
                throw new SQLException("不能直接移交拟稿人" + trans.getTransfer_to_user() + "，请去掉拟稿人选择！");
            }
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats()) {
            throw new SQLException("此计划已由处室废弃，不能再做修改！");
        }
        return plansDao.financeTransfer(review, transfers, cost) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public DataModel authFinance(EduReviews review, EduPlanCost cost) throws SQLException {
        EduPlanTransfer transfer = plansDao.getTransferById(review.getTransfer_code());
        if (transfer == null) {
            throw new SQLException("未找到移交记录");
        }
        if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
            throw new SQLException("已完成,不能修改！");
        }
        EduPlans plan = plansDao.getPlanById(review.getPlan_code());
        int persons = classDao.getPersonNum(plan.getPlan_code(), "");
        if (plan == null) {
            throw new SQLException("未找到计划");
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats()) {
            throw new SQLException("此计划已由处室废弃，不能再做修改！");
        }
        if (persons == plan.getPlan_num()) {
            throw new SQLException("培训班总人数已达到该计划培训总人数" + persons + "人，不能再建班！");
        }
        int endnum = plan.getPlan_num() - persons;
        if (cost.getCost_persons() > endnum) {
            throw new SQLException("人数超标，还能安排" + endnum + "人！");
        }
        ///培训班经费不能超过预算
        BigDecimal total = plansDao.getPlanTotals(plan.getPlan_code());
        //剩余可分配经费
        BigDecimal endfees = plan.getTotal_fees().subtract(total);
        if (cost.getTotal_cost().compareTo(endfees) == 1) {
            throw new SQLException("费用超过费用标准，总经费：" + plan.getTotal_fees().doubleValue() + ",已分配：" + total.doubleValue() + ",可分配费用:" + endfees.doubleValue());
        }
        return plansDao.authFinance(review, cost) ? new DataModel().withInfo("执行成功") : new DataModel().withErr("执行失败");
    }

    @Override
    public List<EduPlanCost> getFinances(String plan_code) throws SQLException {
        EduPlans plan = plansDao.getPlanById(plan_code);
        String cost_satus = "3";
        if (plan == null) {
            throw new SQLException("未查到该计划");
        }
        if (plan.getTraintype().equalsIgnoreCase("3") || plan.getTraintype().equalsIgnoreCase("4")) {
            cost_satus = EduReviewSimpleStatus.财务待审.getStats() + "";
        } else {
            cost_satus = EduReviewSimpleStatus.职教经办.getStats() + "";
        }
        if(!UsersService.GetCurrentUser().getCompanyId().equalsIgnoreCase(configMap.get("cwcunitid").toString()))
        {
             cost_satus = EduReviewSimpleStatus.职教经办.getStats() + "";
        }
        return plansDao.getFinancesByPlan(plan_code, cost_satus);
    }

    @Override
    public List<EduSocTraintype> getSocTypes(Object... parmas) throws SQLException {
        return plansDao.getSocTypes(parmas);
    }

    @Override
    public List<EduSocialMainunit> getSocMainunits(Object... parmas) throws SQLException {
        return plansDao.getSocMainunits(parmas);
    }

    @Override
    public List<EduSocialExecunit> getSocExecunits(Object... parmas) throws SQLException {
        return plansDao.getSocExecunits(parmas);
    }

    @Override
    public List<EduHighspeedFlag> getSocHighFlages(Object... parmas) throws SQLException {
        return plansDao.getSocHighFlages(parmas);
    }

    @Override
    public List<EduAbroadType> getAbroadTypes(Object... parmas) throws SQLException {
        return plansDao.getAbroadTypes(parmas);
    }

    @Override
    public List<EduStationTraintype> getAStatinTtypes(Object... parmas) throws SQLException {
        return plansDao.getAStatinTtypes(parmas);
    }

    @Override
    public List<EduStationChannel> getStationChannels(Object... parmas) throws SQLException {
        return plansDao.getStationChannels(parmas);
    }

    @Override
    public List<EduStationtPersons> getStationPersons(Object... parmas) throws SQLException {
        return plansDao.getStationPersons(parmas);
    }

    @Override
    public List<EduTeachesType> getStationTeaches(Object... parmas) throws SQLException {
        return plansDao.getStationTeaches(parmas);
    }

    @Override
    public DataModel authPlans(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException {
        String transIds = "";
        String planIds = "";
        List<EduPlans> dplans = new ArrayList<EduPlans>();
        List<EduPlanTransfer> tranfers = new ArrayList<EduPlanTransfer>();
        for (int i = 0; i < plans.size(); i++) {
            if (i == 0) {
                transIds += "'" + plans.get(i).getTransfer_code() + "'";
                planIds += "'" + plans.get(i).getPlan_code() + "'";
            } else {
                transIds += ",'" + plans.get(i).getTransfer_code() + "'";
                planIds += ",'" + plans.get(i).getPlan_code() + "'";
            }
        }
        dplans = plansDao.getPlans(planIds, "", "", "", "");
        tranfers = plansDao.getTransfers(transIds);
        if (dplans.size() != tranfers.size() || dplans.isEmpty() || tranfers.isEmpty()) {
            throw new SQLException("未查到该计划或移送记录，请重新打开窗口以同步数据！");
        }
        for (EduPlansTransDto plan1 : plans) {
            EduPlanTransfer transfer = getTranByCode(tranfers, plan1.getTransfer_code());
            if (transfer == null) {
                throw new SQLException("未找到移交记录");
            }
            if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
                throw new SQLException("已完成,不能修改！");
            }
            EduPlans plan = getPlanCode(dplans, plan1.getPlan_code());
            if (plan == null) {
                throw new SQLException("未找到计划");
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
            }
        }
        return plansDao.authPlans(plans, review, costlist) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    private EduPlanTransfer getTranByCode(List<EduPlanTransfer> trans, String code) {
        for (EduPlanTransfer item : trans) {
            if (item.getTransfer_code().equals(code)) {
                return item;
            }
        }
        return null;
    }

    private EduPlans getPlanCode(List<EduPlans> trans, String code) {
        for (EduPlans item : trans) {
            if (item.getPlan_code().equals(code)) {
                return item;
            }
        }
        return null;
    }

    @Override
    public DataModel backTops(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException {
        String transIds = "";
        String planIds = "";
        List<EduPlans> dplans = new ArrayList<EduPlans>();
        List<EduPlanTransfer> tranfers = new ArrayList<EduPlanTransfer>();
        for (int i = 0; i < plans.size(); i++) {
            if (i == 0) {
                transIds += "'" + plans.get(i).getTransfer_code() + "'";
                planIds += "'" + plans.get(i).getPlan_code() + "'";
            } else {
                transIds += ",'" + plans.get(i).getTransfer_code() + "'";
                planIds += ",'" + plans.get(i).getPlan_code() + "'";
            }
        }
        dplans = plansDao.getPlans(planIds, "", "", "", "");
        tranfers = plansDao.getTransfers(transIds);
        if (dplans.size() != tranfers.size() || dplans.isEmpty() || tranfers.isEmpty()) {
            throw new SQLException("未查到该计划或移送记录，请重新打开窗口以同步数据！");
        }
        for (EduPlansTransDto plan1 : plans) {
            EduPlanTransfer transfer = getTranByCode(tranfers, plan1.getTransfer_code());
            if (transfer == null) {
                throw new SQLException("未找到移交记录");
            }
            if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
                throw new SQLException("已完成,不能修改！");
            }
            EduPlans plan = getPlanCode(dplans, plan1.getPlan_code());
            if (plan == null) {
                throw new SQLException("未找到计划");
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
            }
        }

        return plansDao.backTops(plans, review, costlist) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel bactUsers(List<EduPlansTransDto> plans, List<EduReviews> review, List<EduPlanTransfer> transferss) throws SQLException {
        String transIds = "";
        String planIds = "";
        List<EduPlans> dplans = new ArrayList<EduPlans>();
        List<EduPlanTransfer> tranfers = new ArrayList<EduPlanTransfer>();
        for (int i = 0; i < plans.size(); i++) {
            if (i == 0) {
                transIds += "'" + plans.get(i).getTransfer_code() + "'";
                planIds += "'" + plans.get(i).getPlan_code() + "'";
            } else {
                transIds += ",'" + plans.get(i).getTransfer_code() + "'";
                planIds += ",'" + plans.get(i).getPlan_code() + "'";
            }
        }
        dplans = plansDao.getPlans(planIds, "", "", "", "");
        tranfers = plansDao.getTransfers(transIds);
        if (dplans.size() != tranfers.size() || dplans.isEmpty() || tranfers.isEmpty()) {
            throw new SQLException("未查到该计划或移送记录，请重新打开窗口以同步数据！");
        }
        for (EduPlansTransDto plan1 : plans) {
            EduPlanTransfer transfer = getTranByCode(tranfers, plan1.getTransfer_code());
            if (transfer == null) {
                throw new SQLException("未找到移交记录");
            }
            if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
                throw new SQLException("已完成，废弃，或由处室完结,不能修改！");
            }
            EduPlans plan = getPlanCode(dplans, plan1.getPlan_code());
            if (plan == null) {
                throw new SQLException("未找到计划");
            }
            if (plan.getAdd_user().equals(transfer.getTransfer_to_idcard())) {
                throw new SQLException("不能直接移交拟稿人，请选择返拟稿人操作！");
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
            }
        }
        return plansDao.bactUsers(plans, review, transferss) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel throwPlans(List<EduReviews> plans) throws SQLException {
        return plansDao.throwPlans(plans) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel unitsTransBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException {

        if (!(review.size() > 0 && transfers.size() > 0)) {
            throw new SQLException("参数不能为空！");
        }
        String transIds = "";
        String planIds = "";
        List<EduPlans> dplans = new ArrayList<EduPlans>();
        List<EduPlanTransfer> tranferss = new ArrayList<EduPlanTransfer>();
        for (int i = 0; i < transfers.size(); i++) {
            if (i == 0) {
                transIds += "'" + transfers.get(i).getTransfer_code() + "'";
                planIds += "'" + transfers.get(i).getPlan_code() + "'";
            } else {
                transIds += ",'" + transfers.get(i).getTransfer_code() + "'";
                planIds += ",'" + transfers.get(i).getPlan_code() + "'";
            }
        }
        dplans = plansDao.getPlans(planIds, "", "", "", "");
        tranferss = plansDao.getTransfers(transIds);
        for (EduPlanTransfer transfer : tranferss) {
            if (transfer == null) {
                throw new SQLException("未找到移交记录");
            }
            if (transfer.getTrans_status() == EduReviewSimpleStatus.经办.getStats()) {
                throw new SQLException("已完成,不能修改！");
            }
            EduPlans plan = getPlanCode(dplans, transfer.getPlan_code());
            if (plan == null) {
                throw new SQLException("未找到计划");
            }
            for (EduPlanTransfer trans : transfers) {
                if (plan.getAdd_user().equals(trans.getTransfer_to_idcard())) {
                    throw new SQLException("不能直接移交拟稿人" + trans.getTransfer_to_user() + "，请去掉拟稿人选择！");
                }
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
            }
        }

        return plansDao.unitsTransBatch(review, transfers) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel overEduPlans(List<EduReviews> review, String plansStr, int isEdu) throws SQLException {
        //还有待办事项，不能完结
        if (plansDao.hasPlanLoading(plansStr)) {
            throw new SQLException("存在待办事项，不能完结！");
        }
        //职教/ 人事处  财务盖章才能算通过 
        List<EduPlanCost> ilist = new ArrayList<EduPlanCost>();
        if (isEdu == 0) {
            //职教处，财务处签章
            ilist = plansDao.getHasFlags(plansStr, configMap.get("zjcunitid").toString(), configMap.get("cwcunitid").toString());
            //其他培训需要两个章，职教处，财务处
        } else {
            //人事处，财务处签章
            ilist = plansDao.getHasFlags(plansStr, configMap.get("rscunitid").toString(), configMap.get("cwcunitid").toString());
        }
//        if (ilist.size() % 2 != 0 || ilist.isEmpty()) {
//            throw new SQLException("没有必要部门签章，无法完结！");
//        }
//        for (EduPlanCost item : ilist) {
//            if (item.getCost_persons() <= 0) {
//                throw new SQLException("没有必要部门签章，无法完结！");
//            }
//        }
        return plansDao.overPlans(review) ? new DataModel().withInfo("操作成功") : new DataModel().withErr("操作失败");
    }

    @Override
    public DataModel transfersBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException {
        String planIds = "";
        List<EduPlans> dplans = new ArrayList<EduPlans>();
        List<EduPlanTransfer> tranferss = new ArrayList<EduPlanTransfer>();
        for (int i = 0; i < transfers.size(); i++) {
            if (i == 0) {
                planIds += "'" + transfers.get(i).getPlan_code() + "'";
            } else {
                planIds += ",'" + transfers.get(i).getPlan_code() + "'";
            }
        }
        dplans = plansDao.getPlans(planIds, "", "", "", "");
        if (dplans.isEmpty() || dplans.size() != review.size() || review.isEmpty() || transfers.isEmpty()) {
            throw new SQLException("未找到数据");
        }
        for (EduPlanTransfer trans : transfers) {
            EduPlans plan = getPlanCode(dplans, trans.getPlan_code());
            if (trans.getTransfer_to_idcard().equals(plan.getAdd_user())) {
                throw new SQLException("不能移交给拟稿人！");
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室废弃.getStats() || plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("此计划已由处室完结或废弃，不能在做修改！");
            }
        }
        return plansDao.transfersBatch(review, transfers) ? new DataModel().withInfo("操作成功") : new DataModel().withErr("操作失败");
    }
}
