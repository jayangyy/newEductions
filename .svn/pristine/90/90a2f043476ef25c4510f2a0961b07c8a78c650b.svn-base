/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.IServices.ILoadAuthService;
import cr.cdrb.web.edu.services.IServices.IRolesServices;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang 2016-08-03
 */
@Controller
@RequestMapping("Roles")
public class RolesController {

    @Autowired
    IRolesServices roleService;
    @Autowired
    ILoadAuthService authService;

    @RequestMapping(value = "/Index", method = RequestMethod.GET)
    public ModelAndView Index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Roles/index");
        return mv;
    }

    @RequestMapping(value = "/Edit", method = RequestMethod.GET)
    public ModelAndView edit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Roles/edit");
        return mv;
    }

    @RequestMapping(value = "/authRoles", method = RequestMethod.GET)
    public ModelAndView authRoles() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Roles/authRoles");
        return mv;
    }
    //管理员管理
    @RequestMapping(value = "/admanages", method = RequestMethod.GET)
    public ModelAndView adManage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Roles/adminsManage");
        return mv;
    }

    @RequestMapping(value = "/roleDeps", method = RequestMethod.GET)
    public ModelAndView roleDeps() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Roles/rolesDeps");
        return mv;
    }
    @RequestMapping(value = "/loadAuths", method = RequestMethod.GET)
    public ModelAndView loadAuths() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Roles/loadAhths");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/PutRole", method = RequestMethod.POST)
    public DataModel PutRes(Role role) throws Throwable {
        role.setRolename("ROLE_" + role.getRolename());
        return roleService.AddRole(role);
    }

    @ResponseBody
    @RequestMapping(value = "/PatchRole", method = RequestMethod.POST)
    public DataModel UpdateRes(Role role) throws Throwable {
        role.setRolename("ROLE_" + role.getRolename());
        return roleService.UpdateRole(role);
    }

    @ResponseBody
    @RequestMapping(value = "/DeleteRole", method = RequestMethod.GET)
    public DataModel DeleteRes(int roleid) throws Throwable {
        return roleService.DeleteRole(roleid);
    }

    @ResponseBody
    @RequestMapping(value = "/GetRole", method = RequestMethod.GET)
    public Role GetRes(int roleid) throws Throwable {
        return roleService.GetRole(roleid);
    }

    @ResponseBody
    @RequestMapping(value = "/GetRolePage", method = RequestMethod.GET)
    public DataModel GetResPagging(QueryModel pageModel) throws Throwable {
        return roleService.GetRolesPagging(pageModel);
    }

    ////获取资源树（带选中）
    @ResponseBody
    @RequestMapping(value = "/GetResRolesTree", method = RequestMethod.GET)
    public List<ComboTree> GetResRolesTree(int roleid) throws Throwable {
        return roleService.GetResRolesTree(roleid);
    }
//    ////获取角色树（带选中）

    @ResponseBody
    @RequestMapping(value = "/GetRolesTree", method = RequestMethod.GET)
    public List<ComboTree> GetRolesTree(int roleid) throws Throwable {
        return roleService.GetRolesTree(roleid);
    }

    @ResponseBody
    @RequestMapping(value = "/UpdateRolesTree", method = RequestMethod.POST)
    public DataModel UpdateRolesTree(Role role) throws Throwable {
        return roleService.UpdateRoelsTree(role);
    }

    ///手动更新权限
    @Secured({"ROLE_ADMIN"})
    @ResponseBody
    @RequestMapping(value = "/RefreshAuths", method = RequestMethod.POST)
    public DataModel RefreshAuths() throws Throwable {
        authService.LoadAuthAchae();
        return new DataModel().withInfo("执行成功!");
    }

    @ResponseBody
    @RequestMapping(value = "/UpdateResRoles", method = RequestMethod.POST)
    public DataModel UpdateResRoles(Role role) throws Throwable {
        String[] ress = role.getRolesdown().split(",");
        if (ress.length == 0) {
            return new DataModel().withInfo("未选择记录，无更改！ ");
        }
        List<ResRole> list = new ArrayList<ResRole>();
        for (String item : ress) {
            if (!item.equalsIgnoreCase("")) {
                ResRole resrole = new ResRole();
                resrole.setRes_id(Integer.parseInt(item));
                resrole.setRoleid(role.getRoleid());
                list.add(resrole);
            }
        }
        DataModel result = roleService.UpdateResRoels(list, role.getRoleid());
        if (result.getResult()) {
            //刷新权限缓存
            authService.LoadAuthAchae();
        }
        return result;
    }
}
