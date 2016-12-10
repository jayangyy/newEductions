/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.UserRole;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Jayang
 */
public interface IUsersService {

    /**
     *
     * 获取权限用户
     *
     * @param username 用户名
     * @return 用户权限对象 EduUser
     * @throws java.sql.SQLException
     */
    public EduUser GetEduUser(String username) throws SQLException;

    /**
     *
     * 获取用户分页数据
     *
     * @param pageModel 分页模型
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel getEduUsersPage(QueryModel pageModel) throws Throwable;

    /**
     *
     * 新增用户
     *
     * @param user
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel addEduUser(EduUser user) throws SQLException;

    /**
     *
     * 更新用户
     *
     * @param user
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel updateEduUser(EduUser user) throws SQLException;

    /**
     *
     * 批量删除用户
     *
     * @param uids
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel deleteEduUser(String uids) throws SQLException;

    /**
     *
     * 后去用户-角色树模型
     *
     * @param username
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public List<ComboTree> getUserRolesTree(String username) throws SQLException;

    /**
     *
     * 获取用户-用户组树模型
     *
     * @param username
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public List<ComboTree> getUserGroupsTree(String username) throws SQLException;

    /**
     *
     * 更新用户-角色关系
     *
     * @param username
     * @param roleids
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel updateUserRoles(List<UserRole> userRole,String username) throws SQLException;

    /**
     *
     * 更新用户-用户组关系
     *
     * @param username
     * @param groupids
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel updateUserGroups(List<GroupUser> groupUser,String username) throws SQLException;
    
   
    /**
     *
     * 更新用户SESSION
     * @return void 
     * @throws java.sql.SQLException
     */
    public void ReloadUser() throws SQLException;
       /**
     *
     * 获取用户属于哪个级别人员（处室，站段，职教，财务等。。。。）
     * @return  List<String> 
     * @throws java.sql.SQLException
     */
    public  List<String> GetUserDep() ;
    
}
