/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

/**
 *
 * @author milord
 */
public class Special_Job_Type {
    private String code;
    private String name;
    private String parentcode;

    /**
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * @param code the code to set
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the parentcode
     */
    public String getParentcode() {
        return parentcode;
    }

    /**
     * @param parentcode the parentcode to set
     */
    public void setParentcode(String parentcode) {
        this.parentcode = parentcode;
    }
}
