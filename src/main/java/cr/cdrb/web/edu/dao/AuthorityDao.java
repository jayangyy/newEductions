/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;
import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.web.edu.daointerface.IAuthDao;
import cr.cdrb.web.edu.security.domains.ResRole;
import cr.cdrb.web.edu.security.domains.Role;
import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
/**
 *
 * @author Jayang
 */
@Repository
public class AuthorityDao implements IAuthDao {
    @Resource(name = "db1")
    private DbUtilsPlus db;
    @Override
    public List<Role> getAllAuthorityName() throws SQLException {
        String sqlStr = "select * from edu_roles";
        return db.queryBeanList(Role.class, sqlStr);
    }
    @Override
    public List<cr.cdrb.web.edu.security.domains.Resource> getResource(String rolename) throws SQLException {
        String sqlStr = "select O.* from edu_roles R\n"
                + "   join edu_res_roles O on O.roleid=R.roleid\n"
                + "   where R.rolename='" + rolename + "'";
        return db.queryBeanList(cr.cdrb.web.edu.security.domains.Resource.class, sqlStr);
    }
    @Override
    public List<ResRole> getResRoles() throws SQLException {
        String sqlStr = "select * from edu_res_roles";
        return db.queryBeanList(ResRole.class, sqlStr);
    }
}
