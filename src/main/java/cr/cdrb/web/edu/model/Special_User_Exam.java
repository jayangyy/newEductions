/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

import org.apache.commons.lang3.StringUtils;

/**
 *
 * @author milord
 */
public class Special_User_Exam {
    private Integer id;
    private String pid;
    private String equipment_code;
    private String equipment_name;
    private String valid_begin_date;
    private String valid_end_date;
    private String hand_uesr;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the pid
     */
    public String getPid() {
        return pid;
    }

    /**
     * @param pid the pid to set
     */
    public void setPid(String pid) {
        this.pid = pid;
    }

    /**
     * @return the equipment_code
     */
    public String getEquipment_code() {
        return equipment_code;
    }

    /**
     * @param equipment_code the equipment_code to set
     */
    public void setEquipment_code(String equipment_code) {
        this.equipment_code = equipment_code;
    }

    /**
     * @return the valid_begin_date
     */
    public String getValid_begin_date() {
        return StringUtils.isBlank(valid_begin_date) ? "" : valid_begin_date.split(" ")[0];
    }

    /**
     * @param valid_begin_date the valid_begin_date to set
     */
    public void setValid_begin_date(String valid_begin_date) {
        this.valid_begin_date = valid_begin_date;
    }

    /**
     * @return the valid_end_date
     */
    public String getValid_end_date() {
        return StringUtils.isBlank(valid_end_date) ? "" : valid_end_date.split(" ")[0];
    }

    /**
     * @param valid_end_date the valid_end_date to set
     */
    public void setValid_end_date(String valid_end_date) {
        this.valid_end_date = valid_end_date;
    }

    /**
     * @return the hand_uesr
     */
    public String getHand_uesr() {
        return hand_uesr;
    }

    /**
     * @param hand_uesr the hand_uesr to set
     */
    public void setHand_uesr(String hand_uesr) {
        this.hand_uesr = hand_uesr;
    }

    /**
     * @return the equipment_name
     */
    public String getEquipment_name() {
        return equipment_name;
    }

    /**
     * @param equipment_name the equipment_name to set
     */
    public void setEquipment_name(String equipment_name) {
        this.equipment_name = equipment_name;
    }
}
