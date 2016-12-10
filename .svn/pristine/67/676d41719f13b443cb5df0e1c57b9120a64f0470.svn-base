/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.web.edu.domains.easyui.FilterRule;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.model.EDU_TRAINING_EXPENSE;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.EduTrainingExpenseService;
import cr.cdrb.web.edu.services.UsersService;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author milord
 */
@Controller
@RequestMapping("/expense")
public class EduTrainingExpenseController {
    @Resource(name="configMap")
    private Map config;
    @Autowired
    EduTrainingExpenseService service;
    
    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) {
        boolean isadmin = UsersService.IsAdmin();
        request.setAttribute("isadmin", isadmin);
        String zjcunitid = (String) config.get("zjcunitid");
        boolean iszjcuser = false;
        EduUser user = UsersService.GetCurrentUser();
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
        return "expense/list";
    }
    
    @RequestMapping(value = "edit")
    public String getEditPage(HttpServletRequest request) {
        boolean isadmin = UsersService.IsAdmin();
        request.setAttribute("isadmin", isadmin);
        return "expense/edit";
    }
    
    @RequestMapping(value = "allDatas", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllDatas(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();
        String sort = StringUtils.isBlank(model.getSort()) ? "id" : model.getSort();
        String order = StringUtils.isBlank(model.getOrder()) ? "asc" : model.getOrder();
        List<String> param = new ArrayList<>();
        
        String whereStr = "1=1";
        List<FilterRule> frlist = JSON.parseArray(model.getFilterRules(), FilterRule.class);
        if (frlist != null) {
            for (FilterRule item : frlist) {
                String field = item.getField();
                String op = item.getOp();
                String value = item.getValue();
                switch (op) {
                    case "equals":
                        whereStr += " and " + field + " = ?";
                        param.add(value);
                        break;
                    case "contains":
                        whereStr += " and " + field + " like ?";
                        param.add("%"+value+"%");
                        break;
                    case "less":
                        whereStr += " and " + field + " > ?";
                        param.add(value);
                        break;
                    case "greater":
                        whereStr += " and " + field + " < ?";
                        param.add(value);
                        break;
                    case "custom":
                        break;
                }
            }
        }
        return service.getDataPaging(page, rows, sort, order, whereStr, model.getSearch(), param.toArray());
    }
    
    @RequestMapping(value = "getDataByParentId", method = RequestMethod.GET)
    @ResponseBody
    public Object getDataByParentId(int parentid,String gp) throws Exception {
        String whereStr = "parentid="+parentid;
        return service.getDataByWhere(whereStr,gp);
    }
    
    @RequestMapping(value = "getDataById", method = RequestMethod.GET)
    @ResponseBody
    public Object getDataById(int id) throws Exception {
        return service.getDataById(id);
    }
    
    @RequestMapping(value = "addData", method = RequestMethod.POST)
    @ResponseBody
    public Object addData(EDU_TRAINING_EXPENSE data) throws Exception {
        return service.addData(data);
    }
    
    @RequestMapping(value = "upData", method = RequestMethod.POST)
    @ResponseBody
    public Object upData(EDU_TRAINING_EXPENSE data) throws Exception {
        return service.upData(data);
    }
    
    @RequestMapping(value = "delDataById", method = RequestMethod.POST)
    @ResponseBody
    public Object delDataById(int id) throws Exception {
        return service.delDataById(id);
    }
    
}
