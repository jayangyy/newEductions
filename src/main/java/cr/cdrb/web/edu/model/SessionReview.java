/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

import java.util.Date;

/**
 *
 * @author Jayang
 */
public class SessionReview {

    ///总用户个数
    private String totalCount;
    private String lastquest;

    public String getLastquest() {
        return lastquest;
    }

    public void setLastquest(String lastquest) {
        this.lastquest = lastquest;
    }

    public String getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }
    private String name;
    //存活SESSION 个数
    private String sessionCount;

    public String getSessionCount() {
        return sessionCount;
    }

    public void setSessionCount(String sessionCount) {
        this.sessionCount = sessionCount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    private String value;

}
