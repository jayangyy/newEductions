/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.eduplans;

import java.math.BigDecimal;

/**
 *
 * @author Jayang
 * @see 教师讲课费用明细
 */
public class EduTeachFees {

    //主键
    private String teach_fee_id;
    //外键
    private String cost_id;
    //教师等级描述
    private String teach_cmt;
    //人。场单价
    private BigDecimal teach_fee;
    //数量
    private int teach_num;
    //总费用
    private BigDecimal teach_fees;
    //审核人，场均价
    private BigDecimal auth_teach_fee;
    //数量
    private int auth_teach_num;
    //总费用
    private BigDecimal auth_teach_fees;
    //是否兼职教师
    private Boolean is_outer_teacher;

    public String getTeach_fee_id() {
        return teach_fee_id;
    }

    public void setTeach_fee_id(String teach_fee_id) {
        this.teach_fee_id = teach_fee_id;
    }

    public String getCost_id() {
        return cost_id;
    }

    public void setCost_id(String cost_id) {
        this.cost_id = cost_id;
    }

    public String getTeach_cmt() {
        return teach_cmt;
    }

    public void setTeach_cmt(String teach_cmt) {
        this.teach_cmt = teach_cmt;
    }

    public BigDecimal getTeach_fee() {
        return teach_fee;
    }

    public void setTeach_fee(BigDecimal teach_fee) {
        this.teach_fee = teach_fee;
    }

    public int getTeach_num() {
        return teach_num;
    }

    public void setTeach_num(int teach_num) {
        this.teach_num = teach_num;
    }

    public BigDecimal getTeach_fees() {
        return teach_fees;
    }

    public void setTeach_fees(BigDecimal teach_fees) {
        this.teach_fees = teach_fees;
    }

    public BigDecimal getAuth_teach_fee() {
        return auth_teach_fee;
    }

    public void setAuth_teach_fee(BigDecimal auth_teach_fee) {
        this.auth_teach_fee = auth_teach_fee;
    }

    public int getAuth_teach_num() {
        return auth_teach_num;
    }

    public void setAuth_teach_num(int auth_teach_num) {
        this.auth_teach_num = auth_teach_num;
    }

    public BigDecimal getAuth_teach_fees() {
        return auth_teach_fees;
    }

    public void setAuth_teach_fees(BigDecimal auth_teach_fees) {
        this.auth_teach_fees = auth_teach_fees;
    }

    public Boolean getIs_outer_teacher() {
        return is_outer_teacher;
    }

    public void setIs_outer_teacher(Boolean is_outer_teacher) {
        this.is_outer_teacher = is_outer_teacher;
    }

}
