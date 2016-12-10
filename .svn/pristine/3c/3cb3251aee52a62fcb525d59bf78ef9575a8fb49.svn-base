/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IGroups;
import cr.cdrb.web.edu.daointerface.IRoleDao;
import cr.cdrb.web.edu.domains.easyui.ComboTree;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.GroupsRole;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.IServices.IGroupsService;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang
 */
@Service
public class GroupsService implements IGroupsService {

    @Autowired
    IGroups groupDao;
    @Autowired
    IRoleDao roleDao;

    @Override
    public DataModel addGroup(Groups group) throws SQLException {
        return new DataModel().withInfo(groupDao.addGroup(group) ? "添加成功" : "添加失败");
    }

    @Override
    public DataModel updateGroup(Groups group) throws SQLException {
        return new DataModel().withInfo(groupDao.updateGroup(group) ? "添加成功" : "添加失败");
    }

    @Override
    public DataModel removeGroup(String groupids) throws SQLException {
        return new DataModel().withInfo(groupDao.deleteGroup(groupids) ? "添加成功" : "添加失败");
    }

    @Override
    public Groups getGroupsById(int groupid) throws SQLException {
        return groupDao.getGroupById(groupid);
    }

    @Override
    public List<Groups> getAllGroups(Object... groupids) throws SQLException {
        return groupDao.getAllGroups(groupids);
    }

    @Override
    public DataModel getGroupsPage(QueryModel pageModel) throws Throwable {
        Map<Integer, List<Groups>> resPaging = groupDao.getGroupsPage(pageModel);
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

    @Override
    public List<GroupsRole> getGroupsRole(int groupid) throws SQLException {
        return groupDao.getGroupsRole(groupid);
    }

    @Override
    public List<ComboTree> getGroupsRoleTree(int groupid) throws SQLException {
        //当前用户
        Groups group = groupDao.getGroupById(groupid);
        //所有角色
        List<Role> roleList = roleDao.getRoles();
        //已分配角色
        List<Role> crolelist = roleDao.getGroupsRole(groupid);
        List<ComboTree> treeList = new ArrayList<ComboTree>();
        for (Role item : roleList) {
            ComboTree tree = new ComboTree();
            tree.setId(item.getRoleid());
            tree.setText(item.getRolecmt());
            for (Role resrole : crolelist) {
                if (resrole.getRoleid() == item.getRoleid()) {
                    tree.setChecked(Boolean.TRUE);
                }
            }
            treeList.add(tree);
        }
        return treeList;
    }

    @Override
    public DataModel updateGroupsRole(List<GroupsRole> groupsRole,int groupid) throws SQLException {
        return new DataModel().withInfo(groupDao.updateGroupRoles(groupsRole,groupid) ? "添加成功" : "添加失败");
    }

}
