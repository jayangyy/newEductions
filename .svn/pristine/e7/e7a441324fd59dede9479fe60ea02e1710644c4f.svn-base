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
 *
 * 审核状态枚举类型
 */
public enum EduReviewsStatus {
    处室草稿(6),
    职教待审(0),
    职教审核回退(1),
    职教审核结束(2),
    财务待审(3),
    财务审核回退(4),
    财务审核结束(5);
    // 成员变量
    private int status;

    // 构造方法
    private EduReviewsStatus(int status) {
        this.status = status;
    }

    // get set 方法
    public int getStats() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    // 获取职教状态集合
    public static String getTeachStatus() {
        return EduReviewsStatus.职教待审.getStats() + "," + EduReviewsStatus.职教审核回退.getStats();
    }
    // 获取职教状态集合

    public static String getTeachAuth() {
        return EduReviewsStatus.职教待审.getStats() + "," + EduReviewsStatus.职教审核回退.getStats();
    }
// 获取财务状态集合

    public static String getFinanceStatus() {
        return EduReviewsStatus.财务审核回退.getStats() + "," + EduReviewsStatus.财务待审.getStats() + "," + EduReviewsStatus.职教审核结束.ordinal();
    }
    // 获取财务状态集合

    public static String getFinanceAuth() {
        return EduReviewsStatus.财务待审.getStats() + "," + EduReviewsStatus.财务审核回退.getStats() + "," + EduReviewsStatus.职教审核结束.ordinal();
    }

    public static List<ComboTree> getTeachAuths(String flag) {
        List<ComboTree> list = new ArrayList<ComboTree>();
        Field[] fields = EduReviewsStatus.class.getFields();
        for (Field item : fields) {
            System.out.println(item.getName());
            String name = item.getName();
            if (name.contains(flag) && !name.contains("待审")) {
                ComboTree tree = new ComboTree();
                tree.setId(EduReviewsStatus.valueOf(item.getName()).ordinal());
                tree.setText(name);
                list.add(tree);
            }
        }
        return list;
    }
    //获取值方式EduReviewsStatus.Process.getStats()
}
