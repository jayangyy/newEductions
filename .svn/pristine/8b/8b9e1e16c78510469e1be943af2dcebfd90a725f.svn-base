/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.web.edu.model.BookType;
import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrator
 */
@Component
public class BookTypeDao {
    @Resource(name = "db3")
    private DbUtilsPlus db;
    
    public List<BookType> getBookType() throws SQLException {
        return db.queryBeanList(BookType.class,"SELECT 代码 code, 名称 type FROM 类型 WHERE ID IN(17,18,19,21)");
    }
    
    public List<BookType> getBigType() throws SQLException {
        return db.queryBeanList(BookType.class,"SELECT 代码 code, 名称 type FROM 大类");
    }
    
    public List<BookType> getSmallType() throws SQLException {
        return db.queryBeanList(BookType.class,"SELECT 代码 code, 名称 type FROM 小类");
    }
    
    public List<BookType> getSmallTypeByCode(String code) throws SQLException {
        return db.queryBeanList(BookType.class,"SELECT 代码 code, 名称 type FROM 小类 WHERE 代码 LIKE '"+code + "%'");
    }
}
