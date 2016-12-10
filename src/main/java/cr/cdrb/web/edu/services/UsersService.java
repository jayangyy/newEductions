/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IGroups;
import cr.cdrb.web.edu.daointerface.IRoleDao;
import cr.cdrb.web.edu.daointerface.IUserdao;
import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.security.domains.UserRole;
import cr.cdrb.web.edu.services.IServices.IUsersService;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 *
 * @author Jayang 用户
 */
@Service
public class UsersService implements IUsersService {

    @Autowired
    private IUserdao userDao;
    @Autowired
    IRoleDao roleDao;
    @Autowired
    IGroups groupsDao;
    @Resource(name = "configMap")
    java.util.HashMap configMap;

    @Override
    public EduUser GetEduUser(String username) throws SQLException {
        return userDao.GetEduUser(username);
    }

    public static EduUser GetCurrentUser() {
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        return session.getAttribute("SPRING_SECURITY_CONTEXT") != null ? (EduUser) (((SecurityContext) session.getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication().getPrincipal()) : null;
    }

    @Override
    public List<String> GetUserDep() {
        EduUser user = GetCurrentUser();
        String pid = user.getCompanypid();
        String uid=user.getCompanyId();
        List<String> depList = new ArrayList<String>();
        if (pid.equalsIgnoreCase(configMap.get("zjcunitid").toString())) {
            depList.add("0");
            //职教人员
        }
        if (pid.equalsIgnoreCase(configMap.get("cspid").toString())) {
            depList.add("1");
            //职教人员
        }
        if (pid.equalsIgnoreCase(configMap.get("zdpid").toString())) {
            depList.add("2");
            //站段人员
        }
        if (uid.equalsIgnoreCase(configMap.get("cwcunitid").toString())) {
            depList.add("3");
            //站段人员
        }
        return depList;
    }



    /**
     *
     * @author 判断是否为管理员
     * @return
     */
    public static Boolean IsAdmin() {
        EduUser user = UsersService.GetCurrentUser();
        Boolean isAdmin = false;
        for (Role role : user.getRoles()) {
            if (role.getRolename().equalsIgnoreCase("ROLE_ADMIN")) {
                isAdmin = true;
            }
        }
        return isAdmin;
    }

    /**
     *
     * @author 判断是否为某用户组人员
     * @param 默认为职教人员
     * @return
     */
    public static Boolean hasGroups(String group_name) {
        EduUser user = UsersService.GetCurrentUser();
        group_name = (group_name == null) || group_name.equals("") ? "职教管理人员" : group_name;
        Boolean isAdmin = false;
        for (Groups groupuser : user.getGroups()) {
            if (groupuser.getGroup_name().equalsIgnoreCase(group_name)) {
                isAdmin = true;
            }
        }
        return isAdmin;
    }

    public static void RemoveSession(HttpServletRequest request) {

//        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//        UserDetails userDetails = null;
//        //PreAuthenticatedAuthenticationToken当然可以用其他token,如UsernamePasswordAuthenticationToken                 
//        UsernamePasswordAuthenticationToken authentication
//                = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
//        authentication.setDetails(new WebAuthenticationDetails(request));
//        SecurityContextHolder.getContext().setAuthentication(authentication);
//        HttpSession session = request.getSession(true);
//        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        HttpSession session = request.getSession();

        session.removeAttribute("SPRING_SECURITY_CONTEXT");
        // session.setAttribute("SPRING_SECURITY_CONTEXT", null);
    }

    @Override
    public void ReloadUser() throws SQLException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        UserDetails userDetails = userDao.GetEduUser(GetCurrentUser().getUsername());
        //PreAuthenticatedAuthenticationToken当然可以用其他token,如UsernamePasswordAuthenticationToken                 
        UsernamePasswordAuthenticationToken authentication
                = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        HttpSession session = request.getSession(true);
        session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
    }

    public static void ReloadUserByUser(UserDetails userDetails) throws SQLException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        // UserDetails userDetails = userDao.GetEduUser(GetCurrentUser().getUsername());
        //PreAuthenticatedAuthenticationToken当然可以用其他token,如UsernamePasswordAuthenticationToken                 
        UsernamePasswordAuthenticationToken authentication
                = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        HttpSession session = request.getSession(true);
        session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
    }

    @Override
    public DataModel getEduUsersPage(QueryModel pageModel) throws Throwable {
        Map<Integer, List<EduUser>> resPaging = userDao.GetEduUserPage(pageModel);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public DataModel addEduUser(EduUser user) throws SQLException {

        return new DataModel().withInfo(userDao.AddUser(user) ? "添加成功" : "添加失败");
    }

    @Override
    public DataModel updateEduUser(EduUser user) throws SQLException {
        return new DataModel().withInfo(userDao.UpdateUser(user) ? "修改成功" : "修改失败");
    }

    @Override
    public DataModel deleteEduUser(String uids) throws SQLException {
        return new DataModel().withInfo(userDao.RemoveUser(uids) ? "删除成功" : "删除失败");
    }

    @Override
    public List<ComboTree> getUserRolesTree(String username) throws SQLException {
        //当前用户
        EduUser user = userDao.GetEduUser(username);
        //所有角色
        List<Role> roleList = roleDao.getRoles();
        //已分配角色
        List<Role> crolelist = roleDao.getUsersRole(username);
        List<ComboTree> treeList = new ArrayList<ComboTree>();
        for (Role item : roleList) {
            ComboTree tree = new ComboTree();
            tree.setId(item.getRoleid());
            tree.setText(item.getRolecmt());
            for (Role resrole : crolelist) {
                if (resrole.getRoleid() == item.getRoleid()) {
                    tree.setChecked(Boolean.TRUE);
                }
            }
            treeList.add(tree);
        }
        return treeList;
    }

    @Override
    public List<ComboTree> getUserGroupsTree(String username) throws SQLException {
        EduUser user = userDao.GetEduUser(username);
        //所有角色
        List<Groups> roleList = groupsDao.getAllGroups();
        //已分配角色
        List<GroupUser> crolelist = userDao.GetGroupUsers(username);
        List<ComboTree> treeList = new ArrayList<ComboTree>();
        for (Groups item : roleList) {
            ComboTree tree = new ComboTree();
            tree.setId(item.getId());
            tree.setText(item.getGroup_name());
            for (GroupUser resrole : crolelist) {
                if (resrole.getGroup_id() == item.getId()) {
                    tree.setChecked(Boolean.TRUE);
                }
            }
            treeList.add(tree);
        }
        return treeList;
    }

    @Override
    public DataModel updateUserRoles(List<UserRole> userRole, String username) throws SQLException {
        return new DataModel().withInfo(userDao.UpdateUserRoles(userRole, username) ? "修改成功" : "修改失败");
    }

    @Override
    public DataModel updateUserGroups(List<GroupUser> groupUser, String username) throws SQLException {
//         Boolean result=userDao.UpdateGroupUsers(groupUser, username);
//        if(result){ ReloadUser();}
        return new DataModel().withInfo(userDao.UpdateGroupUsers(groupUser, username) ? "修改成功" : "修改失败");
    }
}
