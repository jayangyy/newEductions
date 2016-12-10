/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security;

import cr.cdrb.web.edu.services.LogService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 *
 * @author Jayang
 */
public class LoginAuthenticationSuccessHandler  implements AuthenticationSuccessHandler{
    private static Log log = LogService.getLog(LoginAuthenticationSuccessHandler.class);
    //登录验证成功后需要跳转的url
    private String url;
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication) throws IOException,
            ServletException {
        log.info("登录验证成功："+request.getContextPath()+url);
        //response.sendRedirect(request.getContextPath()+url);
        request.getRequestDispatcher(url).forward(request, response);
    }
    public void setUrl(String url) {
        this.url = url;
    }
    
}
