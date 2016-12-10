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
public class Special_Job_Card {
    private String card_no;
    private String cert_no;
    private String pid;
    private String name;
    private String sex;
    private String lbcode;
    private String zylb;
    private String xmcode;
    private String zcxm;
    private String firstdate;
    private String valid_begin_date;
    private String valid_end_date;
    private String reviewdate;
    private String companyid;
    private String status;
    private String dwid;
    private String dwname;
    private String bmid;
    private String bmname;
    private String treename;
    private String optuserid;
    private String optusername;
    private String optdate;

    /**
     * @return the card_no
     */
    public String getCard_no() {
        return card_no;
    }

    /**
     * @param card_no the card_no to set
     */
    public void setCard_no(String card_no) {
        this.card_no = card_no;
    }

    /**
     * @return the cert_no
     */
    public String getCert_no() {
        return cert_no;
    }

    /**
     * @param cert_no the cert_no to set
     */
    public void setCert_no(String cert_no) {
        this.cert_no = cert_no;
    }

    /**
     * @return the pid
     */
    public String getPid() {
        return pid;
    }

    /**
     * @param pid the pid to set
     */
    public void setPid(String pid) {
        this.pid = pid;
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
     * @return the zylb
     */
    public String getZylb() {
        return zylb;
    }

    /**
     * @param zylb the zylb to set
     */
    public void setZylb(String zylb) {
        this.zylb = zylb;
    }

    /**
     * @return the zcxm
     */
    public String getZcxm() {
        return zcxm;
    }

    /**
     * @param zcxm the zcxm to set
     */
    public void setZcxm(String zcxm) {
        this.zcxm = zcxm;
    }

    /**
     * @return the firstdate
     */
    public String getFirstdate() {
        return firstdate.split(" ")[0];
    }

    /**
     * @param firstdate the firstdate to set
     */
    public void setFirstdate(String firstdate) {
        this.firstdate = firstdate;
    }

    /**
     * @return the valid_begin_date
     */
    public String getValid_begin_date() {
        return StringUtils.isBlank(valid_begin_date) ? "" : valid_begin_date.split(" ")[0];
    }

    /**
     * @param valid_begin_date the valid_begin_date to set
     */
    public void setValid_begin_date(String valid_begin_date) {
        this.valid_begin_date = valid_begin_date;
    }

    /**
     * @return the valid_end_date
     */
    public String getValid_end_date() {
        return StringUtils.isBlank(valid_end_date) ? "" : valid_end_date.split(" ")[0];
    }

    /**
     * @param valid_end_date the valid_end_date to set
     */
    public void setValid_end_date(String valid_end_date) {
        this.valid_end_date = valid_end_date;
    }

    /**
     * @return the reviewdate
     */
    public String getReviewdate() {
        return StringUtils.isBlank(reviewdate) ? "" : reviewdate.split(" ")[0];
    }

    /**
     * @param reviewdate the reviewdate to set
     */
    public void setReviewdate(String reviewdate) {
        this.reviewdate = reviewdate;
    }

    /**
     * @return the lbcode
     */
    public String getLbcode() {
        return lbcode;
    }

    /**
     * @param lbcode the lbcode to set
     */
    public void setLbcode(String lbcode) {
        this.lbcode = lbcode;
    }

    /**
     * @return the xmcode
     */
    public String getXmcode() {
        return xmcode;
    }

    /**
     * @param xmcode the xmcode to set
     */
    public void setXmcode(String xmcode) {
        this.xmcode = xmcode;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
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
     * @return the dwname
     */
    public String getDwname() {
        return dwname;
    }

    /**
     * @param dwname the dwname to set
     */
    public void setDwname(String dwname) {
        this.dwname = dwname;
    }

    /**
     * @return the bmname
     */
    public String getBmname() {
        return bmname;
    }

    /**
     * @param bmname the bmname to set
     */
    public void setBmname(String bmname) {
        this.bmname = bmname;
    }

    /**
     * @return the treename
     */
    public String getTreename() {
        return treename;
    }

    /**
     * @param treename the treename to set
     */
    public void setTreename(String treename) {
        this.treename = treename;
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
     * @return the bmid
     */
    public String getBmid() {
        return bmid;
    }

    /**
     * @param bmid the bmid to set
     */
    public void setBmid(String bmid) {
        this.bmid = bmid;
    }

    /**
     * @return the optuserid
     */
    public String getOptuserid() {
        return optuserid;
    }

    /**
     * @param optuserid the optuserid to set
     */
    public void setOptuserid(String optuserid) {
        this.optuserid = optuserid;
    }

    /**
     * @return the optusername
     */
    public String getOptusername() {
        return optusername;
    }

    /**
     * @param optusername the optusername to set
     */
    public void setOptusername(String optusername) {
        this.optusername = optusername;
    }

    /**
     * @return the optdate
     */
    public String getOptdate() {
        return StringUtils.isBlank(optdate) ? "" : optdate.split(" ")[0];
    }

    /**
     * @param optdate the optdate to set
     */
    public void setOptdate(String optdate) {
        this.optdate = optdate;
    }
}
