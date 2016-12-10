/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.eduplans;

import java.util.Date;

/**
 *
 * @author Jayang
 *
 * 培训审核流程类
 */
public class EduReviews {

    /**
     * --审核ID
     */
    private String review_dcode;
    private Date review_date;
    private String current_unit;
    private String transfer_from_user;
    private String transfer_code;
    private String cost_id;

    public String getCost_id() {
        return cost_id;
    }

    public void setCost_id(String cost_id) {
        this.cost_id = cost_id;
    }

    public String getTransfer_code() {
        return transfer_code;
    }

    public void setTransfer_code(String transfer_code) {
        this.transfer_code = transfer_code;
    }

    public String getTransfer_from_user() {
        return transfer_from_user;
    }

    public void setTransfer_from_user(String transfer_from_user) {
        this.transfer_from_user = transfer_from_user;
    }

    public String getTransfer_from_idcard() {
        return transfer_from_idcard;
    }

    public void setTransfer_from_idcard(String transfer_from_idcard) {
        this.transfer_from_idcard = transfer_from_idcard;
    }
    private String transfer_from_idcard;
    /**
     * 移送人身份证
     */
    private String review_to_idcard;

    public String getReview_to_idcard() {
        return review_to_idcard;
    }

    public void setReview_to_idcard(String review_to_idcard) {
        this.review_to_idcard = review_to_idcard;
    }

    public String getReview_to_user() {
        return review_to_user;
    }

    public void setReview_to_user(String review_to_user) {
        this.review_to_user = review_to_user;
    }

    /**
     * 移送到具体人
     */
    private String review_to_user;

    public String getCurrent_unit() {
        return current_unit;
    }

    public void setCurrent_unit(String current_unit) {
        this.current_unit = current_unit;
    }

    public String getCurrent_unitid() {
        return current_unitid;
    }

    public void setCurrent_unitid(String current_unitid) {
        this.current_unitid = current_unitid;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }
    private String current_unitid;
    private String idcard;

    public Date getReview_date() {
        return review_date;
    }

    public void setReview_date(Date review_date) {
        this.review_date = review_date;
    }

    public String getReview_dcode() {
        return review_dcode;
    }

    public void setReview_dcode(String review_dcode) {
        this.review_dcode = review_dcode;
    }

    public String getPlan_code() {
        return plan_code;
    }

    public void setPlan_code(String plan_code) {
        this.plan_code = plan_code;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }

    public int getReview_status() {
        return review_status;
    }

    public void setReview_status(int review_status) {
        this.review_status = review_status;
    }

    public String getReview_cmt() {
        return review_cmt;
    }

    public void setReview_cmt(String review_cmt) {
        this.review_cmt = review_cmt;
    }

    public String getReview_url() {
        return review_url;
    }

    public void setReview_url(String review_url) {
        this.review_url = review_url;
    }
    /**
     * --计划ID
     */
    private String plan_code;
    /**
     * --审核人
     */
    private String reviewer;
    /**
     * --审核状态
     */
    private int review_status;
    /**
     * --审核备注
     */
    private String review_cmt;
    /**
     * --审核附件地址
     */
    private String review_url;
    /**
     * 培训计划执行状态描述
     */
    private String plan_status_cmt;
    /**
     * 培训计划执行状态描述
     */
    private String plan_status;

    public String getPlan_status() {
        return plan_status;
    }

    public void setPlan_status(String plan_status) {
        this.plan_status = plan_status;
    }
    public String getPlan_status_cmt() {
        return plan_status_cmt;
    }

    public void setPlan_status_cmt(String plan_status_cmt) {
        this.plan_status_cmt = plan_status_cmt;
    }
}
