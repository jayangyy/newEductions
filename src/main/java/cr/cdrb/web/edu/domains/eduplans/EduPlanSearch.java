/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.eduplans;

import cr.cdrb.web.edu.domains.easyui.QueryModel;

/**
 *
 * @author Jayang
 */
public class EduPlanSearch extends QueryModel {

    private String reviewstatus;
    //拟稿人
    private String adduser;

    public String getAdduser() {
        return adduser;
    }

    public void setAdduser(String adduser) {
        this.adduser = adduser;
    }

    public int getTrans_status() {
        return trans_status;
    }

    public void setTrans_status(int trans_status) {
        this.trans_status = trans_status;
    }
    private String sreviewstatus;
    private int isAuth;
    private int isCompany;
    private String current_unit;
    private int trans_status;
    // 是否包含移送计划
    private int if_union;

    public int getIf_union() {
        return if_union;
    }

    public void setIf_union(int if_union) {
        this.if_union = if_union;
    }
    //移送单位
    private String to_unit;

    public String getTo_unit() {
        return to_unit;
    }

    public void setTo_unit(String to_unit) {
        this.to_unit = to_unit;
    }

    public String getTo_user() {
        return to_user;
    }

    public void setTo_user(String to_user) {
        this.to_user = to_user;
    }

    public String getTo_idcard() {
        return to_idcard;
    }

    public void setTo_idcard(String to_idcard) {
        this.to_idcard = to_idcard;
    }

    public String getTo_uid() {
        return to_uid;
    }

    public void setTo_uid(String to_uid) {
        this.to_uid = to_uid;
    }
    //移送人
    private String to_user;
    //移送人身份证
    private String to_idcard;
    //移送人单位
    private String to_uid;

    public String getCurrent_unit() {
        return current_unit;
    }

    public void setCurrent_unit(String current_unit) {
        this.current_unit = current_unit;
    }

    public int getIsCompany() {
        return isCompany;
    }

    public void setIsCompany(int isCompany) {
        this.isCompany = isCompany;
    }

    public int getIsAuth() {
        return isAuth;
    }

    public void setIsAuth(int isAuth) {
        this.isAuth = isAuth;
    }

    public String getSreviewstatus() {
        return sreviewstatus;
    }

    public void setSreviewstatus(String sreviewstatus) {
        this.sreviewstatus = sreviewstatus;
    }

    public String getReviewstatus() {
        return reviewstatus;
    }

    public void setReviewstatus(String reviewstatus) {
        this.reviewstatus = reviewstatus;
    }

    public String getPlan_mainid() {
        return plan_mainid;
    }

    public void setPlan_mainid(String plan_mainid) {
        this.plan_mainid = plan_mainid;
    }

    public String getPlan_execid() {
        return plan_execid;
    }

    public void setPlan_execid(String plan_execid) {
        this.plan_execid = plan_execid;
    }

    public String getPlanname() {
        return planname;
    }

    public void setPlanname(String planname) {
        this.planname = planname;
    }
    private String plan_mainid;
    private String plan_execid;
    private String planname;
}
