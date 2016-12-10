/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.model;

import java.util.List;

/**
 *
 * @author Administrator
 */
public class Post {
    private Integer id; 
    private String post;
    private Integer type; 
    private String main;
    private String professional;
    private List<Post> children;

    /**
     * @return the post
     */
    public String getPost() {
        return post;
    }

    /**
     * @param post the post to set
     */
    public void setPost(String post) {
        this.post = post;
    }

    /**
     * @return the type
     */
    public Integer getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(Integer type) {
        this.type = type;
    }

    /**
     * @return the main
     */
    public String getMain() {
        return main;
    }

    /**
     * @param main the main to set
     */
    public void setMain(String main) {
        this.main = main;
    }

    /**
     * @return the professional
     */
    public String getProfessional() {
        return professional;
    }

    /**
     * @param professional the professional to set
     */
    public void setProfessional(String professional) {
        this.professional = professional;
    }

    /**
     * @return the children
     */
    public List<Post> getChildren() {
        return children;
    }

    /**
     * @param children the children to set
     */
    public void setChildren(List<Post> children) {
        this.children = children;
    }

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
}
