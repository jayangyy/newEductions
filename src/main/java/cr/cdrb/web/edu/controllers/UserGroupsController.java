/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.GroupsRole;
import cr.cdrb.web.edu.services.IServices.IGroupsService;
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
 */
@Controller
@RequestMapping("/groups")
public class UserGroupsController {

    @Autowired
    IGroupsService groupService;

    /**
     *
     * @author Jayang 权限管理首页
     */
    @RequestMapping("/index")
    public ModelAndView Index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/UserGroups/index");
        return mv;
    }

    @RequestMapping(value = "/Edit", method = RequestMethod.GET)
    public ModelAndView edit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/UserGroups/edit");
        return mv;
    }

    @RequestMapping(value = "/editRole", method = RequestMethod.GET)
    public ModelAndView editGroups() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/UserGroups/editRoles");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/PutGroup", method = RequestMethod.POST)
    public DataModel PutGroup(Groups group) throws Throwable {
        return groupService.addGroup(group);
    }

    @ResponseBody
    @RequestMapping(value = "/PatchGroup", method = RequestMethod.POST)
    public DataModel PatchGroup(Groups group) throws Throwable {
        return groupService.updateGroup(group);
    }

    @ResponseBody
    @RequestMapping(value = "/DeleteGroup", method = RequestMethod.POST)
    public DataModel DeleteGroup(String groupids) throws Throwable {
        return groupService.removeGroup(groupids);
    }

    @ResponseBody
    @RequestMapping(value = "/GetGroup", method = RequestMethod.GET)
    public Groups GetGroup(int groupid) throws Throwable {
        return groupService.getGroupsById(groupid);
    }

    @ResponseBody
    @RequestMapping(value = "/GetGroupsPage", method = RequestMethod.GET)
    public DataModel GetGroupsPage(QueryModel pageModel) throws Throwable {
        return groupService.getGroupsPage(pageModel);
    }

    @ResponseBody
    @RequestMapping(value = "/GetGroupsRoleTree", method = RequestMethod.GET)
    public List<ComboTree> getGroupsRoleTree(int groupid) throws Throwable {
        return groupService.getGroupsRoleTree(groupid);
    }

    @ResponseBody
    @RequestMapping(value = "/UpdateGroupsRole", method = RequestMethod.POST)
    public DataModel UpdateGroupsRole(int groupid, @RequestParam(value = "roleids", required = true, defaultValue = "") String roleids) throws Throwable {
        String[] rolesArray = roleids.split(",");
        if (groupid == 0) {
            return new DataModel().withErr("用户名不能为空！");
        }
        List<GroupsRole> roleGroup = new ArrayList<GroupsRole>();
        for (String item : rolesArray) {
            if (!item.equalsIgnoreCase("")) {
                GroupsRole guser = new GroupsRole();
                guser.setGroup_id(groupid);
                guser.setRoleid(Integer.parseInt(item));
                roleGroup.add(guser);
            }
        }
        return groupService.updateGroupsRole(roleGroup, groupid);
    }
}
