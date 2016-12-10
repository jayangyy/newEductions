/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IEduStudents;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduClassDto;
import cr.cdrb.web.edu.domains.educlass.EduClassSearch;
import cr.cdrb.web.edu.domains.educlass.EduStudent;
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
public class EduStudentDao implements IEduStudents {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public Boolean addStudent(EduStudent student) throws SQLException {
        String insSql = "insert into edu_students(id,stu_name,stu_sex,stu_idcard,"
                + "class_no,stu_unit,stu_dep, stu_oldjob, stu_curjob, stu_phy_points,stu_phy_url, stu_prac_points,stu_prac_url,"
                + "stu_sec_points, stu_sec_url,stu_bsec_points,stu_bsec_url,stu_cer_date, stu_cer_no, stu_order_date, stu_order_no, stu_bphy_points) values("
                + "'" + UUID.randomUUID() + "',?,?,?,?,?,?, ?, ?, ?,?, ?,?,?, ?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, ?)";
        oracle.sql.ROWID rowid = db.insert(insSql, student.getStu_name(), student.getStu_sex(), student.getStu_idcard(), student.getClass_no(), student.getStu_unit(), student.getStu_dep(), student.getStu_oldjob(), student.getStu_curjob(), student.getStu_phy_points(), student.getStu_phy_url(), student.getStu_prac_points(), student.getStu_prac_url(),
                student.getStu_sec_points(), student.getStu_sec_url(), student.getStu_bsec_points(), student.getStu_bsec_url(), student.getStu_cer_date(), student.getStu_cer_no(), student.getStu_order_date(), student.getStu_order_no(), student.getStu_bphy_points()
        );
        return !rowid.isNull();
    }

    @Override
    public Boolean updateStudent(EduStudent student) throws SQLException {
        String updateSql = " update edu_students set id = v_id,stu_name = v_stu_name, stu_sex = v_stu_sex,stu_idcard = v_stu_idcard,class_no = v_class_no,stu_unit = v_stu_unit,stu_dep = v_stu_dep,stu_oldjob = v_stu_oldjob,stu_curjob = v_stu_curjob,"
                + "stu_phy_points = v_stu_phy_points,stu_phy_url = v_stu_phy_url,stu_prac_points = v_stu_prac_points,stu_prac_url = v_stu_prac_url,stu_sec_points = v_stu_sec_points,stu_sec_url = v_stu_sec_url,"
                + "stu_bsec_points = v_stu_bsec_points,stu_bsec_url = v_stu_bsec_url,stu_cer_date = v_stu_cer_date,stu_cer_no = v_stu_cer_no,stu_order_date = v_stu_order_date,stu_order_no = v_stu_order_no,stu_bphy_points = v_stu_bphy_points "
                + "where id = v_id;";
        return (int) db.update(updateSql) > 0;
    }

    @Override
    public EduStudent getStudent(String stu_idcard, String classno, String id) throws SQLException {
        String querySql = "select id, stu_name, stu_sex, stu_idcard, class_no, stu_unit, stu_dep, stu_oldjob, stu_curjob, stu_phy_points, stu_phy_url, stu_prac_points, stu_prac_url, stu_sec_points, stu_sec_url, stu_bsec_points, stu_bsec_url, stu_cer_date, stu_cer_no, stu_order_date, stu_order_no, stu_bphy_points from edu_students where 1=1";
        if (stu_idcard != null) {
            if (stu_idcard.length() > 0) {
                querySql += " and stu_idcard='" + stu_idcard + "'";
            }
        }
        if (classno != null) {
            if (classno.length() > 0) {
                querySql += " and class_no='" + classno + "'";
            }
        }
        if (id != null) {
            if (id.length() > 0) {
                querySql += " and id='" + id + "'";
            }
        }
        return db.queryBean(EduStudent.class, querySql);
    }

    @Override
    public Boolean removeStudents(String ids, String classno, String unit) throws SQLException {
        String delSql = "delete from edu_students where  class_no=? ";
        List<Object> params = new ArrayList<Object>();
        params.add(classno);
        if (unit != null) {
            delSql += " and stu_unit=? ";
            params.add(unit);
        }
        if (ids != null) {
            delSql += " and stu_idcard in('" + ids + "') ";
            // params.add(ids);
        }
        return (int) db.update(delSql, params.toArray()) >= 0;
    }

    @Override
    public Boolean scoreRecording(EduStudent student) throws SQLException {
        String recordSql = "update edu_students set stu_phy_points = ?,stu_prac_points = ?,stu_sec_points = ?,stu_bsec_points = ?,stu_bphy_points = ? where id=?";
        return (int) db.update(recordSql, student.getStu_phy_points(), student.getStu_prac_points(), student.getStu_sec_points(), student.getStu_bsec_points(), student.getStu_bphy_points(), student.getId()) > 0;
    }

    @Override
    public Boolean addStudents(List<EduStudent> students) throws SQLException {
        String insSql = "insert into edu_students(id,stu_name,stu_sex,stu_idcard,"
                + "class_no,stu_unit,stu_dep, stu_oldjob, stu_curjob, stu_phy_points,stu_phy_url, stu_prac_points,stu_prac_url,"
                + "stu_sec_points, stu_sec_url,stu_bsec_points,stu_bsec_url,stu_cer_date, stu_cer_no, stu_order_date, stu_order_no, stu_bphy_points) values("
                + "?,?,?,?,?,?,?, ?, ?, ?,?, ?,?,?, ?,?,?,to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, ?)";
        List<String> paramArray = new ArrayList<String>();
        Object[][] params = null;
        Object[][] params2 = null;
        if (students.size() > 0) {
            params = new Object[students.size()][22];
            for (int i = 0; i < students.size(); i++) {
                params[i][0] = UUID.randomUUID().toString();
                params[i][1] = students.get(i).getStu_name();
                params[i][2] = students.get(i).getStu_sex();
                params[i][3] = students.get(i).getStu_idcard();
                params[i][4] = students.get(i).getClass_no();
                params[i][5] = students.get(i).getStu_unit();
                params[i][6] = students.get(i).getStu_dep();
                params[i][7] = students.get(i).getStu_oldjob();
                params[i][8] = students.get(i).getStu_curjob();
                params[i][9] = students.get(i).getStu_phy_points();
                params[i][10] = students.get(i).getStu_phy_url();
                params[i][11] = students.get(i).getStu_prac_points();
                params[i][12] = students.get(i).getStu_prac_url();
                params[i][13] = students.get(i).getStu_sec_points();
                params[i][14] = students.get(i).getStu_sec_url();
                params[i][15] = students.get(i).getStu_bsec_points();
                params[i][16] = students.get(i).getStu_bsec_url();
                params[i][17] = students.get(i).getStu_cer_date();
                params[i][18] = students.get(i).getStu_cer_no();
                params[i][19] = students.get(i).getStu_order_date();
                params[i][20] = students.get(i).getStu_order_no();
                params[i][21] = students.get(i).getStu_bphy_points();
            }
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            int[] ttt = db.batch(insSql, params);
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
    public Map<Integer, List<EduStudent>> getStudentsPage(EduClassSearch pageModel) throws Throwable {
        String whereSql = " 1=1 ";
        List<Object> list = new ArrayList<Object>();
        String querySql1 = " ";
        String selects = "";
        if (pageModel.getIs_inputs()) {
            querySql1 += "  employee T INNER JOIN v_position P ON T .em_id = P .employee_id INNER JOIN b_unit b ON b.u_id = P .dw_id INNER JOIN b_department D ON D .dwxxbmbs = P .bm_id LEFT JOIN (SELECT stu_idcard,class_no from  EDU_STUDENTS where 1=1 ";
            if (pageModel.getClassno() != null) {
                if (pageModel.getClassno().length() > 0) {
                    querySql1 += " and class_no='" + pageModel.getClassno() + "'";
                }
            }
            querySql1 += " ) e on e.stu_idcard = T .em_idcard ";
            selects += "select DISTINCT T.EM_GZ as stu_oldjob,em_name AS stu_name,CASE WHEN em_egender = 1 THEN '男' ELSE '女' END AS stu_sex,em_idcard AS stu_idcard,b.u_id dwid,b. NAME stu_unit,D .dwxxbmbs bmid,D .xsbmmc AS stu_dep,e.class_no  from ";
            selects += querySql1;
        } else {
            if (!pageModel.getIs_entry() && pageModel.getIs_search()) {
                querySql1 += " edu_students S join EDU_CLASS C on C.CLASSNO=S.CLASS_NO where 1=1  ";
                if (pageModel.getStu_sunit() != null) {
                    if (pageModel.getStu_sunit().length() > 0) {
                        querySql1 += "  and C.EXECUNIT='" + pageModel.getStu_sunit() + "'";
                    }
                }
                if (pageModel.getClassno() != null) {
                    querySql1 += "  and C.CLASSNO='" + pageModel.getClassno() + "'";
                }
                //获取已录入人员数据
                selects += " select DISTINCT stu_name, stu_sex, stu_idcard, stu_unit from ";
            } else {
                querySql1 += " edu_students ";
                selects += " select id, stu_name, stu_sex, stu_idcard, class_no, stu_unit, stu_dep, stu_oldjob, stu_curjob, stu_phy_points, stu_phy_url, stu_prac_points, stu_prac_url, stu_sec_points, stu_sec_url, stu_bsec_points, stu_bsec_url, stu_cer_date, stu_cer_no, stu_order_date, stu_order_no, stu_bphy_points from ";
            }
            selects += querySql1;
        }
        if (pageModel.getStu_sidcard() != null) {
            if (pageModel.getStu_sidcard().length() > 0) {
                whereSql += " and stu_idcard=?  ";
                list.add(pageModel.getStu_sidcard());
            }
        }
        if (pageModel.getStu_sname() != null) {
            if (pageModel.getStu_sname().length() > 0) {
                whereSql += " and stu_name like ?  ";
                list.add("%" + pageModel.getStu_sname() + "%");
            }
        }
        if (pageModel.getStu_sunit() != null) {
            if (pageModel.getStu_sunit().length() > 0) {
                whereSql += " and stu_unit =?  ";
                list.add(pageModel.getStu_sunit());
            }
        }
        if (pageModel.getClassno() != null && !pageModel.getIs_entry() && !pageModel.getIs_search()) {
            if (pageModel.getClassno().length() > 0) {
                if (pageModel.getIs_inputs()) {
                    whereSql += " AND (class_no !=? or class_no is NULL) ";
                } else {
                    whereSql += " and (class_no=?  and class_no is not null)";
                }
                list.add(pageModel.getClassno());
            }
        }
        pageModel.setFilterRules(whereSql);
        pageModel.setSelects(selects);
        pageModel.setParams(list);
//        ISelectBuilder builder = new OracleSelectBuilder()
//                .from(selects)
//                .where(pageModel.getFilterRules())
//                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
//                .page(pageModel.getPage(), pageModel.getRows());
//        String totalSql = builder.total();
//        String querySql = builder.toSql();
//        Map<Integer, List<EduStudent>> map = new HashMap<>();
//        BigDecimal total = db.queryScalar(totalSql, list.toArray());
//        map.put(Integer.parseInt(total.toString()), db.queryBeanList(EduStudent.class, querySql, list.toArray()));
        return getStudentsCom(pageModel);
    }

    @Override
    public List<EduClassDto> getStuClass(String idcard, String unit) throws SQLException {
        String querySql = "select DISTINCT c.classno as class_no,c.classname as class_name from edu_class c join edu_students s on s.class_no=c.classno where 1=1 ";
        List<Object> list = new ArrayList<Object>();
        if (idcard.length() > 0) {
            querySql += " and s.idcard=?";
            list.add(idcard);
        }
        if (unit.length() > 0) {
            querySql += " and c.EXECUNIT=?";
            list.add(unit);
        }
        return db.queryBeanList(EduClassDto.class, querySql, list.toArray());
    }

    @Override
    public Map<Integer, List<EduStudent>> getStudentsCom(EduClassSearch pageModel) throws Throwable {
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(pageModel.getSelects())
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EduStudent>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql, pageModel.getParams().toArray());
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(EduStudent.class, querySql, pageModel.getParams().toArray()));
        return map;
    }

    @Override
    public int getStusNum(String classno, String unit) throws SQLException {
        String querySql = "SELECT count(DISTINCT STU_IDCARD) as total from EDU_STUDENTS where 1=1 ";
        List<Object> params = new ArrayList<Object>();
        if (!StringUtils.isBlank(classno)) {
            querySql += " and CLASS_NO=? ";
            params.add(classno);
        }
        if (!StringUtils.isBlank(unit)) {
            querySql += " and STU_UNIT=? ";
            params.add(unit);
        }
        BigDecimal countAll = db.queryScalar(1, querySql, params.toArray());
        return Integer.parseInt(countAll.toString());
    }
}
