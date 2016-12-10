/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.eduplans;

import cr.cdrb.web.edu.domains.easyui.ComboTree;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jayang
 */
public enum EduReviewSimpleStatus {
    处室待办(2),
    处室经办(1),
    处室回发(5),
    处室废弃(7),
    待办(3),
    经办(4),
    回发(6),
    职教待审(8),//经费审批
    职教经办(9),//经费审批
    费用回发(12),
    财务待审(10),//经费审批
    财务经办(11),//经费审批
    开始建班(14),
    建班结束(13);
    private int status;

    // get set 方法
    public int getStats() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    // 构造方法
    private EduReviewSimpleStatus(int status) {
        this.status = status;
    }

    //其他待办查看
    public static String getCompanyStatus() {
        return EduReviewSimpleStatus.待办.getStats() + "," + EduReviewSimpleStatus.回发.getStats();
    }

    // 处室待办查看
    public static String getOfficesAuth() {
        return EduReviewSimpleStatus.处室回发.getStats() + "," + EduReviewSimpleStatus.处室待办.getStats();
    }

    public static String getOfficOverStatus() {
        return EduReviewSimpleStatus.处室废弃.getStats() + "," + EduReviewSimpleStatus.处室经办.getStats();
    }

    public static List<ComboTree> getTeachAuths(String flag) {
        List<ComboTree> list = new ArrayList<ComboTree>();
        Field[] fields = EduReviewsStatus.class.getFields();
        for (Field item : fields) {
            System.out.println(item.getName());
            String name = item.getName();
            if (name.contains(flag) && !name.contains("待审")) {
                ComboTree tree = new ComboTree();
                tree.setId(EduReviewsStatus.valueOf(item.getName()).getStats());
                tree.setText(name);
                list.add(tree);
            }
        }
        return list;
    }
}
