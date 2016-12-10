/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import cr.cdrb.commons.crypt.PublicKeyCrypt;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Properties;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Administrator
 */
public class AESCryptTest {
   
    public AESCryptTest() {
    }
    
    @Test
    public void TestAES() {
        String content = "Hello, World!";
        String key = "SomeKey";
        String encode = PublicKeyCrypt.encryptAES(content, key);
        String decode = PublicKeyCrypt.decryptAES(encode, key);
        assertEquals(decode, content);
    }
    
    @Test
    public void TestDES() {
        String content = "Hello, World!";
        String key = "SomeKey";
        String encode = PublicKeyCrypt.encryptDES(content, key);
        String decode = PublicKeyCrypt.decryptDES(encode, key);
        assertEquals(decode, content);
    }
    
    @Test
    public void TestBlowfish() {
        String content = "Hello, World!";
        String key = "SomeKey";
        String encode = PublicKeyCrypt.encryptBlowfish(content, key);
        String decode = PublicKeyCrypt.decryptBlowfish(encode, key);
        assertEquals(decode, content);
    }
    
    @Test
    public void TestRC2() {
        String content = "Hello, World!";
        String key = "SomeKey";
        String encode = PublicKeyCrypt.encryptRC2(content, key);
        String decode = PublicKeyCrypt.decryptRC2(encode, key);
        assertEquals(decode, content);
    }
    
    @Test
    public void TestRC4() {
        String content = "Hello, World!";
        String key = "SomeKey";
        String encode = PublicKeyCrypt.encryptRC4(content, key);
        String decode = PublicKeyCrypt.decryptRC4(encode, key);
        assertEquals(decode, content);
    }
    
    @Test
    public void TestPBE() {
        String content = "Hello, World!";
        String key = "SomeKey";
        String salt = "*%$#&^*(^)&^";
        String encode = PublicKeyCrypt.encryptPBE(content, key, salt);
        String decode = PublicKeyCrypt.decryptPBE(encode, key, salt);
        assertEquals(decode, content);
    }
    
    //@Test
    public void TestCryptJdbc() throws Exception {
        Properties prop = new Properties();
        String base_dir = System.getProperty("user.dir");
        String path_from = base_dir + "\\src\\test\\java\\test\\jdbc.properties";
        String path_to = base_dir + "\\src\\main\\webapp\\WEB-INF\\jdbc.properties";
        try (InputStream ins = new FileInputStream(path_from)) {
            prop.load(ins);
        }
        prop.stringPropertyNames().stream().forEach((key) -> {
            String value = prop.getProperty(key, "");
            String newValue = PublicKeyCrypt.encryptAES(value, key);
            prop.setProperty(key, newValue);
        });
        try (FileOutputStream os = new FileOutputStream(path_to)) {
            prop.store(os, "1:SSOP 2:YGPX 3:EBOOK 4:EXAM");
        }
    }
    
    //@Test
    public void TestDecryptJdbc() throws Exception {
        Properties prop = new Properties();
        String base_dir = System.getProperty("user.dir");
        String path_from = base_dir + "\\src\\main\\webapp\\WEB-INF\\jdbc.properties";
        String path_to = base_dir + "\\src\\test\\java\\test\\jdbc1.properties";
        try (InputStream ins = new FileInputStream(path_from)) {
            prop.load(ins);
        }
        prop.stringPropertyNames().stream().forEach((key) -> {
            String value = prop.getProperty(key, "");
            String newValue = PublicKeyCrypt.decryptAES(value, key);
            prop.setProperty(key, newValue);
        });
        try (FileOutputStream os = new FileOutputStream(path_to)) {
            prop.store(os, "1:SSOP 2:YGPX 3:EBOOK 4:EXAM");
        }
    }
}
