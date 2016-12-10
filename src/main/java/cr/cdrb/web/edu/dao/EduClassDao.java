/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IEduClassDao;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.ClassCostsSearch;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduNewPost;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.educlass.EduTrainingCategory;
import cr.cdrb.web.edu.domains.educlass.PlanClassCostDto;
import cr.cdrb.web.edu.domains.educlass.UnitsPersons;
import cr.cdrb.web.edu.services.UsersService;
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
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 */
@Repository
public class EduClassDao implements IEduClassDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    //新增班级信息
    @Override
    public Boolean addClass(EduClass educlass) throws SQLException {
        String insStr = "insert into edu_class\n"
                + "  (n_id, unit, classno, classname, telldate,startdate, enddate, plandate, signenddate, studentscope, classform, classlevel, prof, classtype, crh, planunit, execunit, departman, projman, refdoc,  classplace, studentnum, newpost, studentdays, classhours, book1, bookfrom1, book2, bookfrom2, book3, bookfrom3, book4, bookfrom4, projreport, archivedate, projplan, selfteach, unitid, planunitid, execunitid, departmanid, projmanid, refdocurl,plan_code,record_url,plan_books,cost_id,add_user,add_user_name,class_status,class_status_cmt)\n"
                + "values\n"
                + "  (?, ?, ?,?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), to_date(?,'yyyy-mm-dd hh24:mi:ss'), to_date(?,'yyyy-mm-dd hh24:mi:ss'), to_date(?,'yyyy-mm-dd hh24:mi:ss'), to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?)";
        String key = UUID.randomUUID().toString();
        List<UnitsPersons> plist = educlass.getUnitpers();
        Object[][] params = new Object[][]{};
        String pSql = "insert into edu_unit_persons(unit_perid,unit_id,unit_name,unit_num,cost_id,class_id) values(?,?,?,?,?,?)";
        String cSql = "update edu_plan_costs set cost_status=?,cost_status_cmt=? where cost_id=? ";
        int i = 0;
        if (plist != null) {
            if (plist.size() > 0) {
                params = new Object[plist.size()][6];
                for (UnitsPersons item : plist) {
                    params[i][0] = UUID.randomUUID().toString();
                    params[i][1] = item.getUnit_id();
                    params[i][2] = item.getUnit_name();
                    params[i][3] = item.getUnit_num();
                    params[i][4] = item.getCost_id();
                    params[i][5] = key;
                    i++;
                }
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.insert(insStr, key, educlass.getUnit(), educlass.getClassno(), educlass.getClassname(), educlass.getTelldate(), educlass.getStartdate(), educlass.getEnddate(), educlass.getPlandate() == null ? educlass.getPlandate() : educlass.getPlandate(), educlass.getSignenddate(),
                    educlass.getStudentscope(), educlass.getClassform(), educlass.getClasslevel(), educlass.getProf(), educlass.getClasstype(), educlass.getCrh(), educlass.getPlanunit(), educlass.getExecunit(), educlass.getDepartman(), educlass.getProjman(), educlass.getRefdoc(), educlass.getClassplace(), educlass.getStudentnum(), educlass.getNewpost(), educlass.getStudentdays(), educlass.getClasshours(), educlass.getBook1(), educlass.getBookfrom1(), educlass.getBook2(), educlass.getBookfrom2(), educlass.getBook3(), educlass.getBookfrom3(), educlass.getBook4(), educlass.getBookfrom4(), educlass.getProjreport(), educlass.getArchivedate(), educlass.getProjplan(), educlass.getSelfteach(), educlass.getUnitid(), educlass.getPlanunitid(), educlass.getExecunitid(), educlass.getDepartmanid(), educlass.getProjmanid(), educlass.getRefdocurl(), educlass.getPlan_code(), educlass.getRecord_url(), educlass.getPlan_books(), educlass.getCost_id(), educlass.getAdd_user(), educlass.getAdd_user_name(), educlass.getClass_status(), educlass.getClass_status_cmt());
            db.update(cSql, educlass.getClass_status(), educlass.getClass_status_cmt(), educlass.getCost_id());
            db.batch(pSql, params);
            //建班结束修改资费状态
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
//更新班级信息

    @Override
    public Boolean updateClass(EduClass educlass) throws SQLException {
        String updateSql = "UPDATE edu_class SET unit = ?,classno = ?,classname = ?, startdate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),\n"
                + " enddate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),plandate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),signenddate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),studentscope = ?,classform = ?,classlevel = ?,\n"
                + " prof = ?,classtype = ?,crh = ?,planunit = ?,execunit = ?,departman = ?,projman = ?,refdoc = ?,\n"
                + " telldate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),classplace = ?,studentnum = ?,newpost = ?,studentdays = ?,classhours = ?,book1 = ?,\n"
                + " bookfrom1 = ?,book2 = ?,bookfrom2 = ?,book3 = ?,bookfrom3 = ?,book4 = ?,bookfrom4 = ?,projreport = ?,archivedate = to_date(?,'yyyy-mm-dd hh24:mi:ss'),projplan = ?,selfteach = ?,\n"
                + " unitid = ?,planunitid = ?,execunitid = ?,departmanid = ?,projmanid = ?,refdocurl = ?,plan_code=?,record_url=?,plan_books=?,cost_id=?,add_user=?,add_user_name=?,CLASS_SATUS=?,class_status_cmt=? \n"
                + "WHERE\n"
                + "	n_id =?";
        String key = UUID.randomUUID().toString();
        List<UnitsPersons> plist = educlass.getUnitpers();
        Object[][] params = new Object[][]{};
        String pSql = "insert into edu_unit_persons(unit_perid,unit_id,unit_name,unit_num,cost_id,class_id) values(?,?,?,?,?,?)";
        String delSql = "delete from edu_unit_persons where class_id=?";
        String cSql = "update edu_plan_costs set cost_status=?,cost_status_cmt=? where cost_id=? ";
        int i = 0;
        if (plist != null) {
            if (plist.size() > 0) {
                params = new Object[plist.size()][6];
                for (UnitsPersons item : plist) {
                    params[i][0] = UUID.randomUUID().toString();
                    params[i][1] = item.getUnit_id();
                    params[i][2] = item.getUnit_name();
                    params[i][3] = item.getUnit_num();
                    params[i][4] = item.getCost_id();
                    params[i][5] = key;
                    i++;
                }
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update(updateSql, educlass.getUnit(), educlass.getClassno(), educlass.getClassname(), educlass.getStartdate() == null ? educlass.getStartdate() : educlass.getStartdate(), educlass.getEnddate() == null ? educlass.getEnddate() : educlass.getEnddate(), educlass.getPlandate() == null ? educlass.getPlandate() : educlass.getPlandate(), educlass.getSignenddate() == null ? educlass.getSignenddate() : educlass.getSignenddate(),
                    educlass.getStudentscope(), educlass.getClassform(), educlass.getClasslevel(), educlass.getProf(), educlass.getClasstype(), educlass.getCrh(), educlass.getPlanunit(), educlass.getExecunit(), educlass.getDepartman(), educlass.getProjman(), educlass.getRefdoc(), educlass.getTelldate() == null ? educlass.getTelldate() : educlass.getTelldate(), educlass.getClassplace(), educlass.getStudentnum(), educlass.getNewpost(), educlass.getStudentdays(), educlass.getClasshours(), educlass.getBook1(), educlass.getBookfrom1(), educlass.getBook2(), educlass.getBookfrom2(), educlass.getBook3(), educlass.getBookfrom3(), educlass.getBook4(), educlass.getBookfrom4(), educlass.getProjreport(), educlass.getArchivedate(), educlass.getProjplan(), educlass.getSelfteach(), educlass.getUnitid(), educlass.getPlanunitid(), educlass.getExecunitid(), educlass.getDepartmanid(), educlass.getProjmanid(), educlass.getRefdocurl(), educlass.getPlan_code(), educlass.getRecord_url(), educlass.getPlan_books(), educlass.getCost_id(), educlass.getAdd_user(), educlass.getAdd_user_name(), educlass.getClass_status(), educlass.getClass_status_cmt(), educlass.getN_id());
            db.update(delSql, educlass.getN_id());
            db.update(cSql, educlass.getClass_status(), educlass.getClass_status_cmt(), educlass.getCost_id());
            db.batch(pSql, params);
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
    public Map<Integer, List<EduClass>> getClassPage(QueryModel pageModel) throws Throwable {
        if (pageModel.getSearch() != null && pageModel.getSearch() != "" && !pageModel.getSearch().equalsIgnoreCase("null")) {
            String[] params = pageModel.getSearch().split(",");
            //单位名称
            if (params[0].length() > 0) {
                String qs = "   or n_id in(select class_id from edu_unit_persons where unit_name='" + params[0] + "')";
                String fs = "   unit='" + params[0] + "' or add_user='" + UsersService.GetCurrentUser().getUsername() + "' or planunit='"+params[0]+"'";
                if (!StringUtils.isBlank(pageModel.getSelects())) {
                    fs += qs;
                }
                pageModel.setFilterRules(fs);

            }
        }
        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select  * from edu_class")
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EduClass>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql);
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(EduClass.class, querySql, new Object[]{}));
        return map;
    }

    @Override
    public List<EduClass> getClassList(String... classIds) throws SQLException {
        String selSql = "select * from edu_class ";
        if (classIds.length > 0) {
            selSql += " where id in(?)";
            return db.queryBeanList(EduClass.class, selSql, classIds);
        } else {
            return db.queryBeanList(EduClass.class, selSql);
        }
    }

    @Override
    public Boolean removeClass(String classIds) throws SQLException {
        String delSql = "delete  from edu_class where n_id in(?)";
        return (int) db.update(delSql, classIds) > 0;
    }

    @Override
    public EduClass getClassById(String classId) throws SQLException {
        String selSql = "select  * from edu_class where n_id=?";
        String tSql = "select * from edu_unit_persons where class_id=?";
        EduClass eclass = db.queryBean(EduClass.class, selSql, classId);
        if (eclass != null) {
            List<UnitsPersons> persons = db.queryBeanList(UnitsPersons.class, tSql, classId);
            eclass.setUnitpers(persons);
        }
        return eclass;
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
    public List<EduTrainingCategory> getTrainnings(Object... uids) throws SQLException {
        int i = 0;
        String trainsSql = "select * from edu_training_category  where 1=1";
        if (uids.length > 0) {
            if (uids[0] != null && !uids[0].equals("")) {
                trainsSql += " and id=?";
                i++;
            }
        }
        return i > 0 ? db.queryBeanList(EduTrainingCategory.class, trainsSql, uids) : db.queryBeanList(EduTrainingCategory.class, trainsSql);
    }

    @Override
    public List<EduNewPost> getNewPosts() throws SQLException {
        String postSql = "select * from edu_post ";
        return db.queryBeanList(EduNewPost.class, postSql);
    }
//该计划已建班总人数

    @Override
    public int getPersonNum(String plancode, String cost_id) throws SQLException {
        String querySql = "select case when sum(studentnum) is null then 0 else sum(studentnum) end as ttt from edu_class where plan_code=?";
        if (!StringUtils.isBlank(cost_id)) {
            querySql += " and cost_id='" + cost_id + "'";
        }
        return Integer.parseInt(db.queryScalar(1, querySql, plancode).toString());
    }

    @Override
    public List<PlanClassCostDto> getPlansAndCosts(ClassCostsSearch search) throws SQLException {
        String querySql = "select E.plan_road_url as refdocurl,E.plan_road as refdoc,E.plan_unit,E.plan_unitid,E.plan_execunitid,E.plan_executeunit,e.plan_prof,E.plan_name,E.plan_type,E.traintype,E.plan_object,E.plan_road,E.plan_road_url,C.* from EDU_PLANS E join EDU_PLAN_COSTS C on C.PLAN_CODE=E.PLAN_CODE where 1=1 ";
        String whereSql = "";
        String orSql = "";//执行单位，主办单位为本单位，拟稿人为当前用户
        List<Object> array = new ArrayList<Object>();
        if (!StringUtils.isBlank(search.getPlanstatus())) {
            whereSql += " and e.plan_status=? ";
            array.add(search.getPlanstatus());
        }
        if (!StringUtils.isBlank(search.getCoststatus())) {
            whereSql += " and c.cost_status in(" + search.getCoststatus() + ") ";
            //array.add(search.getCoststatus());
        }
        if (!StringUtils.isBlank(search.getTraintype())) {
            whereSql += " and e.traintype=? ";
            array.add(search.getTraintype());
        }
        if (!StringUtils.isBlank(search.getPlanunit())) {
            if (orSql.length() == 0) {
                orSql += "  e.plan_executeunit=?  or e.plan_unit=?";
            } else {
                orSql += " or e.plan_executeunit=?  or e.plan_unit=?";
            }
            array.add(search.getPlanunit());
            array.add(search.getPlanunit());
        }
        if (!StringUtils.isBlank(search.getUsername())) {
            if (orSql.length() == 0) {
                orSql += "  e.add_user=? ";
            } else {
                orSql += " or e.add_user=? ";
            }
            array.add(search.getUsername());
        }
        return db.queryBeanList(PlanClassCostDto.class, querySql + whereSql + " and (" + orSql + ")", array.toArray());
    }

    @Override
    public EduClass getClassByNo(String classno) throws SQLException {
        String selSql = "select * from edu_class where classno=?";
        EduClass eclass = db.queryBean(EduClass.class, selSql, classno);
        return eclass;
    }
}
