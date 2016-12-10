/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.GroupsRole;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IGroupsService {

    /**
     *
     * 新增用户组
     *
     * @param group
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel addGroup(Groups group) throws SQLException;

    /**
     *
     * 更新用户组
     *
     * @param group
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel updateGroup(Groups group) throws SQLException;

    public DataModel removeGroup(String groupids) throws SQLException;

    public Groups getGroupsById(int groupid) throws SQLException;

    public List<Groups> getAllGroups(Object... groupids) throws SQLException;

    public DataModel getGroupsPage(QueryModel pageModel) throws Throwable;

    public List<GroupsRole> getGroupsRole(int groupid) throws SQLException;

    /**
     *
     * 获取用户组-角色树模型
     *
     * @param groupid
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public List<ComboTree> getGroupsRoleTree(int groupid) throws SQLException;

    /**
     *
     * 更新用户组-角色关系
     *
     * @param groupsRole
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel updateGroupsRole(List<GroupsRole> groupsRole,int groupid) throws SQLException;

}
