/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.BookDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.Book;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class BookService {
    @Resource
    private BookDao dao;
    
    public DataModel getBooksPaging(int page,int rows,String sort,String order, String filterRules, String search,String upid,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Book>> booksPaging = dao.getBooksPaging(page, rows , sort, order, filterRules, search, upid, param);
//        Set<Map.Entry<String, List<Book>>> entrySet = booksPaging.entrySet();
//        if(entrySet!=null)
//        {
//            Iterator<Map.Entry<String, List<Book>>> iterator = entrySet.iterator();
//        }
        Integer key;
        key = (Integer)booksPaging.keySet().toArray()[0];
        return new DataModel().withData(booksPaging.get(key), key);
    }
    
    public DataModel getSgspBooks(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws Exception {
        return new DataModel().withData(dao.getSgspBooks(page, rows , sort, order, filterRules, search, param));
    }
    
    public Object getBookById(int id) throws Exception {
        return new DataModel().withData(dao.getBookById(id));
    }
    
    public Object updateBook(Book book) throws Exception {
        return new DataModel().withInfo(dao.updateBook(book));
    }
    
    public Object deleteBook(Book book,String optUID,String optUName) throws Exception {
        return new DataModel().withInfo(dao.deleteBook(book,optUID,optUName));
    }
    
    public Object shBook(int bookid,String optUID,String optUName,String optDate,String ty) throws Exception {
        return new DataModel().withInfo(dao.shBook(bookid,optUID,optUName,optDate,ty));
    }
    
    public DataModel insertBook(Book book) throws Exception {
        return new DataModel().withInfo(dao.insertBook(book));
    }
    
    public Object bookBindPost(String bookids,String posts) throws Exception {
        return dao.bookBindPost(bookids,posts);
    }
    
    public Object collectionBook(String bookids,String userid,String opt) throws Exception {
        return new DataModel().withInfo(dao.collectionBook(bookids,userid,opt));
    }
    
    public Object getPostByBookId(String bookid) throws Exception {
        return dao.getPostByBookId(bookid);
    }
}
