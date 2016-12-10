/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.infrastructure.interceptor;

import cr.cdrb.web.edu.infrastructure.annotation.AuthPassport;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 *
 * @author 杨洋 验证拦截器 针对ACTION,控制器类，作用在控制器这一层
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {

    ///登录验证
    private boolean IsValid() {
        return false;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//      if(handler instanceof org.springframework.web.servlet.resource.DefaultServletHttpRequestHandler)
//      {
//          return true;
//      }
        if (handler instanceof HandlerMethod) {
            //注解在类上面
            AuthPassport[] AuthinTypes = ((HandlerMethod) handler).getBean().getClass().getAnnotationsByType(AuthPassport.class);
            if (handler.getClass().isAssignableFrom(HandlerMethod.class) || AuthinTypes.length > 0) {
                AuthPassport authPassport = null;
                if (AuthinTypes.length > 0) {
                    authPassport = AuthinTypes[0];
                } else {
                    authPassport = ((HandlerMethod) handler).getMethodAnnotation(AuthPassport.class);
                }
                /// ((HandlerMethod) handler).getMethod().getClass()
//            Annotation[] annotations = handler.getClass().getAnnotations();
//            for (Annotation annotation : annotations) {
//                System.out.println(annotation.annotationType().getName());
//            }
                //没有声明需要权限,或者声明不验证权限
                if (authPassport == null || authPassport.validate() == false) {
                    return true;
                } else //在这里实现自己的权限验证逻辑
                {
                    if (IsValid())//如果验证成功返回true（这里直接写false来模拟验证失败的处理）
                    {
                        return true;
                    } else//如果验证失败
                    {
                        //返回到登录界面
                        response.sendRedirect("/login");
                        return false;
                    }
                }
            } else {
                return true;
            }
        } else {
            return true;
        }

    }
}
