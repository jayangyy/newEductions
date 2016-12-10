/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.infrastructure.annotation.SysLog;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/test")
public class TestController {
    @RequestMapping("/jsonObject")
    @ResponseBody
    public Map<String,Object> json() throws Throwable {
        Map map = new HashMap() {{ 
            put("number", 1);
            put("string", "2");
            put("nullNumber", (Integer) null);
            put("nullString", (String) null);
            put("nullObject", null);
        }};
        return map;
    }
    @RequestMapping("/jsonNumber")
    @ResponseBody
    public Map<String, Integer> jsonNumber() throws Throwable {
        Map map = new HashMap() {{ 
            put("number", 1);
            //put("string", "2");
            put("nullNumber", (Integer) null);
            //put("nullString", (String) null);
            //put("nullObject", null);
        }};
        return map;
    }
    @RequestMapping("/jsonString")
    @ResponseBody
    public Map<String, String> jsonString() throws Throwable {
        Map map = new HashMap() {{ 
            //put("number", 1);
            put("string", "2");
            //put("nullNumber", (Integer) null);
            put("nullString", (String) null);
            //put("nullObject", null);
        }};
        return map;
    }
    
    @RequestMapping("/jsonBean")
    @ResponseBody
    public DataModel jsonBean() throws Throwable {
        return new DataModel().withData(null);
    }
    
}
