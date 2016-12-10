/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.services;

import cr.cdrb.commons.file.FileUtil;
import static java.lang.Math.log;
import static java.lang.StrictMath.log;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.userdetails.User;

/**
 *
 * @author Jayang
 */
public class LogService {

    ///实例化日志类
  ///  private static Logger logger = LogManager.getLogger(LogService.class);
   ///private static Log log;
   
    public static Log getLog(Class type) {
       /// log = LogFactory.getLog(type);
        return  LogFactory.getLog(type);
    }
    public static Log getLog() {
      ///  log = LogFactory.getLog(LogService.class);
        return LogFactory.getLog(LogService.class);
    }
    public static void addLogToDb(Log log) {
    
    }

    public static void main(String[] args) {
        Log log=getLog();
          log.error("ERROR3333333");
        log.debug("DEBUG");
        log.warn("WARN");
        log.info("INFO");
        log.trace("TRACE");
         FileUtil.removeFile("D:\\Projects\\JAVA\\JAVA\\education\\target\\education\\uploade");
       System.out.println(log.getClass());
    }
}
