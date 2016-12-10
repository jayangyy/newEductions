/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.web.edu.dao.PostDao;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import java.sql.SQLException;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrator
 */
@Component
public class PostService {
    @Resource
    private PostDao dao;
    
    public DataModel getAllPost(String system) throws SQLException {
        return new DataModel().withData(dao.getAllPost(system));
    }
    
    public DataModel getAllPostTree(String system) throws SQLException {
        return new DataModel().withData(dao.getAllPostTree(system));
    }
    
    public DataModel getBindedPost() throws SQLException {
        return new DataModel().withData(dao.getBindedPost());
    }
    
    public Object TestAspectj() throws Throwable
    {
        int i=9/0;
        return "";
    }
    
    public DataModel getSgspProfessional() throws SQLException {
        return new DataModel().withData(dao.getSgspProfessional());
    }
}
