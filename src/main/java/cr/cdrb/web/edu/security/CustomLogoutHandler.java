/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

/**
 *
 * @author jayan
 * 注销HANDLER
 */
public class CustomLogoutHandler implements LogoutHandler {

    public CustomLogoutHandler() {
    }

    @Override
    public void logout(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication) {
        System.out.println("CustomLogoutSuccessHandler.logout() is called!");
    }

}
