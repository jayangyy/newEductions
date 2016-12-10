/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.UserRole;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IUserdao {

    /**
     *
     * 后去单个权限用户
     *
     * @param usernmae 用户名
     * @return 用户权限对象 EduUser
     * @throws java.sql.SQLException
     */
    public EduUser GetEduUser(String usernmae) throws SQLException;

    /**
     *
     * 增加用户
     *
     * @param user
     * @return true/false
     * @throws java.sql.SQLException
     */
    public Boolean AddUser(EduUser user) throws SQLException;

    /**
     *
     * 更新用户
     *
     * @param user
     * @return true/false
     * @throws java.sql.SQLException
     */
    public Boolean UpdateUser(EduUser user) throws SQLException;

    /**
     *
     * 批量删除用户
     *
     * @param uids 用户ID集合
     * @return true/false
     * @throws java.sql.SQLException
     */
    public Boolean RemoveUser(String uids) throws SQLException;

    /**
     *
     * 获取分页用户数据
     *
     * @param pageModel 分页模型
     * @return 用户分页数据MAP
     * @throws java.sql.SQLException
     */
    public Map<Integer, List<EduUser>> GetEduUserPage(QueryModel pageModel) throws Throwable;

    /**
     *
     * 更新用户-角色对应关系
     * @param userRole 用户-角色对应集合
     * @return true/false
     * @throws java.sql.SQLException
     */
    public Boolean UpdateUserRoles(List<UserRole> userRole,String username) throws SQLException;
       /**
     *
     *获取用户已在用户组
     * @param usernmae 用户名
     * @return true/false
     * @throws java.sql.SQLException
     */
    public List<GroupUser> GetGroupUsers(String usernmae) throws SQLException;
        /**
     *
     * 更新用户用户组关系
     * @param userRole 用户-角色对应集合
     * @return true/false
     * @throws java.sql.SQLException
     */
    public Boolean UpdateGroupUsers(List<GroupUser> groupUser,String username) throws SQLException;


}
