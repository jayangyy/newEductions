/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IGroups;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.GroupsRole;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 */
@Repository
public class GroupsDao implements IGroups {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public Boolean addGroup(Groups group) throws SQLException {
        String insSql = "insert into edu_groups(id,group_name) values (edu_groups_seq.nextval,?)";
        return (int) db.update(insSql, group.getGroup_name()) > 0;
    }

    @Override
    public Boolean deleteGroup(String groupids) throws SQLException {
        String delSql = "delete  from edu_groups where id in(?)";
        return (int) db.update(delSql, groupids) > 0;
    }

    @Override
    public Boolean updateGroup(Groups group) throws SQLException {
        String updateSql = "update edu_groups set group_name=? where id=?";
        return (int) db.update(updateSql, group.getGroup_name(), group.getId()) > 0;
    }

    @Override
    public Groups getGroupById(int groupid) throws SQLException {
        String getByIdSql = "select * from edu_groups where id=?";
        return db.queryBean(Groups.class, getByIdSql, groupid);
    }

    @Override
    public List<Groups> getAllGroups(Object... roleid) throws SQLException {
        String getAllGroupsSql = " select G.* from edu_groups  G";
        if (roleid.length != 0) {
            getAllGroupsSql += "  join edu_group_roles R on R.group_id=G.id where R.roleid=?";
            return db.queryBeanList(Groups.class, getAllGroupsSql, roleid);
        } else {
            return db.queryBeanList(Groups.class, getAllGroupsSql);
        }
    }

    @Override
    public Map<Integer, List<Groups>> getGroupsPage(QueryModel pageModel) throws Throwable {

        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select * from edu_groups")
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Groups>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql);
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(Groups.class, querySql, new Object[]{}));
        return map;
    }

    @Override
    public Boolean updateGroupRoles(List<GroupsRole> groupsRole,int groupid) throws SQLException {
        String insSql = "insert into edu_group_roles (id,group_id,roleid) values (edu_group_roles_seq.nextval,?,?)";
       int size=groupsRole.size();
        Object[][] params = new Object[size][2];
        for (int i = 0; i < groupsRole.size(); i++) {
            params[i][0] = groupsRole.get(i).getGroup_id();
            params[i][1] = groupsRole.get(i).getRoleid();
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update("delete from edu_group_roles where group_id=?", groupid);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            conn.rollback();
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public List<GroupUser> getGroupUsers(String username) throws SQLException {
        String groupUsersSql="select * from edu_group_members where idcard=?";        
        return db.queryBeanList(GroupUser.class, groupUsersSql,username);
    }

    @Override
    public List<GroupsRole> getGroupsRole(int groupid) throws SQLException {
        String groupUsersSql="select * from edu_group_roles where idcard=?";        
        return db.queryBeanList(GroupsRole.class, groupUsersSql,groupid);
    }
}
