/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.daointerface.IBaseDao;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import java.math.BigDecimal;
import java.util.ArrayList;
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
public class BaseDao implements IBaseDao {
    
    @Resource(name = "db1")
    private DbUtilsPlus db;
    
    @Override
    public <T, L extends QueryModel> Map<Integer, List<T>> getPageComs(L pageModel, Class<T> classtype) throws Throwable {
        if (pageModel.getParams() == null) {
            pageModel.setParams(new ArrayList<Object>());                     
        }
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(pageModel.getSelects())
                .where(pageModel.getFilterRules())
                .orderBy(pageModel.getSort() + " " + pageModel.getOrder())
                .page(pageModel.getPage(), pageModel.getRows());
        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<T>> map = new HashMap<>();
        BigDecimal total = db.queryScalar(totalSql, pageModel.getParams().toArray());
        map.put(Integer.parseInt(total.toString()), db.queryBeanList(classtype, querySql, pageModel.getParams().toArray()));
        return map;
    }
}
