/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.GroupsRole;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IGroups {

    /**
     *
     * 增加用户组
     *
     * @param group 用户名
     * @return TRUE/FALSE
     * @throws java.sql.SQLException
     */
    public Boolean addGroup(Groups group) throws SQLException;

    /**
     *
     * 批量删除用户组
     *
     * @param groupids 用户组ID集合
     * @return TRUE/FALSE
     * @throws java.sql.SQLException
     */
    public Boolean deleteGroup(String groupids) throws SQLException;

    /**
     *
     * 更新用户组
     *
     * @param group 用户组对象
     * @return TRUE/FALSE
     * @throws java.sql.SQLException
     */
    public Boolean updateGroup(Groups group) throws SQLException;

    /**
     *
     * 获取单个用户组
     *
     * @param groupid 用户组ID
     * @return 用户组 Groups
     * @throws java.sql.SQLException
     */
    public Groups getGroupById(int groupid) throws SQLException;

    /**
     *
     * 获取用户组列表，（可更具角色ID获取）
     *
     * @param roleid 角色ID
     * @return 用户组集合
     * @throws java.sql.SQLException
     */
    public List<Groups> getAllGroups(Object... roleid) throws SQLException ;
/**
     *
     * 获取用户组分页列表
     *
     * @param pageModel 分页通用模型
     * @return 用户组分页MAP
     * @throws java.sql.SQLException
     */
    public Map<Integer, List<Groups>> getGroupsPage(QueryModel pageModel) throws Throwable;
/**
     *
     * 更新 用户组-角色 关系
     *
     * @param groupsRole 用户组-角色列表
     * @return TRUE/FALSE
     * @throws java.sql.SQLException
     */
    public Boolean updateGroupRoles(List<GroupsRole> groupsRole,int groupid) throws SQLException;
    public List<GroupUser> getGroupUsers(String username) throws SQLException;
        public List<GroupsRole> getGroupsRole(int groupid) throws SQLException;
}
