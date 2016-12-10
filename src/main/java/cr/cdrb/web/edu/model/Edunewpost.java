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
public class Edunewpost {

    private int id;
    private String username;
    private String usersex;
    private String usereduback;
    private String userpid;
    private String workshop;
    private String bz;
    private String old_post;
    private String new_post;
    private String pxlb;
    private String pxxs;
    private int crh;
    private String study_no;
    private String study_date;
    private String aq_begindate;
    private String aq_enddate;
    private String aq_classno;
    private String aq_address;
    private String aq_study_hour;
    private String aq_cj;
    private String aq_khyj;
    private String aq_fzr;
    private String aq_sj_url;
    private String aq_cj_cj;
    private String aq_cj_fzr;
    private String aq_cj_khyj;
    private String aq_bz_cj;
    private String aq_bz_fzr;
    private String aq_bz_khyj;
    private String ll_begindate;
    private String ll_enddate;
    private String ll_classno;
    private String ll_address;
    private String ll_study_hour;
    private String ll_cj;
    private String ll_sj_url;
    private String sz_pactno;
    private String sz_begindate;
    private String sz_enddate;
    private String sz_teacher_name;
    private String sz_address;
    private String sz_study_hour;
    private String sz_cj;
    private String sz_sj_url;
    private String fzdw;
    private String fzrq;
    private String dzl_no;
    private String dzl_date;
    private String companyid;
    private String filepath;
    private String dworbm;
    private String dwid;

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
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the usersex
     */
    public String getUsersex() {
        return usersex;
    }

    /**
     * @param usersex the usersex to set
     */
    public void setUsersex(String usersex) {
        this.usersex = usersex;
    }

    /**
     * @return the usereduback
     */
    public String getUsereduback() {
        return usereduback;
    }

    /**
     * @param usereduback the usereduback to set
     */
    public void setUsereduback(String usereduback) {
        this.usereduback = usereduback;
    }

    /**
     * @return the userpid
     */
    public String getUserpid() {
        return userpid;
    }

    /**
     * @param userpid the userpid to set
     */
    public void setUserpid(String userpid) {
        this.userpid = userpid;
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
     * @return the bz
     */
    public String getBz() {
        return bz;
    }

    /**
     * @param bz the bz to set
     */
    public void setBz(String bz) {
        this.bz = bz;
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
     * @return the pxlb
     */
    public String getPxlb() {
        return pxlb;
    }

    /**
     * @param pxlb the pxlb to set
     */
    public void setPxlb(String pxlb) {
        this.pxlb = pxlb;
    }

    /**
     * @return the pxxs
     */
    public String getPxxs() {
        return pxxs;
    }

    /**
     * @param pxxs the pxxs to set
     */
    public void setPxxs(String pxxs) {
        this.pxxs = pxxs;
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
     * @return the aq_begindate
     */
    public String getAq_begindate() {
        return StringUtils.isBlank(aq_begindate) ? "" : aq_begindate.split(" ")[0];
    }

    /**
     * @param aq_begindate the aq_begindate to set
     */
    public void setAq_begindate(String aq_begindate) {
        this.aq_begindate = aq_begindate;
    }

    /**
     * @return the aq_enddate
     */
    public String getAq_enddate() {
        return StringUtils.isBlank(aq_enddate) ? "" : aq_enddate.split(" ")[0];
    }

    /**
     * @param aq_enddate the aq_enddate to set
     */
    public void setAq_enddate(String aq_enddate) {
        this.aq_enddate = aq_enddate;
    }

    /**
     * @return the aq_classno
     */
    public String getAq_classno() {
        return aq_classno;
    }

    /**
     * @param aq_classno the aq_classno to set
     */
    public void setAq_classno(String aq_classno) {
        this.aq_classno = aq_classno;
    }

    /**
     * @return the aq_address
     */
    public String getAq_address() {
        return aq_address;
    }

    /**
     * @param aq_address the aq_address to set
     */
    public void setAq_address(String aq_address) {
        this.aq_address = aq_address;
    }

    /**
     * @return the aq_study_hour
     */
    public String getAq_study_hour() {
        return aq_study_hour;
    }

    /**
     * @param aq_study_hour the aq_study_hour to set
     */
    public void setAq_study_hour(String aq_study_hour) {
        this.aq_study_hour = aq_study_hour;
    }

    /**
     * @return the aq_cj
     */
    public String getAq_cj() {
        return aq_cj;
    }

    /**
     * @param aq_cj the aq_cj to set
     */
    public void setAq_cj(String aq_cj) {
        this.aq_cj = aq_cj;
    }

    /**
     * @return the aq_khyj
     */
    public String getAq_khyj() {
        return aq_khyj;
    }

    /**
     * @param aq_khyj the aq_khyj to set
     */
    public void setAq_khyj(String aq_khyj) {
        this.aq_khyj = aq_khyj;
    }

    /**
     * @return the aq_fzr
     */
    public String getAq_fzr() {
        return aq_fzr;
    }

    /**
     * @param aq_fzr the aq_fzr to set
     */
    public void setAq_fzr(String aq_fzr) {
        this.aq_fzr = aq_fzr;
    }

    /**
     * @return the aq_sj_url
     */
    public String getAq_sj_url() {
        return aq_sj_url;
    }

    /**
     * @param aq_sj_url the aq_sj_url to set
     */
    public void setAq_sj_url(String aq_sj_url) {
        this.aq_sj_url = aq_sj_url;
    }

    /**
     * @return the aq_cj_cj
     */
    public String getAq_cj_cj() {
        return aq_cj_cj;
    }

    /**
     * @param aq_cj_cj the aq_cj_cj to set
     */
    public void setAq_cj_cj(String aq_cj_cj) {
        this.aq_cj_cj = aq_cj_cj;
    }

    /**
     * @return the aq_cj_fzr
     */
    public String getAq_cj_fzr() {
        return aq_cj_fzr;
    }

    /**
     * @param aq_cj_fzr the aq_cj_fzr to set
     */
    public void setAq_cj_fzr(String aq_cj_fzr) {
        this.aq_cj_fzr = aq_cj_fzr;
    }

    /**
     * @return the aq_cj_khyj
     */
    public String getAq_cj_khyj() {
        return aq_cj_khyj;
    }

    /**
     * @param aq_cj_khyj the aq_cj_khyj to set
     */
    public void setAq_cj_khyj(String aq_cj_khyj) {
        this.aq_cj_khyj = aq_cj_khyj;
    }

    /**
     * @return the aq_bz_cj
     */
    public String getAq_bz_cj() {
        return aq_bz_cj;
    }

    /**
     * @param aq_bz_cj the aq_bz_cj to set
     */
    public void setAq_bz_cj(String aq_bz_cj) {
        this.aq_bz_cj = aq_bz_cj;
    }

    /**
     * @return the aq_bz_fzr
     */
    public String getAq_bz_fzr() {
        return aq_bz_fzr;
    }

    /**
     * @param aq_bz_fzr the aq_bz_fzr to set
     */
    public void setAq_bz_fzr(String aq_bz_fzr) {
        this.aq_bz_fzr = aq_bz_fzr;
    }

    /**
     * @return the aq_bz_khyj
     */
    public String getAq_bz_khyj() {
        return aq_bz_khyj;
    }

    /**
     * @param aq_bz_khyj the aq_bz_khyj to set
     */
    public void setAq_bz_khyj(String aq_bz_khyj) {
        this.aq_bz_khyj = aq_bz_khyj;
    }

    /**
     * @return the ll_begindate
     */
    public String getLl_begindate() {
        return StringUtils.isBlank(ll_begindate) ? "" : ll_begindate.split(" ")[0];
    }

    /**
     * @param ll_begindate the ll_begindate to set
     */
    public void setLl_begindate(String ll_begindate) {
        this.ll_begindate = ll_begindate;
    }

    /**
     * @return the ll_enddate
     */
    public String getLl_enddate() {
        return StringUtils.isBlank(ll_enddate) ? "" : ll_enddate.split(" ")[0];
    }

    /**
     * @param ll_enddate the ll_enddate to set
     */
    public void setLl_enddate(String ll_enddate) {
        this.ll_enddate = ll_enddate;
    }

    /**
     * @return the ll_classno
     */
    public String getLl_classno() {
        return ll_classno;
    }

    /**
     * @param ll_classno the ll_classno to set
     */
    public void setLl_classno(String ll_classno) {
        this.ll_classno = ll_classno;
    }

    /**
     * @return the ll_address
     */
    public String getLl_address() {
        return ll_address;
    }

    /**
     * @param ll_address the ll_address to set
     */
    public void setLl_address(String ll_address) {
        this.ll_address = ll_address;
    }

    /**
     * @return the ll_study_hour
     */
    public String getLl_study_hour() {
        return ll_study_hour;
    }

    /**
     * @param ll_study_hour the ll_study_hour to set
     */
    public void setLl_study_hour(String ll_study_hour) {
        this.ll_study_hour = ll_study_hour;
    }

    /**
     * @return the ll_cj
     */
    public String getLl_cj() {
        return ll_cj;
    }

    /**
     * @param ll_cj the ll_cj to set
     */
    public void setLl_cj(String ll_cj) {
        this.ll_cj = ll_cj;
    }

    /**
     * @return the ll_sj_url
     */
    public String getLl_sj_url() {
        return ll_sj_url;
    }

    /**
     * @param ll_sj_url the ll_sj_url to set
     */
    public void setLl_sj_url(String ll_sj_url) {
        this.ll_sj_url = ll_sj_url;
    }

    /**
     * @return the sz_begindate
     */
    public String getSz_begindate() {
        return StringUtils.isBlank(sz_begindate) ? "" : sz_begindate.split(" ")[0];
    }

    /**
     * @param sz_begindate the sz_begindate to set
     */
    public void setSz_begindate(String sz_begindate) {
        this.sz_begindate = sz_begindate;
    }

    /**
     * @return the sz_enddate
     */
    public String getSz_enddate() {
        return StringUtils.isBlank(sz_enddate) ? "" : sz_enddate.split(" ")[0];
    }

    /**
     * @param sz_enddate the sz_enddate to set
     */
    public void setSz_enddate(String sz_enddate) {
        this.sz_enddate = sz_enddate;
    }

    /**
     * @return the sz_teacher_name
     */
    public String getSz_teacher_name() {
        return sz_teacher_name;
    }

    /**
     * @param sz_teacher_name the sz_teacher_name to set
     */
    public void setSz_teacher_name(String sz_teacher_name) {
        this.sz_teacher_name = sz_teacher_name;
    }

    /**
     * @return the sz_address
     */
    public String getSz_address() {
        return sz_address;
    }

    /**
     * @param sz_address the sz_address to set
     */
    public void setSz_address(String sz_address) {
        this.sz_address = sz_address;
    }

    /**
     * @return the sz_study_hour
     */
    public String getSz_study_hour() {
        return sz_study_hour;
    }

    /**
     * @param sz_study_hour the sz_study_hour to set
     */
    public void setSz_study_hour(String sz_study_hour) {
        this.sz_study_hour = sz_study_hour;
    }

    /**
     * @return the sz_cj
     */
    public String getSz_cj() {
        return sz_cj;
    }

    /**
     * @param sz_cj the sz_cj to set
     */
    public void setSz_cj(String sz_cj) {
        this.sz_cj = sz_cj;
    }

    /**
     * @return the sz_sj_url
     */
    public String getSz_sj_url() {
        return sz_sj_url;
    }

    /**
     * @param sz_sj_url the sz_sj_url to set
     */
    public void setSz_sj_url(String sz_sj_url) {
        this.sz_sj_url = sz_sj_url;
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
        return StringUtils.isBlank(fzrq) ? "" : fzrq.split(" ")[0];
    }

    /**
     * @param fzrq the fzrq to set
     */
    public void setFzrq(String fzrq) {
        this.fzrq = fzrq;
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
     * @return the companyid
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

    /**
     * @return the dworbm
     */
    public String getDworbm() {
        return dworbm;
    }

    /**
     * @param dworbm the dworbm to set
     */
    public void setDworbm(String dworbm) {
        this.dworbm = dworbm;
    }

    /**
     * @return the dwid
     */
    public String getDwid() {
        return dwid;
    }

    /**
     * @param dwid the dwid to set
     */
    public void setDwid(String dwid) {
        this.dwid = dwid;
    }

    /**
     * @return the sz_pactno
     */
    public String getSz_pactno() {
        return sz_pactno;
    }

    /**
     * @param sz_pactno the sz_pactno to set
     */
    public void setSz_pactno(String sz_pactno) {
        this.sz_pactno = sz_pactno;
    }
}
