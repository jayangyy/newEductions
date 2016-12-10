/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.OracleSelectBuilder;
import cr.cdrb.web.edu.model.DepartmentTree;
import cr.cdrb.web.edu.model.Special_Job_Card;
import cr.cdrb.web.edu.model.Special_Job_Type;
import cr.cdrb.web.edu.model.Unit;
import cr.cdrb.web.edu.security.domains.EduUser;
import java.sql.SQLException;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author milord
 */
@Component
public class SpecialJobCardDao {

    @Resource(name = "db1")
    private DbUtilsPlus db;

    public Map<Integer, List<Special_Job_Card>> getSpecialJobCardPaging(int page, int rows, String sort, String order, String filterRules, String search, Object[] param) throws SQLException, Exception {
        String _from = "select u.*,b.u_id dwid,b.name dwname,d.dwxxbmbs bmid,d.xsbmmc bmname,d.treename from \n"
                + "(select a.*,case when valid_end_date > sysdate then case when reviewdate<sysdate then 0 when reviewdate<add_months(sysdate,3) then 1 else 2 end else 0 end as status from edu_special_job_card a) u \n"
                + "INNER JOIN EMPLOYEE e on u.pid=e.EM_IDCARD \n"
                + "INNER JOIN v_position p on e.EM_ID=p.EMPLOYEE_ID \n"
                + "INNER JOIN B_UNIT b on b.u_id=p.dw_id\n"
                + "INNER JOIN B_DEPARTMENT d on d.dwxxbmbs=p.bm_id";
        ISelectBuilder builder = new OracleSelectBuilder()
                .from(_from)
                .where(filterRules)
                .orderBy(sort + " " + order)
                .page(page, rows);

        String totalSql = builder.total();
        String querySql = builder.toSql();
        Map<Integer, List<Special_Job_Card>> map = new HashMap<>();
        Integer total = Integer.parseInt(db.queryScalar(totalSql, param).toString());
        map.put(total, db.queryBeanList(Special_Job_Card.class, querySql, param));
        return map;
    }

    public Map<Boolean, String> insertSpecialJobCard(Special_Job_Card card) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_special_job_card where card_no=? or (pid=? and lbcode=? and xmcode=?)";
        Integer count = Integer.parseInt(db.queryArray(sql, card.getCard_no(), card.getPid(), card.getLbcode(), card.getXmcode())[0].toString());
        if (count <= 0) {
            sql = "insert into edu_special_job_card(card_no,cert_no,pid,name,sex,lbcode,zylb,xmcode,zcxm,firstdate,valid_begin_date,valid_end_date,reviewdate,companyid,optuserid,optusername,optdate) values(?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,to_date(?,'yyyy-mm-dd'))";
            db.insert(sql, card.getCard_no(), card.getCert_no(), card.getPid(), card.getName(), card.getSex(), card.getLbcode(), card.getZylb(), card.getXmcode(), card.getZcxm(), card.getFirstdate(), card.getValid_begin_date(), card.getValid_end_date(), card.getReviewdate(), card.getCompanyid(),card.getOptuserid(),card.getOptusername(),card.getOptdate());
            resultMap.put(true, "保存成功！");
        } else {
            resultMap.put(false, "保存失败，该卡号[ " + card.getCard_no() + " ]或者[用户作业类别与准操项目]数据已经存在！");
        }
        return resultMap;
    }

    public Map<Boolean, String> updateSpecialJobCard(Special_Job_Card card, String oldcardno) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "select count(1) from edu_special_job_card where card_no=? and card_no<>?";
        Integer count = Integer.parseInt(db.queryArray(sql, card.getCard_no(), oldcardno)[0].toString());
        if (count <= 0) {
            sql = "update edu_special_job_card set card_no=?,cert_no=?,pid=?,name=?,sex=?,lbcode=?,zylb=?,xmcode=?,zcxm=?,firstdate=to_date(?,'yyyy-mm-dd'),valid_begin_date=to_date(?,'yyyy-mm-dd'),valid_end_date=to_date(?,'yyyy-mm-dd'),reviewdate=to_date(?,'yyyy-mm-dd') where card_no=?";
            db.update(sql, card.getCard_no(), card.getCert_no(), card.getPid(), card.getName(), card.getSex(), card.getLbcode(), card.getZylb(), card.getXmcode(), card.getZcxm(), card.getFirstdate(), card.getValid_begin_date(), card.getValid_end_date(), card.getReviewdate(), oldcardno);
            resultMap.put(true, "编辑成功！");
        } else {
            resultMap.put(false, "编辑失败，该卡号[ " + card.getCard_no() + " ]数据已经存在！");
        }
        return resultMap;
    }

    public Map<Boolean, String> deleteSpecialJobCard(String cardno) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "delete from edu_special_job_card where card_no=?";
        db.update(sql, cardno);
        resultMap.put(true, "删除成功！");
        return resultMap;
    }

    public Special_Job_Card getSpecialJobCardByCardNo(String card_no) throws Exception {
        String sql = "select * from edu_special_job_card where card_no=?";
        Special_Job_Card card = db.queryBean(Special_Job_Card.class, sql, card_no);
        return card;
    }

    public List<Special_Job_Type> getSpecialJobType(String fcode) throws SQLException {
        String sql = "select code,name,parentcode from edu_special_job_type where parentcode=?";
        return db.queryBeanList(Special_Job_Type.class, sql, fcode);
    }

    public List<Special_Job_Type> getAllSpecialJobType() throws SQLException {
        String sql = "select code,name,parentcode from edu_special_job_type";
        return db.queryBeanList(Special_Job_Type.class, sql);
    }

    public Map<Boolean, String> insertSJCRevirewLog(String car_no, String reviewdate, String old_begin_date, String old_end_date, String new_begin_date, String new_end_date, String opttime, String optuid) throws SQLException {
        Map<Boolean, String> resultMap = new HashMap<>();
        String sql = "insert into edu_sjc_revirew_log(card_no,reviewdate,old_begin_date,old_end_date,new_begin_date,new_end_date,optdate,optuid) values(?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd hh24:mi:ss'),?)";
        db.insert(sql, car_no, reviewdate, old_begin_date, old_end_date, new_begin_date, new_end_date, opttime, optuid);
        resultMap.put(true, "保存成功！");
        return resultMap;
    }

    public EduUser getUserInfoByPid(String pid, String companyid,boolean iszjcuser) throws SQLException {
        String sql = "select U.IDCARD AS username,Z.EM_NAME as workername,(case when Z.EM_EGENDER=1 THEN '男' else '女' end) as sex,b.dw_id as companyId from EDU_USERS U left join EMPLOYEE  Z on Z.EM_IDCARD=U.IDCARD left JOIN v_position b on Z.EM_ID = b.EMPLOYEE_ID where U.IDCARD=?";
        if(!iszjcuser){
            sql += " and b.dw_id=?";
            return db.queryBean(EduUser.class, sql, pid, companyid);
        }else{
            return db.queryBean(EduUser.class, sql, pid);
        }
    }
    public List<EduUser> getUserByName(String name, String companyid,boolean iszjcuser) throws SQLException {
        String sql = "select U.IDCARD AS username,Z.EM_NAME as workername,(case when Z.EM_EGENDER=1 THEN '男' else '女' end) as sex,z.em_eduback xl,u.NAME as company,b.dw_id as companyId from EDU_USERS U left join EMPLOYEE  Z on Z.EM_IDCARD=U.IDCARD left JOIN v_position b on Z.EM_ID = b.EMPLOYEE_ID left join b_unit u on b.DW_ID=u.U_ID where Z.EM_NAME like ?";
        if(!iszjcuser){
            sql += " and b.dw_id=?";
            return db.queryBeanList(EduUser.class, sql, "%"+name+"%", companyid);
        }else{
            return db.queryBeanList(EduUser.class, sql, "%"+name+"%");
        }
    }

    public List<Unit> getAllUnit(String zjcunitid) throws SQLException {
        String sql = "select u_id id, name, system from b_unit where P_ID='9999000200140006' or U_ID=? order by u_level, name";
        List<Unit> units = db.queryBeanList(Unit.class, sql, zjcunitid);
        return units;
    }

    public List<DepartmentTree> getDepartmentTreeByDwid(String dwid) throws SQLException {
//        String sql = "select dwxxbmbs id, xsbmmc text, treename from b_department where dwbsm=? and treename is not null order by treename";
        String sql = "select dwxxbmbs id, xsbmmc text, treename from b_department where dwbsm=? order by treename";
        List<DepartmentTree> dms = db.queryBeanList(DepartmentTree.class, sql, dwid);
        List<DepartmentTree> parents = new ArrayList<>();
        DepartmentTree root = new DepartmentTree();
        for (int i = 0; i < dms.size(); i++) {
            DepartmentTree self = dms.get(i);
            if (parents.size() == 0) {
                root.getChildren().add(self);
                parents.add(self);
            } else {
                int last = parents.size() - 1;
                DepartmentTree parent = parents.get(last);
                if (isChild(parent, self)) {
                    parent.setState("closed");
                    parent.getChildren().add(self);
                    parents.add(self);
                }
                else {
                    parents.remove(last);
                    i--;
                }
            }
        }
        return root.getChildren();
    }

    private Boolean isChild(DepartmentTree parent, DepartmentTree depart) {
        return depart.getTreename().startsWith(parent.getTreename() + "-");
    }
}
