/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.eduplans;

/**
 *
 * @author Jayang
 */
public class EduPlanTransfer {

    private int trans_status;
    private String transfer_url;
    private String transfer_from_unitid;
    private String transfer_from_unit;
    private String cost_id;

    public String getCost_id() {
        return cost_id;
    }

    public void setCost_id(String cost_id) {
        this.cost_id = cost_id;
    }

    public String getTransfer_from_unitid() {
        return transfer_from_unitid;
    }

    public void setTransfer_from_unitid(String transfer_from_unitid) {
        this.transfer_from_unitid = transfer_from_unitid;
    }

    public String getTransfer_from_unit() {
        return transfer_from_unit;
    }

    public void setTransfer_from_unit(String transfer_from_unit) {
        this.transfer_from_unit = transfer_from_unit;
    }

    public String getTransfer_url() {
        return transfer_url;
    }

    public void setTransfer_url(String transfer_url) {
        this.transfer_url = transfer_url;
    }

    public String getTrans_status_cmt() {
        return trans_status_cmt;
    }

    public void setTrans_status_cmt(String trans_status_cmt) {
        this.trans_status_cmt = trans_status_cmt;
    }
    private String trans_status_cmt;

    public int getTrans_status() {
        return trans_status;
    }

    public void setTrans_status(int trans_status) {
        this.trans_status = trans_status;
    }
    /**
     *
     * 主键
     */
    private String transfer_code;

    /**
     *
     * 计划ID
     */
    private String plan_code;

    /**
     *
     * 操作人
     */
    private String transfer_from_user;

    public String getTransfer_code() {
        return transfer_code;
    }

    public void setTransfer_code(String transfer_code) {
        this.transfer_code = transfer_code;
    }

    public String getPlan_code() {
        return plan_code;
    }

    public void setPlan_code(String plan_code) {
        this.plan_code = plan_code;
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

    public String getTransfer_to_user() {
        return transfer_to_user;
    }

    public void setTransfer_to_user(String transfer_to_user) {
        this.transfer_to_user = transfer_to_user;
    }

    public String getTransfer_to_idcard() {
        return transfer_to_idcard;
    }

    public void setTransfer_to_idcard(String transfer_to_idcard) {
        this.transfer_to_idcard = transfer_to_idcard;
    }

    public String getTransfer_to_unit() {
        return transfer_to_unit;
    }

    public void setTransfer_to_unit(String transfer_to_unit) {
        this.transfer_to_unit = transfer_to_unit;
    }

    public String getTransfer_to_uid() {
        return transfer_to_uid;
    }

    public void setTransfer_to_uid(String transfer_to_uid) {
        this.transfer_to_uid = transfer_to_uid;
    }

    public String getTransfer_date() {
        return transfer_date;
    }

    public void setTransfer_date(String transfer_date) {
        this.transfer_date = transfer_date;
    }

    /**
     *
     * 操作人身份证
     */
    private String transfer_from_idcard;

    /**
     *
     * 移送抄送人
     */
    private String transfer_to_user;

    /**
     *
     * 移送抄送人身份证
     */
    private String transfer_to_idcard;

    /**
     *
     * 移送单位
     */
    private String transfer_to_unit;

    /**
     *
     * 移送单位ID
     */
    private String transfer_to_uid;

    /**
     *
     * 移送日期 时间戳
     */
    private String transfer_date;
}
