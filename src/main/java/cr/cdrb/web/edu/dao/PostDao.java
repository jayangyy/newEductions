/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.dao;

import cr.cdrb.commons.db.DbUtilsPlus;
import cr.cdrb.web.edu.model.Post;
import cr.cdrb.web.edu.model.PostForTree;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrator
 */
@Component
public class PostDao {
    @Resource(name = "db3")
    private DbUtilsPlus db;
    
    public List<Post> getAllPost(String system) throws SQLException {
//        return db.queryBeanList(Post.class, "SELECT 名称 post, 分类 type, 主要行车工种 main,专业 professional FROM 行车工种");
        String whereStr="";
        if(system.equals("职教"))
            whereStr += "1=1";
        else if(system.equals("车务"))
            whereStr += "专业='车务' or 专业='客运' or 专业='货运'";
        else
            whereStr += "专业='"+system+"'";
        String sql = "SELECT DISTINCT 专业 professional from 行车工种 where " + whereStr;
        List<Post> posts = db.queryBeanList(Post.class, sql);
        for (int i = 0; i < posts.size(); i++) {
            String pro = posts.get(i).getProfessional();
            sql = "SELECT 名称 post, 分类 type, 主要行车工种 main,专业 professional FROM 行车工种 where 专业='"+pro+"'";
            posts.get(i).setChildren(db.queryBeanList(Post.class, sql));
        }
        return posts;
    }
    
    public List<PostForTree> getAllPostTree(String system) throws SQLException {
        List<PostForTree> postTree = new ArrayList<>();
        
        //推荐
        PostForTree recommended = new PostForTree(){{setId(1);setText("推荐");}};
        postTree.add(recommended);
        
        //我的收藏
        PostForTree collect = new PostForTree(){{setId(2);setText("我的收藏");}};
        postTree.add(collect);
        
        //铁路专业
        PostForTree cdrdNode = new PostForTree(){{setId(null);setText("铁路专业");setState("closed");}};
        postTree.add(cdrdNode);
        String sql = "SELECT DISTINCT 专业 text,null id,大类ID typeid from 行车工种";
        List<PostForTree> posts = db.queryBeanList(PostForTree.class, sql);
        for (int i = 0; i < posts.size(); i++) {
            String pro = posts.get(i).getText();
            if(!"".equals(system) && pro.equals(system)){
                posts.get(i).setState("");
                cdrdNode.setState("");
            }
            else
                posts.get(i).setState("closed");
            sql = "SELECT 3 id, 名称 text FROM 行车工种 where 专业='"+pro+"'";
            List<PostForTree> posttrees =  db.queryBeanList(PostForTree.class, sql);
            posttrees.add(new PostForTree(){{setId(3); setText("其他");}});
            posts.get(i).setChildren(posttrees);
        }
        cdrdNode.setChildren(posts);
        
        //非铁路专业
        PostForTree nocdrdNode = new PostForTree(){{setId(null);setText("非铁路专业");setState("closed");}};
        postTree.add(nocdrdNode);
        sql = "SELECT Type2 text,null id from 资料信息 where Type2>'a' GROUP BY Type2 ORDER BY Type2";
        List<PostForTree> posts2 = db.queryBeanList(PostForTree.class, sql);
        for (int i = 0; i < posts2.size(); i++) {
            posts2.get(i).setState("closed");
            String pro = posts2.get(i).getText();
            sql = "SELECT Type3 text,4 id from 资料信息 where Type2='"+pro+"' GROUP BY Type3";
            posts2.get(i).setChildren(db.queryBeanList(PostForTree.class, sql));
        }
        nocdrdNode.setChildren(posts2);
        
        return postTree;
    }
    
    public List<Post> getBindedPost() throws SQLException {
        return db.queryBeanList(Post.class, "SELECT post, 0 type, '' main FROM 资料工种 GROUP BY post");
    }
    public List<Post> getSgspProfessional() throws SQLException {
        return db.queryBeanList(Post.class, "select 专业 professional,大类ID main from 资料信息 a LEFT JOIN (select 专业,大类ID from 行车工种 GROUP BY 专业,大类ID) b on a.Type2_ID=b.大类ID where memo='施工视频' GROUP BY 专业,大类ID");
    }
}
