/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IBaseDao {

    public <T extends Object, L extends QueryModel> Map<Integer, List<T>> getPageComs(L pageModel,Class<T> classtype) throws Throwable;
}
