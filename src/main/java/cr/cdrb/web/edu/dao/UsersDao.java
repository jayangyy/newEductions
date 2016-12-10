/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IUserdao;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.GroupUser;
import cr.cdrb.web.edu.security.domains.Groups;
import cr.cdrb.web.edu.security.domains.UserRole;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 */
@Repository
public class UsersDao implements IUserdao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public EduUser GetEduUser(String usernmae) throws SQLException {
        EduUser endUser = new EduUser();
        //检查数据是否已经存在
        String queryStr = "select DISTINCT S.EM_IDCARD as workername,U.IDCARD as username from EMPLOYEE S\n"
                + "left join edu_users U on U.IDCARD=S.EM_IDCARD\n"
                + "where S.EM_IDCARD='" + usernmae + "' AND length(S.EM_IDCARD)=18";
        EduUser quser = db.queryBean(EduUser.class, queryStr);
        if (quser == null) {
            if (!usernmae.equalsIgnoreCase("edu_admin")) {
                usernmae = "users";
            }
            //设置为默认访问用户
        } else //老职工表存在，新用户表不存在则向新用户表插入一条数据,分配匿名用户组
        {
            if (quser.getWorkername() != null && quser.getUsername() == null) {
                String sqlInsert = "insert into edu_users values('" + usernmae + "','21232f297a57a5a743894a0e4a801fc3')";
                String sqlGroup = "insert into EDU_GROUP_MEMBERS values(edu_group_members_seq.nextval,'" + usernmae + "','23')";
                db.insert(sqlInsert);
                db.insert(sqlGroup);
            }
        }
        String sqlStr = "select  p.type_name,p.type_id,c.p_id as companypid,c.u_id as companyId,c.system,d.dwxxbmbs as departmentId,U.IDCARD AS username,U.password,S1.rolename,S1.roleid,S1.rolecmt,Z.EM_NAME as workername,(case when Z.EM_EGENDER=1 THEN '男' else '女' end) as sex,c.name as company,Z.EM_POLITICALSTATUS as political,d.treename as department,Z.EM_GZ as post,Z.EM_ZC as title,Z.EM_JOBLEVEL as technicalgrade,Z.EM_GW as station from EDU_USERS U "
                + " left join EMPLOYEE  Z on Z.EM_IDCARD=U.IDCARD "
                + " left JOIN v_position b on Z.EM_ID = b.EMPLOYEE_ID"
                + " left JOIN B_UNIT c on b.dw_id = c.u_id"
                + " left JOIN B_DEPARTMENT d on b.bm_id = d.dwxxbmbs"
                + " left join edu_user_roles  R on R.IDCARD=U.IDCARD "
                + " left JOIN E_TYPE  t on t.EM_ID= Z.EM_ID "
                + "  left join (select DISTINCT TYPE_ID,TYPE_NAME from DIC_PPTYPE WHERE TYPE_NAME ='单位正职领导' or TYPE_NAME ='单位副职领导')  p on p.type_id=t.type_id"
                + " left join edu_roles S1 on S1.roleid=R.roleid where U.idcard='" + usernmae + "'  "
                + " union  "
                + " select p1.type_name,p1.type_id,c1.p_id as companypid,c1.u_id as companyId,c1.system,d1.dwxxbmbs as departmentId,U1.IDCARD as username,U1.password,S.rolename,S.roleid,S.rolecmt,Z1.EM_NAME as workername,(case when Z1.EM_EGENDER=1 THEN '男' else '女' end) as sex,c1.name as company,Z1.EM_POLITICALSTATUS as political,d1.treename  as department,Z1.EM_GZ as post,Z1.EM_ZC as title,Z1.EM_JOBLEVEL as technicalgrade,Z1.EM_GW as station from edu_users U1 "
                + " left join EMPLOYEE  Z1 on Z1.EM_IDCARD=U1.idcard "
                + " left JOIN v_position b1 on Z1.EM_ID = b1.EMPLOYEE_ID"
                + " left JOIN B_UNIT c1 on b1.dw_id = c1.u_id"
                + " left JOIN B_DEPARTMENT d1 on b1.bm_id = d1.dwxxbmbs"
                + " left join edu_group_members G on G.idcard=U1.idcard "
                + " left join edu_group_roles  R1 on R1.group_id=G.group_id "
                + " left JOIN E_TYPE  t1 on t1.EM_ID= Z1.EM_ID "
                + "  left join (select DISTINCT TYPE_ID,TYPE_NAME from DIC_PPTYPE WHERE TYPE_NAME ='单位正职领导' or TYPE_NAME ='单位副职领导')  p1 on p1.type_id=t1.type_id"
                + " left join edu_roles S on S.roleid=R1.roleid  where U1.idcard='" + usernmae + "' ";
        List<EduUser> userList = db.queryBeanList(EduUser.class, sqlStr);
        if (userList.size() == 0) {
            throw new UsernameNotFoundException("未匹配到用户");
        }
        List<Role> roles = new ArrayList<Role>();
        boolean ismap = true;
        for (EduUser user : userList) {
            if (ismap) {
                endUser = user;
                ismap = false;
            }
            Role role = new Role();
            role.setRoleid(user.getRoleid());
            role.setRolename(user.getRolename());
            role.setRolecmt(user.getRolecmt());
            if (user.getRolename() != null) {
                roles.add(role);
            }          
        }
        endUser.setRoles(roles);
        List<Groups> groups = db.queryBeanList(Groups.class, "select * from edu_groups G  join edu_group_members M on G.id=M.group_id where M.idcard=?", usernmae);
        endUser.setGroups(groups);
        return endUser;
    }

    @Override
    public Boolean AddUser(EduUser user) throws SQLException {
        String insSql = "insert into edu_users(idcard,password) values (?,?)";
        return (int) db.insert(insSql, user.getUsername(), user.getPassword()) > 0;
    }

    @Override
    public Boolean UpdateUser(EduUser user) throws SQLException {
        String updateSql = "update edu_users set idcard=?,password=?";
        return (int) db.update(updateSql, user.getUsername(), user.getPassword()) > 0;
    }

    @Override
    public Boolean RemoveUser(String uids) throws SQLException {
        String delSql = "delete from edu_users where idcard in(?)";
        return (int) db.update(delSql, uids) > 0;
    }

    @Override
    public Map<Integer, List<EduUser>> GetEduUserPage(QueryModel pageModel) throws Throwable {
        String quserSql = "select  c.u_id as companyId,c.system,d.dwxxbmbs as departmentId,U.IDCARD AS username,U.password,Z.EM_NAME as workername,(case when Z.EM_EGENDER=1 THEN '男' else '女' end) as sex,c.name as company,Z.EM_POLITICALSTATUS as political,d.treename as department,Z.EM_GZ as post,Z.EM_ZC as title,Z.EM_JOBLEVEL as technicalgrade,Z.EM_GW as station from EDU_USERS U "
                + " left join EMPLOYEE  Z on Z.EM_IDCARD=U.IDCARD "
                + " left JOIN E_POSITION b on Z.EM_ID = b.EMPLOYEE_ID"
                + " left JOIN B_UNIT c on b.dw_id = c.u_id"
                + " left JOIN B_DEPARTMENT d on b.bm_id = d.dwxxbmbs";
        if (pageModel.getSearch() != null && pageModel.getSearch() != "" && !pageModel.getSearch().equalsIgnoreCase("null")) {
            pageModel.setFilterRules("   username like '%" + pageModel.getSearch() + "%' or workername like '%" + pageModel.getSearch() + "%' ");
        }
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(quserSql)
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<EduUser>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql);
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(EduUser.class, querySql, new Object[]{}));
        return map;
    }

    @Override
    public Boolean UpdateUserRoles(List<UserRole> userRole, String username) throws SQLException {
        String insSql = "insert into edu_user_roles (id,idcard,roleid) values (edu_user_roles_seq.nextval,?,?)";
        int size = userRole.size();
        Object[][] params = new Object[size][2];
        for (int i = 0; i < userRole.size(); i++) {
            params[i][0] = userRole.get(i).getUseranme();
            params[i][1] = userRole.get(i).getRoleid();
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update("delete from edu_user_roles where idcard=?", username);
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
    public List<GroupUser> GetGroupUsers(String usernmae) throws SQLException {
        String groupUser = "select * from edu_groups G join edu_group_members M on M.group_id=G.id where idcard in('" + usernmae + "')";
        return db.queryBeanList(GroupUser.class, groupUser);
    }

    @Override
    public Boolean UpdateGroupUsers(List<GroupUser> groupUser, String username) throws SQLException {
        String insSql = "insert into edu_group_members (id,idcard,group_id) values (edu_group_members_seq .nextval,?,?)";
        int size = groupUser.size();
        Object[][] params = new Object[size][2];

        for (int i = 0; i < groupUser.size(); i++) {
            params[i][0] = groupUser.get(i).getUsername();
            params[i][1] = groupUser.get(i).getGroup_id();
        }
        Connection conn = db.getConnection();
        try {
            conn.setAutoCommit(false);
            db.update("delete from edu_group_members where idcard=?", username);
            if (params.length > 0) {
                db.batch(insSql, params);
            }//为空不插入
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
}
