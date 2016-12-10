/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

import java.util.List;

/**
 *
 * @author milord
 */
public class PostForTree {
    private Integer id; 
    private String text;
    private String typeid;
    private List<PostForTree> children;
    private String state;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
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
    public List<PostForTree> getChildren() {
        return children;
    }

    /**
     * @param children the children to set
     */
    public void setChildren(List<PostForTree> children) {
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
     * @return the typeId
     */
    public String getTypeId() {
        return typeid;
    }

    /**
     * @param typeId the typeId to set
     */
    public void setTypeId(String typeId) {
        this.typeid = typeId;
    }
}
