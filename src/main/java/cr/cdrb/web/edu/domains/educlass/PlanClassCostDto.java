/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.educlass;

import cr.cdrb.web.edu.domains.eduplans.EduPlanCost;

/**
 *
 * @author Jayang
 */
public class PlanClassCostDto extends EduPlanCost {

    public String getPlan_unit() {
        return plan_unit;
    }

    public void setPlan_unit(String plan_unit) {
        this.plan_unit = plan_unit;
    }

    public String getPlan_unitid() {
        return plan_unitid;
    }

    public void setPlan_unitid(String plan_unitid) {
        this.plan_unitid = plan_unitid;
    }

    public String getPlan_type() {
        return plan_type;
    }

    public void setPlan_type(String plan_type) {
        this.plan_type = plan_type;
    }

    public String getPlan_object() {
        return plan_object;
    }

    public void setPlan_object(String plan_object) {
        this.plan_object = plan_object;
    }

    public String getPlan_name() {
        return plan_name;
    }

    public void setPlan_name(String plan_name) {
        this.plan_name = plan_name;
    }

    public String getPlan_prof() {
        return plan_prof;
    }

    public void setPlan_prof(String plan_prof) {
        this.plan_prof = plan_prof;
    }

    public String getRefdoc() {
        return refdoc;
    }

    public void setRefdoc(String refdoc) {
        this.refdoc = refdoc;
    }

    public String getPlan_execunitid() {
        return plan_execunitid;
    }

    public void setPlan_execunitid(String plan_execunitid) {
        this.plan_execunitid = plan_execunitid;
    }

    public String getPlan_executeunit() {
        return plan_executeunit;
    }

    public void setPlan_executeunit(String plan_executeunit) {
        this.plan_executeunit = plan_executeunit;
    }

    public String getPlan_road_url() {
        return plan_road_url;
    }

    public void setPlan_road_url(String plan_road_url) {
        this.plan_road_url = plan_road_url;
    }

    public String getPlan_road() {
        return plan_road;
    }

    public void setPlan_road(String plan_road) {
        this.plan_road = plan_road;
    }
    private String plan_unit;
    private String plan_unitid;
    private String plan_type;
    private String plan_object;
    private String plan_name;
    private String plan_prof;
    private String refdoc;
    private String plan_execunitid;
    private String plan_executeunit;
    private String plan_road_url;

    private String plan_road;
}
