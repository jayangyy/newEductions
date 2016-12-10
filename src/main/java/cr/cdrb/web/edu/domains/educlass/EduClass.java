/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.educlass;

import java.util.List;

/**
 *
 * @author Jayang 2016-08-11 班级类
 */
public class EduClass {
    //主键

    private String n_id;

    public String getN_id() {
        return n_id;
    }

    public void setN_id(String n_id) {
        this.n_id = n_id;
    }
    private Integer id;
    private String plan_code;
    //项目书
    private String plan_books;
    //人数分配
    private List<UnitsPersons> unitpers;

    public List<UnitsPersons> getUnitpers() {
        return unitpers;
    }

    public void setUnitpers(List<UnitsPersons> unitpers) {
        this.unitpers = unitpers;
    }
    //履历URL
    private String record_url;
    //经费ID
    private String cost_id;

    public String getCost_id() {
        return cost_id;
    }

    public void setCost_id(String cost_id) {
        this.cost_id = cost_id;
    }

    public String getPlan_books() {
        return plan_books;
    }

    public void setPlan_books(String plan_books) {
        this.plan_books = plan_books;
    }

    public String getRecord_url() {
        return record_url;
    }

    public void setRecord_url(String record_url) {
        this.record_url = record_url;
    }

    public String getPlan_code() {
        return plan_code;
    }

    public void setPlan_code(String plan_code) {
        this.plan_code = plan_code;
    }
    private String unit;
    private String classno;
    private String classname;
    private String classfrom;

    public String getClassfrom() {
        return classfrom;
    }

    public void setClassfrom(String classfrom) {
        this.classfrom = classfrom;
    }
    private String startdate;
    private String enddate;
    private String plandate;
    private String signenddate;
    private String studentscope;
    private String classform;
    private String classlevel;
    private String prof;
    private String classtype;
    private Integer crh;
    private String planunit;
    private String execunit;
    private String departman;
    private String projman;
    private String refdoc;
    private String telldate;
    private String classplace;
    private Integer studentnum;
    private String newpost;
    private Integer studentdays;
    private Integer classhours;
    private String book1;
    private String bookfrom1;
    private String book2;
    private String bookfrom2;
    private String book3;
    private String bookfrom3;
    private String book4;
    private String bookfrom4;
    private String projreport;
    private String archivedate;
    private String projplan;
    private String selfteach;
    private String unitid;
    private String planunitid;
    private String execunitid;
    private String departmanid;
    private String projmanid;
    private String refdocurl;
    //标识建班是否结束
    private Boolean isover;
    //添加人身份证号码
    private String add_user;
    //添加人姓名
    private String add_user_name;

    public String getAdd_user() {
        return add_user;
    }

    public void setAdd_user(String add_user) {
        this.add_user = add_user;
    }

    public String getAdd_user_name() {
        return add_user_name;
    }

    public void setAdd_user_name(String add_user_name) {
        this.add_user_name = add_user_name;
    }

    public int getClass_status() {
        return class_status;
    }

    public void setClass_status(int class_status) {
        this.class_status = class_status;
    }

    public String getClass_status_cmt() {
        return class_status_cmt;
    }

    public void setClass_status_cmt(String class_status_cmt) {
        this.class_status_cmt = class_status_cmt;
    }
    //班级状态
    private int class_status;
    //班级状态描述
    private String class_status_cmt;
    //经费状态
    private String cost_status;

    public String getCost_status() {
        return cost_status;
    }

    public void setCost_status(String cost_status) {
        this.cost_status = cost_status;
    }

    public String getCost_status_cmt() {
        return cost_status_cmt;
    }

    public void setCost_status_cmt(String cost_status_cmt) {
        this.cost_status_cmt = cost_status_cmt;
    }
//经费状态描述
    private String cost_status_cmt;

    public Boolean getIsover() {
        return isover;
    }

    public void setIsover(Boolean isover) {
        this.isover = isover;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getClassno() {
        return classno;
    }

    public void setClassno(String classno) {
        this.classno = classno;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public String getPlandate() {
        return plandate;
    }

    public void setPlandate(String plandate) {
        this.plandate = plandate;
    }

    public String getSignenddate() {
        return signenddate;
    }

    public void setSignenddate(String signenddate) {
        this.signenddate = signenddate;
    }

    public String getStudentscope() {
        return studentscope;
    }

    public void setStudentscope(String studentscope) {
        this.studentscope = studentscope;
    }

    public String getClassform() {
        return classform;
    }

    public void setClassform(String classform) {
        this.classform = classform;
    }

    public String getClasslevel() {
        return classlevel;
    }

    public void setClasslevel(String classlevel) {
        this.classlevel = classlevel;
    }

    public String getProf() {
        return prof;
    }

    public void setProf(String prof) {
        this.prof = prof;
    }

    public String getClasstype() {
        return classtype;
    }

    public void setClasstype(String classtype) {
        this.classtype = classtype;
    }

    public Integer getCrh() {
        return crh;
    }

    public void setCrh(Integer crh) {
        this.crh = crh;
    }

    public String getPlanunit() {
        return planunit;
    }

    public void setPlanunit(String planunit) {
        this.planunit = planunit;
    }

    public String getExecunit() {
        return execunit;
    }

    public void setExecunit(String execunit) {
        this.execunit = execunit;
    }

    public String getDepartman() {
        return departman;
    }

    public void setDepartman(String departman) {
        this.departman = departman;
    }

    public String getProjman() {
        return projman;
    }

    public void setProjman(String projman) {
        this.projman = projman;
    }

    public String getRefdoc() {
        return refdoc;
    }

    public void setRefdoc(String refdoc) {
        this.refdoc = refdoc;
    }

    public String getTelldate() {
        return telldate;
    }

    public void setTelldate(String telldate) {
        this.telldate = telldate;
    }

    public String getClassplace() {
        return classplace;
    }

    public void setClassplace(String classplace) {
        this.classplace = classplace;
    }

    public Integer getStudentnum() {
        return studentnum;
    }

    public void setStudentnum(Integer studentnum) {
        this.studentnum = studentnum;
    }

    public String getNewpost() {
        return newpost;
    }

    public void setNewpost(String newpost) {
        this.newpost = newpost;
    }

    public Integer getStudentdays() {
        return studentdays;
    }

    public void setStudentdays(Integer studentdays) {
        this.studentdays = studentdays;
    }

    public Integer getClasshours() {
        return classhours;
    }

    public void setClasshours(Integer classhours) {
        this.classhours = classhours;
    }

    public String getBook1() {
        return book1;
    }

    public void setBook1(String book1) {
        this.book1 = book1;
    }

    public String getBookfrom1() {
        return bookfrom1;
    }

    public void setBookfrom1(String bookfrom1) {
        this.bookfrom1 = bookfrom1;
    }

    public String getBook2() {
        return book2;
    }

    public void setBook2(String book2) {
        this.book2 = book2;
    }

    public String getBookfrom2() {
        return bookfrom2;
    }

    public void setBookfrom2(String bookfrom2) {
        this.bookfrom2 = bookfrom2;
    }

    public String getBook3() {
        return book3;
    }

    public void setBook3(String book3) {
        this.book3 = book3;
    }

    public String getBookfrom3() {
        return bookfrom3;
    }

    public void setBookfrom3(String bookfrom3) {
        this.bookfrom3 = bookfrom3;
    }

    public String getBook4() {
        return book4;
    }

    public void setBook4(String book4) {
        this.book4 = book4;
    }

    public String getBookfrom4() {
        return bookfrom4;
    }

    public void setBookfrom4(String bookfrom4) {
        this.bookfrom4 = bookfrom4;
    }

    public String getProjreport() {
        return projreport;
    }

    public void setProjreport(String projreport) {
        this.projreport = projreport;
    }

    public String getArchivedate() {
        return archivedate;
    }

    public void setArchivedate(String archivedate) {
        this.archivedate = archivedate;
    }

    public String getProjplan() {
        return projplan;
    }

    public void setProjplan(String projplan) {
        this.projplan = projplan;
    }

    public String getSelfteach() {
        return selfteach;
    }

    public void setSelfteach(String selfteach) {
        this.selfteach = selfteach;
    }

    public String getUnitid() {
        return unitid;
    }

    public void setUnitid(String unitid) {
        this.unitid = unitid;
    }

    public String getPlanunitid() {
        return planunitid;
    }

    public void setPlanunitid(String planunitid) {
        this.planunitid = planunitid;
    }

    public String getExecunitid() {
        return execunitid;
    }

    public void setExecunitid(String execunitid) {
        this.execunitid = execunitid;
    }

    public String getDepartmanid() {
        return departmanid;
    }

    public void setDepartmanid(String departmanid) {
        this.departmanid = departmanid;
    }

    public String getProjmanid() {
        return projmanid;
    }

    public void setProjmanid(String projmanid) {
        this.projmanid = projmanid;
    }

    public String getRefdocurl() {
        return refdocurl;
    }

    public void setRefdocurl(String refdocurl) {
        this.refdocurl = refdocurl;
    }

}
