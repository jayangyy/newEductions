/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import java.sql.SQLException;

/**
 *
 * @author Jayang
 */
public interface ILoadAuthService {
     /**
     *
     * 更新系统权限架构
     * @return void 
     * @throws java.sql.SQLException
     */
    public void LoadAuthAchae()  throws SQLException;
     /**
     *
     * 更新用户SESSION
     * @return void 
     * @throws java.sql.SQLException
     */
    public void ReloadUser() throws SQLException;
    
}
