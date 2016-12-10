/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Resource;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IResourceDao {

    public List<Resource> getResource(String rolename) throws SQLException;

    public Resource getResById(int resid) throws Throwable;

    public Object addRes(Resource res) throws Throwable;

    public Boolean removeRes(int resid) throws Throwable;

    public Map<Integer, List<Resource>> getResourcesPagging(QueryModel pageModel) throws Throwable;

    public Boolean updateRes(Resource res) throws Throwable;

    public List<cr.cdrb.web.edu.security.domains.ResourceDto> getResourceDto() throws SQLException;

    public List<cr.cdrb.web.edu.security.domains.Resource> getResources() throws SQLException;

    public List<cr.cdrb.web.edu.security.domains.Resource> getResByUsername(String idcard) throws SQLException;

    public List<cr.cdrb.web.edu.security.domains.Resource> getResourcesAll() throws SQLException;

    public List<cr.cdrb.web.edu.security.domains.ResourceDto> getResourceDtoById(int fid) throws SQLException;
}
