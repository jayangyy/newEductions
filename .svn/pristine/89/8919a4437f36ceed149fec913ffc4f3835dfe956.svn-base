/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IAuthDao;
import cr.cdrb.web.edu.daointerface.IResourceDao;
import cr.cdrb.web.edu.daointerface.IUserdao;
import cr.cdrb.web.edu.security.EduInvocationSecurityMetadataSourceService;
import cr.cdrb.web.edu.services.IServices.ILoadAuthService;
import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang
 */
@Service
public class LoadAuths implements ILoadAuthService {

    @Autowired
    IAuthDao authDao;
    @Autowired
    IResourceDao resDao;
    @Autowired
    private IUserdao userDao;
    @Override
    public void LoadAuthAchae() throws SQLException {
        EduInvocationSecurityMetadataSourceService service = new EduInvocationSecurityMetadataSourceService(authDao, resDao);
    }

    @Override
    public void ReloadUser() throws SQLException {
        UsersService.ReloadUserByUser(userDao.GetEduUser(UsersService.GetCurrentUser().getUsername()));
    }
}
