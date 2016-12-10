/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security;

import java.util.Collection;
import java.util.Iterator;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

/**
 *
 * @author Jayang 授权控制类
 */
public class EduAccessDecisionManager implements AccessDecisionManager {

    @Override
    public void decide(Authentication a, Object o, Collection<ConfigAttribute> clctn) throws AccessDeniedException, InsufficientAuthenticationException {
        if (clctn == null) {
            return;
        }
        Iterator<ConfigAttribute> ite = clctn.iterator();
        while (ite.hasNext()) {
            ConfigAttribute ca = ite.next();
            String authRole = ((SecurityConfig) ca).getAttribute();
            for (GrantedAuthority ga : a.getAuthorities()) {
                if (authRole.trim().equals(ga.getAuthority().trim())) {
                    return;
                }
            }
        }
        throw new AccessDeniedException("无权限!");
        ///throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean supports(ConfigAttribute ca) {
        return true;
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean supports(Class<?> type) {
        return true;
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
