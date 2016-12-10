/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.BookTypeDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.BookType;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrator
 */
@Component
public class BookTypeService {
    @Autowired
    private BookTypeDao dao;
    
    public DataModel getBookType() throws SQLException {
        return new DataModel().withData(dao.getBookType());
    }
    
    public DataModel getBigType() throws SQLException {
        return new DataModel().withData(dao.getBigType());
    }
    
    public DataModel getSmallType() throws SQLException {
        return new DataModel().withData(dao.getSmallType());
    }
    
    public DataModel getSmallTypeByCode(String code) throws SQLException {
        return new DataModel().withData(dao.getSmallTypeByCode(code));
    }
    
    /**
     * 一次性返回：类型、大类、小类
     * @return 类型、大类、小类 的 Map
     * @throws SQLException
     */
    public DataModel getAllType() throws SQLException {
        Map map = new HashMap<String, List<BookType>>();
        map.put("booktype", dao.getBookType());
        map.put("bigtype", dao.getBigType());
        map.put("smalltype", dao.getSmallType());
        return new DataModel().withData(map);
    }
    
}
