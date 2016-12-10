/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.web.edu.daointerface.IBaseDao;
import cr.cdrb.web.edu.daointerface.IStaPeronsDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.eduplans.StaPeronsSearch;
import cr.cdrb.web.edu.domains.eduplans.StationPersons;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 */
@Repository
public class StaPersonsDao implements IStaPeronsDao {

    @Autowired
    private IBaseDao baseDao;
    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public Boolean addStaPers(List<StationPersons> stas) throws SQLException {
        String insSql = "insert into StationPserons(station_code,station_name,station_Id,station_cmt,plan_code,station_num,plan_name,add_user) values (?,?,?,?,?,?,?,?) ";
        Object[][] params = new Object[][]{};
        if (stas.size() > 0) {
            params = new Object[stas.size()][8];
            int i = 0;
            for (StationPersons item : stas) {
                params[i][0] = item.getStation_code();
                params[i][1] = item.getStation_name();
                params[i][2] = item.getStation_Id();
                params[i][3] = item.getStation_cmt();
                params[i][4] = item.getPlan_code();
                params[i][5] = item.getStation_num();
                params[i][6] = item.getPlan_name();
                params[i][7] = item.getAdd_user();
            }
        } else {
            throw new SQLException("执行失败，没有任何数据！");
        }
        throw new SQLException("执行失败，没有任何数据！");
    }

    @Override
    public StationPersons getStaPer(String sta_code) throws SQLException {
        return db.queryBean(StationPersons.class, "select * from StationPserons where station_code=?", sta_code);
    }

    @Override
    public Boolean updateStaPerson(StationPersons stas) throws SQLException {
        return db.update("update StationPserons set station_code=?,station_name=?,station_Id=?,station_cmt=?,plan_code=?,station_num=?,plan_name=?,add_user=? where station_code=?", stas.getPlan_code(), stas.getStation_Id(), stas.getStation_cmt(), stas.getPlan_code(), stas.getStation_num(), stas.getPlan_name(), stas.getAdd_user(), stas.getStation_code()) > 0;
    }

    @Override
    public Boolean updateStaPersons(List<StationPersons> stas) throws SQLException {

        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Boolean removeRole(String sta_code) throws SQLException {
        return db.update("delete from StationPserons where station_code in(?)", sta_code) > 0;
    }

    @Override
    public List<StationPersons> getStaPersons(String... roleids) throws SQLException {
        String querySql = "select S.*,E.plan_name,E.add_user from  StationPserons S join edu_plans e on e.plan_code=S.plan_code where 1=1 ";
        List<String> params = new ArrayList<String>();
        if (roleids.length > 0) {
            if (!StringUtils.isBlank(roleids[0])) {
                querySql += " and S.plan_code=? ";
                params.add(roleids[0]);
            }
            if (!StringUtils.isBlank(roleids[1])) {
                querySql += " and S.station_code in (?) ";
                params.add(roleids[1]);
            }
        }
        return db.queryBeanList(StationPersons.class, querySql, params.toArray());

    }

    @Override
    public Map<Integer, List<StationPersons>> getStaPersonsPagging(StaPeronsSearch pageModel) throws Throwable {
        List<Object> params = new ArrayList<Object>();
        String querySql = "select S.* from  StationPserons S ";
        String whereSql = " 1=1 ";
        if (!StringUtils.isBlank(pageModel.getSta_unit())) {
            whereSql += " and  station_name=? ";
            params.add(pageModel.getSta_unit());
        }
        if (!StringUtils.isBlank(pageModel.getPlanname())) {
            whereSql += " and  PLAN_NAME like '%"+pageModel.getPlanname()+"%' ";
           // params.add(pageModel.getPlanname());
        }
        pageModel.setParams(params);
        pageModel.setSelects(querySql);
        pageModel.setFilterRules(whereSql);
        return baseDao.getPageComs(pageModel, StationPersons.class);
    }

    @Override
    public Boolean updateStaPerNum(StationPersons stas) throws SQLException {
        return db.update("update StationPserons set station_num=?,station_cmt=? where station_code=?", stas.getStation_num(), stas.getStation_cmt(), stas.getStation_code()) > 0;
    }
}
