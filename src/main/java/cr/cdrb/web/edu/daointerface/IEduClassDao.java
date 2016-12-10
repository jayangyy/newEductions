/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.daointerface;

import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.ClassCostsSearch;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduNewPost;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.educlass.EduTrainingCategory;
import cr.cdrb.web.edu.domains.educlass.PlanClassCostDto;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jayang
 */
public interface IEduClassDao {

    public Boolean addClass(EduClass educlass) throws SQLException;

    public Boolean updateClass(EduClass educlass) throws SQLException;

    public Map<Integer, List<EduClass>> getClassPage(QueryModel pageModel) throws Throwable;

    public List<EduClass> getClassList(String... classIds) throws SQLException;

    public Boolean removeClass(String classIds) throws SQLException;

    public EduClass getClassById(String classId) throws SQLException;

    public List<EduProf> getProfs(Object... uids) throws SQLException;

    public List<EduTrainingCategory> getTrainnings(Object... uids) throws SQLException;

    public List<EduNewPost> getNewPosts() throws SQLException;

    public int getPersonNum(String plancode, String cost_id) throws SQLException;

    public List<PlanClassCostDto> getPlansAndCosts(ClassCostsSearch search) throws SQLException;

    public EduClass getClassByNo(String classno) throws SQLException;

}
