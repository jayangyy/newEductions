/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Resource;

/**
 *
 * @author Jayang
 */
public interface IResourcesServices {
    public Resource GetResById(int resid)  throws Throwable ;
    public DataModel AddRes(Resource res) throws Throwable ;
    public DataModel RemoveRes(int resid) throws Throwable ;
    public DataModel GetResourcesPagging(QueryModel pageModel) throws Throwable ;
    public DataModel UpdateRes(Resource res) throws Throwable ;
    public DataModel GetResTreeGrid()throws Throwable ;
    public DataModel GetResMeans(String username) throws Throwable;
            
}
