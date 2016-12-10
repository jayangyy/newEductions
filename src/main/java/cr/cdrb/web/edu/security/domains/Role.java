/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security.domains;

import java.util.List;

/**
 *
 * @author Jayang
 */
public class Role implements java.io.Serializable {

    /**
     *
     * 角色名称
     */
    private String rolename;
    /**
     *
     * 角色名称描述
     */
    private String rolecmt;
    /**
     *
     * 角色ID
     */
    private Integer roleid;
    /**
     *
     * 下发角色1,2,3,4F
     */
    private String rolesdown;
    /**
     *
     * 角色权限
     */
    private List<ResRole> res_roles;

    public String getRolesdown() {
        return rolesdown;
    }

    public void setRolesdown(String rolesdown) {
        this.rolesdown = rolesdown;
    }

    public List<ResRole> getRes_roles() {
        return res_roles;
    }

    public void setRes_roles(List<ResRole> res_roles) {
        this.res_roles = res_roles;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getRolecmt() {
        return rolecmt;
    }

    public void setRolecmt(String rolecmt) {
        this.rolecmt = rolecmt;
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }
}
