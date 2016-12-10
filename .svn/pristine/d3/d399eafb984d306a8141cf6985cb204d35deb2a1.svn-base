/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Role;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Jayang
 */
public interface IAuthDao {

    public List<Role> getAllAuthorityName()  throws SQLException;

    public List<cr.cdrb.web.edu.security.domains.Resource> getResource(String rolename) throws SQLException;
    
    ///获取所有RES_ROLE映射
    public List<ResRole> getResRoles() throws SQLException;
    
}
