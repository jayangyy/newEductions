/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor;

/**
 *
 * @author jayan 方法拦截器
 */
public class EduMethodSecurityInterceptor extends MethodSecurityInterceptor implements Filter {
    @Override
    public void init(FilterConfig fc) throws ServletException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    @Override
    public Object invoke(MethodInvocation mi) throws Throwable {
        // 拦截@Secure注解的方法
        if (1 == 1) {

        } else {
            throw new AccessDeniedException("无权限!");//对未加入权限的URL全部实施拦截

        }
        return "";
    }
    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException {

        // 拦截@Secure注解的方法
        throw new AccessDeniedException("无权限!");//对未加入权限的URL全部实施拦截
        //  throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void destroy() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
