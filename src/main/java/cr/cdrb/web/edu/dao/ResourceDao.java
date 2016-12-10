/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IResourceDao;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import java.math.BigDecimal;
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
public class ResourceDao implements IResourceDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public List<cr.cdrb.web.edu.security.domains.Resource> getResource(String rolename) throws SQLException {
        String sqlStr = "select S.* from edu_roles R\n"
                + "   join edu_res_roles O on O.roleid=R.roleid\n"
                + "   join edu_resources S on S.id=O.res_id\n"
                + "   where R.rolename='" + rolename + "'";
        return db.queryBeanList(cr.cdrb.web.edu.security.domains.Resource.class, sqlStr);
    }

    /**
     *
     * 根据ID获取所有子级节点
     */
    @Override
    public List<cr.cdrb.web.edu.security.domains.ResourceDto> getResourceDtoById(int fid) throws SQLException {
        String sqlStr = "select res_name,res_url,id,res_pid,RES_ENABLE,res_pid as \"_parentId\"  from edu_resources where id=" + fid;
        return db.queryBeanList(cr.cdrb.web.edu.security.domains.ResourceDto.class, sqlStr);
    }

    /**
     *
     * 获取所有子级节点
     */
    @Override
    public List<cr.cdrb.web.edu.security.domains.ResourceDto> getResourceDto() throws SQLException {
        String sqlStr = "select res_name,res_url,id,res_pid,RES_ENABLE,res_pid as \"__parentId\"  from edu_resources where res_pid!=0 ";
        List<cr.cdrb.web.edu.security.domains.ResourceDto> list = db.queryBeanList(cr.cdrb.web.edu.security.domains.ResourceDto.class, sqlStr);
        for (cr.cdrb.web.edu.security.domains.ResourceDto item : list) {
            item.set__parentId(item.getRes_pid());
        }
        return list;
    }

    /**
     *
     * 获取所有根节点
     */
    @Override
    public List<cr.cdrb.web.edu.security.domains.Resource> getResources() throws SQLException {
        String sqlStr = "select *  from edu_resources where res_pid=0 ";
        return db.queryBeanList(cr.cdrb.web.edu.security.domains.Resource.class, sqlStr);
    }

    /**
     *
     * 获取所有节点
     */
    @Override
    public List<cr.cdrb.web.edu.security.domains.Resource> getResourcesAll() throws SQLException {
        String sqlStr = "select res_name,res_url,id,res_pid,RES_ENABLE,res_pid as \"_parentId\"  from edu_resources";
        return db.queryBeanList(cr.cdrb.web.edu.security.domains.Resource.class, sqlStr);
    }

    @Override
    public cr.cdrb.web.edu.security.domains.Resource getResById(int resid) throws Throwable {
        String getStr = "select * from edu_resources where id=" + resid;
        return db.queryBean(cr.cdrb.web.edu.security.domains.Resource.class, getStr);
    }

    @Override
    public Object addRes(cr.cdrb.web.edu.security.domains.Resource res) throws Throwable {
        String isenable = res.isRes_enable() ? "1" : "0";
        String insSql = "insert into edu_resources(id,res_url,res_name,res_pid,res_enable) values(edu_resources_seq.nextval,'" + res.getRes_url() + "','" + res.getRes_name() + "'," + res.getRes_pid() + "," + isenable + ")";
        Object o = db.insert(insSql);
        return o;
    }

    @Override
    public Boolean removeRes(int resid) throws Throwable {
        String delSql = "delete from edu_resources where id=" + resid + " or res_pid=" + resid;
         String delSql1 = "delete from eu where id=" + resid + " or res_pid=" + resid;
        return (int) db.update(delSql) > 0;
    }

    @Override
    public Map<Integer, List<cr.cdrb.web.edu.security.domains.Resource>> getResourcesPagging(QueryModel pageModel) throws Throwable {

        ISelectBuilder builder = new OracleSelectBuilder()
                .from("select res_name,res_url,id,res_pid,RES_ENABLE from edu_resources  ")
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<cr.cdrb.web.edu.security.domains.Resource>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql);
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(cr.cdrb.web.edu.security.domains.Resource.class, querySql, new Object[]{}));
        return map;
    }

    @Override
    public Boolean updateRes(cr.cdrb.web.edu.security.domains.Resource res) throws Throwable {
        String isenable = res.isRes_enable() ? "1" : "0";
        String upStr = "update edu_resources set res_enable=" + isenable + ", res_name='" + res.getRes_name() + "',res_url='" + res.getRes_url() + "',res_pid=" + res.getRes_pid() + " where id=" + res.getId();
        return (int) db.update(upStr) > 0;
    }

    @Override
    public List<cr.cdrb.web.edu.security.domains.Resource> getResByUsername(String idcard) throws SQLException {

        String sqlStr = " select * from (SELECT E.* from  EDU_USERS U\n"
                + "join EDU_USER_ROLES R ON R.IDCARD=U.IDCARD\n"
                + "join EDU_RES_ROLES S ON S.roleid=R.roleid\n"
                + "join  EDU_RESOURCES E ON E.id=S.res_id\n"
                + "WHERE U.IDCARD=?  "
                + "UNION \n"
                + "SELECT E1.* from  EDU_USERS U1\n"
                + "join EDU_GROUP_MEMBERS M on M.IDCARD=U1.IDCARD\n"
                + "join EDU_GROUP_ROLES S1 on S1.group_id=M.GROUP_ID\n"
                + "join EDU_RES_ROLES S2 ON S2.roleid=S1.roleid\n"
                + "join  EDU_RESOURCES E1 ON E1.id=S2.res_id\n"
                + "WHERE U1.IDCARD=?  )order by sort_res";
        return db.queryBeanList(cr.cdrb.web.edu.security.domains.Resource.class, sqlStr, idcard,idcard);
    }

}
