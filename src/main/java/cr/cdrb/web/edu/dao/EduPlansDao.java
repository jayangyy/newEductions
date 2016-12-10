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
import cr.cdrb.web.edu.daointerface.IBaseDao;
import cr.cdrb.web.edu.daointerface.IEduPlansDao;
import cr.cdrb.web.edu.daointerface.IPlanReview;
import cr.cdrb.web.edu.daointerface.IStaPeronsDao;
import cr.cdrb.web.edu.domains.educlass.EduClass;
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
import cr.cdrb.web.edu.domains.eduplans.EduSocTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduSocialExecunit;
import cr.cdrb.web.edu.domains.eduplans.EduSocialMainunit;
import cr.cdrb.web.edu.domains.eduplans.EduStationChannel;
import cr.cdrb.web.edu.domains.eduplans.EduStationTraintype;
import cr.cdrb.web.edu.domains.eduplans.EduStationtPersons;
import cr.cdrb.web.edu.domains.eduplans.EduTeachFees;
import cr.cdrb.web.edu.domains.eduplans.EduTeachesType;
import cr.cdrb.web.edu.domains.eduplans.StationPersons;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 *
 * 培训计划制定审核
 */
@Repository
public class EduPlansDao implements IEduPlansDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;
    @Autowired
    private IPlanReview reviewDao;
    @Autowired
    private IBaseDao baseDao;
    @Autowired
    private IStaPeronsDao perDao;

    @Override
    public Boolean addPlan(EduPlans plan) throws SQLException {
        String plan_code = UUID.randomUUID().toString();
        String insSql = "insert into edu_plans\n"
                + "  (plan_code, plan_name, plan_num, plan_periods, plan_sdate, plan_edate, plan_object, plan_cmt, plan_type, plan_executeunit, plan_unit, plan_situation, plan_execunitid, plan_unitid, plan_profid, plan_prof, plan_class, plan_status_cmt, plan_status,add_user,plan_days,traintype,plan_road,plan_road_url,plan_highspeed,plan_abroad,plan_gradation,plan_soc_type,is_highspeed,is_personsdb,station_type,station_teaches,station_channel,station_prof,station_line,plan_other_cmt,total_fees,fees_ways,plans_post_type,plan_address,is_yearplan,plan_old_code,plan_type_fees) values\n"
                + "  ('" + plan_code + "', ?, ?, ?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        //新增选择站段
        String insSqls = "insert into StationPserons(station_code,station_name,station_Id,station_cmt,plan_code,station_num,plan_name,add_user) values (?,?,?,?,?,?,?,?) ";
        Object[][] params = new Object[][]{};
        List<StationPersons> stas = plan.getStas();
        if (stas.size() > 0) {
            params = new Object[stas.size()][8];
            int i = 0;
            for (StationPersons item : stas) {
                params[i][0] = UUID.randomUUID().toString();
                params[i][1] = item.getStation_name();
                params[i][2] = item.getStation_Id();
                params[i][3] = "";
                params[i][4] = plan_code;
                params[i][5] = 0;
                params[i][6] = plan.getPlan_name();
                params[i][7] = plan.getAdd_user();
                i++;
            }

        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            oracle.sql.ROWID rowid = db.insert(insSql, plan.getPlan_name(), plan.getPlan_num(), plan.getPlan_periods(), plan.getPlan_sdate(), plan.getPlan_edate(), plan.getPlan_object(), plan.getPlan_cmt(), plan.getPlan_type(), plan.getPlan_executeunit(), plan.getPlan_unit(), plan.getPlan_situation(), plan.getPlan_execunitid(),
                    plan.getPlan_unitid(), plan.getPlan_profid(), plan.getPlan_prof(), plan.getPlan_class(), EduReviewSimpleStatus.处室待办.toString(), EduReviewSimpleStatus.处室待办.getStats(), plan.getAdd_user(), plan.getPlan_days(), plan.getTraintype(), plan.getPlan_road(), plan.getPlan_road_url(), plan.getPlan_highspeed(), plan.getPlan_abroad(), plan.getPlan_gradation(), plan.getPlan_soc_type(), plan.getIs_highspeed(), plan.getIs_personsdb(), plan.getStation_type(), plan.getStation_teaches(), plan.getStation_channel(), plan.getStation_prof(), plan.getStation_line(), plan.getPlan_other_cmt(), plan.getTotal_fees(), plan.getFees_ways(), plan.getPlans_post_type(), plan.getPlan_address(), plan.getIs_yearplan(),plan.setPlan_type_code,plan.getPlan_type_fees);
            db.insertBatch(insSqls, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean updatePlan(EduPlans plan) throws SQLException {
        String updateSql = "update edu_plans set plan_name = ?,plan_num = ?,plan_periods = ?,plan_sdate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),plan_edate = to_date(?,'yyyy-mm-dd hh24:mi:ss'), plan_object = ?, plan_cmt = ?, plan_type = ?, plan_executeunit = ?, plan_unit = ?, plan_situation = ?,plan_execunitid = ?, plan_unitid = ?,plan_profid = ?,plan_prof = ?,plan_class = ?,plan_days=?,traintype=?,plan_road=?,plan_road_url=?,plan_highspeed=?,plan_abroad=?,plan_gradation=?,plan_soc_type=?,is_highspeed=?,is_personsdb=?,station_type=?,station_teaches=?,station_channel=?,station_prof=?,station_line=?,plan_other_cmt=?,total_fees=?,fees_ways=?,plans_post_type=?,plan_address=?,is_yearplan=?,plan_type_fees=?,plan_old_code=? where plan_code = ?";
        //更新站段
        String insSqls = "insert into StationPserons(station_code,station_name,station_Id,station_cmt,plan_code,station_num,plan_name,add_user) values (?,?,?,?,?,?,?,?) ";
        String delSql = "delete from StationPserons where station_code=?";
        String upStaSql = "update StationPserons set station_num=? where station_code=? ";
        Object[][] params = new Object[][]{};//新增
        List<StationPersons> nlist = new ArrayList<StationPersons>();
        Object[][] params1 = new Object[][]{};//修改
        List<StationPersons> ulist = new ArrayList<StationPersons>();
        Object[][] params2 = new Object[][]{};//删除
        List<StationPersons> dlist = new ArrayList<StationPersons>();
        List<StationPersons> elist = new ArrayList<StationPersons>();//不同对象集合
        List<StationPersons> stas = plan.getStas();
        List<StationPersons> ostas = perDao.getStaPersons(plan.getPlan_code(), "");
        if (stas.size() > 0) {
            for (StationPersons item : stas) {
                int o = 0;
                for (StationPersons item1 : ostas) {
                    if (item1.getStation_name().equalsIgnoreCase(item.getStation_name())) {
                        o++;
                    }
                }
                if (o > 0) {
                    ulist.add(item);
                } else {
                    nlist.add(item);
                }
            }
            for (StationPersons item : ostas) {
                int o = 0;
                for (StationPersons item1 : stas) {
                    if (item1.getStation_name().equalsIgnoreCase(item.getStation_name())) {
                        o++;
                    }
                }
                if (o > 0) {
                    if (ulist.contains(item)) {
                        //ulist.add(item);
                    }

                } else {
                    dlist.add(item);
                }
            }
            int j = 0;
            if (nlist.size() > 0) {
                params = new Object[nlist.size()][8];
                for (StationPersons item : nlist) {
                    params[j][0] = UUID.randomUUID().toString();
                    params[j][1] = item.getStation_name();
                    params[j][2] = item.getStation_Id();
                    params[j][3] = "";
                    params[j][4] = plan.getPlan_code();
                    params[j][5] = 0;
                    params[j][6] = plan.getPlan_name();
                    params[j][7] = plan.getAdd_user();
                    j++;
                }
            }
            int k = 0;
            if (dlist.size() > 0) {
                params2 = new Object[dlist.size()][1];
                for (StationPersons item : dlist) {
                    params2[k][0] = item.getStation_code();
                    k++;
                }

            }
//            int l = 0;
//            if (ulist.size() > 0) {
//                params1 = new Object[ulist.size()][2];
//                for (StationPersons item : ulist) {
//                    params1[l][0] = item.getStation_num();
//                    params1[l][1] = item.getStation_code();
//                    l++;
//                }
//            }

        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            // db.batch(upStaSql, params1);
            //未完结，未进入流程可修改站段提报
            EduPlans oplan = getPlanInclude(plan.getPlan_code());
            if (oplan == null) {
                throw new SQLException("未找到原计划，请稍后重试！");
            }
            if (oplan.getPlan_status() != EduReviewSimpleStatus.处室经办.getStats() && oplan.getPlantranfers().size() <= 0) {
                db.batch(delSql, params2);
                db.insertBatch(insSqls, params);
            }
            db.update(updateSql, plan.getPlan_name(), plan.getPlan_num(), plan.getPlan_periods(), plan.getPlan_sdate(), plan.getPlan_edate(), plan.getPlan_object(), plan.getPlan_cmt(), plan.getPlan_type(), plan.getPlan_executeunit(), plan.getPlan_unit(), plan.getPlan_situation(), plan.getPlan_execunitid(),
                    plan.getPlan_unitid(), plan.getPlan_profid(), plan.getPlan_prof(), plan.getPlan_class(), plan.getPlan_days(), plan.getTraintype(), plan.getPlan_road(), plan.getPlan_road_url(), plan.getPlan_highspeed(), plan.getPlan_abroad(), plan.getPlan_gradation(), plan.getPlan_soc_type(), plan.getIs_highspeed(), plan.getIs_personsdb(), plan.getStation_type(), plan.getStation_teaches(), plan.getStation_channel(), plan.getStation_prof(), plan.getStation_line(), plan.getPlan_other_cmt(), plan.getTotal_fees(), plan.getFees_ways(), plan.getPlans_post_type(), plan.getPlan_address(), plan.getIs_yearplan(), ,plan.getPlan_type_fees,plan.setPlan_type_code,plan.getPlan_code());
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean removePlan(String ids) throws SQLException {
        BigDecimal i = db.queryScalar("select count(plan_code) from edu_plans_reviews where plan_code='" + ids + "'");
        if (Integer.parseInt(i.toString()) > 0) {
            throw new SQLException("计划已开始执行，不允许删除！");
        }
        String removeSql = "delete from edu_plans where plan_code=?";
        return (int) db.update(removeSql, ids) > 0;
    }

    @Override
    public Map<Integer, List<EduPlansTransDto>> getPlansPage(EduPlanSearch pageModel) throws Throwable {
        List<Object> list = new ArrayList<Object>();
        String whereSql = " 1=1 ";
        String querySql1 = "";
        if (pageModel.getIsAuth() == 1) {
            //待办    
            //0：只包含自建立计划，1 ：自建计划+移送计划，2：只包含移送计划
            if (pageModel.getIf_union() == 0 || pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " SELECT t.cost_id,t.TRANSFER_CODE,e.* from edu_plans e left join (select TRANSFER_CODE,PLAN_CODE,COST_ID from EDU_PLANS_TRANSFER where " + " TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and TRANS_STATUS=" + pageModel.getTrans_status() + " ) t on t.PLAN_CODE=e.PLAN_CODE where 1=1 ";
                if (pageModel.getTo_unit() != null) {
                    querySql1 += pageModel.getTo_unit().length() > 0 ? "  and (( E .PLAN_UNIT =?  " : "";
                    list.add(pageModel.getTo_unit());
                    if (pageModel.getAdduser() != null) {
                        querySql1 += pageModel.getAdduser().length() > 0 ? " and e.add_user=?)  OR(E.ADD_USER=? " : "";

                        list.add(pageModel.getAdduser());
                        list.add(pageModel.getAdduser());

                    }
                    querySql1 += " )) ";

                }
                querySql1 += " and e.PLAN_STATUS!=" + EduReviewSimpleStatus.处室经办.getStats() + " AND e.PLAN_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats() + " ";
                querySql1 += " and e.plan_status in (" + EduReviewSimpleStatus.getOfficesAuth() + ")";
            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " union ";

            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 2 || pageModel.getIf_union() == 3) {
                querySql1 += " SELECT T1.cost_id,T1.TRANSFER_CODE,E1.* from EDU_PLANS_TRANSFER t1 join edu_plans e1 on t1.plan_code=e1.plan_code   where 1=1 ";
                querySql1 += " and T1.TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND T1.TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and T1.TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and T1.TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and T1.TRANS_STATUS=" + pageModel.getTrans_status() + " ";
                querySql1 += " and e1.PLAN_STATUS!=" + EduReviewSimpleStatus.处室经办.getStats() + " AND e1.PLAN_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats() + " ";
            }
        } else if (pageModel.getIsAuth() == 2) {
            //经办      
            if (pageModel.getIf_union() == 0 || pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " SELECT e.* from EDU_PLANS e left join (select TRANSFER_CODE,PLAN_CODE,COST_ID from EDU_PLANS_TRANSFER where " + " TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and TRANS_STATUS=" + pageModel.getTrans_status() + ") t on t.PLAN_CODE=e.PLAN_CODE where 1=1 ";
                if (pageModel.getTo_unit() != null) {
                    querySql1 += pageModel.getTo_unit().length() > 0 ? "  and (( E .PLAN_UNIT =?  " : "";
                    list.add(pageModel.getTo_unit());
                    if (pageModel.getAdduser() != null) {
                        querySql1 += pageModel.getAdduser().length() > 0 ? " and e.add_user=?)  OR(E.ADD_USER=?  " : "";

                        list.add(pageModel.getAdduser());
                        list.add(pageModel.getAdduser());

                    }
                    querySql1 += " )) ";

                }
                querySql1 += " and e.plan_status  not in (" + EduReviewSimpleStatus.getOfficesAuth() + ")";
            }

//            if (pageModel.getAdduser() != null) {
//                querySql1 += pageModel.getAdduser().length() > 0 ? " and e.add_user=?  " : "";
//                list.add(pageModel.getAdduser());
//            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " union ";
            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 2 || pageModel.getIf_union() == 3) {
                //包含移送计划
                //querySql1 += " union ";
                querySql1 += " SELECT E1.* from EDU_PLANS_TRANSFER t1 ";
                //  querySql1+=" left join (SELECT DISTINCT PLAN_CODE from EDU_PLANS_TRANSFER where TRANS_STATUS="+EduReviewSimpleStatus.待办.getStats()+" and TRANSFER_TO_UNIT ='"+pageModel.getTo_unit()+"' AND TRANSFER_TO_UID = '"+pageModel.getTo_uid()+"' AND TRANSFER_TO_USER = '"+pageModel.getTo_user()+"' AND TRANSFER_TO_IDCARD = '"+pageModel.getTo_idcard()+"') t2 on t2.PLAN_CODE!=t1.PLAN_CODE";
                querySql1 += " join EDU_PLANS e1 on t1.plan_code=e1.plan_code   where 1=1 ";
                querySql1 += " and T1.TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND T1.TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and T1.TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and T1.TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and T1.TRANS_STATUS!=" + pageModel.getTrans_status() + " ";
                querySql1 += " AND e1.PLAN_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats() + " ";
            }
        }
        //指定处室
        if (pageModel.getPlan_mainid() != null) {
            if (pageModel.getPlan_mainid().length() > 0) {
                //主办单位
                whereSql += "  and plan_unit=? ";
                list.add(pageModel.getPlan_mainid());
            }
        }
        if (pageModel.getPlan_execid() != null) {
            //主办单位+移送过来
            if (pageModel.getPlan_execid().length() > 0) {
                whereSql += " and plan_executeunit=? ";
                list.add(pageModel.getPlan_execid());
            }
        }
        if (pageModel.getSreviewstatus() != null) {
            //承办单位
            if (pageModel.getSreviewstatus().length() > 0) {
                whereSql += " and plan_status=?";
                list.add(pageModel.getSreviewstatus());
            }
        }
        if (pageModel.getPlanname() != null) {
            if (pageModel.getPlanname().length() > 0) {
                //计划名称
                whereSql += " and plan_name like '%" + pageModel.getPlanname() + "%'";
            }
        }
        if (pageModel.getFilterRules() != null) {
            whereSql += "  " + pageModel.getFilterRules();
        }
        pageModel.setFilterRules(whereSql);
        pageModel.setSelects(querySql1);
        if (pageModel.getParams() != null) {
            list.addAll(pageModel.getParams());
        }
        pageModel.setParams(list);
        return baseDao.getPageComs(pageModel, EduPlansTransDto.class);
    }

    @Override
    public EduPlans getPlanById(String id) throws SQLException {
        String querySql = "select * from edu_plans where plan_code=?";
        return db.queryBean(EduPlans.class, querySql, id);
    }

    @Override
    public List<EduPlans> getPlans(Object... params) throws SQLException {
        String querySql = "select * from edu_plans where 1=1 ";
        List<String> paramArray = new ArrayList<String>();
        if (params.length > 0) {
            if (params[0].toString().length() > 0) {
                querySql += " and plan_code in (" + params[0] + ")";
            }
            //主办单位或承办单位均可建立班级
            if (params[1].toString().length() > 0) {
                querySql += " or plan_unit=?";
                paramArray.add(params[1].toString());
            }
            if (params[2].toString().length() > 0) {
                querySql += " and plan_status=?";
                paramArray.add(params[2].toString());
            }
            if (params[3].toString().length() > 0) {
                querySql += " or PLAN_EXECUTEUNIT=?";
                paramArray.add(params[3].toString());
            }
            if (params[4].toString().length() > 0) {
                querySql += " or ADD_USER=?";
                paramArray.add(params[4].toString());
            }
        }
        return db.queryBeanList(EduPlans.class, querySql, paramArray.toArray());
    }

    @Override
    public List<EduProf> getProfs(Object... uids) throws SQLException {
        String profSql = "select * from edu_prof where 1=1";
        int i = 0;
        if (uids.length > 0) {
            if (uids[0] != null && !uids[0].equals("")) {
                profSql += " and id=? ";
                i++;
            }
        }
        return i > 0 ? db.queryBeanList(EduProf.class, profSql, uids) : db.queryBeanList(EduProf.class, profSql);
    }

    @Override
    public EduPlans getPlanInclude(String id) throws SQLException {
        String querySql = "select * from edu_plans where plan_code=?";
        EduPlans model = db.queryBean(EduPlans.class, querySql, id);
        if (model != null) {
            String classList = "select * from edu_class where plan_code=?";
            String reviewList = "select * from edu_plans_reviews where plan_code=? ORDER BY REVIEW_DATE DESC";
            String transferList = "select * from edu_plans_transfer where plan_code=? order by transfer_date DESC ";
            String stasList = "select * from StationPserons where plan_code=? ";
            model.setStas(db.queryBeanList(StationPersons.class, stasList, id));
            model.setEduclasses(db.queryBeanList(EduClass.class, classList, id));
            model.setEdureviews(db.queryBeanList(EduReviews.class, reviewList, id));
            model.setPlantranfers(db.queryBeanList(EduPlanTransfer.class, transferList, id));
        }
        return model;
    }
    //处室移送

    @Override
    public Boolean transferPlan(EduPlans plan) throws SQLException {
        String updateSql = "update edu_plans set plan_status=?,plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,review_to_user,review_to_idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?) ";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        String company = "";
        if (plan.getPlantranfers().size() > 0) {
            params2 = new Object[plan.getPlantranfers().size()][12];
            List<EduPlanTransfer> edureviews = plan.getPlantranfers();
            for (int i = 0; i < edureviews.size(); i++) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = edureviews.get(i).getPlan_code();
                params2[i][2] = edureviews.get(i).getTransfer_from_user();
                params2[i][3] = edureviews.get(i).getTransfer_from_idcard();
                params2[i][4] = edureviews.get(i).getTransfer_to_user();
                params2[i][5] = edureviews.get(i).getTransfer_to_idcard();
                params2[i][6] = edureviews.get(i).getTransfer_to_unit();
                params2[i][7] = edureviews.get(i).getTransfer_to_uid();
                params2[i][8] = edureviews.get(i).getTrans_status();
                params2[i][9] = edureviews.get(i).getTransfer_from_user() + "移送至" + edureviews.get(i).getTransfer_to_user() + edureviews.get(i).getTrans_status_cmt();
                params2[i][10] = edureviews.get(i).getTransfer_from_unitid();
                params2[i][11] = edureviews.get(i).getTransfer_from_unit();

                company += edureviews.get(i).getTransfer_to_unit() + edureviews.get(i).getTransfer_to_user() + ",";
            }
        }
        if (plan.getEdureviews().size() > 0) {
            params = new Object[plan.getEdureviews().size()][14];
            List<EduReviews> edureviews = plan.getEdureviews();
            for (int i = 0; i < edureviews.size(); i++) {
                params[i][0] = UUID.randomUUID().toString();
                params[i][1] = edureviews.get(i).getPlan_code();
                params[i][2] = edureviews.get(i).getReviewer();
                params[i][3] = edureviews.get(i).getReview_status();
                params[i][4] = edureviews.get(i).getReview_cmt();
                params[i][5] = edureviews.get(i).getReview_url();
                params[i][6] = edureviews.get(i).getCurrent_unit() + edureviews.get(i).getPlan_status_cmt();
                params[i][7] = edureviews.get(i).getCurrent_unit();
                params[i][8] = edureviews.get(i).getCurrent_unitid();
                params[i][9] = edureviews.get(i).getIdcard();
                params[i][10] = edureviews.get(i).getReview_to_user();
                params[i][11] = edureviews.get(i).getReview_to_idcard();
                params[i][12] = params2[i][0];
                params[i][13] = DateUtil.FormatDate(edureviews.get(i).getReview_date());
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, plan.getPlan_status(), "移送至" + company + "待办", plan.getPlan_code());
            db.batch(transSql, params2);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean overPlan(EduReviews plan) throws SQLException {
        String insSql = "insert into edu_plans_reviews(review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,review_date)  values\n"
                + "  ('" + UUID.randomUUID() + "', ?, ?, ?, ?, ?, ?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String updateSql = "update edu_plans set plan_status=?,plan_status_cmt=? where plan_code=? ";
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, plan.getReview_status(), plan.getPlan_status_cmt(), plan.getPlan_code());
            db.insert(insSql, plan.getPlan_code(), plan.getReviewer(), plan.getReview_status(), plan.getReview_cmt(), plan.getReview_url(), plan.getPlan_status_cmt(), DateUtil.FormatDate(plan.getReview_date()));
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean throwPlan(EduReviews plan) throws SQLException {
        String insSql = "insert into edu_plans_reviews(review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,review_date)  values\n"
                + "  ('" + UUID.randomUUID() + "', ?, ?, ?, ?, ?, ?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String updateSql = "update edu_plans set plan_status=?,plan_status_cmt=? where plan_code=? ";
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, plan.getReview_status(), plan.getPlan_status_cmt(), plan.getPlan_code());
            db.insert(insSql, plan.getPlan_code(), plan.getReviewer(), plan.getReview_status(), plan.getReview_cmt(), plan.getReview_url(), plan.getPlan_status_cmt(), DateUtil.FormatDate(plan.getReview_date()));
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean hasPlanLoading(String plan_code) throws SQLException {
        String querySql1 = "SELECT COUNT(1) from EDU_PLANS_TRANSFER where TRANS_STATUS=" + EduReviewSimpleStatus.待办.getStats() + " and plan_code=?";
        BigDecimal countAll = db.queryScalar(1, querySql1, plan_code);
        return Integer.parseInt(countAll.toString()) > 0;
    }

    @Override
    public Boolean canRemove(String plan_code) throws SQLException {
        String querySql1 = "SELECT COUNT(1) from EDU_PLANS_TRANSFER T join edu_plans E where  T.plan_code=? and E.TRANS_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats();
        BigDecimal countAll = db.queryScalar(1, querySql1, plan_code);
        return Integer.parseInt(countAll.toString()) > 0;
    }

    @Override
    public Map<Integer, List<EduPlansTransDto>> getTransPlanPage(EduPlanSearch pageModel) throws Throwable {
        String whereSql = " 1=1 ";
        List<Object> list = new ArrayList<Object>();
        list.add(pageModel.getTo_unit());
        list.add(pageModel.getTo_uid());
        list.add(pageModel.getTo_user());
        list.add(pageModel.getTo_idcard());
        String querySql1 = "";
        if (pageModel.getIsAuth() == 1) {
            whereSql += " and TRANS_STATUS=? AND PLAN_STATUS!=? AND PLAN_STATUS!=?";
            //待办
            list.add(pageModel.getTrans_status());
            list.add(EduReviewSimpleStatus.处室经办.getStats());
            list.add(EduReviewSimpleStatus.处室废弃.getStats());
            querySql1 = "SELECT T.TRANSFER_CODE,T.TRANSFER_DATE,T.TRANSFER_FROM_IDCARD,T.TRANSFER_FROM_USER,T.TRANSFER_TO_IDCARD,T.TRANSFER_TO_UID,T.TRANSFER_TO_UNIT,T.TRANSFER_TO_USER,T.TRANS_STATUS,T.TRANS_STATUS_CMT,P.* from edu_plans_transfer  T join EDU_PLANS P on T.PLAN_CODE=P.PLAN_CODE WHERE T.TRANSFER_TO_UNIT=? AND T.TRANSFER_TO_UID=?  and T.TRANSFER_TO_USER=? and T.TRANSFER_TO_IDCARD =? ";
        } else {
            //经办
            //   whereSql += " ";
            list.add(pageModel.getTrans_status());
            list.add(EduReviewSimpleStatus.处室废弃.getStats());
            querySql1 = "SELECT DISTINCT P .* FROM edu_plans_transfer T JOIN EDU_PLANS P ON T .PLAN_CODE = P .PLAN_CODE WHERE T.TRANSFER_TO_UNIT=? AND T.TRANSFER_TO_UID=?  and T.TRANSFER_TO_USER=? and T.TRANSFER_TO_IDCARD =?  and T.TRANS_STATUS!=?  AND P.PLAN_STATUS!=?";
        }
//        if (pageModel.getPlan_mainid() != null) {
//            if (pageModel.getPlan_mainid().length() > 0) {
//                whereSql += " and plan_executeunit=? ";
//                list.add(pageModel.getPlan_mainid());
//            }
//        }
        if (pageModel.getPlanname() != null) {
            if (pageModel.getPlanname().length() > 0) {
                whereSql += " and plan_name=? ";
                list.add(pageModel.getPlanname());
            }
        }
        pageModel.setFilterRules(whereSql);

        ISelectBuilder builder = new OracleSelectBuilder()
                .from(querySql1)
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EduPlansTransDto>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql, list.toArray());
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(EduPlansTransDto.class, querySql, list.toArray()));
        return map;
    }

    ///移送单位审核通过
    @Override
    public Boolean authReview(EduReviews review) throws SQLException {
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            EduPlanTransfer transfer = new EduPlanTransfer();
            transfer.setTransfer_code(review.getTransfer_code());
            transfer.setTrans_status_cmt(review.getReview_cmt());
            transfer.setTrans_status(review.getReview_status());
            transfer.setTransfer_url(review.getReview_url());
            EduPlans plan = new EduPlans();
            plan.setPlan_code(review.getPlan_code());
            plan.setPlan_status_cmt("由" + review.getReviewer() + review.getPlan_status_cmt() + "完成");
            plan.setPlan_status(-1);
            Boolean result = updaePlanStatus(plan) && updaeTransferStatus(transfer) && reviewDao.addReview(review);
            if (!StringUtils.isBlank(review.getCost_id())) {
                //经费审批状态改变
                db.update("update EDU_PLAN_COSTS set cost_status=?,cost_status_cmt=? where cost_id=?", EduReviewSimpleStatus.职教经办.getStats() + "", EduReviewSimpleStatus.职教经办.toString(), review.getCost_id());
            }
            conn.commit();
            conn.setAutoCommit(true);
            return result;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean updaeTransferStatus(EduPlanTransfer transfer) throws SQLException {
        String updateSql = "update edu_plans_transfer set TRANS_STATUS=?,TRANS_STATUS_CMT=?,TRANSFER_URL=? where transfer_code=?";
        return (int) db.update(updateSql, transfer.getTrans_status(), transfer.getTrans_status_cmt(), transfer.getTransfer_url(), transfer.getTransfer_code()) > 0;
    }

    @Override
    public Boolean updaePlanStatus(EduPlans plan) throws SQLException {
        String updateSql = "update edu_plans ";
        if (plan.getPlan_status() != -1) {
            updateSql += "set plan_status=?,plan_status_cmt=? where plan_code=?";
            return (int) db.update(updateSql, plan.getPlan_status(), plan.getPlan_status_cmt(), plan.getPlan_code()) > 0;
        } else {
            updateSql += "set plan_status_cmt=? where plan_code=?";
            return (int) db.update(updateSql, plan.getPlan_status_cmt(), plan.getPlan_code()) > 0;
        }
    }

    @Override
    public EduPlanTransfer getTransferById(String code) throws SQLException {
        String querySql = "select * from EDU_PLANS_TRANSFER where transfer_code=?";
        return db.queryBean(EduPlanTransfer.class, querySql, code);
    }

    //单位内移交
    @Override
    public Boolean unitsTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException {
        String updateSql = "update edu_plans set plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?) ";
        String updateTrans = "update edu_plans_transfer set trans_status_cmt=?,trans_status=? where transfer_code=?";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        String companys = "";
        if (transfers.size() > 0) {
            params2 = new Object[transfers.size()][12];
            for (int i = 0; i < transfers.size(); i++) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = review.get(0).getPlan_code();
                params2[i][2] = transfers.get(i).getTransfer_from_user();
                params2[i][3] = transfers.get(i).getTransfer_from_idcard();
                params2[i][4] = transfers.get(i).getTransfer_to_user();
                params2[i][5] = transfers.get(i).getTransfer_to_idcard();
                params2[i][6] = transfers.get(i).getTransfer_to_unit();
                params2[i][7] = transfers.get(i).getTransfer_to_uid();
                params2[i][8] = transfers.get(i).getTrans_status();
                params2[i][9] = transfers.get(i).getTransfer_from_user() + "移送至" + transfers.get(i).getTransfer_to_user() + transfers.get(i).getTrans_status_cmt();
                companys += transfers.get(i).getTransfer_to_unit() + "(" + transfers.get(i).getTransfer_to_user() + ")" + "|";
                params2[i][10] = transfers.get(i).getTransfer_from_unitid();
                params2[i][11] = transfers.get(i).getTransfer_from_unit();
            }
        }
        if (review.size() > 0) {
            params = new Object[review.size()][12];
            for (int i = 0; i < review.size(); i++) {
                params[0][0] = UUID.randomUUID().toString();
                params[0][1] = review.get(i).getPlan_code();
                params[0][2] = review.get(i).getReviewer();
                params[0][3] = review.get(i).getReview_status();
                params[0][4] = review.get(i).getReview_cmt();
                params[0][5] = review.get(i).getReview_url();
                params[0][6] = "由" + review.get(i).getCurrent_unit() + review.get(i).getReviewer() + "移交" + companys + "待办";
                params[0][7] = review.get(i).getCurrent_unit();
                params[0][8] = review.get(i).getCurrent_unitid();
                params[0][9] = review.get(i).getIdcard();
                params[0][10] = params2[i][0];
                params[0][11] = DateUtil.FormatDate(review.get(i).getReview_date());
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, "由" + review.get(0).getCurrent_unit() + review.get(0).getReviewer() + "移交" + companys + "待办", review.get(0).getPlan_code());
            db.update(updateTrans, "由" + review.get(0).getCurrent_unit() + review.get(0).getReviewer() + review.get(0).getPlan_status_cmt(), review.get(0).getReview_status(), review.get(0).getTransfer_code());
            db.batch(transSql, params2);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    ///回发拟稿人
    @Override
    public Boolean authBacktop(EduReviews review) throws SQLException {
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            EduPlanTransfer transfer = new EduPlanTransfer();
            transfer.setTransfer_code(review.getTransfer_code());
            transfer.setTrans_status_cmt("由" + review.getReviewer() + review.getPlan_status_cmt());
            transfer.setTrans_status(review.getReview_status());
            transfer.setTransfer_url(review.getReview_url());
            EduPlans plan = new EduPlans();
            plan.setPlan_code(review.getPlan_code());
            plan.setPlan_status_cmt("由" + review.getReviewer() + review.getPlan_status_cmt());
            plan.setPlan_status(review.getReview_status());
            Boolean result = updaePlanStatus(plan) && updaeTransferStatus(transfer) && reviewDao.addReview(review);
            if (!StringUtils.isBlank(review.getCost_id())) {
                //经费审批状态改变
                db.update("update EDU_PLAN_COSTS set cost_status=?,cost_status_cmt=? where cost_id=?", EduReviewSimpleStatus.费用回发.getStats() + "", EduReviewSimpleStatus.费用回发.toString(), review.getCost_id());
            }
            conn.commit();
            conn.setAutoCommit(true);
            return result;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    ///回发上一级
    @Override
    public Boolean authBackuser(EduReviews review, EduPlanTransfer transfer) throws SQLException {
        String updateSql = "update edu_plans set plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?) ";
        String updateTrans = "update edu_plans_transfer set trans_status_cmt=?,trans_status=? where transfer_code=?";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        String companys = "";
        params2 = new Object[1][12];
        params2[0][0] = UUID.randomUUID().toString();
        params2[0][1] = transfer.getPlan_code();
        params2[0][2] = transfer.getTransfer_from_user();
        params2[0][3] = transfer.getTransfer_from_idcard();
        params2[0][4] = transfer.getTransfer_to_user();
        params2[0][5] = transfer.getTransfer_to_idcard();
        params2[0][6] = transfer.getTransfer_to_unit();
        params2[0][7] = transfer.getTransfer_to_uid();
        params2[0][8] = transfer.getTrans_status();
        params2[0][9] = transfer.getTransfer_from_user() + "移送至" + transfer.getTransfer_to_user() + transfer.getTrans_status_cmt();
        params2[0][10] = transfer.getTransfer_from_unitid();
        params2[0][11] = transfer.getTransfer_from_unit();
        params = new Object[1][12];
        params[0][0] = UUID.randomUUID().toString();
        params[0][1] = review.getPlan_code();
        params[0][2] = review.getReviewer();
        params[0][3] = review.getReview_status();
        params[0][4] = review.getReview_cmt();
        params[0][5] = review.getReview_url();
        params[0][6] = "由" + review.getCurrent_unit() + review.getReviewer() + "回发" + transfer.getTransfer_to_unit() + "待办";
        params[0][7] = review.getCurrent_unit();
        params[0][8] = review.getCurrent_unitid();
        params[0][9] = review.getIdcard();
        params[0][10] = params2[0][0];
        params[0][11] = DateUtil.FormatDate(review.getReview_date());
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, "由" + review.getCurrent_unit() + review.getReviewer() + "回发" + companys + "待办", review.getPlan_code());
            db.update(updateTrans, "由" + review.getCurrent_unit() + review.getReviewer() + review.getPlan_status_cmt(), review.getReview_status(), review.getTransfer_code());
            db.batch(transSql, params2);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    /// 移送财务单独审核
    @Override
    public Boolean transferFinance(EduPlanCost cost, EduPlans plan) throws SQLException {
        String updateSql = "update edu_plans set plan_status=?,plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,review_to_user,review_to_idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit,cost_id) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?,?) ";
        String costIns = " insert into edu_plan_costs\n"
                + "  (cost_id, plan_code, cost_user, cost_tell, books_cost, books_cost_num, books_total_fee, place_cost, place_cost_num, place_total_fee, hotel_cost, hotel_cost_num, hotel_total_fee, meals_cost, meals_cost_num, meals_total_fee, info_cost, info_cost_num, info_total_fee, traffic_cost, traffic_cost_num, traffic_total_fee, auth_books_cost, auth_books_num, auth_books_fees, auth_place_cost, auth_place_num, auth_place_fees, auth_hotel_cost, atuh_hotel_num, auth_hotel_fees, auth_meals_cost, auth_meals_num, auth_meals_fees, auth_info_cost, auth_info_num, auth_info_fees, auth_traffic_cost, auth_traffic_num, auth_traffic_fees, is_year_plan,plan_type_fee,plan_post_type,total_cost，cost_days,cost_name,cost_address, cost_persons,cost_place_num,cost_status,cost_status_cmt)"
                + "values "
                + "  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?)";
        String teachesIns = "insert into edu_teach_fees\n"
                + "  (teach_fee_id, cost_id, teach_cmt, teach_fee, teach_num, teach_fees, auth_teach_fee, auth_teach_num, auth_teach_fees, is_outer_teacher)\n"
                + "values\n"
                + "  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String othersIns = "insert into edu_other_costs\n"
                + "  (other_id, cost_id, other_cmt, other_cost)\n"
                + "values\n"
                + "  (?, ?, ?, ?)";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = new Object[0][0];
        Object[][] params2 = null;
        List<Object> params3 = new ArrayList<Object>();
        Object[][] params4 = null;
        List<List<String>> temp4 = new ArrayList<List<String>>();
        Object[][] params5 = null;
        Object[] params6 = null;
        String company = "";
        //费用
        params3.add(UUID.randomUUID().toString());
        params3.add(cost.getPlan_code());
        params3.add(cost.getCost_user());
        params3.add(cost.getCost_tell());
        params3.add(cost.getBooks_cost());
        params3.add(cost.getBooks_cost_num());
        params3.add(cost.getBooks_total_fee());
        params3.add(cost.getPlace_cost());
        params3.add(cost.getPlace_cost_num());
        params3.add(cost.getPlace_total_fee());
        params3.add(cost.getHotel_cost());
        params3.add(cost.getHotel_cost_num());
        params3.add(cost.getHotel_total_fee());
        params3.add(cost.getMeals_cost());
        params3.add(cost.getMeals_cost_num());
        params3.add(cost.getMeals_total_fee());
        params3.add(cost.getInfo_cost());
        params3.add(cost.getInfo_cost_num());
        params3.add(cost.getInfo_total_fee());
        params3.add(cost.getTraffic_cost());
        params3.add(cost.getTraffic_cost_num());
        params3.add(cost.getTraffic_total_fee());
        //审核费用默认为预算费用
        params3.add(cost.getBooks_cost());
        params3.add(cost.getBooks_cost_num());
        params3.add(cost.getBooks_total_fee());
        params3.add(cost.getPlace_cost());
        params3.add(cost.getPlace_cost_num());
        params3.add(cost.getPlace_total_fee());
        params3.add(cost.getHotel_cost());
        params3.add(cost.getHotel_cost_num());
        params3.add(cost.getHotel_total_fee());
        params3.add(cost.getMeals_cost());
        params3.add(cost.getMeals_cost_num());
        params3.add(cost.getMeals_total_fee());
        params3.add(cost.getInfo_cost());
        params3.add(cost.getInfo_cost_num());
        params3.add(cost.getInfo_total_fee());
        params3.add(cost.getTraffic_cost());
        params3.add(cost.getTraffic_cost_num());
        params3.add(cost.getTraffic_total_fee());

        //讲课费用
        if (cost.getTeachfees().size() > 0) {
            int i = 0;
            params4 = new Object[cost.getTeachfees().size()][9];
            List<EduTeachFees> teachlist = cost.getTeachfees();
            for (EduTeachFees teach : teachlist) {
                List<Object> t = new ArrayList<Object>();
                t.add(UUID.randomUUID().toString());
                t.add(params3.get(0).toString());
                t.add(teach.getTeach_cmt());
                t.add(teach.getTeach_fee());
                t.add(teach.getTeach_num());
                t.add(teach.getTeach_fees());
                t.add(teach.getTeach_fee());
                t.add(teach.getTeach_num());
                t.add(teach.getTeach_fees());
                t.add(0);
                params4[i] = t.toArray();
                i++;
            }
        }
        //其他费用
        if (cost.getOtherfees().size() > 0) {
            int j = 0;
            params5 = new Object[cost.getOtherfees().size()][3];
            List<EduOtherFees> otherlist = cost.getOtherfees();
            for (EduOtherFees other : otherlist) {
                List<Object> t1 = new ArrayList<Object>();
                t1.add(UUID.randomUUID().toString());
                t1.add(params3.get(0).toString());
                t1.add(other.getOther_cmt());
                t1.add(other.getOther_cost());
                params5[j] = t1.toArray();
                j++;
            }
        }
        if (plan.getPlantranfers().size() > 0) {
            params2 = new Object[plan.getPlantranfers().size()][13];
            List<EduPlanTransfer> edureviews = plan.getPlantranfers();
            for (int i = 0; i < edureviews.size(); i++) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = edureviews.get(i).getPlan_code();
                params2[i][2] = edureviews.get(i).getTransfer_from_user();
                params2[i][3] = edureviews.get(i).getTransfer_from_idcard();
                params2[i][4] = edureviews.get(i).getTransfer_to_user();
                params2[i][5] = edureviews.get(i).getTransfer_to_idcard();
                params2[i][6] = edureviews.get(i).getTransfer_to_unit();
                params2[i][7] = edureviews.get(i).getTransfer_to_uid();
                params2[i][8] = edureviews.get(i).getTrans_status();
                params2[i][9] = edureviews.get(i).getTransfer_from_user() + "移送至" + edureviews.get(i).getTransfer_to_user() + edureviews.get(i).getTrans_status_cmt();
                params2[i][10] = edureviews.get(i).getTransfer_from_unitid();
                params2[i][11] = edureviews.get(i).getTransfer_from_unit();
                params2[i][12] = params3.get(0);
                company += edureviews.get(i).getTransfer_to_unit() + edureviews.get(i).getTransfer_to_user() + ",";
            }
        }
        params3.add(cost.getIs_year_plan());
        params3.add(cost.getPlan_type_fee());
        params3.add(cost.getPlan_post_type());
        params3.add(cost.getTotal_cost());
        params3.add(cost.getCost_days());
        params3.add(cost.getCost_name());
        params3.add(cost.getCost_address());
        params3.add(cost.getCost_persons());
        params3.add(cost.getCost_place_num());
        params3.add(cost.getCost_status());
        params3.add(cost.getCost_status_cmt());
        if (plan.getEdureviews().size() > 0) {
            params = new Object[plan.getEdureviews().size()][14];
            List<EduReviews> edureviews = plan.getEdureviews();
            for (int i = 0; i < edureviews.size(); i++) {
                params[i][0] = UUID.randomUUID().toString();
                params[i][1] = edureviews.get(i).getPlan_code();
                params[i][2] = edureviews.get(i).getReviewer();
                params[i][3] = edureviews.get(i).getReview_status();
                params[i][4] = edureviews.get(i).getReview_cmt();
                params[i][5] = edureviews.get(i).getReview_url();
                params[i][6] = edureviews.get(i).getCurrent_unit() + edureviews.get(i).getPlan_status_cmt();
                params[i][7] = edureviews.get(i).getCurrent_unit();
                params[i][8] = edureviews.get(i).getCurrent_unitid();
                params[i][9] = edureviews.get(i).getIdcard();
                params[i][10] = edureviews.get(i).getReview_to_user();
                params[i][11] = edureviews.get(i).getReview_to_idcard();
                params[i][12] = params2[i][0];
                params[i][13] = DateUtil.FormatDate(edureviews.get(i).getReview_date());
            }
        }
        //培训计划费用
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, plan.getPlan_status(), "移送至" + company + "待办", plan.getPlan_code());
            db.insert(costIns, params3.toArray());
            db.batch(teachesIns, params4 == null ? new Object[][]{} : params4);
            db.batch(othersIns, params5 == null ? new Object[][]{} : params5);
            db.batch(transSql, params2);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public EduPlanCost getFinanceInclude(String plan_code, String cost_code) throws SQLException {
        String querySql = "select * from edu_plan_costs where plan_code=? and cost_id=?";
        EduPlanCost cost = db.queryBean(EduPlanCost.class, querySql, plan_code, cost_code);
        if (cost != null) {
            String teachSql = "select * from edu_teach_fees where cost_id=? ";
            List<EduTeachFees> teachs = db.queryBeanList(EduTeachFees.class, teachSql, cost_code);
            cost.setTeachfees(teachs);
            String otherSql = " select * from EDU_OTHER_COSTS where cost_id=? ";
            List<EduOtherFees> others = db.queryBeanList(EduOtherFees.class, otherSql, cost_code);
            cost.setOtherfees(others);
        }
        return cost;
    }

    //经费审批单位内移交
    @Override
    public Boolean financeTransfer(List<EduReviews> review, List<EduPlanTransfer> transfers, String costid) throws SQLException {
        String updateSql = "update edu_plans set plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit,cost_id) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?,?) ";
        String updateTrans = "update edu_plans_transfer set trans_status_cmt=?,trans_status=? where transfer_code=?";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        String companys = "";
        if (transfers.size() > 0) {
            params2 = new Object[transfers.size()][13];
            for (int i = 0; i < transfers.size(); i++) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = review.get(0).getPlan_code();
                params2[i][2] = transfers.get(i).getTransfer_from_user();
                params2[i][3] = transfers.get(i).getTransfer_from_idcard();
                params2[i][4] = transfers.get(i).getTransfer_to_user();
                params2[i][5] = transfers.get(i).getTransfer_to_idcard();
                params2[i][6] = transfers.get(i).getTransfer_to_unit();
                params2[i][7] = transfers.get(i).getTransfer_to_uid();
                params2[i][8] = transfers.get(i).getTrans_status();
                params2[i][9] = transfers.get(i).getTransfer_from_user() + "移送至" + transfers.get(i).getTransfer_to_user() + transfers.get(i).getTrans_status_cmt();
                companys += transfers.get(i).getTransfer_to_unit() + "(" + transfers.get(i).getTransfer_to_user() + ")" + "|";
                params2[i][10] = transfers.get(i).getTransfer_from_unitid();
                params2[i][11] = transfers.get(i).getTransfer_from_unit();
                params2[i][12] = transfers.get(i).getCost_id();
            }
        }
        if (review.size() > 0) {
            params = new Object[review.size()][12];
            for (int i = 0; i < review.size(); i++) {
                params[0][0] = UUID.randomUUID().toString();
                params[0][1] = review.get(i).getPlan_code();
                params[0][2] = review.get(i).getReviewer();
                params[0][3] = review.get(i).getReview_status();
                params[0][4] = review.get(i).getReview_cmt();
                params[0][5] = review.get(i).getReview_url();
                params[0][6] = "由" + review.get(i).getCurrent_unit() + review.get(i).getReviewer() + "移交" + companys + "待办";
                params[0][7] = review.get(i).getCurrent_unit();
                params[0][8] = review.get(i).getCurrent_unitid();
                params[0][9] = review.get(i).getIdcard();
                params[0][10] = params2[i][0];
                params[0][11] = DateUtil.FormatDate(review.get(i).getReview_date());
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, "由" + review.get(0).getCurrent_unit() + review.get(0).getReviewer() + "移交" + companys + "待办", review.get(0).getPlan_code());
            db.update(updateTrans, "由" + review.get(0).getCurrent_unit() + review.get(0).getReviewer() + review.get(0).getPlan_status_cmt(), review.get(0).getReview_status(), review.get(0).getTransfer_code());
            db.batch(transSql, params2);
            db.batch(insSql, params);
            if (!StringUtils.isBlank(costid)) {
                //经费审批状态改变
                db.update("update EDU_PLAN_COSTS set cost_status=?,cost_status_cmt=? where cost_id=?", EduReviewSimpleStatus.财务待审.getStats() + "", EduReviewSimpleStatus.财务待审.toString(), costid);
            }
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean authFinance(EduReviews review, EduPlanCost cost) throws SQLException {
        Connection conn = db.getConnection();
        String upCostSql = "update edu_plan_costs set cost_user = ?,cost_tell = ?,auth_books_cost = ?,auth_books_num = ?,auth_books_fees = ?,auth_place_cost = ?,auth_place_num = ?,\n"
                + "  auth_place_fees = ?,auth_hotel_cost = ?,atuh_hotel_num = ?,auth_hotel_fees = ?,auth_meals_cost = ?,auth_meals_num = ?,\n"
                + "  auth_meals_fees = ?,auth_info_cost = ?,auth_info_num = ?, auth_info_fees = ?,auth_traffic_cost = ?,auth_traffic_num = ?,\n"
                + "  auth_traffic_fees = ?,\n"
                + "  is_year_plan = ?,total_cost = ?,plan_type_fee = ?,plan_post_type = ?,cost_days=?,cost_status=?,cost_status_cmt=?\n"
                + " where cost_id = ? ";
        String teachesIns = "insert into edu_teach_fees\n"
                + "  (teach_fee_id, cost_id, teach_cmt,auth_teach_fee, auth_teach_num, auth_teach_fees, is_outer_teacher)\n"
                + "values\n"
                + "  (?, ?, ?, ?, ?, ?, ?)";
        String othersIns = "insert into edu_other_costs\n"
                + "  (other_id, cost_id, other_cmt, other_cost)\n"
                + "values\n"
                + "  (?, ?, ?, ?)";
        String delTeach = "delete from edu_teach_fees where cost_id=?";
        String delOther = "delete from edu_other_costs where cost_id=?";
        List<Object> costParams = new ArrayList<Object>();
        Object[][] teachePrams = new Object[][]{};
        Object[][] othersPrams = new Object[][]{};
        costParams.add(cost.getCost_user());
        costParams.add(cost.getCost_tell());
        costParams.add(cost.getAuth_books_cost());
        costParams.add(cost.getAuth_books_num());
        costParams.add(cost.getAuth_books_fees());
        costParams.add(cost.getAuth_place_cost());
        costParams.add(cost.getAuth_place_num());
        costParams.add(cost.getAuth_place_fees());
        costParams.add(cost.getAuth_hotel_cost());
        costParams.add(cost.getAtuh_hotel_num());
        costParams.add(cost.getAuth_hotel_fees());
        costParams.add(cost.getAuth_meals_cost());
        costParams.add(cost.getAuth_meals_num());
        costParams.add(cost.getAuth_meals_fees());
        costParams.add(cost.getAuth_info_cost());
        costParams.add(cost.getAuth_info_num());
        costParams.add(cost.getAuth_info_fees());
        costParams.add(cost.getAuth_traffic_cost());
        costParams.add(cost.getAuth_traffic_num());
        costParams.add(cost.getAuth_traffic_fees());
        costParams.add(cost.getIs_year_plan());
        costParams.add(cost.getTotal_cost());
        costParams.add(cost.getPlan_type_fee());
        costParams.add(cost.getPlan_post_type());
        costParams.add(cost.getCost_days());
        costParams.add(cost.getCost_status());
        costParams.add(cost.getCost_status_cmt());
        costParams.add(cost.getCost_id());
        //教师讲课费
        if (cost.getTeachfees().size() > 0) {
            teachePrams = new Object[cost.getTeachfees().size()][7];
            List<EduTeachFees> teaches = cost.getTeachfees();
            int i = 0;
            for (EduTeachFees item : teaches) {
                teachePrams[i][0] = UUID.randomUUID().toString();
                teachePrams[i][1] = cost.getCost_id();
                teachePrams[i][2] = item.getTeach_cmt();
                teachePrams[i][3] = item.getAuth_teach_fee();
                teachePrams[i][4] = item.getAuth_teach_num();
                teachePrams[i][5] = item.getAuth_teach_fees();
                teachePrams[i][6] = 0;
                i++;
            }
        }
        //其他费用
        if (cost.getOtherfees().size() > 0) {
            othersPrams = new Object[cost.getOtherfees().size()][4];
            int j = 0;
            List<EduOtherFees> others = cost.getOtherfees();
            for (EduOtherFees item : others) {
                othersPrams[j][0] = UUID.randomUUID().toString();
                othersPrams[j][1] = cost.getCost_id();
                othersPrams[j][2] = item.getOther_cmt();
                othersPrams[j][3] = item.getOther_cost();
            }
        }
        try {
            conn.setAutoCommit(false);
            EduPlanTransfer transfer = new EduPlanTransfer();
            transfer.setTransfer_code(review.getTransfer_code());
            transfer.setTrans_status_cmt(review.getReview_cmt());
            transfer.setTrans_status(review.getReview_status());
            transfer.setTransfer_url(review.getReview_url());
            EduPlans plan = new EduPlans();
            plan.setPlan_code(review.getPlan_code());
            plan.setPlan_status_cmt("由" + review.getReviewer() + review.getPlan_status_cmt() + "完成");
            plan.setPlan_status(-1);
            Boolean result = updaePlanStatus(plan) && updaeTransferStatus(transfer) && reviewDao.addReview(review);
            //修改经费信息
            if (!result) {
                throw new SQLException("审核失败！");
            }
            db.update(upCostSql, costParams.toArray());
            db.update(delTeach, cost.getCost_id());
            db.update(delOther, cost.getCost_id());
            db.insertBatch(teachesIns, teachePrams);
            db.insertBatch(othersIns, othersPrams);
            conn.commit();
            conn.setAutoCommit(true);
            return result;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public List<EduPlanCost> getFinancesByPlan(String plan_code, String cost_satus) throws SQLException {
        String querySql = "select * from edu_plan_costs where plan_code=? and (cost_status=? ";
        querySql += " or cost_status=" + EduReviewSimpleStatus.财务待审.getStats() + ")";
        return db.queryBeanList(EduPlanCost.class, querySql, plan_code, cost_satus);
    }

    @Override
    public List<EduPlanCost> getHasFlag(String plan_code) throws SQLException {
        String querySql = "select (CASE when   COUNT(1) is NULL then 0 else COUNT(1)  END)as cost_persons from EDU_PLANS E\n"
                + "join EDU_PLANS_TRANSFER H on E.PLAN_CODE=H.PLAN_CODE\n"
                + "WHERE \n"
                + " H.TRANS_STATUS=4\n"
                + "and H.TRANSFER_TO_UID='19B8C3534DE35665E0539106C00A58FD'\n"
                + "and H.PLAN_CODE=? "
                + "UNION\n"
                + "select (CASE when   COUNT(1) is NULL then 0 else COUNT(1)  END)as cost_persons from EDU_PLANS E\n"
                + "join EDU_PLANS_TRANSFER H on E.PLAN_CODE=H.PLAN_CODE\n"
                + "WHERE \n"
                + " H.TRANS_STATUS=4\n"
                + "and H.TRANSFER_TO_UID='19B8C3534E3E5665E0539106C00A58FD'\n"
                + "and H.PLAN_CODE=?";
        return db.queryBeanList(EduPlanCost.class, querySql, plan_code, plan_code);
    }

    @Override
    public EduPlanCost getPlanCost(String plan_code) throws SQLException {
        String querySql = "select * from edu_plan_costs where cost_id=?";
        return db.queryBean(EduPlanCost.class, querySql, plan_code);
    }

    @Override
    public List<EduSocTraintype> getSocTypes(Object... parmas) throws SQLException {
        String querySql = "select * from edu_social_traintype where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //类型编码
                    whereSql += " and social_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //类型名称
                    whereSql += " and social_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduSocTraintype.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduSocialMainunit> getSocMainunits(Object... parmas) throws SQLException {
        String querySql = "select unit_code,unit_code as u_id,unit_name,unit_name as name from edu_social_mainunit where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //编码
                    whereSql += " and unit_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //单位名称
                    whereSql += " and unit_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduSocialMainunit.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduSocialExecunit> getSocExecunits(Object... parmas) throws SQLException {
        String querySql = "select exec_code,exec_code as u_id,exec_unit_name,exec_unit_name as name from edu_social_execunit where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //编码
                    whereSql += " and exec_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //单位名称
                    whereSql += " and exec_unit_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduSocialExecunit.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduHighspeedFlag> getSocHighFlages(Object... parmas) throws SQLException {
        String querySql = "select * from edu_highspeed_flag where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //类型编码
                    whereSql += " and speed_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //类型名称
                    whereSql += " and speed_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduHighspeedFlag.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduAbroadType> getAbroadTypes(Object... parmas) throws SQLException {
        String querySql = "select * from edu_abroad_type where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //类型编码
                    whereSql += " and abroad_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //类型名称
                    whereSql += " and abroad_type=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduAbroadType.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduStationTraintype> getAStatinTtypes(Object... parmas) throws SQLException {
        String querySql = "select * from edu_station_traintype where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //编码
                    whereSql += " and station_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //单位名称
                    whereSql += " and station_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduStationTraintype.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduStationChannel> getStationChannels(Object... parmas) throws SQLException {
        String querySql = "select * from edu_station_channel where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //编码
                    whereSql += " and channel_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //单位名称
                    whereSql += " and channel_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduStationChannel.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduStationtPersons> getStationPersons(Object... parmas) throws SQLException {
        String querySql = "select * from edu_station_tpersons where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //编码
                    whereSql += " and person_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //单位名称
                    whereSql += " and person_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduStationtPersons.class, querySql + whereSql, paramsArray.toArray());
    }

    @Override
    public List<EduTeachesType> getStationTeaches(Object... parmas) throws SQLException {
        String querySql = "select * from edu_teaches_type where 1=1 ";
        String whereSql = "";
        List<Object> paramsArray = new ArrayList<Object>();
        if (parmas != null) {
            if (parmas.length > 0) {
                if (StringUtils.isBlank(parmas[0].toString())) {
                    //编码
                    whereSql += " and teach_code=? ";
                    paramsArray.add(parmas[0]);
                }
                if (StringUtils.isBlank(parmas[1].toString())) {
                    //单位名称
                    whereSql += " and teach_name=? ";
                    paramsArray.add(parmas[1]);
                }
            }
        }
        return db.queryBeanList(EduTeachesType.class, querySql + whereSql, paramsArray.toArray());
    }

    //移送单位审核通过批量
    @Override
    public Boolean authPlans(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException {
        String planSql = "update edu_plans set plan_status_cmt=? where plan_code=?";
        String transSql = "update edu_plans_transfer set TRANS_STATUS=?,TRANS_STATUS_CMT=?,TRANSFER_URL=? where transfer_code=?";
        String reviewSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,idcard,current_unit,current_unitid,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String costSql = "update EDU_PLAN_COSTS set cost_status=?,cost_status_cmt=? where cost_id=?";
        Object[][] reviewArray = new Object[][]{};
        Object[][] transArray = new Object[][]{};
        Object[][] planArray = new Object[][]{};
        Object[][] costArray = new Object[][]{};
        int count = plans.size();
        if (count > 0) {
            reviewArray = new Object[count][12];
            transArray = new Object[count][4];
            planArray = new Object[count][2];
        }
        int j = 0;
        for (int i = 0; i < count; i++) {
            reviewArray[i][0] = UUID.randomUUID().toString();
            reviewArray[i][1] = plans.get(i).getPlan_code();
            reviewArray[i][2] = review.getReviewer();
            reviewArray[i][3] = review.getReview_status();
            reviewArray[i][4] = review.getReview_cmt();
            reviewArray[i][5] = review.getReview_url();
            reviewArray[i][6] = "由" + review.getReviewer() + review.getPlan_status_cmt() + "完成";
            reviewArray[i][7] = review.getIdcard();
            reviewArray[i][8] = review.getCurrent_unit();
            reviewArray[i][9] = review.getCurrent_unitid();
            reviewArray[i][10] = plans.get(i).getTransfer_code();
            reviewArray[i][11] = DateUtil.FormatDate(review.getReview_date());
            transArray[i][3] = plans.get(i).getTransfer_code();
            transArray[i][1] = "由" + review.getReviewer() + review.getPlan_status_cmt() + "完成";
            transArray[i][0] = review.getReview_status();
            transArray[i][2] = review.getReview_url();
            planArray[i][0] = "由" + review.getReviewer() + review.getPlan_status_cmt() + "完成";
            planArray[i][1] = plans.get(i).getPlan_code();
        }
        if (costlist.size() > 0) {
            costArray = new Object[costlist.size()][3];
            int k = 0;
            for (EduPlanCost item : costlist) {
                costArray[k][0] = item.getCost_status();
                costArray[k][1] = item.getCost_status_cmt();
                costArray[k][2] = item.getCost_id();
                k++;
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            int[] pcount = db.batch(planSql, planArray);
            int[] tcount = db.batch(transSql, transArray);
            db.insertBatch(reviewSql, reviewArray);
            int[] ccount = db.batch(costSql, costArray);
            if (!(pcount.length == planArray.length && tcount.length == transArray.length && ccount.length == costlist.size())) {
                throw new SQLException("操作失败");
            }
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean backTops(List<EduPlansTransDto> plans, EduReviews review, List<EduPlanCost> costlist) throws SQLException {
        String planSql = "update edu_plans set plan_status_cmt=?,plan_status=? where plan_code=?";
        String transSql = "update edu_plans_transfer set TRANS_STATUS=?,TRANS_STATUS_CMT=?,TRANSFER_URL=? where transfer_code=?";
        String reviewSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,idcard,current_unit,current_unitid,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String costSql = "update EDU_PLAN_COSTS set cost_status=?,cost_status_cmt=? where cost_id=?";
        Object[][] reviewArray = new Object[][]{};
        Object[][] transArray = new Object[][]{};
        Object[][] planArray = new Object[][]{};
        Object[][] costArray = new Object[][]{};
        int count = plans.size();
        if (count > 0) {
            reviewArray = new Object[count][12];
            transArray = new Object[count][4];
            planArray = new Object[count][3];
        }
        int j = 0;
        for (int i = 0; i < count; i++) {
            reviewArray[i][0] = UUID.randomUUID().toString();
            reviewArray[i][1] = plans.get(i).getPlan_code();
            reviewArray[i][2] = review.getReviewer();
            reviewArray[i][3] = review.getReview_status();
            reviewArray[i][4] = review.getReview_cmt();
            reviewArray[i][5] = review.getReview_url();
            reviewArray[i][6] = review.getPlan_status_cmt();
            reviewArray[i][7] = review.getIdcard();
            reviewArray[i][8] = review.getCurrent_unit();
            reviewArray[i][9] = review.getCurrent_unitid();
            reviewArray[i][10] = plans.get(i).getTransfer_code();
            reviewArray[i][11] = DateUtil.FormatDate(review.getReview_date());
            transArray[i][3] = plans.get(i).getTransfer_code();
            transArray[i][1] = review.getReview_cmt();
            transArray[i][0] = review.getReview_status();
            transArray[i][2] = review.getReview_url();
            planArray[i][0] = "由" + review.getReviewer() + review.getPlan_status_cmt();
            planArray[i][1] = review.getReview_status();
            planArray[i][2] = plans.get(i).getPlan_code();
        }
        if (costlist.size() > 0) {
            costArray = new Object[costlist.size()][3];
            int k = 0;
            for (EduPlanCost item : costlist) {
                costArray[k][0] = item.getCost_status();
                costArray[k][1] = item.getCost_status_cmt();
                costArray[k][2] = item.getCost_id();
                k++;
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            int[] pcount = db.batch(planSql, planArray);
            int[] tcount = db.batch(transSql, transArray);
            db.insertBatch(reviewSql, reviewArray);
            int[] ccount = db.batch(costSql, costArray);
            if (!(pcount.length == count && tcount.length == count && ccount.length == costlist.size())) {
                throw new SQLException("操作失败");
            }
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean bactUsers(List<EduPlansTransDto> plans, List<EduReviews> reviews, List<EduPlanTransfer> transfers) throws SQLException {
        String updateSql = "update edu_plans set plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit,cost_id) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?,?) ";
        String updateTrans = "update edu_plans_transfer set trans_status_cmt=?,trans_status=? where transfer_code=?";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        Object[][] upArray = new Object[][]{};
        Object[][] oArray = new Object[][]{};
        String companys = "";
        if (plans.size() > 0) {
            int k = 0;
            upArray = new Object[plans.size()][2];
            for (EduPlans plan : plans) {
                upArray[k][0] = plan.getPlan_status_cmt();
                upArray[k][1] = plan.getPlan_code();

                k++;
            }
        } else {
            throw new SQLException("计划不能为空");
        }
        if (transfers.size() > 0) {
            params2 = new Object[transfers.size()][13];
            oArray = new Object[transfers.size()][3];
            int i = 0;
            for (EduPlanTransfer transfer : transfers) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = transfer.getPlan_code();
                params2[i][2] = transfer.getTransfer_from_user();
                params2[i][3] = transfer.getTransfer_from_idcard();
                params2[i][4] = transfer.getTransfer_to_user();
                params2[i][5] = transfer.getTransfer_to_idcard();
                params2[i][6] = transfer.getTransfer_to_unit();
                params2[i][7] = transfer.getTransfer_to_uid();
                params2[i][8] = transfer.getTrans_status();
                params2[i][9] = transfer.getTransfer_from_user() + "移送至" + transfer.getTransfer_to_user() + transfer.getTrans_status_cmt();
                params2[i][10] = transfer.getTransfer_from_unitid();
                params2[i][11] = transfer.getTransfer_from_unit();
                params2[i][12] = transfer.getCost_id();
                oArray[i][0] = transfer.getTransfer_from_user() + "经办完成";
                oArray[i][1] = EduReviewSimpleStatus.经办.getStats();
                oArray[i][2] = transfer.getTransfer_code();
                i++;
            }
        }
        if (reviews.size() > 0) {
            params = new Object[reviews.size()][12];
            int j = 0;
            for (EduReviews review : reviews) {
                params = new Object[1][12];
                params[j][0] = UUID.randomUUID().toString();
                params[j][1] = review.getPlan_code();
                params[j][2] = review.getReviewer();
                params[j][3] = review.getReview_status();
                params[j][4] = review.getReview_cmt();
                params[j][5] = review.getReview_url();
                params[j][6] = "由" + review.getCurrent_unit() + review.getReviewer() + "回发" + transfers.get(j).getTransfer_to_unit() + "待办";
                params[j][7] = review.getCurrent_unit();
                params[j][8] = review.getCurrent_unitid();
                params[j][9] = review.getIdcard();
                params[j][10] = params2[j][0];
                params[j][11] = DateUtil.FormatDate(review.getReview_date());
                j++;
            }
        }

        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            int[] ucount = db.batch(updateSql, upArray);
            int[] ocount = db.batch(updateTrans, oArray);
            // db.update(updateSql, "由" + review.getCurrent_unit() + review.getReviewer() + "回发" + companys + "待办", review.getPlan_code());
            ///  db.update(updateTrans, "由" + review.getCurrent_unit() + review.getReviewer() + review.getPlan_status_cmt(), review.getReview_status(), review.getTransfer_code());
            int[] tcount = db.batch(transSql, params2);
            int[] iount = db.insertBatch(insSql, params);
            if (ucount.length != upArray.length || ocount.length != oArray.length || tcount.length != params2.length || iount.length != params.length) {
                throw new SQLException("回发失败!");
            }
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean throwPlans(List<EduReviews> plans) throws SQLException {
        String insSql = "insert into edu_plans_reviews(review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,review_date)  values\n"
                + "  ('" + UUID.randomUUID() + "', ?, ?, ?, ?, ?, ?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String updateSql = "update edu_plans set plan_status=?,plan_status_cmt=? where plan_code=? ";
        Object[][] insArray = new Object[][]{};
        Object[][] upArray = new Object[][]{};
        if (plans.size() > 0) {
            insArray = new Object[plans.size()][8];
            upArray = new Object[plans.size()][3];
        }
        int i = 0;
        for (EduReviews plan : plans) {
            insArray[i][0] = UUID.randomUUID();
            insArray[i][1] = plan.getPlan_code();
            insArray[i][2] = plan.getReviewer();
            insArray[i][3] = plan.getReview_status();
            insArray[i][4] = plan.getReview_cmt();
            insArray[i][5] = plan.getReview_url();
            insArray[i][6] = plan.getPlan_status_cmt();
            insArray[i][7] = DateUtil.FormatDate(plan.getReview_date());
            upArray[i][0] = plan.getReview_status();
            upArray[i][1] = plan.getPlan_status_cmt();
            upArray[i][2] = plan.getPlan_code();
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            //  db.update(updateSql, plan.getReview_status(), plan.getPlan_status_cmt(), plan.getPlan_code());
            // db.insert(insSql, plan.getPlan_code(), plan.getReviewer(), plan.getReview_status(), plan.getReview_cmt(), plan.getReview_url(), plan.getPlan_status_cmt(), DateUtil.FormatDate(plan.getReview_date()));
            db.batch(updateSql, upArray);
            db.insertBatch(insSql, insArray);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    //单位内移交，包含财务移交批量
    @Override
    public Boolean unitsTransBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException {
        String updateSql = "update edu_plans set plan_status_cmt=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit,cost_id) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?,?) ";
        String updateTrans = "update edu_plans_transfer set trans_status_cmt=?,trans_status=? where transfer_code=?";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        Object[][] upArray = new Object[][]{};
        Object[][] tArray = new Object[][]{};
        String companys = "";
        if (transfers.size() > 0) {
            params2 = new Object[transfers.size()][13];
            for (int i = 0; i < transfers.size(); i++) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = review.get(0).getPlan_code();
                params2[i][2] = transfers.get(i).getTransfer_from_user();
                params2[i][3] = transfers.get(i).getTransfer_from_idcard();
                params2[i][4] = transfers.get(i).getTransfer_to_user();
                params2[i][5] = transfers.get(i).getTransfer_to_idcard();
                params2[i][6] = transfers.get(i).getTransfer_to_unit();
                params2[i][7] = transfers.get(i).getTransfer_to_uid();
                params2[i][8] = transfers.get(i).getTrans_status();
                params2[i][9] = transfers.get(i).getTransfer_from_user() + "移送至" + transfers.get(i).getTransfer_to_user() + transfers.get(i).getTrans_status_cmt();
                companys += transfers.get(i).getTransfer_to_unit() + "(" + transfers.get(i).getTransfer_to_user() + ")" + "|";
                params2[i][10] = transfers.get(i).getTransfer_from_unitid();
                params2[i][11] = transfers.get(i).getTransfer_from_unit();
                params2[i][12] = transfers.get(i).getCost_id();

            }
        }
        if (review.size() > 0) {
            params = new Object[review.size()][12];
            upArray = new Object[review.size()][2];
            tArray = new Object[review.size()][3];
            for (int i = 0; i < review.size(); i++) {
                params[i][0] = UUID.randomUUID().toString();
                params[i][1] = review.get(i).getPlan_code();
                params[i][2] = review.get(i).getReviewer();
                params[i][3] = review.get(i).getReview_status();
                params[i][4] = review.get(i).getReview_cmt();
                params[i][5] = review.get(i).getReview_url();
                params[i][6] = "由" + review.get(i).getCurrent_unit() + review.get(i).getReviewer() + "移交" + companys + "待办";
                params[i][7] = review.get(i).getCurrent_unit();
                params[i][8] = review.get(i).getCurrent_unitid();
                params[i][9] = review.get(i).getIdcard();
                params[i][10] = params2[i][0];
                params[i][11] = DateUtil.FormatDate(review.get(i).getReview_date());
                upArray[i][0] = "由" + review.get(i).getCurrent_unit() + review.get(i).getReviewer() + "移交" + companys + "待办";
                upArray[i][1] = review.get(i).getPlan_code();
                tArray[i][0] = "由" + review.get(i).getCurrent_unit() + review.get(i).getReviewer() + "移交" + companys + "待办";
                tArray[i][1] = review.get(i).getReview_status();
                tArray[i][2] = review.get(i).getTransfer_code();
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.batch(updateSql, upArray);
            db.batch(updateTrans, tArray);
            db.batch(transSql, params2);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean overPlans(List<EduReviews> review) throws SQLException {
        String insSql = "insert into edu_plans_reviews(review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String updateSql = "update edu_plans set plan_status=?,plan_status_cmt=? where plan_code=? ";
        Object[][] upArray = new Object[][]{};
        Object[][] insArray = new Object[][]{};
        if (review.size() > 0) {
            upArray = new Object[review.size()][8];
            insArray = new Object[review.size()][3];
        }
        int i = 0;
        for (EduReviews plan : review) {
            insArray[i][0] = UUID.randomUUID().toString();
            insArray[i][1] = plan.getPlan_code();
            insArray[i][2] = plan.getReviewer();
            insArray[i][3] = plan.getReview_status();
            insArray[i][4] = plan.getReview_cmt();
            insArray[i][5] = plan.getReview_url();
            insArray[i][6] = plan.getPlan_status_cmt();
            insArray[i][7] = DateUtil.FormatDate(plan.getReview_date());
            upArray[i][0] = plan.getReview_status();
            upArray[i][1] = plan.getPlan_status_cmt();
            upArray[i][2] = plan.getPlan_code();
            i++;
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.batch(updateSql, upArray);
            db.insertBatch(insSql, insArray);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public Boolean hasPlanLoadings(String plancode) throws SQLException {
        String querySql1 = "SELECT COUNT(1) from EDU_PLANS_TRANSFER where TRANS_STATUS=" + EduReviewSimpleStatus.待办.getStats() + " and plan_code in('" + plancode + "')";
        BigDecimal countAll = db.queryScalar(1, querySql1);
        return Integer.parseInt(countAll.toString()) > 0;
    }

    @Override
    public List<EduPlanCost> getHasFlags(String plancode, String csid, String recid) throws SQLException {
        String querySql = "select (CASE when   COUNT(1) is NULL then 0 else COUNT(1)  END)as cost_persons from EDU_PLANS E\n"
                + "join EDU_PLANS_TRANSFER H on E.PLAN_CODE=H.PLAN_CODE\n"
                + "WHERE \n"
                + " H.TRANS_STATUS=4\n"
                + "and H.TRANSFER_TO_UID='" + recid + "'\n"
                + "and H.PLAN_CODE in (" + plancode + ") "
                + "UNION\n"
                + "select (CASE when   COUNT(1) is NULL then 0 else COUNT(1)  END)as cost_persons from EDU_PLANS E\n"
                + "join EDU_PLANS_TRANSFER H on E.PLAN_CODE=H.PLAN_CODE\n"
                + "WHERE \n"
                + " H.TRANS_STATUS=4\n"
                + "and H.TRANSFER_TO_UID='" + csid + "'\n"
                + "and H.PLAN_CODE in (" + plancode + ") ";
        return db.queryBeanList(EduPlanCost.class, querySql);
    }

    @Override
    public Boolean transfersBatch(List<EduReviews> review, List<EduPlanTransfer> transfers) throws SQLException {
        String updateSql = "update edu_plans set plan_status_cmt=?,plan_status=? where plan_code=? ";
        String insSql = "insert into edu_plans_reviews  (review_dcode, plan_code, reviewer, review_status, review_cmt, review_url, plan_status_cmt,current_unit,current_unitid,idcard,transfer_code,review_date)  values\n"
                + "  (?, ?, ?, ?, ?, ?, ?,?,?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'))";
        String transSql = "INSERT INTO edu_plans_transfer(transfer_code ,plan_code ,transfer_from_user,transfer_from_idcard ,transfer_to_user ,transfer_to_idcard ,transfer_to_unit,transfer_to_uid,trans_status,trans_status_cmt,transfer_from_unitid,transfer_from_unit,cost_id) VALUES(? ,? ,? ,?  ,?  ,?  ,? ,? ,?,?,?,?,?) ";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        Object[][] upArray = new Object[][]{};
        String companys = "";
        if (transfers.size() > 0) {
            params2 = new Object[transfers.size()][13];
            for (int i = 0; i < transfers.size(); i++) {
                params2[i][0] = UUID.randomUUID().toString();
                params2[i][1] = review.get(i).getPlan_code();
                params2[i][2] = transfers.get(i).getTransfer_from_user();
                params2[i][3] = transfers.get(i).getTransfer_from_idcard();
                params2[i][4] = transfers.get(i).getTransfer_to_user();
                params2[i][5] = transfers.get(i).getTransfer_to_idcard();
                params2[i][6] = transfers.get(i).getTransfer_to_unit();
                params2[i][7] = transfers.get(i).getTransfer_to_uid();
                params2[i][8] = transfers.get(i).getTrans_status();
                params2[i][9] = transfers.get(i).getTransfer_from_user() + "移送至" + transfers.get(i).getTransfer_to_user() + transfers.get(i).getTrans_status_cmt();
                companys += transfers.get(i).getTransfer_to_unit() + "(" + transfers.get(i).getTransfer_to_user() + ")" + "|";
                params2[i][10] = transfers.get(i).getTransfer_from_unitid();
                params2[i][11] = transfers.get(i).getTransfer_from_unit();
                params2[i][12] = transfers.get(i).getCost_id();

            }
        }
        if (review.size() > 0) {
            params = new Object[review.size()][12];
            upArray = new Object[review.size()][3];
            for (int i = 0; i < review.size(); i++) {
                params[i][0] = UUID.randomUUID().toString();
                params[i][1] = review.get(i).getPlan_code();
                params[i][2] = review.get(i).getReviewer();
                params[i][3] = review.get(i).getReview_status();
                params[i][4] = review.get(i).getReview_cmt();
                params[i][5] = review.get(i).getReview_url();
                params[i][6] = "由" + review.get(i).getCurrent_unit() + review.get(i).getReviewer() + "移交" + companys + "待办";
                params[i][7] = review.get(i).getCurrent_unit();
                params[i][8] = review.get(i).getCurrent_unitid();
                params[i][9] = review.get(i).getIdcard();
                params[i][10] = params2[i][0];
                params[i][11] = DateUtil.FormatDate(review.get(i).getReview_date());
                ///  params[i][11] = review.get(i).getReview_date();
                //   params[i][12]=review.get(i).getCost_id();
                upArray[i][0] = "由" + review.get(0).getCurrent_unit() + review.get(0).getReviewer() + "移交" + companys + "待办";
                upArray[i][1] = review.get(i).getPlan_status();
                upArray[i][2] = review.get(i).getPlan_code();
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.batch(updateSql, upArray);
            db.batch(transSql, params2);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public List<EduPlanTransfer> getTransfers(String tids) throws SQLException {
        String querySql = "select * from EDU_PLANS_TRANSFER where 1=1 ";
        if (!StringUtils.isBlank(tids)) {
            querySql += " and TRANSFER_CODE in(" + tids + ")";
        }
        return db.queryBeanList(EduPlanTransfer.class, querySql);
    }

    @Override
    public BigDecimal getPlanTotals(String tids) throws SQLException {
        String querySql = "select (case when sum(total_cost) is null then 0 else sum(total_cost) end) as total_cost from edu_plan_costs  where plan_code=?";
        return db.queryScalar(1, querySql, tids);
    }

    @Override
    public Map<Integer, List<EduPlansTransDto>> getOverOwnPlans(EduPlanSearch pageModel) throws Throwable {
        List<Object> list = new ArrayList<Object>();
        String whereSql = " 1=1 ";
        String querySql1 = "";
        if (pageModel.getIsAuth() == 1) {
            //待办    
            //0：只包含自建立计划，1 ：自建计划+移送计划，2：只包含移送计划
            if (pageModel.getIf_union() == 0 || pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " SELECT t.cost_id,t.TRANSFER_CODE,e.* from edu_plans e left join (select TRANSFER_CODE,PLAN_CODE,COST_ID from EDU_PLANS_TRANSFER where " + " TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and TRANS_STATUS=" + pageModel.getTrans_status() + " ) t on t.PLAN_CODE=e.PLAN_CODE where 1=1 ";
                if (pageModel.getTo_unit() != null) {
                    querySql1 += pageModel.getTo_unit().length() > 0 ? "  and (( E .PLAN_UNIT =?  " : "";
                    list.add(pageModel.getTo_unit());
                    if (pageModel.getAdduser() != null) {
                        querySql1 += pageModel.getAdduser().length() > 0 ? " and e.add_user=?)  OR(E.ADD_USER=? " : "";

                        list.add(pageModel.getAdduser());
                        list.add(pageModel.getAdduser());

                    }
                    querySql1 += " )) ";

                }
                querySql1 += " and e.PLAN_STATUS!=" + EduReviewSimpleStatus.处室经办.getStats() + " AND e.PLAN_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats() + " ";
                querySql1 += " and e.plan_status in (" + EduReviewSimpleStatus.getOfficesAuth() + ")";
            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " union ";

            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 2 || pageModel.getIf_union() == 3) {
                querySql1 += " SELECT T1.cost_id,T1.TRANSFER_CODE,E1.* from EDU_PLANS_TRANSFER t1 join edu_plans e1 on t1.plan_code=e1.plan_code   where 1=1 ";
                querySql1 += " and T1.TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND T1.TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and T1.TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and T1.TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and T1.TRANS_STATUS=" + pageModel.getTrans_status() + " ";
                querySql1 += " and e1.PLAN_STATUS!=" + EduReviewSimpleStatus.处室经办.getStats() + " AND e1.PLAN_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats() + " ";
            }
        } else if (pageModel.getIsAuth() == 2) {
            //经办      
            if (pageModel.getIf_union() == 0 || pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " SELECT e.* from EDU_PLANS e left join (select TRANSFER_CODE,PLAN_CODE,COST_ID from EDU_PLANS_TRANSFER where " + " TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and TRANS_STATUS=" + pageModel.getTrans_status() + ") t on t.PLAN_CODE=e.PLAN_CODE where 1=1 ";
                if (pageModel.getTo_unit() != null) {
                    querySql1 += pageModel.getTo_unit().length() > 0 ? "  and (( E .PLAN_UNIT =?  " : "";
                    list.add(pageModel.getTo_unit());
                    if (pageModel.getAdduser() != null) {
                        querySql1 += pageModel.getAdduser().length() > 0 ? " and e.add_user=?)  OR(E.ADD_USER=?  " : "";

                        list.add(pageModel.getAdduser());
                        list.add(pageModel.getAdduser());

                    }
                    querySql1 += " )) ";

                }
                querySql1 += " and e.plan_status  not in (" + EduReviewSimpleStatus.getOfficesAuth() + ")";
            }

//            if (pageModel.getAdduser() != null) {
//                querySql1 += pageModel.getAdduser().length() > 0 ? " and e.add_user=?  " : "";
//                list.add(pageModel.getAdduser());
//            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 3) {
                querySql1 += " union ";
            }
            if (pageModel.getIf_union() == 1 || pageModel.getIf_union() == 2 || pageModel.getIf_union() == 3) {
                //包含移送计划
                //querySql1 += " union ";
                querySql1 += " SELECT E1.* from EDU_PLANS_TRANSFER t1 ";
                //  querySql1+=" left join (SELECT DISTINCT PLAN_CODE from EDU_PLANS_TRANSFER where TRANS_STATUS="+EduReviewSimpleStatus.待办.getStats()+" and TRANSFER_TO_UNIT ='"+pageModel.getTo_unit()+"' AND TRANSFER_TO_UID = '"+pageModel.getTo_uid()+"' AND TRANSFER_TO_USER = '"+pageModel.getTo_user()+"' AND TRANSFER_TO_IDCARD = '"+pageModel.getTo_idcard()+"') t2 on t2.PLAN_CODE!=t1.PLAN_CODE";
                querySql1 += " join EDU_PLANS e1 on t1.plan_code=e1.plan_code   where 1=1 ";
                querySql1 += " and T1.TRANSFER_TO_UNIT='" + pageModel.getTo_unit() + "' AND T1.TRANSFER_TO_UID='" + pageModel.getTo_uid() + "'  and T1.TRANSFER_TO_USER='" + pageModel.getTo_user() + "' and T1.TRANSFER_TO_IDCARD ='" + pageModel.getTo_idcard() + "' and T1.TRANS_STATUS!=" + pageModel.getTrans_status() + " ";
                querySql1 += " AND e1.PLAN_STATUS!=" + EduReviewSimpleStatus.处室废弃.getStats() + " ";
            }
        }
        //指定处室
        if (pageModel.getPlan_mainid() != null) {
            if (pageModel.getPlan_mainid().length() > 0) {
                //主办单位
                whereSql += "  and plan_unit=? ";
                list.add(pageModel.getPlan_mainid());
            }
        }
        if (pageModel.getPlan_execid() != null) {
            //主办单位+移送过来
            if (pageModel.getPlan_execid().length() > 0) {
                whereSql += " and plan_executeunit=? ";
                list.add(pageModel.getPlan_execid());
            }
        }
        if (pageModel.getSreviewstatus() != null) {
            //承办单位
            if (pageModel.getSreviewstatus().length() > 0) {
                whereSql += " and plan_status=?";
                list.add(pageModel.getSreviewstatus());
            }
        }
        if (pageModel.getPlanname() != null) {
            if (pageModel.getPlanname().length() > 0) {
                //计划名称
                whereSql += " and plan_name like '%" + pageModel.getPlanname() + "%'";
            }
        }
        if (pageModel.getFilterRules() != null) {
            whereSql += "  " + pageModel.getFilterRules();
        }
        pageModel.setFilterRules(whereSql);
        pageModel.setSelects(querySql1);
        if (pageModel.getParams() != null) {
            list.addAll(pageModel.getParams());
        }
        pageModel.setParams(list);
        return baseDao.getPageComs(pageModel, EduPlansTransDto.class);
    }
}
