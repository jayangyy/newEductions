/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.GroupsRole;
import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Role;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IRoleDao {

    public Boolean addRole(Role role) throws SQLException;

    public Role getRole(int roleid) throws SQLException;

    public Boolean updateRole(Role role) throws SQLException;

    public Boolean removeRole(int roleid) throws SQLException;

    public Map<Integer, List<Role>> getResourcesPagging(QueryModel pageModel) throws Throwable;

    public List<Role> getRoles(String... roleids) throws SQLException;

    /**
     *
     * 获取该角色拥有权限资源
     */
    public List<ResRole> getResRoels(int roleid) throws SQLException;

    public Boolean updateResRoles(List<ResRole> resRoles,int roleid) throws SQLException;

    public List<Role> getGroupsRole(int groupid) throws SQLException;
    public List<Role> getUsersRole(String username) throws SQLException;
}
