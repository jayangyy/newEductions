/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.daointerface.IEduPlansDao;
import cr.cdrb.web.edu.daointerface.IStaPeronsDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.eduplans.EduPlans;
import cr.cdrb.web.edu.domains.eduplans.EduReviewSimpleStatus;
import cr.cdrb.web.edu.domains.eduplans.StaPeronsSearch;
import cr.cdrb.web.edu.domains.eduplans.StationPersons;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.IServices.IStationPerService;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jayang
 */
@Service
public class StationPerService implements IStationPerService {

    @Autowired
    private IStaPeronsDao perDao;
    @Autowired
    IEduPlansDao plansDao;

    @Override
    public DataModel addStaPers(List<StationPersons> stas) throws SQLException {
        return perDao.addStaPers(stas) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public StationPersons getStaPer(String sta_code) throws SQLException {
        return perDao.getStaPer(sta_code);
    }

    @Override
    public DataModel updateStaPerson(StationPersons stas) throws SQLException {
        EduPlans plan = plansDao.getPlanInclude(stas.getPlan_code());
        if (plan.getPlantranfers().size() > 0) {
            throw new SQLException("计划已开始，不能修改!");
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
            throw new SQLException("计划已完结，不能修改!");
        }
        EduUser user = UsersService.GetCurrentUser();
        if (!(user.getUsername().equalsIgnoreCase(stas.getAdd_user()) || user.getCompany().equalsIgnoreCase(stas.getStation_name()))) {
            throw new SQLException("无修改权限，不能修改!");
        }
        return perDao.updateStaPerson(stas) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel updateStaPerNum(StationPersons stas) throws SQLException {
        EduPlans plan = plansDao.getPlanInclude(stas.getPlan_code());
        EduUser user = UsersService.GetCurrentUser();
        if (plan.getPlantranfers().size() > 0) {
            throw new SQLException("计划已开始，不能修改!");
        }
        if (plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
            throw new SQLException("计划已完结，不能修改!");
        }
        if (!(user.getUsername().equalsIgnoreCase(stas.getAdd_user()) || user.getCompany().equalsIgnoreCase(stas.getStation_name()))) {
            throw new SQLException("无修改权限，不能修改!");
        }
        return perDao.updateStaPerNum(stas) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel updateStaPersons(List<StationPersons> stas) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        for (StationPersons item : stas) {
            EduPlans plan = plansDao.getPlanById(item.getPlan_code());
            if (plan.getPlantranfers().size() > 0) {
                throw new SQLException("计划已开始，不能修改!");
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("计划已完结，不能修改!");
            }
            if (!(user.getUsername().equalsIgnoreCase(item.getAdd_user()) || user.getCompany().equalsIgnoreCase(item.getStation_name()))) {
                throw new SQLException("无修改权限，不能修改!");
            }
        }
        return perDao.updateStaPersons(stas) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public DataModel removeStaPer(String sta_code) throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
        //计划人才有删除权限
        List<StationPersons> pers = perDao.getStaPersons("", sta_code);
        for (StationPersons item : pers) {
            EduPlans plan = plansDao.getPlanInclude(item.getPlan_code());
            if (plan.getPlantranfers().size() > 0) {
                throw new SQLException("计划已开始，不能修改!");
            }
            if (plan.getPlan_status() == EduReviewSimpleStatus.处室经办.getStats()) {
                throw new SQLException("计划已完结，不能删除!");
            }
            if (!(user.getUsername().equalsIgnoreCase(item.getAdd_user()) || user.getCompany().equalsIgnoreCase(item.getStation_name()))) {
                throw new SQLException("无修改权限，不能修改!");
            }
        }
        return perDao.removeRole(sta_code) ? new DataModel().withInfo("执行成功!") : new DataModel().withErr("执行失败!");
    }

    @Override
    public List<StationPersons> getStaPersons(String... roleids) throws SQLException {
        return perDao.getStaPersons(roleids);
    }

    @Override
    public DataModel getStaPersonsPagging(StaPeronsSearch pageModel) throws Throwable {
        Map<Integer, List<StationPersons>> resPaging = perDao.getStaPersonsPagging(pageModel);;
        Integer key;
        key = (Integer) resPaging.keySet().toArray()[0];
        return new DataModel().withData(resPaging.get(key), key);
    }

}
