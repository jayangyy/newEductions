/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.e
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.commons.file.ImageUtil;
import cr.cdrb.commons.tools.DateUtil;
import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.eduplans.EduAbroadType;
import cr.cdrb.web.edu.domains.eduplans.EduHighspeedFlag;
import cr.cdrb.web.edu.domains.eduplans.EduOtherFees;
import cr.cdrb.web.edu.domains.eduplans.EduPlanCost;
import cr.cdrb.web.edu.domains.eduplans.EduPlanSearch;
import cr.cdrb.web.edu.domains.eduplans.EduPlanTransfer;
import cr.cdrb.web.edu.domains.eduplans.EduPlans;
import cr.cdrb.web.edu.domains.eduplans.EduPlansTransDto;
import cr.cdrb.web.edu.domains.eduplans.EduReviewSimpleStatus;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import cr.cdrb.web.edu.domains.eduplans.EduReviewsStatus;
import cr.cdrb.web.edu.domains.eduplans.EduSocTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduSocialExecunit;
import cr.cdrb.web.edu.domains.eduplans.EduSocialMainunit;
import cr.cdrb.web.edu.domains.eduplans.EduStationChannel;
import cr.cdrb.web.edu.domains.eduplans.EduStationTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduStationtPersons;
import cr.cdrb.web.edu.domains.eduplans.EduTeachFees;
import cr.cdrb.web.edu.domains.eduplans.EduTeachesType;
import cr.cdrb.web.edu.domains.eduplans.StationPersons;
import cr.cdrb.web.edu.model.Employee;
import cr.cdrb.web.edu.security.domains.EduUnit;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.EduTrainingExpenseService;
import cr.cdrb.web.edu.services.IServices.IPlansService;
import cr.cdrb.web.edu.services.IServices.IUnitService;
import cr.cdrb.web.edu.services.IServices.IUsersService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang
 *
 * 培训计划控制器
 */
@Controller
@RequestMapping("/plans")
public class PlansController {

    @Autowired
    IPlansService planService;
    @Autowired
    IUnitService unitService;
    @Resource(name = "configMap")
    java.util.HashMap configMap;
    @Autowired
    IUsersService userService;
    @Autowired
    EduTrainingExpenseService expenseService;

    // <editor-fold desc="培训计划制定">
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView Index() {
        ModelAndView view = new ModelAndView();
        view.setViewName("/plans/index");
        return view;
    }

    @RequestMapping(value = "/selectUnits", method = RequestMethod.GET)
    public ModelAndView selectUnits() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("user", UsersService.GetCurrentUser());
        mv.addObject("isadmin", UsersService.IsAdmin());
        mv.setViewName("/plans/selectUnits");
        return mv;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit() {
        ModelAndView view = new ModelAndView();
        EduUser user = UsersService.GetCurrentUser();
        view.addObject("companyId", user.getCompanyId());
        view.addObject("company", user.getCompany());
        view.addObject("companypId", user.getCompanypid());
        view.addObject("statusEnum", EduReviewSimpleStatus.getOfficOverStatus());
        view.addObject("editEnum", EduReviewSimpleStatus.待办.getStats());
        view.addObject("adduser", user.getUsername());
        view.addObject("user", user.getWorkername());
        view.addObject("card", user.getUsername());
        view.addObject("depList", userService.GetUserDep());
        view.addObject("isstation", user.getCompanypid().equalsIgnoreCase(configMap.get("zdpid").toString()));
        view.setViewName("/plans/edit");
        return view;
    }

    @RequestMapping(value = "/planView", method = RequestMethod.GET)
    public ModelAndView PlanView() {
        ModelAndView view = new ModelAndView();
        view.addObject("companyId", UsersService.GetCurrentUser().getCompanyId());
        view.addObject("companypId", UsersService.GetCurrentUser().getCompanypid());
        view.setViewName("/plans/planview");
        return view;
    }

    @RequestMapping(value = "/selectUser", method = RequestMethod.GET)
    public ModelAndView selectUser() {
        ModelAndView view = new ModelAndView();
        view.addObject("officEnum", EduReviewsStatus.getFinanceAuth());
        view.setViewName("/plans/selectUser");
        return view;
    }

    @RequestMapping(value = "/transfinance", method = RequestMethod.GET)
    public ModelAndView transfinance() {
        ModelAndView view = new ModelAndView();
        view.setViewName("/plans/transfinance");
        view.addObject("company", UsersService.GetCurrentUser().getCompany());
        return view;
    }

    @RequestMapping(value = "/getfinance", method = RequestMethod.GET)
    public ModelAndView getfinance(String plan_code, String cost_id) {
        ModelAndView view = new ModelAndView();
        view.addObject("plancode", plan_code);
        view.addObject("costid", cost_id);
        view.setViewName("/teachreview/financeview");
        return view;
    }

    @RequestMapping(value = "/authfinance", method = RequestMethod.GET)
    public ModelAndView authFinanceView(String plantype, String id, String tcode, String costid) {
        ModelAndView view = new ModelAndView();
        EduUser user = UsersService.GetCurrentUser();
        view.addObject("plancode", id);
        view.addObject("costid", costid);
        view.addObject("passedEnum", EduReviewSimpleStatus.经办.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.经办);
        view.addObject("user", user);
        view.addObject("transfer_code", tcode);
        view.addObject("plantype", plantype);
        view.addObject("isfinance", user.getCompanypid().equalsIgnoreCase("9999000200140001") ? "0" : "1");
        view.setViewName("/teachreview/authfinance");
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/getPlansPage", method = RequestMethod.GET)
    public DataModel getPlansPage(EduPlanSearch model) throws Throwable {
        EduUser user = UsersService.GetCurrentUser();
        model.setTo_idcard(user.getUsername());
        model.setTo_user(user.getWorkername());
        model.setTo_unit(user.getCompany());
        model.setTo_uid(user.getCompanyId());
        model.setTrans_status(EduReviewSimpleStatus.待办.getStats());
        model.setAdduser(user.getUsername());
//        if (model.getPlan_mainid().equalsIgnoreCase("全部单位")) {
//            model.setPlan_mainid(null);
//        }
//        if (model.getPlan_execid().equalsIgnoreCase("全部单位")) {
//            model.setPlan_execid(null);
//        }
        //   if (!UsersService.IsAdmin()) {
        //限定主办单位为当前处室
        // model.setPlan_mainid(UsersService.GetCurrentUser().getCompany());
        //  }
        return planService.getPlansPages(model);
    }

    @ResponseBody
    @RequestMapping(value = "/putPlan", method = RequestMethod.POST)
    public DataModel putPlan(EduPlans plan, String persnum) throws SQLException {
        plan.setAdd_user(UsersService.GetCurrentUser().getUsername());
        if (StringUtils.isBlank(persnum)) {
            plan.setStas(new ArrayList<StationPersons>());
        } else {
            plan.setStas(JSON.parseArray(persnum, StationPersons.class));
        }
        return planService.addPlan(plan);
    }

    @ResponseBody
    @RequestMapping(value = "/patchPlan", method = RequestMethod.POST)
    public DataModel pathcPlan(EduPlans plan, String persnum) throws SQLException {
        plan.setAdd_user(UsersService.GetCurrentUser().getUsername());
        if (StringUtils.isBlank(persnum)) {
            plan.setStas(new ArrayList<StationPersons>());
        } else {
            plan.setStas(JSON.parseArray(persnum, StationPersons.class));
        }
        return planService.updatePlan(plan);
    }

    @ResponseBody
    @RequestMapping(value = "/getPlan", method = RequestMethod.GET)
    public EduPlans getPlan(String id) throws SQLException {
        return planService.getPlan(id);
    }

    ///包含关系
    @ResponseBody
    @RequestMapping(value = "/getPlanInclude", method = RequestMethod.GET)
    public EduPlans getPlanInclude(String id) throws SQLException {
        return planService.getPlanInclude(id);
    }

    @ResponseBody
    @RequestMapping(value = "/deltePlan", method = RequestMethod.POST)
    public DataModel deltePlan(String id) throws SQLException {
        return planService.removePlan(id);
    }

// </editor-fold>
    // <editor-fold desc="培训计划审核">
    @RequestMapping(value = "/financeIndex", method = RequestMethod.GET)
    public ModelAndView financeIndex() {
        ModelAndView view = new ModelAndView();
        view.addObject("statusEnum", EduReviewsStatus.getFinanceAuth());
        view.setViewName("/finance/index");
        return view;
    }
    // <editor-fold desc="处室操作">

    @ResponseBody
    @RequestMapping(value = "/transOfficPlan", method = RequestMethod.POST)
    public DataModel transOfficPlan(String prof, String plan_code) throws SQLException {
        EduPlans plan = new EduPlans();
        plan.setPlan_status(EduReviewSimpleStatus.处室待办.getStats());
        plan.setPlan_status_cmt(EduReviewSimpleStatus.处室待办.toString());
        plan.setPlan_prof(prof);
        plan.setPlan_code(plan_code);
        EduUser user = UsersService.GetCurrentUser();
        List<EduReviews> list = JSON.parseArray(plan.getPlan_prof(), EduReviews.class);
        List<EduPlanTransfer> trans = new ArrayList<EduPlanTransfer>();
        for (EduReviews item : list) {
            item.setReviewer(user.getWorkername());
            item.setIdcard(user.getUsername());
            item.setPlan_code(plan.getPlan_code());
            item.setReview_status(EduReviewSimpleStatus.待办.getStats());
            item.setPlan_status_cmt(EduReviewSimpleStatus.待办.toString());
            item.setReview_date(new Date());
            EduPlanTransfer transfer = new EduPlanTransfer();
            transfer.setPlan_code(item.getPlan_code());
            transfer.setTransfer_from_idcard(user.getUsername());
            transfer.setTransfer_from_user(user.getWorkername());
            transfer.setTransfer_from_unit(user.getCompany());
            transfer.setTransfer_from_unitid(user.getCompanyId());
            transfer.setTransfer_to_idcard(item.getReview_to_idcard());
            transfer.setTransfer_to_user(item.getReview_to_user());
            transfer.setTransfer_to_uid(item.getCurrent_unitid());
            transfer.setTransfer_to_unit(item.getCurrent_unit());
            transfer.setTrans_status_cmt(EduReviewSimpleStatus.待办.toString());
            transfer.setTrans_status(EduReviewSimpleStatus.待办.getStats());
            trans.add(transfer);
        }
        plan.setEdureviews(list);
        plan.setPlantranfers(trans);
        return planService.transOfficPlan(plan);
    }

    @ResponseBody
    @RequestMapping(value = "/overPlan", method = RequestMethod.POST)
    public DataModel overPlan(String plan_code) throws SQLException {
        EduReviews review = new EduReviews();
        EduUser user = UsersService.GetCurrentUser();
        review.setPlan_code(plan_code);
        review.setIdcard(user.getUsername());
        review.setReview_cmt("");
        review.setReview_url("");
        review.setReview_date(new Date());
        review.setReviewer(user.getWorkername());
        review.setPlan_status_cmt(EduReviewSimpleStatus.处室经办.toString());
        review.setReview_status(EduReviewSimpleStatus.处室经办.getStats());
        return planService.overPlan(review);
    }

    @ResponseBody
    @RequestMapping(value = "/throwPlan", method = RequestMethod.POST)
    public DataModel throwPlan(String plan_code) throws SQLException {
        EduReviews review = new EduReviews();
        EduUser user = UsersService.GetCurrentUser();
        review.setPlan_code(plan_code);
        review.setIdcard(user.getUsername());
        review.setReview_cmt("");
        review.setReview_date(new Date());
        review.setReview_url("");
        review.setReviewer(user.getWorkername());
        review.setPlan_status_cmt(EduReviewSimpleStatus.处室废弃.toString());
        review.setReview_status(EduReviewSimpleStatus.处室废弃.getStats());
        return planService.throwPlan(review);
    }

    // <editor-fold desc="移送财务处室审批,附带预算数据">
    @ResponseBody
    @RequestMapping(value = "/transferfin", method = RequestMethod.POST)
    public DataModel transferFin(EduPlanCost cost, String teaches1, String otherfees1, String users1, String prof1, String t_plan_code) throws SQLException {
        ///    EduPlanCost cost=new EduPlanCost();
        EduPlans plan = new EduPlans();
        plan.setPlan_status(EduReviewSimpleStatus.处室待办.getStats());
        plan.setPlan_status_cmt(EduReviewSimpleStatus.处室待办.toString());
        plan.setPlan_prof(users1);
        plan.setPlan_code(t_plan_code);
        cost.setPlan_code(t_plan_code);
        EduUser user = UsersService.GetCurrentUser();
        List<EduReviews> list = JSON.parseArray(plan.getPlan_prof(), EduReviews.class);
        List<EduPlanTransfer> trans = new ArrayList<EduPlanTransfer>();
        List<EduOtherFees> otherfee = JSON.parseArray(otherfees1, EduOtherFees.class);
        List<EduTeachFees> teachfees = JSON.parseArray(teaches1, EduTeachFees.class);
        for (EduReviews item : list) {
            item.setReviewer(user.getWorkername());
            item.setIdcard(user.getUsername());
            item.setPlan_code(plan.getPlan_code());
            item.setReview_status(EduReviewSimpleStatus.待办.getStats());
            item.setPlan_status_cmt(EduReviewSimpleStatus.待办.toString());
            item.setReview_date(new Date());
            EduPlanTransfer transfer = new EduPlanTransfer();
            transfer.setPlan_code(item.getPlan_code());
            transfer.setTransfer_from_idcard(user.getUsername());
            transfer.setTransfer_from_user(user.getWorkername());
            transfer.setTransfer_from_unit(user.getCompany());
            transfer.setTransfer_from_unitid(user.getCompanyId());
            transfer.setTransfer_to_idcard(item.getReview_to_idcard());
            transfer.setTransfer_to_user(item.getReview_to_user());
            transfer.setTransfer_to_uid(item.getCurrent_unitid());
            transfer.setTransfer_to_unit(item.getCurrent_unit());
            transfer.setTrans_status_cmt(EduReviewSimpleStatus.待办.toString());
            transfer.setTrans_status(EduReviewSimpleStatus.待办.getStats());
            transfer.setCost_id(cost.getCost_id());
            trans.add(transfer);
        }
        plan.setEdureviews(list);
        plan.setPlantranfers(trans);
        cost.setTeachfees(teachfees);
        cost.setOtherfees(otherfee);
//        BigDecimal total_cost=new BigDecimal(0);
//        for(EduOtherFees item:otherfee)
//        {
//            total_cost=total_cost.add(item.getOther_cost());
//        }
//        for(EduTeachFees item:teachfees)
//        {
//            total_cost=total_cost.add(item.getTeach_fees());
//        }
//        total_cost.add(cost.getBooks_total_fee()).add(cost.getHotel_total_fee()).add(cost.getPlace_total_fee())
//                .add(cost.getMeals_total_fee()).add(cost.getInfo_total_fee()).add(cost.getTraffic_total_fee());
//        cost.setTotal_cost(total_cost);//总费用
//移送与制定经费审批项
        EduPlans curplan = planService.getPlan(t_plan_code);
        if (curplan == null) {
            throw new SQLException("未找到该计划 ");
        }
        if (cost.getCost_id().length() > 0) {
            //若为人事处干部培训，则直接提交财务审核
            cost.setCost_status(EduReviewSimpleStatus.财务待审.getStats() + "");
            cost.setCost_status_cmt(EduReviewSimpleStatus.财务待审.toString());
            return planService.financeTransfer(list, plan.getPlantranfers(), cost.getCost_id());
        } else {
            if (curplan.getTraintype().equalsIgnoreCase("3") || curplan.getTraintype().equalsIgnoreCase("4")) {
                cost.setCost_status(EduReviewSimpleStatus.财务待审.getStats() + "");
                cost.setCost_status_cmt(EduReviewSimpleStatus.财务待审.toString());
            } else {
                cost.setCost_status(EduReviewSimpleStatus.职教待审.getStats() + "");
                cost.setCost_status_cmt(EduReviewSimpleStatus.职教待审.toString());
            }
            return planService.transferFinance(cost, plan);
        }
    }
    // </editor-fold>
    // </editor-fold>
    // <editor-fold desc="移送单位审核">

    @RequestMapping(value = "/authReview", method = RequestMethod.GET)
    public ModelAndView authReview() {
        ModelAndView view = new ModelAndView();
        view.addObject("user", UsersService.GetCurrentUser().getWorkername());
        view.addObject("card", UsersService.GetCurrentUser().getUsername());
        view.addObject("typename", UsersService.GetCurrentUser().getType_name());
        view.addObject("editEnum", EduReviewSimpleStatus.待办.getStats());
        view.addObject("isfinance", UsersService.GetCurrentUser().getCompanyId().equalsIgnoreCase("19B8C3534E3E5665E0539106C00A58FD") ? "0" : "1");
        view.setViewName("/teachreview/auth");
        return view;
    }

    @RequestMapping(value = "/teachIndex", method = RequestMethod.GET)
    public ModelAndView teacheIndex() {
        ModelAndView view = new ModelAndView();
        view.addObject("statusEnum", EduReviewsStatus.getTeachAuth());
        view.setViewName("/teachreview/index");
        return view;
    }

    @RequestMapping(value = "/authPassedView", method = RequestMethod.GET)
    public ModelAndView authPassedView(String id, String tcode, String costid) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.经办.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.经办);
        view.addObject("user", UsersService.GetCurrentUser());
        view.addObject("transfer_code", tcode);
        view.addObject("costid", costid);
        view.setViewName("/teachreview/authPassed");
        return view;
    }

    @RequestMapping(value = "/authTransView", method = RequestMethod.GET)
    public ModelAndView authTransView(String id, String tcode, String cost_code) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.经办.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.经办);
        view.addObject("user", UsersService.GetCurrentUser());
        view.addObject("transfer_code", tcode);
        view.addObject("cost_id", cost_code);
        view.setViewName("/teachreview/authTransfer");
        return view;
    }

    @RequestMapping(value = "/backTop", method = RequestMethod.GET)
    public ModelAndView backTopView(String id, String tcode, String costid) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.处室回发.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.处室回发);
        view.addObject("user", UsersService.GetCurrentUser());
        view.addObject("transfer_code", tcode);
        view.addObject("costid", costid);
        view.setViewName("/teachreview/authBack");
        return view;
    }

    @RequestMapping(value = "/backUser", method = RequestMethod.GET)
    public ModelAndView backUser(String id, String tcode, String to_user, String to_uid, String to_unit, String to_unitid) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.回发.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.回发);
        view.addObject("to_user", to_user);
        view.addObject("to_uid", to_uid);
        view.addObject("to_unit", to_unit);
        view.addObject("to_unitid", to_unitid);
        view.addObject("user", UsersService.GetCurrentUser());
        view.addObject("transfer_code", tcode);
        view.setViewName("/teachreview/authBackuser");
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/authPassed", method = RequestMethod.POST)
    public DataModel authPassed(EduReviews review, HttpServletRequest request, String cost_id) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        // if (user.getType_name() != null) {
//            if (!(user.getType_name().contains("单位正职领导") || user.getType_name().contains("单位副职领导"))) {
//                return new DataModel().withErr("没有权限审核!");
//            } else {
        EduUnit unit = unitService.getUnit(review.getCurrent_unitid());
        Date currentdate = new Date();
        String url = "./GenePngPics?current_unit=" + review.getCurrent_unit() + "&review_date=" + DateUtil.FormatDate(currentdate) + "&unit_name=" + review.getCurrent_unit();
        review.setReview_date(currentdate);
        if (user.getType_name() != null) {
            if ((user.getType_name().contains("单位正职领导") || user.getType_name().contains("单位副职领导"))) {
                review.setReview_url(url);
            }
        }
        return planService.authPassed(review);
        //  }
        /// } else {
        // return new DataModel().withErr("没有权限审核!");
        /// }
    }
///移送单位再移送操作

    @ResponseBody
    @RequestMapping(value = "/authTransfer", method = RequestMethod.POST)
    public DataModel authTransfer(String review, String transfer_people, String costid) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        List<EduPlanTransfer> list = JSON.parseArray(transfer_people, EduPlanTransfer.class);
        List<EduReviews> reviews = JSON.parseArray(review, EduReviews.class);
        for (EduReviews item : reviews) {
            item.setReview_date(new Date());
        }
        for (EduPlanTransfer item : list) {
            item.setTransfer_from_unit(user.getCompany());
            item.setTransfer_from_unitid(user.getCompanyId());
            item.setTrans_status_cmt(EduReviewSimpleStatus.待办.toString());
            item.setTrans_status(EduReviewSimpleStatus.待办.getStats());
        }
        if (StringUtils.isBlank(costid)) {
            //单位内一般移交，只查看审核意见
            return planService.authTransfer(reviews, list);
        } else {
            //经费审批移交，需处理经费关联
            return planService.financeTransfer(reviews, list, costid);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/backTopuser", method = RequestMethod.POST)
    public DataModel backTopuser(EduReviews review) throws SQLException {
        review.setReview_date(new Date());
        return planService.authBacktop(review);
    }

    @ResponseBody
    @RequestMapping(value = "/backUpUser", method = RequestMethod.POST)
    public DataModel backUpUser(EduReviews review, EduPlanTransfer transfer) throws SQLException {
        transfer.setTrans_status_cmt(EduReviewSimpleStatus.待办.toString());
        transfer.setTrans_status(EduReviewSimpleStatus.待办.getStats());
        review.setReview_date(new Date());
        return planService.authBackuser(review, transfer);
    }

    ///获取移送单位审核分页数据
    @ResponseBody
    @RequestMapping(value = "/getpReviews", method = RequestMethod.GET)
    public DataModel getpReviews(EduPlanSearch model) throws Throwable {
        EduUser user = UsersService.GetCurrentUser();
        model.setTo_idcard(user.getUsername());
        model.setTo_user(user.getWorkername());
        model.setTo_unit(user.getCompany());
        model.setTo_uid(user.getCompanyId());
        model.setTrans_status(EduReviewSimpleStatus.待办.getStats());
//        if (!UsersService.IsAdmin()) {
//            //限定主办单位为当前处室
//            model.setPlan_mainid(UsersService.GetCurrentUser().getCompany());
//        }
        return planService.getTransPlanPage(model);
    }

    @ResponseBody
    @RequestMapping(value = "/authfinPassed", method = RequestMethod.POST)
    public DataModel authFinancePassed(EduReviews review, EduPlanCost cost, String teaches1, String otherfees1) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        // if (user.getType_name() != null) {
//            if(!user.getCompanypid().equalsIgnoreCase(""))
//            {
//                 return new DataModel().withErr("没有权限审核!");
//            }
//            if (!(user.getType_name().contains("单位正职领导") || user.getType_name().contains("单位副职领导"))) {
//                return new DataModel().withErr("没有权限审核!");
//            } else {
        EduUnit unit = unitService.getUnit(review.getCurrent_unitid());
        Date currentdate = new Date();
        String url = "./GenePngPics?current_unit=" + review.getCurrent_unit() + "&review_date=" + DateUtil.FormatDate(currentdate) + "&unit_name=" + review.getCurrent_unit();
        review.setReview_date(currentdate);
        if (user.getType_name() != null) {
            if ((user.getType_name().contains("单位正职领导") || user.getType_name().contains("单位副职领导"))) {
                review.setReview_url(url);
            }
        }

        List<EduOtherFees> otherfee = JSON.parseArray(otherfees1, EduOtherFees.class);
        List<EduTeachFees> teachfees = JSON.parseArray(teaches1, EduTeachFees.class);
        cost.setOtherfees(otherfee);
        cost.setTeachfees(teachfees);
        if (user.getType_name() != null) {
            if ((user.getType_name().contains("单位正职领导") || user.getType_name().contains("单位副职领导"))) {
                cost.setCost_status(EduReviewSimpleStatus.财务经办.getStats() + "");
                cost.setCost_status_cmt(EduReviewSimpleStatus.财务经办.toString());
            } else {
                cost.setCost_status(EduReviewSimpleStatus.财务待审.getStats() + "");
                cost.setCost_status_cmt(EduReviewSimpleStatus.财务待审.toString());
            }
        } else {
            cost.setCost_status(EduReviewSimpleStatus.财务待审.getStats() + "");
            cost.setCost_status_cmt(EduReviewSimpleStatus.财务待审.toString());
        }

        return planService.authFinance(review, cost);
//            }
        ///} else {
        /// return new DataModel().withErr("没有权限审核!");
        /// }
    }

    @ResponseBody
    @RequestMapping(value = "/getFinances", method = RequestMethod.GET)
    public List<EduPlanCost> getFinances(String plan_code) throws SQLException {

        return planService.getFinances(plan_code);
    }
    // </editor-fold>

    @RequestMapping(value = "/editReview", method = RequestMethod.GET)
    public ModelAndView editReview() {
        ModelAndView view = new ModelAndView();
        view.setViewName("/plans/editreview");
        return view;
    }

    @RequestMapping(value = "/authfReview", method = RequestMethod.GET)
    public ModelAndView authfReview() {
        ModelAndView view = new ModelAndView();
        view.addObject("user", UsersService.GetCurrentUser().getWorkername());
        view.addObject("card", UsersService.GetCurrentUser().getUsername());
        view.setViewName("/finance/auth");
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/getfReviews", method = RequestMethod.GET)
    public DataModel getfReviews(EduPlanSearch model) throws Throwable {
        model.setReviewstatus(EduReviewsStatus.getFinanceStatus());
        return planService.getPlansPages(model);
    }

    @ResponseBody
    @RequestMapping(value = "/getReviewPage", method = RequestMethod.GET)
    public DataModel getReviewPage(QueryModel model) throws Throwable {
        return planService.getReviewPage(model);
    }

    @ResponseBody
    @RequestMapping(value = "/putReview", method = RequestMethod.POST)
    public DataModel putReview(EduReviews review) throws SQLException {
        review.setReview_date(new Date());
        return planService.addReview(review);
    }

    @ResponseBody
    @RequestMapping(value = "/pathcReview", method = RequestMethod.POST)
    public DataModel pathcReview(EduReviews review) throws SQLException {
        return planService.updateReview(review);
    }

    @ResponseBody
    @RequestMapping(value = "/getReview", method = RequestMethod.GET)
    public EduReviews getReview(String id) throws SQLException {
        return planService.getReview(id);
    }

    @ResponseBody
    @RequestMapping(value = "/delteReview", method = RequestMethod.POST)
    public DataModel delteReview(String id) throws SQLException {
        return planService.removeReview(id);
    }

    @ResponseBody
    @RequestMapping(value = "/getTeachAuths", method = RequestMethod.GET)
    public List<ComboTree> getTeachAuths(String flag) throws SQLException {
        return EduReviewsStatus.getTeachAuths(flag);
    }

    // </editor-fold>
    // <editor-fold desc="公用">
    //获取单位
    @ResponseBody
    @RequestMapping(value = "/getUnits", method = RequestMethod.GET)
    public List<EduUnit> getUnits(String uid, String uname, int searchType) throws Throwable {
        String pid = null;
        EduUser user = UsersService.GetCurrentUser();
        if (searchType == 0) {
            //处室
            pid = configMap.get("cspid").toString().replace(",", "','");
            if (!UsersService.IsAdmin()) {
                uid = user.getCompanyId();
            }
        } else if (searchType == 1) {
            //
            pid = configMap.get("zdpid").toString();
        }
        List<EduUnit> list = unitService.getUnits(uid, pid, uname, "");
        return list;
    }

    // </editor-fold>
    // <editor-fold desc="公用">
    //获取单位
    @ResponseBody
    @RequestMapping(value = "/getUnitPlans", method = RequestMethod.GET)
    public List<EduUnit> getUnitPlans(String uid, String uname, int searchType) throws Throwable {
        String pid = null;
        EduUser user = UsersService.GetCurrentUser();
        if (searchType == 0) {
            //处室
            pid = configMap.get("cspid").toString().replace(",", "','");
            if (!UsersService.IsAdmin()) {
                uid = user.getCompanyId();
            }
        } else if (searchType == 1) {
            //
            pid = configMap.get("zdpid").toString();
        }
        List<EduUnit> list = unitService.getUnits(uid, pid, uname, "");
        EduUnit unit = new EduUnit();
        unit.setName("全部单位");
        unit.setU_id("");
        unit.setP_id("");
        list.add(0, unit);
        return list;
    }
    //获取培训类型

    @ResponseBody
    @RequestMapping(value = "/getExpenseType", method = RequestMethod.GET)
    public Object getExpenseType(String gp, int isteach, String plan_type) throws Throwable {
        String whreSql = "";
        switch (plan_type) {
            case "0":
                whreSql = " type='站段日常培训' ";
                break;
            case "1":
                whreSql = " type='局内培训机构' ";
                break;
            case "2":
                whreSql = " type='委外培训' ";
                break;
            case "3":
                whreSql = " type='局内培训机构' ";
                break;
            case "4":
                whreSql = " type='站段日常培训' ";
                break;
            default:
                whreSql = " type in('外聘师资','局内师资') ";
                break;
        }
        return expenseService.getDataByWhere(whreSql, gp).getRows();
    }

    @ResponseBody
    @RequestMapping(value = "/getPlanCosts", method = RequestMethod.GET)
    public Object getPlanCosts(String plan_code, String cost_id) throws Throwable {
        return planService.getFinanceInclude(plan_code, cost_id);
    }

    // </editor-fold>
    // <editor-fold desc="公用">
    //获取单位
    @ResponseBody
    @RequestMapping(value = "/getOfficUnits", method = RequestMethod.GET)
    public List<EduUnit> getOfficUnits(String uid, String uname, int searchType, String extraunit) throws Throwable {
        String pid = configMap.get("cspid").toString().replace(",", "','") + "','" + configMap.get("zdpid").toString();
        if (searchType == 1) {
            uid = UsersService.GetCurrentUser().getCompanyId();
        }
        List<EduUnit> list = unitService.getUnits(uid, pid, uname, extraunit.replace(",", "','"));
        EduUnit all = new EduUnit();
        all.setU_id("");
        all.setName("全部单位");
        all.setP_id("");
        list.add(0, all);
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "/getEmployeePage", method = RequestMethod.GET)
    public DataModel getEmployeePage(QueryModel model, String offic_unit, String offic_username, int searchType, String offic_unit1) throws Throwable {
        if (!UsersService.IsAdmin()) {
            if (searchType == 1) {
                offic_unit = UsersService.GetCurrentUser().getCompany();
            }
        }
        //
        if (searchType == 2) {
            if (!StringUtils.isBlank(offic_unit1)) {
                offic_unit = offic_unit1;
            }
        }
        return planService.getEmployeePage(model, offic_unit, offic_username);
    }

    @ResponseBody
    @RequestMapping(value = "/getProf", method = RequestMethod.GET)
    public List<EduProf> getProfs(String id) throws Throwable {
        return planService.getProfs(id);
    }

    // <editor-fold desc="人事科干部培训">
    @RequestMapping(value = "/personsIndex", method = RequestMethod.GET)
    public ModelAndView personsIndexx() {
        ModelAndView view = new ModelAndView();
        view.setViewName("/plans/personsindex");
        return view;
    }

    @RequestMapping(value = "/personsedit", method = RequestMethod.GET)
    public ModelAndView personsedit() {
        ModelAndView view = new ModelAndView();
        EduUser user = UsersService.GetCurrentUser();
        view.addObject("companyId", user.getCompanyId());
        view.addObject("company", user.getCompany());
        view.addObject("companypId", user.getCompanypid());
        view.addObject("statusEnum", EduReviewSimpleStatus.getOfficOverStatus());
        view.addObject("editEnum", EduReviewSimpleStatus.待办.getStats());
        view.addObject("adduser", user.getUsername());
        view.addObject("user", user.getWorkername());
        view.addObject("card", user.getUsername());
        view.addObject("depList", userService.GetUserDep());
        view.addObject("isstation", user.getCompanypid().equalsIgnoreCase(configMap.get("zdpid").toString()));
        view.setViewName("/plans/personsedit");
        return view;
    }

    // <editor-fold desc="计划批量操作">
    // <editor-fold desc="批量审核通过计划">
    @ResponseBody
    @RequestMapping(value = "authrisePlans", method = RequestMethod.POST)
    public DataModel authrisePlans(String plansStr, EduReviews review, String costStr, int isEdu) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        if (user.getType_name() != null) {
            if (!(user.getType_name().contains("单位正职领导") || user.getType_name().contains("单位副职领导"))) {
                return new DataModel().withErr("没有权限审核!");
            } else {
                EduUnit unit = unitService.getUnit(review.getCurrent_unitid());
                List<EduPlansTransDto> plans = new ArrayList<EduPlansTransDto>();
                List<EduPlanCost> costlist = new ArrayList<EduPlanCost>();
                List<EduPlanCost> ecostlist = new ArrayList<EduPlanCost>();
                plans = JSON.parseArray(plansStr, EduPlansTransDto.class);
                costlist = JSON.parseArray(plansStr, EduPlanCost.class);
                Date currentdate = new Date();
                String url = "./GenePngPics?current_unit=" + review.getCurrent_unit() + "&review_date=" + DateUtil.FormatDate(currentdate) + "&unit_name=" + review.getCurrent_unit();
                review.setReview_date(currentdate);
                review.setReview_url(url);
                for (EduPlanCost cost : costlist) {
                    if (!StringUtils.isBlank(cost.getCost_id())) {
                        if (user.getCompanyId().equalsIgnoreCase(configMap.get("cwcunitid").toString())) {
                            //财务
                            cost.setCost_status(EduReviewSimpleStatus.财务经办.getStats() + "");
                            cost.setCost_status_cmt("由" + user.getCompany() + ":" + user.getWorkername() + EduReviewSimpleStatus.财务经办.getStats() + "");
                        } else {
                            cost.setCost_status(EduReviewSimpleStatus.职教经办.getStats() + "");
                            cost.setCost_status_cmt("由" + user.getCompany() + ":" + user.getWorkername() + EduReviewSimpleStatus.职教经办.getStats() + "");
                        }
                        ecostlist.add(cost);
                    }
                }
                return planService.authPlans(plans, review, ecostlist);
            }
        } else {
            return new DataModel().withErr("没有权限审核!");
        }
    }

    @RequestMapping(value = "/authPassedsView", method = RequestMethod.GET)
    public ModelAndView authPassedView() {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.经办.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.经办);
        view.addObject("user", UsersService.GetCurrentUser());
        view.setViewName("/plans/authPasseds");
        return view;
    }
// </editor-fold>

    // <editor-fold desc="批量返回拟稿人">
    @ResponseBody
    @RequestMapping(value = "backToTops", method = RequestMethod.POST)
    public DataModel backToTops(String plansStr, EduReviews review, String costStr) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        List<EduPlansTransDto> plans = new ArrayList<EduPlansTransDto>();
        List<EduPlanCost> costlist = new ArrayList<EduPlanCost>();
        plans = JSON.parseArray(plansStr, EduPlansTransDto.class);
        costlist = JSON.parseArray(plansStr, EduPlanCost.class);
        Date currentdate = new Date();
        review.setReview_date(currentdate);
        for (EduPlanCost cost : costlist) {
            cost.setCost_status(EduReviewSimpleStatus.费用回发.getStats() + "");
            cost.setCost_status_cmt("由" + user.getCompany() + ":" + user.getWorkername() + EduReviewSimpleStatus.费用回发.getStats() + "");
        }
        return planService.backTops(plans, review, costlist);
    }

    @RequestMapping(value = "/backTopsView", method = RequestMethod.GET)
    public ModelAndView backTopsView(String id, String tcode, String costid) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.处室回发.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.处室回发);
        view.addObject("user", UsersService.GetCurrentUser());
        view.addObject("transfer_code", tcode);
        view.addObject("costid", costid);
        view.setViewName("/plans/authTopUsers");
        return view;
    }
// </editor-fold>

    // <editor-fold desc="批量返回上一级操作人">
    @ResponseBody
    @RequestMapping(value = "bactToUsers", method = RequestMethod.POST)
    public DataModel bactToUsers(String plansStr, EduReviews review, String costStr) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        List<EduPlansTransDto> plans = new ArrayList<EduPlansTransDto>();
        List<EduPlanTransfer> costlist = new ArrayList<EduPlanTransfer>();
        List<EduReviews> reviews = new ArrayList<EduReviews>();
        plans = JSON.parseArray(plansStr, EduPlansTransDto.class);
        //costlist = JSON.parseArray(plansStr, EduPlanTransfer.class);
        //reviews = JSON.parseArray(review, EduReviews.class);
        Date currentdate = new Date();
        int i = 0;
        for (EduPlansTransDto plan : plans) {
            //cost.setTrans_status_cmt(EduReviewSimpleStatus.待办.toString());
            ///cost.setTrans_status(EduReviewSimpleStatus.待办.getStats());
            // plans.get(i).setPlan_status_cmt("由" + user.getCompany() + ":" + user.getWorkername() + "移送至" + cost.getTransfer_from_unit() + ":" + cost.getTransfer_from_user());
            EduReviews newre = new EduReviews();
            newre.setPlan_code(plans.get(i).getPlan_code());
            ///    newre.setTran//sfer_code(plans.get(i).getTransfer_code());
            newre.setReview_date(currentdate);
            newre.setPlan_status_cmt("由" + review.getReviewer() + review.getReview_cmt());
            newre.setReview_cmt("由" + review.getReviewer() + review.getReview_cmt());
            newre.setCurrent_unit(review.getCurrent_unit());
            newre.setCurrent_unitid(review.getCurrent_unitid());
            newre.setIdcard(review.getIdcard());
            newre.setPlan_status(review.getReview_status() + "");
            newre.setReview_cmt(review.getReview_cmt());
            newre.setReview_dcode(review.getReview_dcode());
            newre.setReview_status(review.getReview_status());
            newre.setReviewer(review.getReviewer());
            reviews.add(newre);
            EduPlanTransfer trans = new EduPlanTransfer();//移送记录
            trans.setPlan_code(plan.getPlan_code());
            trans.setTrans_status(EduReviewSimpleStatus.待办.getStats());
            // trans.setTrans_status_cmt("由" + review.getReviewer() + "移送至" + em.getEm_name() + "待办");
            trans.setTransfer_date(DateUtil.FormatDate(new Date()));
            trans.setTransfer_from_idcard(review.getIdcard());
            trans.setTransfer_from_user(review.getReviewer());
            trans.setTransfer_from_unit(review.getCurrent_unit());
            trans.setTransfer_from_unitid(review.getCurrent_unitid());
            trans.setCost_id(plan.getCost_id());
//            trans.setTransfer_to_idcard(em.getEm_idcard());
//            trans.setTransfer_to_user(em.getEm_name());
//            trans.setTransfer_to_uid(em.getDwid());
//            trans.setTransfer_to_unit(em.getDwname());
            costlist.add(trans);
            i++;
        }
        return planService.bactUsers(plans, reviews, costlist);
    }

    @RequestMapping(value = "/backUsers", method = RequestMethod.GET)
    public ModelAndView backUsers() {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.回发.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.回发);
        view.addObject("user", UsersService.GetCurrentUser());
        view.setViewName("/plans/authbackuseres");
        return view;
    }
// </editor-fold>

    // <editor-fold desc="批量废除计划">
    @ResponseBody
    @RequestMapping(value = "throwsPlans", method = RequestMethod.POST)
    public DataModel throwsPlans(String planStr, EduReviews review) throws SQLException {
        List<EduReviews> reviews = JSON.parseArray(planStr, EduReviews.class);
        List<EduPlans> plans = JSON.parseArray(planStr, EduPlans.class);
        for (int i = 0; i < plans.size(); i++) {
            EduReviews newre = new EduReviews();
            newre.setPlan_code(plans.get(i).getPlan_code());
            ///    newre.setTran//sfer_code(plans.get(i).getTransfer_code());
            newre.setReview_date(new Date());
            newre.setPlan_status_cmt("由" + review.getReviewer() + review.getReview_cmt());
            newre.setReview_cmt("由" + review.getReviewer() + review.getReview_cmt());
            newre.setCurrent_unit(review.getCurrent_unit());
            newre.setCurrent_unitid(review.getCurrent_unitid());
            newre.setIdcard(review.getIdcard());
            newre.setPlan_status(review.getReview_status() + "");
            newre.setReview_cmt(review.getReview_cmt());
            newre.setReview_dcode(review.getReview_dcode());
            newre.setReview_status(review.getReview_status());
            newre.setReviewer(review.getReviewer());
            reviews.add(newre);
        }
        return planService.throwPlans(reviews);
    }

    @RequestMapping(value = "/throwsPlansView", method = RequestMethod.GET)
    public ModelAndView throwsPlansView(String id, String tcode, String costid) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnudm", EduReviewSimpleStatus.处室废弃.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.处室废弃.toString());
        view.addObject("user", UsersService.GetCurrentUser());
        view.setViewName("/plans/thorwPlans");
        return view;
    }
    // </editor-fold>
    // <editor-fold desc="单位批量移送计划">

    @ResponseBody
    @RequestMapping(value = "unitsTransBatch", method = RequestMethod.POST)
    public DataModel unitsTransBatch(String reviewStr, String transferStr, EduReviews re) throws SQLException {
        List<EduReviews> reviews = new ArrayList<EduReviews>();
        List<EduPlansTransDto> plans = JSON.parseArray(transferStr, EduPlansTransDto.class);
        List<Employee> users = JSON.parseArray(reviewStr, Employee.class);
        List<EduPlanTransfer> transfers = new ArrayList<EduPlanTransfer>();
        Date date = new Date();
        for (Employee em : users) {
            for (EduPlansTransDto plan : plans) {
//                re.setPlan_code(plan.getPlan_code());//跟踪记录
//                re.setReview_date(date);
//                re.setPlan_status_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
//                re.setReview_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
//                re.setTransfer_code(plan.getTransfer_code());

                EduReviews newre = new EduReviews();
                newre.setPlan_code(plan.getPlan_code());
                newre.setTransfer_code(plan.getTransfer_code());
                newre.setReview_date(date);
                newre.setPlan_status_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
                newre.setReview_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
                newre.setCurrent_unit(re.getCurrent_unit());
                newre.setCurrent_unitid(re.getCurrent_unitid());
                newre.setIdcard(re.getIdcard());
                newre.setPlan_status(re.getPlan_status());
                newre.setReview_cmt(re.getReview_cmt());
                newre.setReview_dcode(re.getReview_dcode());
                newre.setReview_status(re.getReview_status());
                newre.setReviewer(re.getReviewer());
                newre.setCost_id(plan.getCost_id());
                reviews.add(newre);
                EduPlanTransfer trans = new EduPlanTransfer();//移送记录
                trans.setPlan_code(plan.getPlan_code());
                trans.setTrans_status(EduReviewSimpleStatus.待办.getStats());
                trans.setTrans_status_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
                trans.setTransfer_date(DateUtil.FormatDate(date));
                trans.setTransfer_from_idcard(re.getIdcard());
                trans.setTransfer_from_user(re.getReviewer());
                trans.setTransfer_from_unit(re.getCurrent_unit());
                trans.setTransfer_from_unitid(re.getCurrent_unitid());
                trans.setCost_id(plan.getCost_id());
                trans.setTransfer_to_idcard(em.getEm_idcard());
                trans.setTransfer_to_user(em.getEm_name());
                trans.setTransfer_to_uid(em.getDwid());
                trans.setTransfer_to_unit(em.getDwname());
                transfers.add(trans);
            }
        }
        return planService.unitsTransBatch(reviews, transfers);
    }

    @RequestMapping(value = "/authTranfersView", method = RequestMethod.GET)
    public ModelAndView authTranfersView(String id, String tcode, String cost_code) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.经办.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.经办);
        view.addObject("user", UsersService.GetCurrentUser());
        view.setViewName("/plans/selectcUsers");
        return view;
    }

    // </editor-fold>
    // <editor-fold desc="批量处室移送计划">
    @ResponseBody
    @RequestMapping(value = "transBatch", method = RequestMethod.POST)
    public DataModel transBatch(String reviewStr, String transferStr, EduReviews re) throws SQLException {
        List<EduReviews> reviews = new ArrayList<EduReviews>();
        List<EduPlansTransDto> plans = JSON.parseArray(transferStr, EduPlansTransDto.class);
        List<Employee> users = JSON.parseArray(reviewStr, Employee.class);
        List<EduPlanTransfer> transfers = new ArrayList<EduPlanTransfer>();
        Date date = new Date();
        for (Employee em : users) {
            for (EduPlansTransDto plan : plans) {
                EduReviews newre = new EduReviews();
                newre.setPlan_code(plan.getPlan_code());
                newre.setReview_date(date);
                newre.setPlan_status_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
                newre.setReview_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
                newre.setCurrent_unit(re.getCurrent_unit());
                newre.setCurrent_unitid(re.getCurrent_unitid());
                newre.setIdcard(re.getIdcard());
                newre.setPlan_status(re.getPlan_status());
                newre.setReview_cmt(re.getReview_cmt());
                newre.setReview_dcode(re.getReview_dcode());
                newre.setReview_status(re.getReview_status());
                newre.setReviewer(re.getReviewer());
                newre.setCost_id(plan.getCost_id());
                reviews.add(newre);
                EduPlanTransfer trans = new EduPlanTransfer();//移送记录
                trans.setPlan_code(plan.getPlan_code());
                trans.setTrans_status(re.getReview_status());
                trans.setTrans_status_cmt("由" + re.getReviewer() + "移送至" + em.getEm_name() + "待办");
                trans.setTransfer_date(DateUtil.FormatDate(date));
                trans.setTransfer_from_idcard(re.getIdcard());
                trans.setTransfer_from_user(re.getReviewer());
                trans.setTransfer_from_unit(re.getCurrent_unit());
                trans.setTransfer_from_unitid(re.getCurrent_unitid());
                trans.setCost_id(plan.getCost_id());
                trans.setTransfer_to_idcard(em.getEm_idcard());
                trans.setTransfer_to_user(em.getEm_name());
                trans.setTransfer_to_uid(em.getDwid());
                trans.setTransfer_to_unit(em.getDwname());
                transfers.add(trans);
            }
        }
        return planService.transfersBatch(reviews, transfers);
    }

    @RequestMapping(value = "/selectUsers", method = RequestMethod.GET)
    public ModelAndView selectUsers() {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnum", EduReviewSimpleStatus.待办.getStats());
        view.addObject("officpEnum", EduReviewSimpleStatus.处室待办.getStats());
        view.addObject("officpEnumcmt", EduReviewSimpleStatus.处室待办.toString());
        view.addObject("user", UsersService.GetCurrentUser());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.待办.toString());
        view.setViewName("/plans/selectUers");
        return view;
    }

    // </editor-fold>
    // <editor-fold desc="批量完结计划">
    @ResponseBody
    @RequestMapping(value = "overPlans", method = RequestMethod.POST)
    public DataModel overPlans(EduReviews review, String plansStr) throws SQLException {
        List<EduReviews> reviews = new ArrayList<EduReviews>();
        List<EduPlans> plans = new ArrayList<EduPlans>();
        plans = JSON.parseArray(plansStr, EduPlans.class);
        String codeStr = "";
        int isEdu = 0;
        if (review.getCurrent_unitid().equalsIgnoreCase(configMap.get("zjcunitid").toString())) {
            isEdu = 0;
        } else {
            isEdu = 1;
        }
        for (int i = 0; i < plans.size(); i++) {
            review.setPlan_code(plans.get(i).getPlan_code());
            review.setReview_date(new Date());
            reviews.add(review);
            if (i == 0) {
                codeStr += "'" + plans.get(i).getPlan_code() + "'";
            } else {
                codeStr += ",'" + plans.get(i).getPlan_code() + "'";
            }
        }
        return planService.overEduPlans(reviews, codeStr, isEdu);
    }

    @RequestMapping(value = "/overPlansView", method = RequestMethod.GET)
    public ModelAndView overPlansView(String id, String tcode, String costid
    ) {
        ModelAndView view = new ModelAndView();
        view.addObject("passedEnudm", EduReviewSimpleStatus.处室经办.getStats());
        view.addObject("passedEnumcmt", EduReviewSimpleStatus.处室经办.toString());
        view.addObject("user", UsersService.GetCurrentUser());
        view.setViewName("/plans/overPlans");
        return view;
    }
    // </editor-fold>

    // </editor-fold>
    // <editor-fold desc="培训页面">
    // </editor-fold >
    // <editor-fold desc="干部培训相关字典">
    ///干部培训分类
    @ResponseBody
    @RequestMapping(value = "/getSocTypes", method = RequestMethod.GET)
    public List<EduSocTraintype> getSocTypes() throws Throwable {
        return planService.getSocTypes();
    }

    ///干部主办单位
    @ResponseBody
    @RequestMapping(value = "/getSocMunits", method = RequestMethod.GET)
    public List<EduSocialMainunit> getSocMunits() throws Throwable {
        return planService.getSocMainunits();
    }
    ///干部承办单位

    @ResponseBody
    @RequestMapping(value = "/getSocExecs", method = RequestMethod.GET)
    public List<EduSocialExecunit> getSocExecs() throws Throwable {
        return planService.getSocExecunits();
    }
    ///干部高铁标识

    @ResponseBody
    @RequestMapping(value = "/getSocFlages", method = RequestMethod.GET)
    public List<EduHighspeedFlag> getSocFlages() throws Throwable {
        return planService.getSocHighFlages();
    }
    ///干部境（内外培训标识）

    @ResponseBody
    @RequestMapping(value = "/getSocAbroads", method = RequestMethod.GET)
    public List<EduAbroadType> getSocAbroads() throws Throwable {
        return planService.getAbroadTypes();
    }

    ///干部自培训类型
    @ResponseBody
    @RequestMapping(value = "/getStaTypes", method = RequestMethod.GET)
    public List<EduStationTraintype> getStatinTtypes() throws Throwable {
        return planService.getAStatinTtypes();
    }

    ///干获取干部自培训培训渠道
    @ResponseBody
    @RequestMapping(value = "/getStaChannels", method = RequestMethod.GET)
    public List<EduStationChannel> getStaChannels() throws Throwable {
        return planService.getStationChannels();
    }
    ///培训对象类别

    @ResponseBody
    @RequestMapping(value = "/getStaPersons", method = RequestMethod.GET)
    public List<EduStationtPersons> getStaPersons() throws Throwable {
        return planService.getStationPersons();
    }
    ///-培训师资

    @ResponseBody
    @RequestMapping(value = "/getStaTeaches", method = RequestMethod.GET)
    public List<EduTeachesType> getStaTeaches() throws Throwable {
        return planService.getStationTeaches();
    }

    // </editor-fold>
    // </editor-fold >
    @RequestMapping(value = "Upload", method = RequestMethod.POST)
    public void Upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> mapLinkList = multipartRequest.getFileMap();
        MultipartFile file = null;
        PrintWriter out = response.getWriter();
        for (String mf : mapLinkList.keySet()) {
            file = mapLinkList.get(mf);
        }
        String fileRootPath = (String) configMap.get("fileUploadPath");
        String filepath = request.getServletContext().getRealPath("/") + "/s/upload/refdoc/" + multipartRequest.getParameterValues("Filename")[0];
        // 文件保存目录路径，可从配置文件读取
        String savePath = filepath;

        String saveUrl = request.getRequestURL().toString().replace(request.getRequestURI(), "") + request.getContextPath() + "/s/upload/refdoc/" + multipartRequest.getParameterValues("Filename")[0] + "/" + multipartRequest.getParameterValues("Filename")[0];
        // 文件保存目录URL
        response.setContentType("text/html; charset=UTF-8");
        if (!ServletFileUpload.isMultipartContent(request)) {
            //return ResultEx.Init(false, "请选择文件");
        }
        // 检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
            uploadDir.mkdir();
            // return ResultEx.Init(false, "上传目录不存在");
        }
        // 检查目录写权限
        if (!uploadDir.canWrite()) {
            //return ResultEx.Init(false, "上传目录没有写权限");
        }
        String fileName = file.getOriginalFilename();
        // imgFile.getOriginalFilename();
        File targetFile = new File(savePath, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        try {
            // 保存
            file.transferTo(targetFile);
            out.printf(saveUrl);
        } catch (Exception e) {
            out.printf("false");
            e.printStackTrace();
        }
    }

    //生成公章
    @RequestMapping(value = "GenePngPics", method = RequestMethod.GET)
    public void GenePngPics(HttpServletRequest request, HttpServletResponse response, EduReviews review)
            throws Throwable {
        ImageUtil.createSaveImage(review, request, response);
    }

    // </editor-fold >
    @ResponseBody
    @RequestMapping(value = "/getUnitsGroup", method = RequestMethod.GET)
    public List<EduUnit> getUnitsGroup() throws Throwable {
        return unitService.getUnitsGroups(configMap.get("zdpid").toString(), "", "");
    }

}
