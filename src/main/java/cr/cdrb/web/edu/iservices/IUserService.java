/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.iservices;

import cr.cdrb.web.edu.security.domains.EduUser;
import java.sql.SQLException;

/**
 *
 * @author Jayang
 */
public interface IUserService {

    /**
     * 获取 EDU用户信息 返回对象EduUser
     *
     * @param 用户身份证号码
     * @return EduUser 用户信息
     */
    public EduUser GetEduUser(String username) throws SQLException ;
}
