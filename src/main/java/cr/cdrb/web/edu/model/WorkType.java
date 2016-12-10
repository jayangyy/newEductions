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
public class WorkType {
    private String id;
    private String name;
    private String systemid;
    private String type;
    private String dwnum;

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
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
     * @return the systemid
     */
    public String getSystemid() {
        return systemid;
    }

    /**
     * @param systemid the systemid to set
     */
    public void setSystemid(String systemid) {
        this.systemid = systemid;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return the dwnum
     */
    public String getDwnum() {
        return dwnum;
    }

    /**
     * @param dwnum the dwnum to set
     */
    public void setDwnum(String dwnum) {
        this.dwnum = dwnum;
    }
}
