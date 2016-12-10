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
public class StationPersons {

    private String station_code;
//站段/单位名称
    private String station_name;
    //站段/单位ID
    private String station_Id;
    //提报描述，备注
    private String station_cmt;
    //计划ID
    private String plan_code;
    //提报人数
    private int station_num;
    //计划名称
    private String plan_name;
    //计划添加人
    private String add_user;
    public String getAdd_username() {
        return add_username;
    }

    public void setAdd_username(String add_username) {
        this.add_username = add_username;
    }
    //添加人姓名
    private String  add_username;

    public String getAdd_user() {
        return add_user;
    }

    public void setAdd_user(String add_user) {
        this.add_user = add_user;
    }

    public String getPlan_name() {
        return plan_name;
    }

    public void setPlan_name(String plan_name) {
        this.plan_name = plan_name;
    }

    public String getStation_code() {
        return station_code;
    }

    public void setStation_code(String station_code) {
        this.station_code = station_code;
    }

    public String getStation_name() {
        return station_name;
    }

    public void setStation_name(String station_name) {
        this.station_name = station_name;
    }

    public String getStation_Id() {
        return station_Id;
    }

    public void setStation_Id(String station_Id) {
        this.station_Id = station_Id;
    }

    public String getStation_cmt() {
        return station_cmt;
    }

    public void setStation_cmt(String station_cmt) {
        this.station_cmt = station_cmt;
    }

    public String getPlan_code() {
        return plan_code;
    }

    public void setPlan_code(String plan_code) {
        this.plan_code = plan_code;
    }

    public int getStation_num() {
        return station_num;
    }

    public void setStation_num(int station_num) {
        this.station_num = station_num;
    }

}
