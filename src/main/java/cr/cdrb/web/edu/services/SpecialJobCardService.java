/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.SpecialJobCardDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.model.Special_Job_Card;
import cr.cdrb.web.edu.model.Special_Job_Type;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class SpecialJobCardService {
    @Resource
    private SpecialJobCardDao dao;
    
    public DataModel getSpecialJobCardPaging(int page,int rows,String sort,String order, String filterRules, String search,Object[] param) throws SQLException, Exception {
        Map<Integer, List<Special_Job_Card>> cardsPaging = dao.getSpecialJobCardPaging(page, rows , sort, order, filterRules, search,param);
        Integer key;
        key = (Integer)cardsPaging.keySet().toArray()[0];
        return new DataModel().withData(cardsPaging.get(key), key);
    }
    
    public DataModel getUserInfoByPid(String pid,String companyid,boolean iszjcuser) throws SQLException{
        return new DataModel().withData(dao.getUserInfoByPid(pid,companyid,iszjcuser));
    }
    
    public DataModel getUserByName(String name,String companyid,boolean iszjcuser) throws SQLException{
        return new DataModel().withData(dao.getUserByName(name,companyid,iszjcuser));
    }
    
    public DataModel insertSpecialJobCard(Special_Job_Card card) throws Exception {
        Map<Boolean, String> resultMap = dao.insertSpecialJobCard(card);
        return setResultModel(resultMap);
    }
    
    public DataModel updateSpecialJobCard(Special_Job_Card card,String oldcardno) throws Exception {
        Special_Job_Card _tempcard = dao.getSpecialJobCardByCardNo(oldcardno);
        card.setReviewdate(_tempcard.getReviewdate());
        Map<Boolean, String> resultMap = dao.updateSpecialJobCard(card,oldcardno);
        return setResultModel(resultMap);
    }
    
    public DataModel deleteSpecialJobCard(String cardno) throws Exception {
        Map<Boolean, String> resultMap = dao.deleteSpecialJobCard(cardno);
        return setResultModel(resultMap);
    }
    
    public Object getSpecialJobCardByCardNo(String card_no) throws Exception {
        return new DataModel().withData(dao.getSpecialJobCardByCardNo(card_no));
    }
    
    public Object getSpecialJobType(String fcode) throws Exception {
        return new DataModel().withData(dao.getSpecialJobType(fcode));
    }
    
    public Object getAllUnit(String zjcunitid) throws Exception {
        return new DataModel().withData(dao.getAllUnit(zjcunitid));
    }
    
    public Object getDepartmentTreeByDwid(String dwid) throws Exception {
        return new DataModel().withData(dao.getDepartmentTreeByDwid(dwid));
    }
    
    public List<Special_Job_Type> getAllSpecialJobType() throws Exception {
        return dao.getAllSpecialJobType();
    }
    
    private DataModel setResultModel(Map<Boolean, String> resultMap){
        Boolean key;
        key = (Boolean)resultMap.keySet().toArray()[0];
        if(key)
            return new DataModel().withInfo(resultMap.get(key));
        else
            return new DataModel().withErr(resultMap.get(key));
    }
    
    public Object reviewSpecialJobCard(String cardnos,String reviewdate,String upid) throws Exception {
        String[] cardnoArr = cardnos.split(",");
        for (int i = 0; i < cardnoArr.length; i++) {
            String cardno = cardnoArr[i];
            Special_Job_Card card = dao.getSpecialJobCardByCardNo(cardno);
            String old_begin_date = card.getValid_begin_date();
            String old_end_date = card.getValid_end_date();
            String new_begin_date = old_begin_date;
            String new_end_date = old_end_date;
            //比较有效期与复审日期，判断是否需要设置新的有效期
            //复审日期+3个月大于有效期结束日期，则需设置新的有效期
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            Calendar c3 = Calendar.getInstance();
            c1.setTime(df.parse(reviewdate));
            c1.add(Calendar.MONTH, 3);
            c2.setTime(df.parse(old_end_date));
            int result=c1.compareTo(c2);
            if(result>0){
                new_begin_date = reviewdate;
                c1.add(Calendar.MONTH, -3);
                c1.add(Calendar.YEAR, 6);
                new_end_date = df.format(c1.getTime());
                card.setValid_begin_date(new_begin_date);
                card.setValid_end_date(new_end_date);
            }
            //设置新的复审日期
            c3.setTime(df.parse(reviewdate));
            c3.add(Calendar.YEAR, 3);
            String new_review_date = df.format(c3.getTime());
            card.setReviewdate(new_review_date);
            //更新card
            dao.updateSpecialJobCard(card,cardno);
            //记录复审日志
            df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String opttime = df.format(new Date());
            dao.insertSJCRevirewLog(cardno, reviewdate, old_begin_date, old_end_date, new_begin_date, new_end_date,opttime, upid);
        }
        return new DataModel().withInfo("操作成功！");
    }
    
}
