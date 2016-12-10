/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.infrastructure.aspectj;

import com.alibaba.fastjson.support.spring.FastJsonJsonView;
import cr.cdrb.web.edu.services.LogService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author 杨洋 控制器异常捕捉，错误信息反馈
 */
@Component
public class WebHandlerExceptionResolver implements HandlerExceptionResolver {

    private Log log = LogService.getLog(WebHandlerExceptionResolver.class);

    @Override
    @ResponseBody
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        //控制台输出错误日志
        System.out.println("HANDLER 捕获:" + ex.getMessage());
        ModelAndView mv = new ModelAndView();
        try {      
            //异常过滤
            if(ex.getClass().getName().contains("AccessDeniedException")||ex.getClass().getName().contains("UsernameNotFoundException"))
            {
             mv.setViewName("error");
            request.setAttribute("errmessage", ex.getMessage());
            request.setAttribute("stackerror", "");
            return mv;
            }
            if (handler instanceof HandlerMethod) {
                /*  使用FastJson提供的FastJsonJsonView视图返回，不需要捕获异常   */
                FastJsonJsonView view = new FastJsonJsonView();
                ///  ResponseBody responseBodyAnn = AnnotationUtils.findAnnotation(method, ResponseBody.class); 
                Map<String, Object> attributes = new HashMap<String, Object>();
                attributes.put("result", false);
                attributes.put("info", ex.getMessage());
                attributes.put("rows", new ArrayList());
                attributes.put("total", 0);
                view.setAttributesMap(attributes);
                mv.setView(view);                
            } else {               
                mv.setViewName("error");
                request.setAttribute("errmessage", ex.getMessage());
                request.setAttribute("stackerror", ex.getStackTrace());
            }
            //添加自己的异常处理逻辑，如日志记录等   
            log.debug("异常:" + ex.getMessage(), ex);
        } catch (Exception ex1) {
            mv.setViewName("error");
            request.setAttribute("errmessage", ex1.getMessage());
            request.setAttribute("stackerror", ex1.getStackTrace());
            log.debug("异常:" + ex1.getMessage(), ex1);
        }finally
        {
             return mv;  
        }
    }

}
