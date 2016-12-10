/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import com.alibaba.fastjson.JSON;
import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.SqlserverSelectBuilder;
import cr.cdrb.web.edu.model.Book;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class BookDao {

    @Resource(name = "db3")
    private DbUtilsPlus db;

//    @Resource(name = "dataSource1")
//    private DataSource ds1;
    public Map<Integer, List<Book>> getBooksPaging(int page, int rows, String sort, String order, String filterRules, String search,String upid,Object[] param) throws SQLException, Exception {
        ISelectBuilder builder = new SqlserverSelectBuilder()
                .from("SELECT a.id,title,author,press,tdate,type2,type2_id type2Id,type1,type3,type4,abstract abstr,fileurl fileurl1,fileurl2,fileurl3,fileurl4,fileurl5,fileurl6,linkurl\n" +
                        ",height,sh,点击 clickCount,下载 downCount,发布人 publishUser,审核人 shUser,审核时间 shTime,发布时间 publishTime, 审核人ID shUserId, 发布人ID publishUserId, 发布人单位ID publishUserUnitId, postcount,c.collection,memo from 资料信息 a inner join (SELECT a.id, \n" +
                        "count(b.BookId) postcount FROM 资料信息 a left join 资料工种 b on a.id=b.bookid GROUP BY a.id) b on a.id = b.id\n" +
                        "LEFT JOIN (select bookid,'是' collection from BookCollection where userid='"+upid+"') c on a.id=c.bookid")
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Book>> map = new HashMap<>();
        Integer total = db.queryScalar(totalSql,param);
        map.put(total, db.queryBeanList(Book.class, querySql,param));
        return map;
    }
    
    public List<Book> getSgspBooks(int page, int rows, String sort, String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        ISelectBuilder builder = new SqlserverSelectBuilder()
                .from("SELECT a.id,title,author,press,tdate,type2,type2_id type2Id,type1,type3,type4,abstract abstr,fileurl fileurl1,fileurl2,fileurl3,fileurl4,fileurl5,fileurl6,linkurl\n" +
                        "height,sh,点击 clickCount,下载 downCount,发布人 publishUser,审核人 shUser,审核时间 shTime,发布时间 publishTime, 审核人ID shUserId, 发布人ID publishUserId, 发布人单位ID publishUserUnitId\n" +
                        ", memo,b.专业 professional from 资料信息 a LEFT JOIN (select 专业,大类ID from 行车工种 GROUP BY 专业,大类ID) b ON a.Type2_ID=b.大类ID")
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String querySql = builder.toSql();
        return db.queryBeanList(Book.class, querySql, param);
    }

    public Object getBookById(int id) throws Exception {
        ISelectBuilder builder = new SqlserverSelectBuilder()
                .select("id,title,author,press,tdate,type2,type2_id type2Id,type1,type3,type4,abstract abstr,fileurl fileurl1,fileurl2,fileurl3,fileurl4,fileurl5,fileurl6,linkurl,height,sh,点击 clickCount,下载 downCount,发布人 publishUser,审核人 shUser,审核时间 shTime,发布时间 publishTime,审核人ID shUserId,发布人ID publishUserId,发布人单位ID publishUserUnitId")
                .from("资料信息")
                .where("id=?");
        String querySql = builder.toSql();
        Book book = db.queryBean(Book.class, querySql, id);
        return book;
    }

    public String updateBook(Book book) throws SQLException {
        String columns = "title=?,author=?,press=?,tdate=?,type2=?,type2_id=?,type1=?,type3=?,type4=?,abstract=?,fileurl=?,fileurl2=?,fileurl3=?,fileurl4=?,fileurl5=?,fileurl6=?";
        String sql = "update 资料信息 set " + columns + " where id=" + book.getId();
        db.update(sql,
                book.getTitle(), book.getAuthor(), book.getPress(), book.getTdate(), book.getType2(), book.getType2Id(), book.getType1(), book.getType3(), book.getType4(), book.getAbstr(), book.getFileurl1(), book.getFileurl2(), book.getFileurl3(), book.getFileurl4(), book.getFileurl5(), book.getFileurl6());
        return "编辑资料成功！";
    }

    public String deleteBook(Book book,String optUID,String optUName) throws SQLException {
        String sql = "INSERT into 已删资料信息 select a.*,? optUserId,? optUserName from 资料信息 a where id=?";
        db.insert(sql,optUID,optUName,book.getId());
        String delSql = "delete from 资料信息 where id=" + book.getId();
        db.update(delSql);
        return "删除成功！";
    }

    public String shBook(int bookid,String optUID,String optUName,String optDate,String ty) throws SQLException {
        String upSql = "update 资料信息 set sh=?,审核人=?,审核人ID=?,审核时间=? where id=?";
        db.update(upSql,ty,optUName,optUID,optDate,bookid);
        return "操作成功！";
    }

    public String insertBook(Book book) throws SQLException {
        String columns = "title,author,press,tdate,type2,type2_id,type1,type3,type4,abstract,fileurl,fileurl2,fileurl3,fileurl4,fileurl5,fileurl6,linkurl,height,sh,点击,下载,发布人,审核人,审核时间,发布时间,审核人ID,发布人ID,发布人单位ID";
        StringBuilder sb = new StringBuilder();
        sb.append("'").append(book.getTitle()).append("'");
        sb.append(",'").append(book.getAuthor()).append("'");
        sb.append(",'").append(book.getPress()).append("'");
        sb.append(book.getTdate().equals("")? ",null" : ",'"+book.getTdate()+"'");
        sb.append(",'").append(book.getType2()).append("'");
        sb.append(",'").append(book.getType2Id()).append("'");
        sb.append(",'").append(book.getType1()).append("'");
        sb.append(",'").append(book.getType3()).append("'");
        sb.append(",'").append(book.getType4()).append("'");
        sb.append(",'").append(book.getAbstr()).append("'");
        sb.append(",'").append(book.getFileurl1()).append("'");
        sb.append(",'").append(book.getFileurl2()).append("'");
        sb.append(",'").append(book.getFileurl3()).append("'");
        sb.append(",'").append(book.getFileurl4()).append("'");
        sb.append(",'").append(book.getFileurl5()).append("'");
        sb.append(",'").append(book.getFileurl6()).append("'");
        sb.append(book.getLinkurl()==null?","+book.getLinkurl():",'"+book.getLinkurl()+"'");
        sb.append(book.getHeight()==null?","+book.getHeight():",'"+book.getHeight()+"'");
        book.setSh(book.getSh()==null?"0":book.getSh());
        sb.append(",'").append(book.getSh()).append("'");
        book.setClickCount(book.getClickCount()==null?"0":book.getClickCount());
        sb.append(",'").append(book.getClickCount()).append("'");
        book.setDownCount(book.getDownCount()==null?"0":book.getDownCount());
        sb.append(",'").append(book.getDownCount()).append("'");
        sb.append(book.getPublishUser()==null?","+book.getPublishUser():",'"+book.getPublishUser()+"'");
        sb.append(book.getShUser()==null?","+book.getShUser():",'"+book.getShUser()+"'");
        sb.append(book.getShTime()==null?","+book.getShTime():",'"+book.getShTime()+"'");
        sb.append(book.getPublishTime()==null?","+book.getPublishTime():",'"+book.getPublishTime()+"'");
        sb.append(book.getShUserId()==null?","+book.getShUserId():",'"+book.getShUserId()+"'");
        sb.append(book.getPublishUserId()==null?","+book.getPublishUserId():",'"+book.getPublishUserId()+"'");
        sb.append(book.getPublishUserUnitId()==null?","+book.getPublishUserUnitId():",'"+book.getPublishUserUnitId()+"'");
        
        String sql = "insert into 资料信息(" + columns + ") values(" + sb + ")";
        db.insert(sql);
        return "保存成功！";
    }

    public Object bookBindPost(String bookids, String posts) throws Exception {
        String[] bookIdArr = bookids.split(",");
        String[] postArr = posts.split(",");
        try {
            String deleteSql = "delete from 资料工种 where bookid in(" + bookids + ")";
            db.update(deleteSql);
            String insertSql = "insert into 资料工种(bookid,post) values(?,?)";
//            PreparedStatement stmt = db.getConnection().prepareStatement(insertSql);
            for (String bookid : bookIdArr) {
                for (String post : postArr) {
                    db.update(insertSql, bookid, post);
//                    stmt.setInt(1, Integer.parseInt(bookid));
//                    stmt.setString(2, post);
//                    stmt.execute();
                }
            }
            return JSON.parse("{'result':true,'info':'操作成功'}");
        } catch (Exception e) {
            return JSON.parse("{'result':false,'info':" + e.getMessage() + "}");
        }
    }
    
    public String collectionBook(String bookids, String userid,String opt) throws Exception {
        if("collection".equals(opt)){
            String[] bookIdArr = bookids.split(",");
            String sql = "";
            for (String bookid : bookIdArr) {
                sql = "select count(1) from BookCollection where bookid="+bookid+" and userid='"+userid+"'";
                Integer count = (Integer)db.queryArray(sql)[0];
                if(count<=0){
                    sql = "insert into BookCollection(bookid,userid) values(?,?)";
                    db.insert(sql, bookid, userid);
                }
            }
            return "收藏资料成功！";
        }
        else if("uncollection".equals(opt)){
            String[] bookIdArr = bookids.split(",");
            String sql = "";
            for (String bookid : bookIdArr) {
                sql = "delete BookCollection where bookid="+bookid+" and userid='"+userid+"'";
                db.update(sql);
            }
            return "取消收藏资料成功！";
        }
        else
            return "";
    }

    public Object getPostByBookId(String bookid) throws Exception {
        try {
            String querySql = "select post from 资料工种 where bookid=?";
            List<Object[]> queryArray = db.queryArrayList(querySql, bookid);
            return JSON.parse("{'result':true,'info':'获取数据成功！','rows':" + JSON.toJSONString(queryArray) + "}");
        } catch (Exception e) {
            return JSON.parse("{'result':false,'info':" + e.getMessage() + "}");
        }
    }
}
