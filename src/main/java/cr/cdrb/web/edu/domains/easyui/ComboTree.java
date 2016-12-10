/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.domains.easyui;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jayang 2016-08-04 EASYUI Combotree 数据模型
 */
public class ComboTree {

    public int getId() {
        return id;
    }

    public ComboTree() {
        this.setChildren(new ArrayList<ComboTree>());
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }

    public List<ComboTree> getChildren() {
        return children;
    }

    public void setChildren(List<ComboTree> children) {
        this.children = children;
    }
    private int id;
    private String text;
    private String state;
    private Boolean checked;
    private List<ComboTree> children;
}
