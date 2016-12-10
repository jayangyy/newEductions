/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.web.edu.daointerface.IEduUnits;
import cr.cdrb.web.edu.security.domains.EduUnit;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jayang
 */
@Repository
public class UnitDao implements IEduUnits {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    @Override
    public List<EduUnit> getUnits(Object... params) throws SQLException {
        String querySql = "select u_id,p_id,name from b_unit  where 1=1 ";
        List<Object> list = new ArrayList<Object>();
        if (params.length > 0) {
            //u_id
            if (params[0] != null && !params[0].equals("")) {
                querySql += " and u_id=? ";
                list.add(params[0]);
            }

            //p_id,
            if (params[1] != null && !params[1].equals("")) {
                String[] pidArray = params[1].toString().split(",");
                querySql+=" and p_id in('"+params[1]+"')";
//                if (pidArray.length > 1) {
//                    querySql += " and (p_id =? or p_id=?) ";
//                    list.add(pidArray[0]);
//                    list.add(pidArray[1]);
//                } else {
//                    querySql += " and p_id=?";
                    //list.add(params[1].toString());
//                }

            }
            //name
            if (params[2] != null && !params[2].equals("")) {
                querySql += " and name=? ";
                list.add(params[2]);
            }
             if (!StringUtils.isBlank(params[3].toString())) {
                querySql += " and name in ('"+params[3]+"')";
//                list.add(params[3]);
            }
        }
       querySql+=" order by name";
        return db.queryBeanList(EduUnit.class, querySql, list.toArray());
    }

    @Override
    public EduUnit getUnit(String uid) throws SQLException {
        String getByIdSql = "select * from b_unit where u_id=?";
        return db.queryBean(EduUnit.class, getByIdSql, uid);
    }

    @Override
    public Boolean isTeacher(String idcard) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<EduUnit> getUnitsGroups(Object... params) throws SQLException {
                String querySql = "select u_id,p_id,name,SYSTEM from b_unit  where 1=1 ";
        List<Object> list = new ArrayList<Object>();
        if (params.length > 0) {
            if (params[0] != null && !params[0].equals("")) {
                String[] pidArray = params[0].toString().split(",");
                querySql+=" and p_id in('"+params[0]+"')";
            }
             if (params[1] != null && !params[1].equals("")) {
                querySql+=" and SYSTEM='"+params[1]+"'";
            }
              if (params[2] != null && !params[2].equals("")) {
                querySql+=" and u_id='"+params[2]+"'";
                
            }
        }
       querySql+=" group by  u_id,p_id,name,SYSTEM  order by SYSTEM";
        return db.queryBeanList(EduUnit.class, querySql, list.toArray());
    }

}
