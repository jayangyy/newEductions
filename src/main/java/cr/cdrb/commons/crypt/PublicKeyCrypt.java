/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.commons.crypt;

import static java.lang.Integer.min;
import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author Administrator
 */
public class PublicKeyCrypt {
    private static final String AES = "AES";
    private static final String DES = "DES";
    private static final String BLOWFISH = "Blowfish";
    private static final String RC2 = "RC2";
    private static final String RC4 = "RC4";
    private static final String PBE = "PBEWithSHA1AndRC4_128";
    private static final String UTF8 = "utf-8";
    
    public static  String encryptAES(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            int KEYLEN = 16;
            if(keyBytes.length != KEYLEN) {
                byte[] t = keyBytes;
                keyBytes = new byte[KEYLEN];
                System.arraycopy(t, 0, keyBytes, 0, min(KEYLEN, t.length));
            }
            Cipher cipher = Cipher.getInstance(AES);
            cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(keyBytes, AES));
            byte[] aes = cipher.doFinal(content.getBytes(UTF8));
            return Base64.encodeBase64String(aes);
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static String decryptAES(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            int KEYLEN = 16;
            if(keyBytes.length != KEYLEN) {
                byte[] t = keyBytes;
                keyBytes = new byte[KEYLEN];
                System.arraycopy(t, 0, keyBytes, 0, min(KEYLEN, t.length));
            }
            Cipher cipher = Cipher.getInstance(AES);
            cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(keyBytes, "AES"));
            return new String(cipher.doFinal(Base64.decodeBase64(content)), UTF8);
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static  String encryptDES(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            if(keyBytes.length % 8 > 0) {
                byte[] t = keyBytes;
                keyBytes = new byte[t.length +  8 - (t.length % 8)];
                System.arraycopy(t, 0, keyBytes, 0, t.length);
            }
            Cipher cipher = Cipher.getInstance(DES);
            cipher.init (
                Cipher.ENCRYPT_MODE, 
                new SecretKeySpec(keyBytes, DES)//,
                //new SecureRandom(keyBytes)
            );
            return Base64.encodeBase64String(cipher.doFinal(content.getBytes(UTF8)));
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static String decryptDES(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            if(keyBytes.length % 8 > 0) {
                byte[] t = keyBytes;
                keyBytes = new byte[t.length +  8 - (t.length % 8)];
                System.arraycopy(t, 0, keyBytes, 0, t.length);
            }
            Cipher cipher = Cipher.getInstance(DES);
            cipher.init (
                Cipher.DECRYPT_MODE, 
                new SecretKeySpec(keyBytes, DES)
            );
            return new String(cipher.doFinal(Base64.decodeBase64(content)), UTF8);
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static  String encryptBlowfish(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            Cipher cipher = Cipher.getInstance(BLOWFISH);
            cipher.init (
                Cipher.ENCRYPT_MODE, 
                new SecretKeySpec(keyBytes, BLOWFISH)
            );
            return Base64.encodeBase64String(cipher.doFinal(content.getBytes(UTF8)));
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static String decryptBlowfish(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            Cipher cipher = Cipher.getInstance(BLOWFISH);
            cipher.init (
                Cipher.DECRYPT_MODE, 
                new SecretKeySpec(keyBytes, BLOWFISH)
            );
            return new String(cipher.doFinal(Base64.decodeBase64(content)), UTF8);
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static  String encryptRC2(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            Cipher cipher = Cipher.getInstance(RC2);
            cipher.init (
                Cipher.ENCRYPT_MODE, 
                new SecretKeySpec(keyBytes, RC2)
            );
            return Base64.encodeBase64String(cipher.doFinal(content.getBytes(UTF8)));
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static String decryptRC2(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            Cipher cipher = Cipher.getInstance(RC2);
            cipher.init (
                Cipher.DECRYPT_MODE, 
                new SecretKeySpec(keyBytes, RC2)
            );
            return new String(cipher.doFinal(Base64.decodeBase64(content)), UTF8);
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static  String encryptRC4(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            Cipher cipher = Cipher.getInstance(RC4);
            cipher.init (
                Cipher.ENCRYPT_MODE, 
                new SecretKeySpec(keyBytes, RC4)
            );
            return Base64.encodeBase64String(cipher.doFinal(content.getBytes(UTF8)));
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static String decryptRC4(String content, String key) {
        if(content==null || key==null) return null;
        try {
            byte[] keyBytes = key.getBytes(UTF8);
            Cipher cipher = Cipher.getInstance(RC4);
            cipher.init (
                Cipher.DECRYPT_MODE, 
                new SecretKeySpec(keyBytes, RC4)
            );
            return new String(cipher.doFinal(Base64.decodeBase64(content)), UTF8);
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static  String encryptPBE(String content, String key, String salt) {
        if(content==null || key==null || salt==null) return null;
        try {
            PBEKeySpec keySpec = new PBEKeySpec(key.toCharArray());
            Cipher cipher = Cipher.getInstance(PBE);
            cipher.init (
                Cipher.ENCRYPT_MODE, 
                SecretKeyFactory.getInstance(PBE).generateSecret(keySpec),
                new PBEParameterSpec(salt.getBytes(), 128)
            );
            return Base64.encodeBase64String(cipher.doFinal(content.getBytes(UTF8)));
        }
        catch(Exception e) {
            return null;
        }
    }
    
    public static String decryptPBE(String content, String key, String salt) {
        if(content==null || key==null || salt==null) return null;
        try {
            PBEKeySpec keySpec = new PBEKeySpec(key.toCharArray());
            Cipher cipher = Cipher.getInstance(PBE);
            cipher.init (
                Cipher.DECRYPT_MODE, 
                SecretKeyFactory.getInstance(PBE).generateSecret(keySpec),
                new PBEParameterSpec(salt.getBytes(), 128)
            );
            return new String(cipher.doFinal(Base64.decodeBase64(content)), UTF8);
        }
        catch(Exception e) {
            return null;
        }
    }
}
