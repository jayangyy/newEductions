/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import cr.cdrb.commons.db.builder.ISelectBuilder;
import cr.cdrb.commons.db.builder.SqlserverSelectBuilder;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Administrator
 */
public class SelectBuilderTest {
    
//    public SelectBuilderTest() {
//    }
//    
//    @BeforeClass
//    public static void setUpClass() {
//    }
//    
//    @AfterClass
//    public static void tearDownClass() {
//    }
//    
//    @Before
//    public void setUp() {
//    }
//    
//    @After
//    public void tearDown() {
//    }
//
//    @Test
//    public void testSelectBuilder() throws Exception {
//        ISelectBuilder builder = new SqlserverSelectBuilder()
//                .from("资料信息")
//                .where("Type2_ID = 'K'")
//                .orderBy("Title")
//                .limit(20, 20);
//        
//        String sql10 = builder.total();
//        String sql11 = builder.toSql();
//
//        builder = builder.select("*");  //默认返回所有行，select("*") 可以不写
//        String sql20 = builder.total();
//        String sql21 = builder.toSql();
//        assertEquals(sql10, sql20);
//        assertEquals(sql11, sql21);
//    }
}
