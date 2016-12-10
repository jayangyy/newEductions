/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.commons.crypt;

import java.util.Properties;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
/**
 *
 * @author Administrator
 */
public class CryptPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
    @Override
    protected String resolvePlaceholder(String placeholder, Properties props) {
            return decrypt(super.resolvePlaceholder(placeholder, props), placeholder);
    }

    private String decrypt(String propertyValue, String placeholder) {
        return PublicKeyCrypt.decryptAES(propertyValue, placeholder);
    }
}
