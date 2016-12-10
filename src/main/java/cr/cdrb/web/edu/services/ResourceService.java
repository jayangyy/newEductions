/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IResourceDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Resource;
import cr.cdrb.web.edu.services.IServices.IResourcesServices;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang 2016-08-01 菜单管理服务类
 *
 */
@Service
public class ResourceService implements IResourcesServices {

    @Autowired
    private IResourceDao resDao;

    @Override
    public Resource GetResById(int resid) throws Throwable {
        return resDao.getResById(resid);
    }

    @Override
    public DataModel AddRes(Resource res) throws Throwable {

        return new DataModel().withData(resDao.addRes(res));
    }

    @Override
    public DataModel RemoveRes(int resid) throws Throwable {
        return new DataModel().withInfo(resDao.removeRes(resid) ? "删除成功" : "删除失败");
    }

    @Override
    public DataModel GetResourcesPagging(QueryModel pageModel) throws Throwable {
        Map<Integer, List<Resource>> resPaging = resDao.getResourcesPagging(pageModel);
//        Set<Map.Entry<String, List<Book>>> entrySet = booksPaging.entrySet();
//        if(entrySet!=null)
//        {
//            Iterator<Map.Entry<String, List<Book>>> iterator = entrySet.iterator();
//        }
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public DataModel UpdateRes(Resource res) throws Throwable {
        Boolean result = resDao.updateRes(res);
        return result ? new DataModel().withInfo("修改成功!") : new DataModel().withErr("修改失败!");
    }

    @Override
    public DataModel GetResTreeGrid() throws Throwable {
        List<Resource> flist = resDao.getResources();
        List<cr.cdrb.web.edu.security.domains.ResourceDto> clist = resDao.getResourceDto();
        List<Object> endList = new ArrayList<Object>();
        endList.addAll(flist);
        endList.addAll(clist);
        return new DataModel().withData(endList);
    }

    @Override
    public DataModel GetResMeans(String username) throws Throwable {
        return new DataModel().withData(resDao.getResByUsername(username), 0);
    }
}
