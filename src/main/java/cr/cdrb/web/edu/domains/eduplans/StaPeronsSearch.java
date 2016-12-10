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
public class StaPeronsSearch extends QueryModel {

    ///站段名称
    private String sta_unit;
    private String planname;

    public String getPlanname() {
        return planname;
    }

    public void setPlanname(String planname) {
        this.planname = planname;
    }

    public String getSta_unit() {
        return sta_unit;
    }

    public void setSta_unit(String sta_unit) {
        this.sta_unit = sta_unit;
    }
}
