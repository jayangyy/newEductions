/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.web.edu.model.SpecialEquipment;
import java.sql.SQLException;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class DicSpecialEquipmentDao {
    @Resource(name = "db1")
    private DbUtilsPlus db;
    
    public SpecialEquipment getSpecialEquipmentByCode(String code) throws SQLException {
        String sql = "SELECT code,objname from EDU_DIC_SPECIAL_EQUIPMENT where code=?";
        return db.queryBean(SpecialEquipment.class, sql, code.toUpperCase());
    }
}
