/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.security.domains.EduUnit;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Jayang
 */
public interface IUnitService {

    public List<EduUnit> getUnits(String uid, String pid, String uname,String extraunit) throws SQLException;

    public EduUnit getUnit(String uid) throws SQLException;
     public List<EduUnit> getUnitsGroups(String pid,String system,String uid) throws SQLException;
}
