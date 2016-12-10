/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.UserRole;
import cr.cdrb.web.edu.services.IServices.IUsersService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang
 *
 * 权限管理控制器
 */
@Controller
@RequestMapping("/users")
public class UsersController {

    @Autowired
    IUsersService userService;

    /**
     *
     * @author Jayang 权限管理首页
     */
    @RequestMapping("/index")
    public ModelAndView Index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Users/index");
        return mv;
    }

    @RequestMapping(value = "/Edit", method = RequestMethod.GET)
    public ModelAndView edit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Users/edit");
        return mv;
    }

    @RequestMapping(value = "/editRole", method = RequestMethod.GET)
    public ModelAndView editRole() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Users/EditRoles");
        return mv;
    }

    @RequestMapping(value = "/editGroup", method = RequestMethod.GET)
    public ModelAndView editGroups() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Users/EditGroups");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/PutUser", method = RequestMethod.POST)
    public DataModel PutRes(EduUser user) throws Throwable {
        return userService.addEduUser(user);
    }

    @ResponseBody
    @RequestMapping(value = "/PatchUser", method = RequestMethod.POST)
    public DataModel UpdateRes(EduUser user) throws Throwable {
        return userService.updateEduUser(user);
    }

    @ResponseBody
    @RequestMapping(value = "/DeleteUser", method = RequestMethod.GET)
    public DataModel DeleteRes(String uids) throws Throwable {
        return userService.deleteEduUser(uids);
    }

    @ResponseBody
    @RequestMapping(value = "/GetUser", method = RequestMethod.GET)
    public EduUser GetUser(String username) throws Throwable {
        return userService.GetEduUser(username);
    }

    @ResponseBody
    @RequestMapping(value = "/GetUserPage", method = RequestMethod.GET)
    public DataModel GetUserFPagging(QueryModel pageModel) throws Throwable {
        return userService.getEduUsersPage(pageModel);
    }

    @ResponseBody
    @RequestMapping(value = "/GetUserGroupsTree", method = RequestMethod.GET)
    public List<ComboTree> GetUserGroupsTree(String username) throws Throwable {
        return userService.getUserGroupsTree(username);
    }

    @ResponseBody
    @RequestMapping(value = "/UpdateUseGroups", method = RequestMethod.POST)
    public DataModel UpdateUseGroups(@RequestParam(value = "username", required = true, defaultValue = "") String username, @RequestParam(value = "roleids", required = true, defaultValue = "") String groupids) throws Throwable {
        String[] rolesArray = groupids.split(",");
        if (username == "") {
            return new DataModel().withErr("用户名不能为空！");
        }
        List<GroupUser> groupUser = new ArrayList<GroupUser>();
        for (String item : rolesArray) {
            if (!item.equalsIgnoreCase("")) {
                GroupUser guser = new GroupUser();
                guser.setGroup_id(Integer.parseInt(item));
                guser.setUsername(username);
                groupUser.add(guser);
            }
        }
        return userService.updateUserGroups(groupUser, username);
    }

    @ResponseBody
    @RequestMapping(value = "/GetUserRolesTree", method = RequestMethod.GET)
    public List<ComboTree> GetUserRolesTree(String username) throws Throwable {
        return userService.getUserRolesTree(username);
    }

    @ResponseBody
    @RequestMapping(value = "/UpdateUseRoles", method = RequestMethod.POST)
    public DataModel UpdateUseRoles(@RequestParam(value = "username", required = true, defaultValue = "") String username, @RequestParam(value = "roleids", required = true, defaultValue = "") String roleids) throws Throwable {
        String[] rolesArray = roleids.split(",");
        if (username == "") {
            return new DataModel().withErr("用户名不能为空！");
        }
        List<UserRole> roleUser = new ArrayList<UserRole>();
        for (String item : rolesArray) {
            if (!item.equalsIgnoreCase("")) {
                UserRole guser = new UserRole();
                guser.setRoleid(Integer.parseInt(item));
                guser.setUseranme(username);
                roleUser.add(guser);
            }
        }
        return userService.updateUserRoles(roleUser, username);
    }
}
