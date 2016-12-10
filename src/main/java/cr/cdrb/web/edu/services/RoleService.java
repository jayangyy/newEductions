/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IResourceDao;
import cr.cdrb.web.edu.daointerface.IRoleDao;
import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Resource;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.IServices.IRolesServices;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang
 */
@Service
public class RoleService implements IRolesServices {

    @Autowired
    IRoleDao roleDao;
    @Autowired
    IResourceDao resDao;

    @Override
    public DataModel AddRole(Role role) throws Throwable {
        return new DataModel().withInfo(roleDao.addRole(role) ? "修改成功" : "修改失败");
    }

    @Override
    public DataModel UpdateRole(Role role) throws Throwable {
        return new DataModel().withInfo(roleDao.updateRole(role) ? "修改成功" : "修改失败");
    }

    @Override
    public Role GetRole(int roleid) throws Throwable {
        return roleDao.getRole(roleid);
    }

    @Override
    public DataModel DeleteRole(int roleid) throws Throwable {
        return new DataModel().withInfo(roleDao.removeRole(roleid) ? "修改成功" : "修改失败");
    }

    @Override
    public DataModel GetRolesPagging(QueryModel model) throws Throwable {
        Map<Integer, List<Role>> resPaging = roleDao.getResourcesPagging(model);
//        Set<Map.Entry<String, List<Book>>> entrySet = booksPaging.entrySet();
//        if(entrySet!=null)
//        {
//            Iterator<Map.Entry<String, List<Book>>> iterator = entrySet.iterator();
//        }
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }
// <editor-fold desc="获取当前角色权限树">

    @Override
    public List<ComboTree> GetResRolesTree(int roleid) throws Throwable {
        List<Resource> resList = resDao.getResources();
        List<Resource> cresList = resDao.getResourcesAll();
        List<ResRole> resRoleList = roleDao.getResRoels(roleid);
        return GetResRoleseTree(resList, resRoleList, cresList);
    }

    //查询父节点
    private List<ComboTree> GetResRoleseTree(List<Resource> resList, List<ResRole> resRoleList, List<Resource> cresList) {
        List<ComboTree> treeList = new ArrayList<ComboTree>();
        for (Resource res : resList) {
            ComboTree tree = new ComboTree();
            tree.setId(res.getId());
            tree.setText(res.getRes_name());
            for (ResRole resrole : resRoleList) {
                if (resrole.getRes_id() == res.getId()) {
                    tree.setChecked(Boolean.TRUE);
                }
            }
            List<ComboTree> children = new ArrayList<ComboTree>();
            if (IsExitChild(res.getId(), cresList)) {
                tree.setState("closed");
                children = GetChildTree(cresList, resRoleList, res.getId());
            }
            if (!children.isEmpty()) {
                tree.setChildren(children);
            }
            treeList.add(tree);
        }
        return treeList;
    }

    ///判断是否有子节点，以提示是否递归
    private Boolean IsExitChild(int resid, List<Resource> list) {
        int i = 0;
        for (Resource item : list) {
            if (item.getRes_pid() == resid) {
                i++;
                break;
            }
        }
        return i != 0;
    }

    ///递归子节点
    private List<ComboTree> GetChildTree(List<Resource> resList, List<ResRole> resRoleList, Integer id) {

        List<ComboTree> treeList = new ArrayList<ComboTree>();
        for (Resource res : resList) {
            if (Objects.equals(id, res.getRes_pid())) {
                ComboTree tree = new ComboTree();
                tree.setId(res.getId());
                tree.setText(res.getRes_name());
                for (ResRole resrole : resRoleList) {
                    if (resrole.getRes_id() == res.getId()) {
                        tree.setChecked(Boolean.TRUE);
                    }
                }
                if (IsExitChild(res.getId(), resList)) {
                    tree.setState("closed");
                    //递归开始
                    tree.setChildren(GetChildTree(resList, resRoleList, res.getId()));
                }
                treeList.add(tree);
            }
        }
        return treeList;
    }

    // </editor-fold>
// <editor-fold desc="获取当前角色可分配角色树">
    @Override
    public List<ComboTree> GetRolesTree(int roleid) throws Throwable {
        //当前角色
        Role role = roleDao.getRole(roleid);
        //所有角色
        List<Role> roleList = roleDao.getRoles();
        //已分配角色
        List<Role> crolelist = roleDao.getRoles(role.getRolesdown());
        List<ComboTree> treeList = new ArrayList<ComboTree>();
        for (Role item : roleList) {
            ComboTree tree = new ComboTree();
            tree.setId(item.getRoleid());
            tree.setText(item.getRolecmt());
            tree.setState("true");
            for (Role resrole : crolelist) {
                if (resrole.getRoleid() == item.getRoleid()) {
                    tree.setChecked(Boolean.TRUE);
                }
            }
            treeList.add(tree);
        }
        return treeList;
    }
    // </editor-fold>

    // <editor-fold desc="修改已分配角色">
    @Override
    public DataModel UpdateRoelsTree(Role role) throws Throwable {
        Role crole = roleDao.getRole(role.getRoleid());
        crole.setRolesdown(role.getRolesdown());
        return new DataModel().withInfo(roleDao.updateRole(crole) ? "修改成功" : "修改失败");
    }

    // </editor-fold>
    // <editor-fold desc="修改角色权限">
    @Override
    public DataModel UpdateResRoels(List<ResRole> resRoles,int roleid) throws Throwable {
        return roleDao.updateResRoles(resRoles,roleid) ? new DataModel().withInfo("修改成功" ):new DataModel().withErr("修改失败");
    }
    // </editor-fold>
}
