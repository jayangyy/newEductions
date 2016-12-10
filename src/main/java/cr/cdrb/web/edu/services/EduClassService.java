/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.commons.tools.DateUtil;
import cr.cdrb.web.edu.daointerface.IEduClassDao;
import cr.cdrb.web.edu.daointerface.IEduPlansDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.ClassCostsSearch;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduNewPost;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.educlass.EduTrainingCategory;
import cr.cdrb.web.edu.domains.educlass.PlanClassCostDto;
import cr.cdrb.web.edu.domains.educlass.UnitsPersons;
import cr.cdrb.web.edu.domains.eduplans.EduPlanCost;
import cr.cdrb.web.edu.domains.eduplans.EduPlans;
import cr.cdrb.web.edu.domains.eduplans.EduReviewSimpleStatus;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.IServices.IEduClassService;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang 班级管理服务类
 */
@Service
public class EduClassService implements IEduClassService {

    @Autowired
    IEduClassDao classDao;
    @Autowired
    IEduPlansDao plansDao;

    @Override
    public DataModel addClass(EduClass model) throws SQLException, ParseException {
        //  if ("1".equals(model.getClasslevel())) {
        int personNum = classDao.getPersonNum(model.getPlan_code(), model.getCost_id());
        EduPlans plan = plansDao.getPlanById(model.getPlan_code());
        EduPlanCost cost = plansDao.getPlanCost(model.getCost_id());
        int totalpersons = 0;
        int endnum = cost.getCost_persons() - personNum;//本次建班剩余人数
        List<UnitsPersons> clist = model.getUnitpers();
        if (clist != null) {
            for (UnitsPersons item : clist) {
                totalpersons += item.getUnit_num();
            }
        }
        if (cost == null) {
            throw new SQLException("未找到经费审核信息！");
        }
        if (plan == null) {
            throw new SQLException("未找到计划信息！");
        }
        if (totalpersons > cost.getCost_persons()) {
            throw new SQLException("人数分配总数超过经费审批人总数！");
        }
        if (model.getStudentnum() > cost.getCost_persons()) {
            throw new SQLException("建班总数超过经费审批人总数！");
        }
        if (model.getStudentdays() > cost.getCost_days()) {
            throw new SQLException("不能超过" + cost.getCost_days() + "天！");
        }
        if (model.getStudentnum() > endnum || totalpersons > endnum) {
            throw new SQLException("人数超标，本次建班还能安排" + endnum + "人！");
        }
//            if ((plan.getPlan_num() * 1.05) < (personNum + model.getStudentnum())) {
//                throw new SQLException("人数超标，培训人数最多不能超过计划人数的百分之五！");
//            }
        //日期验证
        if (!DateUtil.CompareDate(plan.getPlan_sdate().replaceAll("-", "/"), plan.getPlan_edate().replaceAll("-", "/"), model.getStartdate())) {
            throw new SQLException("班级开始日期不能大于计划结束日期！");
        }
        if (!DateUtil.CompareDate(plan.getPlan_sdate().replaceAll("-", "/"), plan.getPlan_edate().replaceAll("-", "/"), model.getEnddate())) {
            throw new SQLException("结束日期不能大于计划结束日期！");
        }
        if (!DateUtil.CompareDate(plan.getPlan_sdate().replaceAll("-", "/"), plan.getPlan_edate().replaceAll("-", "/"), model.getSignenddate())) {
            throw new SQLException("报名截止日期不能大于计划结束日期！");
        }
        if (!DateUtil.CompareDate(plan.getPlan_sdate().replaceAll("-", "/"), plan.getPlan_edate().replaceAll("-", "/"), model.getTelldate())) {
            throw new SQLException("通知日期不能大于计划结束日期！");
        }
//        if (DateUtil.GetCompareDays(model.getStartdate().replaceAll("-", "/"), model.getEnddate().replaceAll("-", "/")) > cost.getCost_days()) {
//            throw new SQLException("培训天数不能超过规定最大天数,天数为：" + cost.getCost_days());
//        }
        if (model.getStudentdays() > cost.getCost_days()) {
            throw new SQLException("不能大于班级费用审批天数！");
        }
        //安排结束
        if ((model.getStudentnum() == endnum && totalpersons == endnum) || (model.getStudentnum() == cost.getCost_persons() && totalpersons == cost.getCost_persons())) {
            model.setIsover(Boolean.TRUE);
            model.setClass_status(EduReviewSimpleStatus.建班结束.getStats());
            model.setClass_status_cmt(EduReviewSimpleStatus.建班结束.toString());
            model.setCost_status(model.getClass_status() + "");
            model.setCost_status_cmt(model.getClass_status_cmt());
        } else {
            model.setIsover(Boolean.FALSE);
            model.setClass_status(EduReviewSimpleStatus.开始建班.getStats());
            model.setClass_status_cmt(EduReviewSimpleStatus.开始建班.toString());
            model.setCost_status(model.getClass_status() + "");
            model.setCost_status_cmt(model.getClass_status_cmt());
        }
        return classDao.addClass(model) ? new DataModel().withInfo("添加成功") : new DataModel().withErr("添加失败");
    }

    @Override
    public DataModel updateClass(EduClass model) throws SQLException, ParseException {
        // if ("1".equals(model.getClasslevel())) {
        int personNum = classDao.getPersonNum(model.getPlan_code(), model.getCost_id());
        EduPlans plan = plansDao.getPlanById(model.getPlan_code());
        EduPlanCost cost = plansDao.getPlanCost(model.getCost_id());
        EduUser user = UsersService.GetCurrentUser();
        int endnum = cost.getCost_persons() - personNum;//本次建班剩余人数
        int totalpersons = 0;
        List<UnitsPersons> clist = model.getUnitpers();
        //获取已安排人数  if (clist != null) {

        if (clist != null) {
            for (UnitsPersons item : clist) {
                totalpersons += item.getUnit_num();
            }
        }
        if (!user.getUsername().equalsIgnoreCase(model.getAdd_user())) {
            throw new SQLException("你没有修改该班级权限！");
        }
        if (cost == null) {
            throw new SQLException("未找到经费审核信息！");
        }
        if (plan == null) {
            throw new SQLException("未找到计划信息！");
        }
        if (totalpersons > cost.getCost_persons()) {
            throw new SQLException("人数分配总数超过经费审批人总数！");
        }
        if (model.getStudentnum() > cost.getCost_persons()) {
            throw new SQLException("建班总数超过经费审批人总数！");
        }
        if (model.getStudentdays() > cost.getCost_days()) {
            throw new SQLException("不能超过" + cost.getCost_days() + "天！");
        }
        //修改人数不大于剩余 不大于自身
//        if (model.getStudentnum() > endnum || totalpersons > endnum) {
//            throw new SQLException("人数超标，本次建班还能安排" + endnum + "人！");
//        }
//            if ((Math.round(plan.getPlan_num() * 1.05)) < (personNum + model.getStudentnum())) {
//                throw new SQLException("人数超标，培训人数最多不能超过计划人数的百分之五！");
//            }
        //日期验证
        if (!DateUtil.CompareDate(plan.getPlan_sdate().replaceAll("-", "/"), plan.getPlan_edate().replaceAll("-", "/"), model.getStartdate())) {
            throw new SQLException("班级开始日期不能大于计划结束日期" + plan.getPlan_edate());
        }
        if (!DateUtil.CompareDate(plan.getPlan_sdate().replaceAll("-", "/"), plan.getPlan_edate().replaceAll("-", "/"), model.getEnddate())) {
            throw new SQLException("结束日期不能大于计划结束日期！" + plan.getPlan_edate());
        }
//        if (DateUtil.GetCompareDays(model.getStartdate().replaceAll("-", "/"), model.getEnddate().replaceAll("-", "/")) > cost.getCost_days()) {
//            throw new SQLException("培训天数不能超过规定最大天数,天数为：" + cost.getCost_days());
//        }
        if (model.getStudentdays() > cost.getCost_days()) {
            throw new SQLException("不能大于班级费用审批天数！");
        }
        //安排结束
        //安排结束
        if ((model.getStudentnum() == endnum && totalpersons == endnum) || (model.getStudentnum() == cost.getCost_persons() && totalpersons == cost.getCost_persons())) {
            model.setIsover(Boolean.TRUE);
            model.setClass_status(EduReviewSimpleStatus.建班结束.getStats());
            model.setClass_status_cmt(EduReviewSimpleStatus.建班结束.toString());
            model.setCost_status(model.getClass_status() + "");
            model.setCost_status_cmt(model.getClass_status_cmt());
        } else {
            model.setIsover(Boolean.FALSE);
            model.setClass_status(EduReviewSimpleStatus.开始建班.getStats());
            model.setClass_status_cmt(EduReviewSimpleStatus.开始建班.toString());
            model.setCost_status(model.getClass_status() + "");
            model.setCost_status_cmt(model.getClass_status_cmt());
        }
        //  }
        return classDao.updateClass(model) ? new DataModel().withInfo("修改成功") : new DataModel().withErr("修改失败");
    }

    @Override
    public EduClass getClassSingal(String id) throws SQLException {
        return classDao.getClassById(id);
    }

    @Override
    public List<EduClass> getClassList(String... ids) throws SQLException {
        return classDao.getClassList(ids);
    }

    @Override
    public DataModel deleteClass(String ids) throws SQLException {
        return classDao.removeClass(ids) ? new DataModel().withInfo("删除成功") : new DataModel().withErr("删除失败");
    }

    @Override
    public DataModel getClassPages(QueryModel pageModel) throws Throwable {
        Map<Integer, List<EduClass>> resPaging = classDao.getClassPage(pageModel);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public List<EduProf> getProfs(String id) throws SQLException {
        return classDao.getProfs(id);
    }

    @Override
    public List<EduTrainingCategory> getTrains(String id) throws SQLException {
        return classDao.getTrainnings(id);
    }

    @Override
    public List<EduNewPost> getPosts() throws SQLException {
        return classDao.getNewPosts();
    }

    @Override
    public List<PlanClassCostDto> getPlansCosts(ClassCostsSearch search) throws SQLException {
        return classDao.getPlansAndCosts(search);
    }
}
