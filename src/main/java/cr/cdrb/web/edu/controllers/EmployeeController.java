/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.web.edu.domains.easyui.FilterRule;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.EmployeeService;
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
@RequestMapping("/employee")
public class EmployeeController {

    @Resource(name = "configMap")
    private Map config;
    @Autowired
    EmployeeService service;

    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        request.setAttribute("zjcunitid", zjcunitid);
        EduUser user = UsersService.GetCurrentUser();
        request.setAttribute("user", user);
        boolean iseduuser = false;
        for (Role r : user.getRoles()) {
            if (r.getRolename().equals("ROLE_EDU")) {
                iseduuser = true;
            }
        }
        request.setAttribute("iseduuser", iseduuser);
        boolean iszjcuser = false;
        if (user.getCompanyId().equals(zjcunitid)) {
            iszjcuser = true;
        }
        request.setAttribute("iszjcuser", iszjcuser);
        request.setAttribute("usercompanyid", user.getCompanyId());
        return "employee/list";
    }

    @RequestMapping(value = "view")
    public String getViewPage(HttpServletRequest request) {
        return "employee/view";
    }

    @RequestMapping(value = "allEmployee", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllCards(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();//model.getPage() - 1) * rows;
        String sort = StringUtils.isBlank(model.getSort()) ? "em_id" : model.getSort();
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
                        param.add("%" + value + "%");
                        break;
                    case "less":
                        whereStr += " and " + field + " > ?";
                        param.add(value);
                        break;
                    case "greater":
                        whereStr += " and " + field + " < ?";
                        param.add(value);
                        break;
                    case "in":
                        String[] pidarr = value.split(",");
                        String pids = "";
                        for (int i = 0; i < pidarr.length; i++) {
                            pids += "'" + pidarr[i] + "',";
                        }
                        if (!"".equals(pids)) {
                            pids = pids.substring(0, pids.length() - 1);
                            whereStr += " and " + field + " in (" + pids + ")";
                        }
                        break;
                    case "custom":
                        if (field.equals("mhss")) {
                            whereStr += " and (em_name like ? or em_gz like ? or em_gw like ?)";
                            param.add("%" + value + "%");
                            param.add("%" + value + "%");
                            param.add("%" + value + "%");
                        }
                        break;
                }
            }
        }
        return JSON.toJSONString(service.getEmployeePaging(page, rows, sort, order, whereStr, sort, param.toArray()));
    }

    @RequestMapping(value = "allSys", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllSystem() throws Exception {
        return service.getAllSystem();
    }

    @RequestMapping(value = "getgz", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllGzBySystemId(String sysid) throws Exception {
        return service.getAllGzBySystemId(sysid);
    }

    @RequestMapping(value = "getgw", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllGwByGzId(String gzid) throws Exception {
        return service.getAllGwByGzId(gzid);
    }

    @RequestMapping(value = "setGzgw", method = RequestMethod.POST)
    @ResponseBody
    public Object setGzgw(String uids, String gz, String gw) throws Exception {
        return service.setGzgw(uids, gz, gw);
    }

    @RequestMapping(value = "getEmployeeByPid", method = RequestMethod.GET)
    @ResponseBody
    public Object getEmployeeByPid(String pid) throws Exception {
        return service.getEmployeeByPid(pid);
    }

    @RequestMapping(value = "getStudent", method = RequestMethod.GET)
    @ResponseBody
    public Object getStudent(String pid, boolean isgt) throws Exception {
        String whereStr = " and stu_idcard='" + pid + "'";
        if(isgt){
            whereStr+=" and crh=1 and CLASSTYPE in('新职','转岗','晋升') and (STU_CER_DATE is not null or STU_ORDER_DATE is not null)";
        }else{
            whereStr+=" and CLASSTYPE in('新职','转岗','晋升','师带徒') and STU_CER_NO is not null";
        }
        return service.getStudent(whereStr);
    }

}
