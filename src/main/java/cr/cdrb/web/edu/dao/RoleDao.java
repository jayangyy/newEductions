/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IRoleDao;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Role;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang 角色管理数据处理基础类
 */
@Repository
public class RoleDao implements IRoleDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public Boolean addRole(Role role) throws SQLException {
        String insSql = "insert into EDU_ROLES(roleid,rolename,rolecmt) values (edu_roles_seq.nextval,?,?)";
        oracle.sql.ROWID rowid = db.insert(insSql, role.getRolename(), role.getRolecmt());
        return rowid.isNull();
    }

    @Override
    public Role getRole(int roleid) throws SQLException {
        String getSql = "select * from edu_roles where roleid=?";
        return db.queryBean(Role.class, getSql, roleid);
    }

    @Override
    public Boolean updateRole(Role role) throws SQLException {
        String updateSql = "update edu_roles set rolename=?,rolecmt=?,rolesdown=? where roleid=?";
        return (int) db.update(updateSql, role.getRolename(), role.getRolecmt(),role.getRolesdown(), role.getRoleid()) > 0;
    }

    @Override
    public Boolean removeRole(int roleid) throws SQLException {
        String delSql = "delete from edu_roles where roleid in(?)";
        return (int) db.update(delSql, roleid) > 0;
    }

    @Override
    public Map<Integer, List<Role>> getResourcesPagging(QueryModel pageModel) throws Throwable {
        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select * from edu_roles  ")
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Role>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql);
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(Role.class, querySql, new Object[]{}));
        return map;
    }

    @Override
    public List<ResRole> getResRoels(int roleid) throws SQLException {
        String resSql = "select * from edu_res_roles where roleid=?";
        return db.queryBeanList(ResRole.class, resSql, roleid);
    }

    @Override
    public List<Role> getRoles(String... roleids) throws SQLException {
        String rolesSql = " select * from edu_roles where 1=1 ";
        if (roleids.length != 0) {
            if(roleids[0]==null)
            {
                return new ArrayList<Role>();
            }
            rolesSql += " and roleid in ("+roleids[0]+")";
            return db.queryBeanList(Role.class, rolesSql);
        } else {
            return db.queryBeanList(Role.class, rolesSql);
        }
    }

    @Override
    public Boolean updateResRoles(List<ResRole> resRoles,int roleid) throws SQLException {
        String insSql = "insert into edu_res_roles (id,res_id,roleid) values (edu_res_roles_seq.nextval,?,?)";
        int size = resRoles.size();
        Object[][] params = new Object[size][2];
        for (int i = 0; i < resRoles.size(); i++) {
            Object[] param = new Object[]{resRoles.get(i).getRes_id(), resRoles.get(i).getRoleid()};
            params[i][0] = resRoles.get(i).getRes_id();
            params[i][1] = resRoles.get(i).getRoleid();
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update("delete from edu_res_roles where roleid=?", roleid);
            db.batch(insSql, params);
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception ex) {
            conn.rollback();
            if (!conn.getAutoCommit()) {
                conn.setAutoCommit(true);
            }
            throw new SQLException(ex.getMessage());
        }
    }

    @Override
    public List<Role> getGroupsRole(int groupid) throws SQLException {
        String groupRoleSql = " select R.* from edu_roles R join edu_group_roles G on G.roleid=R.roleid where G.group_id=?";
        return db.queryBeanList(Role.class, groupRoleSql, groupid);
    }

    @Override
    public List<Role> getUsersRole(String username) throws SQLException {
         String resSql = "select R.* from edu_roles  R join edu_user_roles U on U.roleid=R.roleid where U.idcard=?";
        return db.queryBeanList(Role.class, resSql, username);
    }

}
