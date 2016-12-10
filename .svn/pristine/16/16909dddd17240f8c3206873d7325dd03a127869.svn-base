/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author milord
 */
public class DepartmentTree {
    private String id; 
    private String text;
    private String treename;
    private List<DepartmentTree> children;
    private String state;

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }

    /**
     * @return the children
     */
    public List<DepartmentTree> getChildren() {
        if(children == null) children = new ArrayList<DepartmentTree>();
        return children;
    }

    /**
     * @param children the children to set
     */
    public void setChildren(List<DepartmentTree> children) {
        this.children = children;
    }

    /**
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * @return the treename
     */
    public String getTreename() {
        return treename==null?"":treename;
    }

    /**
     * @param treename the treename to set
     */
    public void setTreename(String treename) {
        this.treename = treename;
    }
}
