/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Resource;
import cr.cdrb.web.edu.services.IServices.IResourcesServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang 2016-08-01 菜单资源，权限资源管理
 */
@Controller
@RequestMapping("/Resources")
public class ResourcesController {

    @Autowired
    IResourcesServices resService;

    @RequestMapping(value = "/Index", method = RequestMethod.GET)
    public ModelAndView Index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Resources/index");
        return mv;
    }

    @RequestMapping(value = "/Edit", method = RequestMethod.GET)
    public ModelAndView edit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Resources/edit");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/PutRes", method = RequestMethod.POST)
    public DataModel PutRes(Resource res) throws Throwable {
        return resService.AddRes(res);
    }

    @ResponseBody
    @RequestMapping(value = "/PatchRes", method = RequestMethod.POST)
    public DataModel UpdateRes(Resource res) throws Throwable {
        return resService.UpdateRes(res);
    }

    @ResponseBody
    @RequestMapping(value = "/DeleteRes", method = RequestMethod.GET)
    public DataModel DeleteRes(int resId) throws Throwable {
        return resService.RemoveRes(resId);
    }

    @ResponseBody
    @RequestMapping(value = "/GetRes", method = RequestMethod.GET)
    public Resource GetRes(int resid) throws Throwable {
         return resService.GetResById(resid);
    }

    @ResponseBody
    @RequestMapping(value = "/GetResPage", method = RequestMethod.GET)
    public DataModel GetResPagging(QueryModel pageModel) throws Throwable {
        return resService.GetResourcesPagging(pageModel);
    }

    @ResponseBody
    @RequestMapping(value = "/GetRess", method = RequestMethod.GET)
    public DataModel GetRess() throws Throwable {
        return resService.GetResTreeGrid();
    }

}
