package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSONObject;
import cr.cdrb.commons.file.FileUtil;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.infrastructure.annotation.AuthPassport;
import cr.cdrb.web.edu.infrastructure.annotation.SysLog;
import cr.cdrb.web.edu.model.SessionReview;
import cr.cdrb.web.edu.security.EduUserDetailsService;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.IServices.IResourcesServices;
import cr.cdrb.web.edu.services.PostService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    EduUserDetailsService userDetailsService;
    @Autowired
    IResourcesServices resService;
    @Resource(name = "sessionRegistry")
    public SessionRegistry sessionRegistry1;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView Login(ServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return mv;
    }

    @RequestMapping(value = "/searchSessions", method = RequestMethod.GET)
    public ModelAndView searchSessions(ServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("viewSesssion");
        return mv;
    }

    @RequestMapping(value = "/loginout", method = RequestMethod.GET)
    public ModelAndView loginout(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("errmessage",
                getErrorMessage(request, "SPRING_SECURITY_LAST_EXCEPTION"));

        mv.setViewName("sessiontimeout");

        return mv;
    }

    private String getErrorMessage(HttpServletRequest request, String key) {
        Exception exception = (Exception) request.getSession()
                .getAttribute(key);
        String error = exception != null ? exception.getMessage() : "";
//        if (exception instanceof BadCredentialsException) {
//            error = "Invalid username and password!";
//        } else if (exception instanceof BadAnswerException) {
//            error = exception.getMessage();
//        } else if (exception instanceof LockedException) {
//            error = exception.getMessage();
//        } else {
//            error = "Invalid username and password!";
//        }

        return error;
    }

    @RequestMapping(value = "/getMenus", method = RequestMethod.GET)
    @ResponseBody
    public DataModel GetMenus() throws Throwable {
        return resService.GetResMeans(UsersService.GetCurrentUser().getUsername());
    }

    ///获取URL参数
    private Map<String, String> ProcessParams(String queryString) throws Throwable {
        Map<String, String> params = new HashMap<String, String>();
        if (queryString != null) {
            if (queryString.length() > 0) {
                String[] queryArray = new String(Base64.decodeBase64(queryString), "utf-8").split("&");
                for (String item : queryArray) {
                    String[] itemArray = item.split("=");
                    params.put(itemArray[0], itemArray[1]);
                }
            }
        }
        return params;
    }

    @RequestMapping(value = "/edulogin1", method = RequestMethod.GET)
    public ModelAndView GetUser(HttpServletRequest request, @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout) throws Throwable {
        //Home/EduLogin?cmV0dXJudXJsPS9Ib21lL2pzb24mVXNlclBJRD01MTAyMTUxOTcwMDIyMzA0OXg=
        ModelAndView model = new ModelAndView();
        //Map<String, String[]> params = request.getParameterMap();
        Map<String, String> params = ProcessParams(request.getQueryString());
        String usernmae = params.get("UserPID");
        System.out.print(usernmae);
        if (usernmae == null) {
            throw new AccessDeniedException("用户参数不能为空,请重新登录!");
        }
        if (usernmae.length() == 0) {
            throw new UsernameNotFoundException("用户参数不能为空,重新登录!");
        }
        if (request.getSession().getAttribute("SPRING_SECURITY_CONTEXT") != null) {
            System.out.printf("已经登录");
            SecurityContext springcontext = (SecurityContext) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
            UserDetails olduser = (UserDetails) springcontext.getAuthentication().getPrincipal();
            if (olduser.getUsername().equals(usernmae)) {
                if (params.get("returnurl") != null) {
                    model.setView(new RedirectView("/education" + params.get("returnurl")));
                    // request.getRequestDispatcher(url).forward(request, response);
                } else {
                    model.setViewName("edulogin");
                }
                return model;
            } else {
                request.getSession().removeAttribute("SPRING_SECURITY_CONTEXT");
            }
        }
        System.out.printf(usernmae);
        UserDetails userDetails = userDetailsService.loadUserByUsername(usernmae);
        //PreAuthenticatedAuthenticationToken当然可以用其他token,如UsernamePasswordAuthenticationToken                 
        UsernamePasswordAuthenticationToken authentication
                = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        HttpSession session = request.getSession(true);
        session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
        sessionRegistry1.registerNewSession("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
        session.setAttribute("eduuser", userDetailsService.getDbUser());
        if (params.get("returnurl") != null) {
            model.setView(new RedirectView("/education" + params.get("returnurl")));
            // request.getRequestDispatcher(url).forward(request, response);
        } else {
            model.setViewName("edulogin");
        }
        return model;
    }

    @RequestMapping("/Sessiontimeout")
    public ModelAndView Timeout(ServletRequest request) {
        request.getParameterMap();

        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        mv.addObject("users", "");
        return mv;
    }

    @RequestMapping("/json")
    @ResponseBody
    public Object json() {
        FileUtil.removeFiles("‪D:\\Projects\\TEST\\", false);
        ///   HttpServletResponse request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
        Map<String, String> result = new HashMap<String, String>();
        result.put("zhangsan", "hello");
        result.put("lisi", "world");
        result.put("wangwu", "nihao");
        return result;
    }

    @Autowired
    PostService service;

    @RequestMapping("/post")
    @ResponseBody
    @SysLog(name = "测试")
    public Object post() throws Throwable {

        FileUtil.removeFile("D:\\Projects\\JAVA\\JAVA\\education\\target\\education\\uploade");
        return service.TestAspectj();
        //return service.getPost();
    }

    @AuthPassport
    @RequestMapping("/post1")
    @ResponseBody

    public Object post1() throws Throwable {

        return service.TestAspectj();
    }

    @RequestMapping("/404")
    public String pate() {
        return "404";
    }

    @RequestMapping("/4041")
    public String pate1() {

        return "404";
    }

    @RequestMapping("/sessiontest")
    public void pate2() throws SQLException {
        EduUser user = UsersService.GetCurrentUser();
    }

    @RequestMapping("/getSessions")
    @ResponseBody
    public Object getSessions() {
//        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
//        Enumeration<String> sessionlist = session.getAttributeNames();
        List<Object> lis1t = sessionRegistry1.getAllPrincipals();
        int total = lis1t.size();
        System.out.println("查到" + lis1t.size() + "个用户");
        List<SessionReview> list = new ArrayList<SessionReview>();
        for (Object item : lis1t) {
            List<SessionInformation> curUerSession = sessionRegistry1.getAllSessions(item, false);
            EduUser user = (EduUser) item;
            String name = user.getWorkername();
            SessionReview review = new SessionReview();
            String date="";
            for(SessionInformation session:curUerSession)
            {
                date+=session.getLastRequest().toLocaleString()+"|";
            }
            review.setLastquest(date);
            review.setName(name);
            review.setTotalCount(total + "");
            review.setSessionCount(curUerSession.size() + "");
            review.setValue(user.getCompany());
            list.add(review);
        }
        return list;
    }

    /**
     *
     * 多图片上传
     *
     */
    @SuppressWarnings("unused")
    @ResponseBody
    @RequestMapping(value = {"/upload.do"}, method = {RequestMethod.POST})
    public void UploadImageMuit(HttpServletRequest request, HttpServletResponse response,
            Object resModel) throws ServletException, IOException, FileUploadException {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> mapLinkList = multipartRequest.getFileMap();
        MultipartFile imgFile = null;
        for (String mf : mapLinkList.keySet()) {
            imgFile = mapLinkList.get(mf);
        }
        // 文件保存目录路径，可从配置文件读取
        String savePath = request.getServletContext().getRealPath("/") + "/content/";
        // 文件保存目录URL
        String saveUrl = request.getContextPath() + "/content/";
        response.setContentType("text/html; charset=UTF-8");
        if (!ServletFileUpload.isMultipartContent(request)) {
            //return ResultEx.Init(false, "请选择文件");
        }
        // 检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
            uploadDir.mkdir();
            // return ResultEx.Init(false, "上传目录不存在");
        }
        // 检查目录写权限
        if (!uploadDir.canWrite()) {
            //return ResultEx.Init(false, "上传目录没有写权限");
        }
        String dirName = request.getParameter("dir");
        if (dirName == null) {
            dirName = "image";
        }
        // 创建文件夹
        savePath += dirName + "/";
        saveUrl += dirName + "/";
        File saveDirFile = new File(savePath);
        if (!saveDirFile.exists()) {
            saveDirFile.mkdirs();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        savePath += ymd + "/";
        saveUrl += ymd + "/";
        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String fileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + imgFile.getOriginalFilename()
                .substring(imgFile.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
        // imgFile.getOriginalFilename();
        File targetFile = new File(savePath, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        // 保存
        try {
            imgFile.transferTo(targetFile);
            // 保存数据库
            String name = imgFile.getOriginalFilename();
            String suffix = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
            //resModel.setRes_name(name);
            //resModel.setRes_url(saveUrl + fileName);
            // 后缀名
            //resModel.setRes_suffix(suffix);
            //resModel.setRes_status("0");
            JSONObject obj = new JSONObject();
            //if (resModel.getId() > 0) {
            // 删除旧资源物理文件
//				train_info_file_res res = new EntityServices<UploadFileSearch, train_info_file_res, UploadFileDao>(
//						new UploadFileDao()).GetSingal(resModel.getId().toString());
//				String oldFullpath = res.getRes_url().substring(1, res.getRes_url().length());
//				String oldpath = request.getServletContext().getRealPath("/")
//						+ oldFullpath.substring(oldFullpath.indexOf("/") + 1);
//				if (!(FileUtil.removeFile(oldpath))) {
//					obj.put("error", 0);
//					obj.put("result", false);
//					obj.put("info", "文件删除失败");
//					return JSON.toJSONString(obj);
//				}
            /*
				 * ResultEx del=new EntityServices<UploadFileSearch,
				 * train_info_file_res, UploadFileDao>( new
				 * UploadFileDao()).Delete(resModel.getId().toString());
				 * if(del.getXresult()=="false"){ obj.put("error", 0);
				 * obj.put("result", false); obj.put("info", "数据库记录删除失败");
				 * return ResultEx.Init(false, obj); } }else{ obj.put("error",
				 * 0); obj.put("result", "物理文件删除失败"); return
				 * ResultEx.Init(false, obj); };
             */
            //}
//			ResultEx result = new EntityServices<UploadFileSearch, train_info_file_res, UploadFileDao>(
//					new UploadFileDao()).SaveOrUpdate(resModel);
            obj.put("error", 0);
            obj.put("url", saveUrl + fileName);
            obj.put("name", name);
            System.out.print("Success");
            System.out.print(name);

            //return JSON.toJSONString(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
//		return ResultEx.Init(true, "上传成功");
    }
}
