/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

import org.apache.commons.lang3.StringUtils;

/**
 *
 * @author milord
 */
public class Eud_New_Post {
    private int id;
    private String idcard;
    private String name;
    private String sex;
    private String xl;
    private String workshop;
    private String training_type;
    private String old_post;
    private String new_post;
    private String study_date;
    private String study_no;
    private String rljy_begindate;
    private String rljy_enddate;
    private String llpx_type;
    private String llpx_begindate;
    private String llpx_enddate;
    private String szpx_begindate;
    private String szpx_enddate;
    private String szpx_teacher;
    private double dzkscj_aq;
    private double dzkscj_ll;
    private double dzkscj_sz;
    private String dzl_date;
    private String dzl_no;
    private int crh;
    private String address1;
    private int studyhour1;
    private String address2;
    private int studyhour2;
    private String address3;
    private int studyhour3;
    private String classno;
    private String indenture;
    private double cjaqcj;
    private double bzaqcj;
    private String lzfzr;
    private String zjfzr;
    private String cjpxr;
    private String bzpxr;
    private String fzdw;
    private String fzrq;
    private String companyid;
    private String filepath;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the idcard
     */
    public String getIdcard() {
        return idcard;
    }

    /**
     * @param idcard the idcard to set
     */
    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    /**
     * @return the workshop
     */
    public String getWorkshop() {
        return workshop;
    }

    /**
     * @param workshop the workshop to set
     */
    public void setWorkshop(String workshop) {
        this.workshop = workshop;
    }

    /**
     * @return the training_type
     */
    public String getTraining_type() {
        return training_type;
    }

    /**
     * @param training_type the training_type to set
     */
    public void setTraining_type(String training_type) {
        this.training_type = training_type;
    }

    /**
     * @return the old_post
     */
    public String getOld_post() {
        return old_post;
    }

    /**
     * @param old_post the old_post to set
     */
    public void setOld_post(String old_post) {
        this.old_post = old_post;
    }

    /**
     * @return the new_post
     */
    public String getNew_post() {
        return new_post;
    }

    /**
     * @param new_post the new_post to set
     */
    public void setNew_post(String new_post) {
        this.new_post = new_post;
    }

    /**
     * @return the study_date
     */
    public String getStudy_date() {
        return StringUtils.isBlank(study_date) ? "" : study_date.split(" ")[0];
    }

    /**
     * @param study_date the study_date to set
     */
    public void setStudy_date(String study_date) {
        this.study_date = study_date;
    }

    /**
     * @return the study_no
     */
    public String getStudy_no() {
        return study_no;
    }

    /**
     * @param study_no the study_no to set
     */
    public void setStudy_no(String study_no) {
        this.study_no = study_no;
    }

    /**
     * @return the rljy_begindate
     */
    public String getRljy_begindate() {
        return StringUtils.isBlank(rljy_begindate) ? "" : rljy_begindate.split(" ")[0];
    }

    /**
     * @param rljy_begindate the rljy_begindate to set
     */
    public void setRljy_begindate(String rljy_begindate) {
        this.rljy_begindate = rljy_begindate;
    }

    /**
     * @return the rljy_enddate
     */
    public String getRljy_enddate() {
        return StringUtils.isBlank(rljy_enddate) ? "" : rljy_enddate.split(" ")[0];
    }

    /**
     * @param rljy_enddate the rljy_enddate to set
     */
    public void setRljy_enddate(String rljy_enddate) {
        this.rljy_enddate = rljy_enddate;
    }

    /**
     * @return the llpx_type
     */
    public String getLlpx_type() {
        return llpx_type;
    }

    /**
     * @param llpx_type the llpx_type to set
     */
    public void setLlpx_type(String llpx_type) {
        this.llpx_type = llpx_type;
    }

    /**
     * @return the llpx_begindate
     */
    public String getLlpx_begindate() {
        return StringUtils.isBlank(llpx_begindate) ? "" : llpx_begindate.split(" ")[0];
    }

    /**
     * @param llpx_begindate the llpx_begindate to set
     */
    public void setLlpx_begindate(String llpx_begindate) {
        this.llpx_begindate = llpx_begindate;
    }

    /**
     * @return the llpx_enddate
     */
    public String getLlpx_enddate() {
        return StringUtils.isBlank(llpx_enddate) ? "" : llpx_enddate.split(" ")[0];
    }

    /**
     * @param llpx_enddate the llpx_enddate to set
     */
    public void setLlpx_enddate(String llpx_enddate) {
        this.llpx_enddate = llpx_enddate;
    }

    /**
     * @return the szpx_begindate
     */
    public String getSzpx_begindate() {
        return StringUtils.isBlank(szpx_begindate) ? "" : szpx_begindate.split(" ")[0];
    }

    /**
     * @param szpx_begindate the szpx_begindate to set
     */
    public void setSzpx_begindate(String szpx_begindate) {
        this.szpx_begindate = szpx_begindate;
    }

    /**
     * @return the szpx_enddate
     */
    public String getSzpx_enddate() {
        return StringUtils.isBlank(szpx_enddate) ? "" : szpx_enddate.split(" ")[0];
    }

    /**
     * @param szpx_enddate the szpx_enddate to set
     */
    public void setSzpx_enddate(String szpx_enddate) {
        this.szpx_enddate = szpx_enddate;
    }

    /**
     * @return the szpx_teacher
     */
    public String getSzpx_teacher() {
        return szpx_teacher;
    }

    /**
     * @param szpx_teacher the szpx_teacher to set
     */
    public void setSzpx_teacher(String szpx_teacher) {
        this.szpx_teacher = szpx_teacher;
    }

    /**
     * @return the dzkscj_aq
     */
    public double getDzkscj_aq() {
        return dzkscj_aq;
    }

    /**
     * @param dzkscj_aq the dzkscj_aq to set
     */
    public void setDzkscj_aq(double dzkscj_aq) {
        this.dzkscj_aq = dzkscj_aq;
    }

    /**
     * @return the dzkscj_ll
     */
    public double getDzkscj_ll() {
        return dzkscj_ll;
    }

    /**
     * @param dzkscj_ll the dzkscj_ll to set
     */
    public void setDzkscj_ll(double dzkscj_ll) {
        this.dzkscj_ll = dzkscj_ll;
    }

    /**
     * @return the dzkscj_sz
     */
    public double getDzkscj_sz() {
        return dzkscj_sz;
    }

    /**
     * @param dzkscj_sz the dzkscj_sz to set
     */
    public void setDzkscj_sz(double dzkscj_sz) {
        this.dzkscj_sz = dzkscj_sz;
    }

    /**
     * @return the dzl_date
     */
    public String getDzl_date() {
        return StringUtils.isBlank(dzl_date) ? "" : dzl_date.split(" ")[0];
    }

    /**
     * @param dzl_date the dzl_date to set
     */
    public void setDzl_date(String dzl_date) {
        this.dzl_date = dzl_date;
    }

    /**
     * @return the dzl_no
     */
    public String getDzl_no() {
        return dzl_no;
    }

    /**
     * @param dzl_no the dzl_no to set
     */
    public void setDzl_no(String dzl_no) {
        this.dzl_no = dzl_no;
    }

    /**
     * @return the crh
     */
    public int getCrh() {
        return crh;
    }

    /**
     * @param crh the crh to set
     */
    public void setCrh(int crh) {
        this.crh = crh;
    }

    /**
     * @return the address1
     */
    public String getAddress1() {
        return address1;
    }

    /**
     * @param address1 the address1 to set
     */
    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    /**
     * @return the studyhour1
     */
    public int getStudyhour1() {
        return studyhour1;
    }

    /**
     * @param studyhour1 the studyhour1 to set
     */
    public void setStudyhour1(int studyhour1) {
        this.studyhour1 = studyhour1;
    }

    /**
     * @return the address2
     */
    public String getAddress2() {
        return address2;
    }

    /**
     * @param address2 the address2 to set
     */
    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    /**
     * @return the studyhour2
     */
    public int getStudyhour2() {
        return studyhour2;
    }

    /**
     * @param studyhour2 the studyhour2 to set
     */
    public void setStudyhour2(int studyhour2) {
        this.studyhour2 = studyhour2;
    }

    /**
     * @return the address3
     */
    public String getAddress3() {
        return address3;
    }

    /**
     * @param address3 the address3 to set
     */
    public void setAddress3(String address3) {
        this.address3 = address3;
    }

    /**
     * @return the studyhour3
     */
    public int getStudyhour3() {
        return studyhour3;
    }

    /**
     * @param studyhour3 the studyhour3 to set
     */
    public void setStudyhour3(int studyhour3) {
        this.studyhour3 = studyhour3;
    }

    /**
     * @return the classno
     */
    public String getClassno() {
        return classno;
    }

    /**
     * @param classno the classno to set
     */
    public void setClassno(String classno) {
        this.classno = classno;
    }

    /**
     * @return the indenture
     */
    public String getIndenture() {
        return indenture;
    }

    /**
     * @param indenture the indenture to set
     */
    public void setIndenture(String indenture) {
        this.indenture = indenture;
    }

    /**
     * @return the cjaqcj
     */
    public double getCjaqcj() {
        return cjaqcj;
    }

    /**
     * @param cjaqcj the cjaqcj to set
     */
    public void setCjaqcj(double cjaqcj) {
        this.cjaqcj = cjaqcj;
    }

    /**
     * @return the bzaqcj
     */
    public double getBzaqcj() {
        return bzaqcj;
    }

    /**
     * @param bzaqcj the bzaqcj to set
     */
    public void setBzaqcj(double bzaqcj) {
        this.bzaqcj = bzaqcj;
    }

    /**
     * @return the lzfzr
     */
    public String getLzfzr() {
        return lzfzr;
    }

    /**
     * @param lzfzr the lzfzr to set
     */
    public void setLzfzr(String lzfzr) {
        this.lzfzr = lzfzr;
    }

    /**
     * @return the zjfzr
     */
    public String getZjfzr() {
        return zjfzr;
    }

    /**
     * @param zjfzr the zjfzr to set
     */
    public void setZjfzr(String zjfzr) {
        this.zjfzr = zjfzr;
    }

    /**
     * @return the cjpxr
     */
    public String getCjpxr() {
        return cjpxr;
    }

    /**
     * @param cjpxr the cjpxr to set
     */
    public void setCjpxr(String cjpxr) {
        this.cjpxr = cjpxr;
    }

    /**
     * @return the bzpxr
     */
    public String getBzpxr() {
        return bzpxr;
    }

    /**
     * @param bzpxr the bzpxr to set
     */
    public void setBzpxr(String bzpxr) {
        this.bzpxr = bzpxr;
    }

    /**
     * @return the fzdw
     */
    public String getFzdw() {
        return fzdw;
    }

    /**
     * @param fzdw the fzdw to set
     */
    public void setFzdw(String fzdw) {
        this.fzdw = fzdw;
    }

    /**
     * @return the fzrq
     */
    public String getFzrq() {
        return fzrq;
    }

    /**
     * @param fzrq the fzrq to set
     */
    public void setFzrq(String fzrq) {
        this.fzrq = fzrq;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the sex
     */
    public String getSex() {
        return sex;
    }

    /**
     * @param sex the sex to set
     */
    public void setSex(String sex) {
        this.sex = sex;
    }

    /**
     * @return the xl
     */
    public String getXl() {
        return xl;
    }

    /**
     * @param xl the xl to set
     */
    public void setXl(String xl) {
        this.xl = xl;
    }

    /**
     * @return the commpanyid
     */
    public String getCompanyid() {
        return companyid;
    }

    /**
     * @param companyid the companyid to set
     */
    public void setCompanyid(String companyid) {
        this.companyid = companyid;
    }

    /**
     * @return the filepath
     */
    public String getFilepath() {
        return filepath;
    }

    /**
     * @param filepath the filepath to set
     */
    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }
}
