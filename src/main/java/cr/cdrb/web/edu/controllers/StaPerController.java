/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.eduplans.EduPlans;
import cr.cdrb.web.edu.domains.eduplans.StaPeronsSearch;
import cr.cdrb.web.edu.domains.eduplans.StationPersons;
import cr.cdrb.web.edu.security.domains.EduUnit;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.IServices.IStationPerService;
import cr.cdrb.web.edu.services.IServices.IUnitService;
import cr.cdrb.web.edu.services.UsersService;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang 2016-12-08 11:38:22 计划站段信息提报
 */
@Controller
@RequestMapping("/stapers")
public class StaPerController {

    @Resource(name = "configMap")
    java.util.HashMap configMap;
      @Autowired
    IUnitService unitService;
    @Autowired
    private IStationPerService perService;
    // <editor-fold desc="提报页面">

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("user", UsersService.GetCurrentUser());
        mv.setViewName("/stapers/index");
        return mv;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(String id) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("user", UsersService.GetCurrentUser());
        mv.addObject("stacode", id);
        mv.setViewName("/stapers/edit");
        return mv;
    }

    // </editor-fold>
    
    // <editor-fold desc="提报操作">
    // <editor-fold desc="批量提报">
    @ResponseBody
    @RequestMapping(value = "/putPer", method = RequestMethod.POST)
    public DataModel putPlan(String sarsStr) throws SQLException {
        //   plan.setAdd_user(UsersService.GetCurrentUser().getUsername());
        List<StationPersons> stas = new ArrayList<StationPersons>();
        if (!StringUtils.isBlank(sarsStr)) {
            stas = JSON.parseArray(sarsStr, StationPersons.class);
        }
        return perService.addStaPers(stas);
    }

    // </editor-fold>
    
    // <editor-fold desc="修改提报">
    @ResponseBody
    @RequestMapping(value = "/patchPer", method = RequestMethod.POST)
    public DataModel pathcPlan(StationPersons plan) throws SQLException {
        return perService.updateStaPerson(plan);
    }

    @ResponseBody
    @RequestMapping(value = "/patchPerNum", method = RequestMethod.POST)
    public DataModel patchPerNum(StationPersons plan) throws SQLException {
        return perService.updateStaPerNum(plan);
    }
    // </editor-fold>
    
    // <editor-fold desc="获取提报数据">
    @ResponseBody
    @RequestMapping(value = "/getPer", method = RequestMethod.GET)
    public StationPersons getPer(String id) throws SQLException {
        return perService.getStaPer(id);
    }
    // </editor-fold>
    
    // <editor-fold desc="获取提报分页数据">
    @ResponseBody
    @RequestMapping(value = "/getpPserPaging", method = RequestMethod.GET)
    public DataModel getpPserPaging(StaPeronsSearch model) throws Throwable {
        EduUser user = UsersService.GetCurrentUser();
        if(user.getCompanypid().equalsIgnoreCase(configMap.get("zdpid").toString()))
        {
            model.setSta_unit(user.getCompany());
        }
        return perService.getStaPersonsPagging(model);
    }
    // </editor-fold>
       
      // <editor-fold desc="删除提报数据">
    @ResponseBody
    @RequestMapping(value = "/deltePer", method = RequestMethod.POST)
    public DataModel deltePer(String ids) throws SQLException {
        return perService.removeStaPer(ids);
    }
    
        // </editor-fold>
     // <editor-fold desc="获取单位">
     //获取单位
    @ResponseBody
    @RequestMapping(value = "/getUnits", method = RequestMethod.GET)
    public List<EduUnit> getUnits(String uid, String uname, int levelId, int searchType) throws Throwable {
        String pid = null;
        EduUser user = UsersService.GetCurrentUser();
         String  system="";
        if (!UsersService.IsAdmin()) {
            if(configMap.get("cspid").toString().replace(",", "','").contains(user.getCompanypid()))
            {
//                //处室人员
//                if(!user.getCompanyId().equalsIgnoreCase(configMap.get("zjcunitid").toString())&&!user.getCompanyId().equalsIgnoreCase(configMap.get("rscunitid").toString()))
//                {
//                    system=user.getSystem();
//                }
            }else
            {
                //站段人员
                 if(user.getCompanypid().equalsIgnoreCase(configMap.get("zdpid").toString())) 
                {
                      uid = user.getCompanyId();
                }
            }
        }        
        List<EduUnit> list = unitService.getUnitsGroups(configMap.get("zdpid").toString(),system,uid);
        if (UsersService.IsAdmin()||!user.getCompanypid().equalsIgnoreCase(configMap.get("zdpid").toString())) {
            EduUnit unit = new EduUnit();
            unit.setU_id("");
            unit.setName("全部单位");
            list.add(0, unit);
        }
        return list;
    }
            // </editor-fold>
    // </editor-fold>
}
