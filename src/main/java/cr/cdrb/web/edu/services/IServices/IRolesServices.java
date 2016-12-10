/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Role;
import java.util.List;

/**
 *
 * @author Jayang
 */
public interface IRolesServices {

    public DataModel AddRole(Role role) throws Throwable;

    public DataModel UpdateRole(Role role) throws Throwable;

    public Role GetRole(int roleid) throws Throwable;

    public DataModel DeleteRole(int roleid) throws Throwable;

    public DataModel GetRolesPagging(QueryModel model) throws Throwable;

    /**
     *
     * 获取当前角色权限树形（带选中）
     */
    public List<ComboTree> GetResRolesTree(int roleid) throws Throwable;

    public List<ComboTree> GetRolesTree(int roleid) throws Throwable;

    public DataModel UpdateRoelsTree(Role role) throws Throwable;
    public DataModel UpdateResRoels(List<ResRole> resRoles,int roleid) throws Throwable;
}
