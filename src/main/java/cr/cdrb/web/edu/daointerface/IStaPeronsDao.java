/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

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
public interface IStaPeronsDao {

    public Boolean addStaPers(List<StationPersons> stas) throws SQLException;

    public StationPersons getStaPer(String sta_code) throws SQLException;

    public Boolean updateStaPerson(StationPersons stas) throws SQLException;

    public Boolean updateStaPerNum(StationPersons stas) throws SQLException;

    public Boolean updateStaPersons(List<StationPersons> stas) throws SQLException;

    public Boolean removeRole(String sta_code) throws SQLException;

    public List<StationPersons> getStaPersons(String... roleids) throws SQLException;

    public Map<Integer, List<StationPersons>> getStaPersonsPagging(StaPeronsSearch pageModel) throws Throwable;
}
