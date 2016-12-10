/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services.IServices;

import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.ClassCostsSearch;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduNewPost;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.educlass.EduTrainingCategory;
import cr.cdrb.web.edu.domains.educlass.PlanClassCostDto;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

/**
 *
 * @author Jayang
 */
public interface IEduClassService {

    /**
     *
     * 新增班级
     *
     * @param model 班级模型
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel addClass(EduClass model) throws SQLException, ParseException;

    /**
     *
     * 更新班级
     *
     * @param model 班级模型
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel updateClass(EduClass model) throws SQLException, ParseException;

    /**
     *
     * 获取单个班级信息
     *
     * @param id 班级ID
     * @return EduClass 班级模型
     * @throws java.sql.SQLException
     */
    public EduClass getClassSingal(String id) throws SQLException;

    /**
     *
     * 获取班级集合
     *
     * @param ids 班级ID集合 可变参数
     * @return List<EduClass>
     * @throws java.sql.SQLException
     */
    public List<EduClass> getClassList(String... ids) throws SQLException;

    /**
     *
     * 批量删除班级信息
     *
     * @param ids 班级ID集合
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel deleteClass(String ids) throws SQLException;

    /**
     *
     * 获取班级分页数据
     *
     * @param pageModel 分页模型
     * @return DataModel
     * @throws java.sql.SQLException
     */
    public DataModel getClassPages(QueryModel pageModel) throws Throwable;

    /**
     *
     * 获取专业
     *
     * @param id
     * @return List<EduProf>
     * @throws java.sql.SQLException
     */
    public List<EduProf> getProfs(String id) throws SQLException;

    /**
     *
     * 获取培训类别
     *
     * @param id
     * @return List<EduTrainingCategory>
     * @throws java.sql.SQLException
     */
    public List<EduTrainingCategory> getTrains(String id) throws SQLException;

    /**
     *
     * 获取新任工种
     *
     * @param id
     * @return List<EduTrainingCategory>
     * @throws java.sql.SQLException
     */
    public List<EduNewPost> getPosts() throws SQLException;

    /**
     *
     * 获取已审批计划及经费信息
     *
     * @param search 搜索条件模型
     * @return List<PlanClassCostDto>
     * @throws java.sql.SQLException
     */
    public List<PlanClassCostDto> getPlansCosts(ClassCostsSearch search) throws SQLException;
}
