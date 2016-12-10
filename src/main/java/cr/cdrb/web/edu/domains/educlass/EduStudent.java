/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.educlass;

import java.util.Date;

/**
 *
 * 报名及成绩
 * @author Jayang
 */
public class EduStudent {

    private String id;
    //名字
    private String stu_name;
    //性别
    private String stu_sex;
    //身份证号码
    private String stu_idcard;
    //培训班编号
    private String class_no;
    //单位
    private String stu_unit;
    //部门
    private String stu_dep;
    //原职位
    private String stu_oldjob;
    //学习职位
    private String stu_curjob;
    //理论成绩，老表为字符串
    private String stu_phy_points;
    //理论成绩查看URL
    private String stu_phy_url;
    //实作成绩
    private String stu_prac_points;
    //实作成绩URL
    private String stu_prac_url;
    //安全成绩
    private String stu_sec_points;
    //安全成绩查看URL
    private String stu_sec_url;
    //安全成绩补强成绩
    private String stu_bsec_points;
    //安全成绩补强查看URL
    private String stu_bsec_url;
    //发证日期
    private Date stu_cer_date;
    //证书编号
    private String stu_cer_no;
    //下令日期
    private Date stu_order_date;
    //令号
    private String stu_order_no;
    //理论补强成绩
    private String stu_bphy_points;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStu_name() {
        return stu_name;
    }

    public void setStu_name(String stu_name) {
        this.stu_name = stu_name;
    }

    public String getStu_sex() {
        return stu_sex;
    }

    public void setStu_sex(String stu_sex) {
        this.stu_sex = stu_sex;
    }

    public String getStu_idcard() {
        return stu_idcard;
    }

    public void setStu_idcard(String stu_idcard) {
        this.stu_idcard = stu_idcard;
    }

    public String getClass_no() {
        return class_no;
    }

    public void setClass_no(String class_no) {
        this.class_no = class_no;
    }

    public String getStu_unit() {
        return stu_unit;
    }

    public void setStu_unit(String stu_unit) {
        this.stu_unit = stu_unit;
    }

    public String getStu_dep() {
        return stu_dep;
    }

    public void setStu_dep(String stu_dep) {
        this.stu_dep = stu_dep;
    }

    public String getStu_oldjob() {
        return stu_oldjob;
    }

    public void setStu_oldjob(String stu_oldjob) {
        this.stu_oldjob = stu_oldjob;
    }

    public String getStu_curjob() {
        return stu_curjob;
    }

    public void setStu_curjob(String stu_curjob) {
        this.stu_curjob = stu_curjob;
    }

    public String getStu_phy_points() {
        return stu_phy_points;
    }

    public void setStu_phy_points(String stu_phy_points) {
        this.stu_phy_points = stu_phy_points;
    }

    public String getStu_phy_url() {
        return stu_phy_url;
    }

    public void setStu_phy_url(String stu_phy_url) {
        this.stu_phy_url = stu_phy_url;
    }

    public String getStu_prac_points() {
        return stu_prac_points;
    }

    public void setStu_prac_points(String stu_prac_points) {
        this.stu_prac_points = stu_prac_points;
    }

    public String getStu_prac_url() {
        return stu_prac_url;
    }

    public void setStu_prac_url(String stu_prac_url) {
        this.stu_prac_url = stu_prac_url;
    }

    public String getStu_sec_points() {
        return stu_sec_points;
    }

    public void setStu_sec_points(String stu_sec_points) {
        this.stu_sec_points = stu_sec_points;
    }

    public String getStu_sec_url() {
        return stu_sec_url;
    }

    public void setStu_sec_url(String stu_sec_url) {
        this.stu_sec_url = stu_sec_url;
    }

    public String getStu_bsec_points() {
        return stu_bsec_points;
    }

    public void setStu_bsec_points(String stu_bsec_points) {
        this.stu_bsec_points = stu_bsec_points;
    }

    public String getStu_bsec_url() {
        return stu_bsec_url;
    }

    public void setStu_bsec_url(String stu_bsec_url) {
        this.stu_bsec_url = stu_bsec_url;
    }

    public Date getStu_cer_date() {
        return stu_cer_date;
    }

    public void setStu_cer_date(Date stu_cer_date) {
        this.stu_cer_date = stu_cer_date;
    }

    public String getStu_cer_no() {
        return stu_cer_no;
    }

    public void setStu_cer_no(String stu_cer_no) {
        this.stu_cer_no = stu_cer_no;
    }

    public Date getStu_order_date() {
        return stu_order_date;
    }

    public void setStu_order_date(Date stu_order_date) {
        this.stu_order_date = stu_order_date;
    }

    public String getStu_order_no() {
        return stu_order_no;
    }

    public void setStu_order_no(String stu_order_no) {
        this.stu_order_no = stu_order_no;
    }

    public String getStu_bphy_points() {
        return stu_bphy_points;
    }

    public void setStu_bphy_points(String stu_bphy_points) {
        this.stu_bphy_points = stu_bphy_points;
    }

}
