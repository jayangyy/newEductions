/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.eduplans;

import cr.cdrb.web.edu.domains.educlass.EduClass;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jayang
 *
 * 培训主计划类
 *
 */
public class EduPlans {

    //培训类型种子值
    private String traintype;

    public String getTraintype() {
        return traintype;
    }

    public void setTraintype(String traintype) {
        this.traintype = traintype;
    }

    public String getPlan_road() {
        return plan_road;
    }

    public void setPlan_road(String plan_road) {
        this.plan_road = plan_road;
    }

    public String getPlan_road_url() {
        return plan_road_url;
    }

    public void setPlan_road_url(String plan_road_url) {
        this.plan_road_url = plan_road_url;
    }
    //路外培训依据
    private String plan_road;
    //路外培训依据URL
    private String plan_road_url;
    //计划天数
    private int plan_days;

    public int getPlan_days() {
        return plan_days;
    }

    public void setPlan_days(int plan_days) {
        this.plan_days = plan_days;
    }

    public EduPlans() {
        this.educlasses = new ArrayList<EduClass>();
        this.edureviews = new ArrayList<EduReviews>();
    }
    private String add_user;

    public String getAdd_user() {
        return add_user;
    }

    public void setAdd_user(String add_user) {
        this.add_user = add_user;
    }
    /**
     * 培训ID
     */
    private String plan_code;
    /**
     * 计划名称
     */
    private String plan_name;
    /**
     * 培训人数
     */
    private int plan_num;
    /**
     * 培训期数
     */
    private int plan_periods;
    /**
     * 开始日期
     */
    private String plan_sdate;
    /**
     * 结束日期
     */
    private String plan_edate;
    /**
     * 培训对象
     */
    private String plan_object;
    /**
     * 培训内容
     */
    private String plan_cmt;
    /**
     * 培训方式
     */
    private String plan_type;
    /**
     * 承办单位
     */
    private String plan_executeunit;
    /**
     * 主办单位
     */
    private String plan_unit;
    /**
     * 落实情况
     */
    private String plan_situation;
    /**
     * 承办单位ID
     */
    private String plan_execunitid;
    /**
     * 主办单位ID
     */
    private String plan_unitid;
    /**
     * 培训专业系统ID
     */
    private String plan_profid;
    /**
     * 培训专业系统
     */
    private String plan_prof;
    /**
     * 培训类别
     */
    private String plan_class;
    /**
     * 培训审核计划详细
     */
    private List<EduReviews> edureviews;
    /**
     * 培训计划执行状态描述
     */
    private String plan_status_cmt;
    private String plan_highspeed;//高铁标注
    private String plan_abroad;//境（內）外培训标注
    private String plan_gradation;//--培训层次
    private String is_highspeed;//--是否高铁培训
    private String is_personsdb;//--是否人才库人员培训
    private String station_type;//--培训对象类别
    private String station_teaches;//--培训师资
    private String station_channel;//--培训渠道
    private String station_prof;//--培训专业类别
    private String station_line;//--目标线路或项目、工程
    private String plan_other_cmt;//备注
    private BigDecimal total_fees;//预算经费 

    public BigDecimal getTotal_fees() {
        return total_fees;
    }

    public void setTotal_fees(BigDecimal total_fees) {
        this.total_fees = total_fees;
    }

    public String getFees_ways() {
        return fees_ways;
    }

    public void setFees_ways(String fees_ways) {
        this.fees_ways = fees_ways;
    }

    private String fees_ways;//结算方式
    private String plans_post_type;//培训费用类别

    public String getPlans_post_type() {
        return plans_post_type;
    }

    public void setPlans_post_type(String plans_post_type) {
        this.plans_post_type = plans_post_type;
    }

    public String getPlan_other_cmt() {
        return plan_other_cmt;
    }

    public void setPlan_other_cmt(String plan_other_cmt) {
        this.plan_other_cmt = plan_other_cmt;
    }

    public String getIs_highspeed() {
        return is_highspeed;
    }

    public void setIs_highspeed(String is_highspeed) {
        this.is_highspeed = is_highspeed;
    }

    public String getIs_personsdb() {
        return is_personsdb;
    }

    public void setIs_personsdb(String is_personsdb) {
        this.is_personsdb = is_personsdb;
    }

    public String getStation_type() {
        return station_type;
    }

    public void setStation_type(String station_type) {
        this.station_type = station_type;
    }

    public String getStation_teaches() {
        return station_teaches;
    }

    public void setStation_teaches(String station_teaches) {
        this.station_teaches = station_teaches;
    }

    public String getStation_channel() {
        return station_channel;
    }

    public void setStation_channel(String station_channel) {
        this.station_channel = station_channel;
    }

    public String getStation_prof() {
        return station_prof;
    }

    public void setStation_prof(String station_prof) {
        this.station_prof = station_prof;
    }

    public String getStation_line() {
        return station_line;
    }

    public void setStation_line(String station_line) {
        this.station_line = station_line;
    }

    public String getPlan_highspeed() {
        return plan_highspeed;
    }

    public void setPlan_highspeed(String plan_highspeed) {
        this.plan_highspeed = plan_highspeed;
    }

    public String getPlan_abroad() {
        return plan_abroad;
    }

    public void setPlan_abroad(String plan_abroad) {
        this.plan_abroad = plan_abroad;
    }

    public String getPlan_gradation() {
        return plan_gradation;
    }

    public void setPlan_gradation(String plan_gradation) {
        this.plan_gradation = plan_gradation;
    }

    public String getPlan_soc_type() {
        return plan_soc_type;
    }

    public void setPlan_soc_type(String plan_soc_type) {
        this.plan_soc_type = plan_soc_type;
    }
    private String plan_soc_type;//--培训分类（干部培训）

    public String getPlan_status_cmt() {
        return plan_status_cmt;
    }

    public void setPlan_status_cmt(String plan_status_cmt) {
        this.plan_status_cmt = plan_status_cmt;
    }

    public int getPlan_status() {
        return plan_status;
    }

    public void setPlan_status(int plan_status) {
        this.plan_status = plan_status;
    }
    private int plan_status;

    public String getPlan_code() {
        return plan_code;
    }

    public void setPlan_code(String plan_code) {
        this.plan_code = plan_code;
    }

    public String getPlan_name() {
        return plan_name;
    }

    public void setPlan_name(String plan_name) {
        this.plan_name = plan_name;
    }

    public int getPlan_num() {
        return plan_num;
    }

    public void setPlan_num(int plan_num) {
        this.plan_num = plan_num;
    }

    public int getPlan_periods() {
        return plan_periods;
    }

    public void setPlan_periods(int plan_periods) {
        this.plan_periods = plan_periods;
    }

    public String getPlan_sdate() {
        return plan_sdate;
    }

    public void setPlan_sdate(String plan_sdate) {
        this.plan_sdate = plan_sdate;
    }

    public String getPlan_edate() {
        return plan_edate;
    }

    public void setPlan_edate(String plan_edate) {
        this.plan_edate = plan_edate;
    }

    public String getPlan_object() {
        return plan_object;
    }

    public void setPlan_object(String plan_object) {
        this.plan_object = plan_object;
    }

    public String getPlan_cmt() {
        return plan_cmt;
    }

    public void setPlan_cmt(String plan_cmt) {
        this.plan_cmt = plan_cmt;
    }

    public String getPlan_type() {
        return plan_type;
    }

    public void setPlan_type(String plan_type) {
        this.plan_type = plan_type;
    }

    public String getPlan_executeunit() {
        return plan_executeunit;
    }

    public void setPlan_executeunit(String plan_executeunit) {
        this.plan_executeunit = plan_executeunit;
    }

    public String getPlan_unit() {
        return plan_unit;
    }

    public void setPlan_unit(String plan_unit) {
        this.plan_unit = plan_unit;
    }

    public String getPlan_situation() {
        return plan_situation;
    }

    public void setPlan_situation(String plan_situation) {
        this.plan_situation = plan_situation;
    }

    public String getPlan_execunitid() {
        return plan_execunitid;
    }

    public void setPlan_execunitid(String plan_execunitid) {
        this.plan_execunitid = plan_execunitid;
    }

    public String getPlan_unitid() {
        return plan_unitid;
    }

    public void setPlan_unitid(String plan_unitid) {
        this.plan_unitid = plan_unitid;
    }

    public String getPlan_profid() {
        return plan_profid;
    }

    public void setPlan_profid(String plan_profid) {
        this.plan_profid = plan_profid;
    }

    public String getPlan_prof() {
        return plan_prof;
    }

    public void setPlan_prof(String plan_prof) {
        this.plan_prof = plan_prof;
    }

    public String getPlan_class() {
        return plan_class;
    }

    public void setPlan_class(String plan_class) {
        this.plan_class = plan_class;
    }

    public List<EduReviews> getEdureviews() {
        return edureviews;
    }

    public void setEdureviews(List<EduReviews> edureviews) {
        this.edureviews = edureviews;
    }

    public List<EduClass> getEduclasses() {
        return educlasses;
    }

    public void setEduclasses(List<EduClass> educlasses) {
        this.educlasses = educlasses;
    }
    /**
     * 培训班级
     */
    private List<EduClass> educlasses;
    private List<EduPlanTransfer> plantranfers;

    public List<EduPlanTransfer> getPlantranfers() {
        return plantranfers;
    }

    public void setPlantranfers(List<EduPlanTransfer> plantranfers) {
        this.plantranfers = plantranfers;
    }
    //财务审核后预算费用总额
    private BigDecimal end_total_fees;

    public BigDecimal getEnd_total_fees() {
        return end_total_fees;
    }

    public void setEnd_total_fees(BigDecimal end_total_fees) {
        this.end_total_fees = end_total_fees;
    }
    ///培训地点
    private String plan_address;
    //计划类别 0 年度计划，1:临时计划（需要局领导签字）,2.调整计划（需要局领导签字）)
    private String is_yearplan;
    //培训类别，0，适应性培训1资格性培训
    private int plan_card_type;

    public int getPlan_card_type() {
        return plan_card_type;
    }

    public void setPlan_card_type(int plan_card_type) {
        this.plan_card_type = plan_card_type;
    }

    public int getPlan_old_code() {
        return plan_old_code;
    }

    public void setPlan_old_code(int plan_old_code) {
        this.plan_old_code = plan_old_code;
    }
//调整计划关联计划号
    private int plan_old_code;

    public String getPlan_address() {
        return plan_address;
    }

    public void setPlan_address(String plan_address) {
        this.plan_address = plan_address;
    }

    public String getIs_yearplan() {
        return is_yearplan;
    }

    public void setIs_yearplan(String is_yearplan) {
        this.is_yearplan = is_yearplan;
    }
    private List<StationPersons> stas;

    public List<StationPersons> getStas() {
        return stas;
    }

    public void setStas(List<StationPersons> stas) {
        this.stas = stas;
    }

}
