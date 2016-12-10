/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security;

import org.springframework.security.web.authentication.logout.LogoutFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

/**
 *
 * @author jayan
 * 注销登陆FILTER
 */
public class CustomLogoutFilter extends LogoutFilter {

    public CustomLogoutFilter(String logoutSuccessUrl, LogoutHandler[] handlers) {
        super(logoutSuccessUrl, handlers);
    }

    public CustomLogoutFilter(LogoutSuccessHandler logoutSuccessHandler,
            LogoutHandler[] handlers) {
        super(logoutSuccessHandler, handlers);
    }

}