/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security;

/**
 *
 * @author jayan 登陆成功FILTER
 */
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;

public class CustomLoginHandler extends
        SimpleUrlAuthenticationSuccessHandler {

    private final String LOCAL_SERVER_URL = "/home/index";

    protected final Log logger = LogFactory.getLog(this.getClass());

    private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication)
            throws ServletException, IOException {
        System.out
                .println("登陆成功，准备跳转!");
        Object redictUrl = request.getSession().getAttribute("callRediretUrl");
        if (request.getSession().getAttribute("callRediretUrl") != null) {
            System.out
                    .println(redictUrl.toString());
            super.setDefaultTargetUrl(redictUrl.toString());
        } else {
            System.out
                    .println(LOCAL_SERVER_URL);
            super.setDefaultTargetUrl(LOCAL_SERVER_URL);
        }
        super.setAlwaysUseDefaultTargetUrl(true);
        super.onAuthenticationSuccess(request, response, authentication);
    }

    public void setRequestCache(RequestCache requestCache) {
        this.requestCache = requestCache;
    }

}
