/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.security.domains.EduUnit;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Jayang
 */
public interface IEduUnits {

    /**
     *
     * @author Jayang
     * @param params 获取单位列表集合
     * @return
     * @throws java.sql.SQLException
     */
    public List<EduUnit> getUnits(Object... params) throws SQLException;
    /**
     *
     * @author Jayang
     * @param uid 获取单位
     * @return
     * @throws java.sql.SQLException
     */
    public EduUnit getUnit(String uid) throws SQLException;

    public Boolean isTeacher(String idcard);
        /**
     *
     * @author Jayang
     * @param params 获取单位列表集合
     * @return
     * @throws java.sql.SQLException
     */
    public List<EduUnit> getUnitsGroups(Object... params) throws SQLException;
}
