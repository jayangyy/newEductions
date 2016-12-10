/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.infrastructure.aspectj;

import cr.cdrb.web.edu.infrastructure.annotation.SysLog;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.LogService;
import cr.cdrb.web.edu.services.UsersService;
import java.lang.reflect.Method;
import java.util.UUID;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 *
 * @author Jayang
 */
@Aspect
@Component
public class LogControllers {
    ///日志AOP类日志
    private final Log log = LogService.getLog(LogControllers.class);
    ThreadLocal<Long> time = new ThreadLocal<Long>();
    ThreadLocal<String> tag = new ThreadLocal<String>();

    @Pointcut("execution(* cr.cdrb.web.edu.controllers.*.*(..))")
    public void log() {
        System.out.println("我是一个切入点");
    }

    /**
     * 在所有标注@Log的地方切入
     *
     * @param joinPoint
     */
    @Before("log()")
    public void beforeExec(JoinPoint joinPoint) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//      HttpSession session = request.getSession();  
//       //读取session中的用户  
//      User user = (User) session.getAttribute(WebConstants.CURRENT_USER);  
        time.set(System.currentTimeMillis());
        tag.set(UUID.randomUUID().toString());
        MethodSignature ms = (MethodSignature) joinPoint.getSignature();
        Method method = ms.getMethod();
        String ip = request.getRemoteAddr();
        System.out.println("=====前置通知开始=====");
        System.out.println("请求方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
        //System.out.println("请求人:" + user.getName());  
        System.out.println("请求IP:" + ip);
        System.out.println("请求类:" + joinPoint.getTarget().getClass().getName() + "请求方法" + ms.getName() + "方法描述" + "标记" + tag.get() + "调用开始......");
//        log.info("请求类:" + joinPoint.getTarget().getClass().getName() + "|请求方法" + ms.getName() + "|方法描述标记" + tag.get() + "|调用开始......");
        EduUser user = UsersService.GetCurrentUser();
 /*==========记录本地异常日志==========*/
        log.info(String.format("请求用户  %s|请求IP  %s|方法:%s| 方法描述标记:%s| 调用开始......",
                user == null ? "" : user.getUsername(), ip, joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName(),
                tag.get(), ""));
    }

    @After("log()")
    public void afterExec(JoinPoint joinPoint) {
        MethodSignature ms = (MethodSignature) joinPoint.getSignature();
        Method method = ms.getMethod();
        System.out.println("标记为" + tag.get() + "的方法" + method.getName() + "运行消耗" + (System.currentTimeMillis() - time.get()) + "ms");
        log.info("标记为" + tag.get() + "的方法" + method.getName() + "运行总消耗" + (System.currentTimeMillis() - time.get()) + "ms;");
    }

    @Around("log()")
    public Object aroundExec(ProceedingJoinPoint pjp) throws Throwable {
        MethodSignature ms = (MethodSignature) pjp.getSignature();
        log.info("请求类:" + pjp.getTarget().getClass().getName() + "." + ms.getName() + "|开始执行......");
        return pjp.proceed();
    }

    @AfterThrowing(pointcut = "log()", throwing = "error")
    public void afterThrowing(JoinPoint joinPoint, Throwable error) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        //读取session中的用户  
        ///User user = (User) session.getAttribute(WebConstants.CURRENT_USER);
        //获取请求ip  
        String ip = request.getRemoteAddr();
        //获取用户请求方法的参数并序列化为JSON格式字符串  
        String params = "";
        if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
            for (int i = 0; i < joinPoint.getArgs().length; i++) {
                params += joinPoint.getArgs()[i] + ";";
            }
        }
        EduUser user = UsersService.GetCurrentUser();
        /*========控制台输出=========*/
 /*==========记录本地异常日志==========*/
        log.error(String.format("请求用户  %s|请求IP  %s| 异常方法:%s| 异常类型:%s| 异常信息:%s| 参数:%s ",
                user == null ? "" : user.getUsername(), ip, joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName(),
                error.getClass().getName(),
                error.getMessage(), params));
        System.out.println("=====异常通知结束=====");
    }

    private void info(JoinPoint joinPoint) {
        System.out.println("--------------------------------------------------");
        System.out.println("King:\t" + joinPoint.getKind());
        System.out.println("Target:\t" + joinPoint.getTarget().toString());
        Object[] os = joinPoint.getArgs();
        System.out.println("Args:");
        for (int i = 0; i < os.length; i++) {
            System.out.println("\t==>参数[" + i + "]:\t" + os[i].toString());
        }
        System.out.println("Signature:\t" + joinPoint.getSignature());
        System.out.println("SourceLocation:\t" + joinPoint.getSourceLocation());
        System.out.println("StaticPart:\t" + joinPoint.getStaticPart());
        System.out.println("--------------------------------------------------");
    }

    /**
     * 获取注解中对方法的描述信息 用于service层注解
     *
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public static String getServiceMthodDescription(JoinPoint joinPoint)
            throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String description = "";
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == arguments.length) {
                    description = method.getAnnotation(SysLog.class).description();
                    break;
                }
            }
        }
        return description;
    }

    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     *
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String description = "";
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == arguments.length) {
                    description = method.getAnnotation(SysLog.class).description();
                    break;
                }
            }
        }
        return description;
    }
}
