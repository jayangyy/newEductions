/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IEduUnits;
import cr.cdrb.web.edu.security.domains.EduUnit;
import cr.cdrb.web.edu.services.IServices.IUnitService;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang
 */
@Service
public class UnitService implements IUnitService {

    @Autowired
    IEduUnits unitDao;

    @Override
    public List<EduUnit> getUnits(String uid, String pid, String uname,String extraunit) throws SQLException {
        return unitDao.getUnits(uid,pid,uname, extraunit);
    }

    @Override
    public EduUnit getUnit(String uid) throws SQLException {
        return unitDao.getUnit(uid);
    }

    @Override
    public List<EduUnit> getUnitsGroups(String pid,String system,String uid) throws SQLException {
           return unitDao.getUnitsGroups(pid,system,uid);
    }
}
