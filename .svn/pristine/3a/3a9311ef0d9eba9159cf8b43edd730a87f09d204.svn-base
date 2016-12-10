/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.DicSpecialEquipmentDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class DicSpecialEquipmentService {
    @Resource
    private DicSpecialEquipmentDao dao;
    public Object getSpecialEquipmentByCode(String code) throws Exception {
        return new DataModel().withData(dao.getSpecialEquipmentByCode(code));
    }
}
