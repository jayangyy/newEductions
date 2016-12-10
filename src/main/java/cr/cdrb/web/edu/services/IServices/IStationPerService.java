/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.eduplans.StaPeronsSearch;
import cr.cdrb.web.edu.domains.eduplans.StationPersons;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IStationPerService {

    /**
     *
     * @author Jayang 批量新增站段提报
     * @param stas
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel addStaPers(List<StationPersons> stas) throws SQLException;

    /**
     *
     * @author Jayang 获取站段提报
     * @param sta_code 提报CODE
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public StationPersons getStaPer(String sta_code) throws SQLException;

    /**
     *
     * @author Jayang 更新站段提报
     * @param stas
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel updateStaPerson(StationPersons stas) throws SQLException;

    /**
     *
     * @author Jayang 更新站段提报
     * @param stas
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel updateStaPerNum(StationPersons stas) throws SQLException;

    /**
     *
     * @author Jayang 批量更新站段提报
     * @param stas
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel updateStaPersons(List<StationPersons> stas) throws SQLException;

    /**
     *
     * @author Jayang 批量删除站段提报
     * @param stas
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel removeStaPer(String sta_code) throws SQLException;

    /**
     *
     * @author Jayang 获取站段提报集合
     * @param roleids 培训计划CODE
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public List<StationPersons> getStaPersons(String... roleids) throws SQLException;

    /**
     *
     * @author Jayang 获取站段提报分页数据
     * @param pageModel 站段提报专用分页搜索子类
     * @return 执行结果
     * @throws java.sql.SQLException
     *
     */
    public DataModel getStaPersonsPagging(StaPeronsSearch pageModel) throws Throwable;
}
