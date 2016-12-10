/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import static cr.cdrb.commons.file.FileUtil.moveFolder;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.FilterRule;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.model.Book;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.security.domains.Role;
import cr.cdrb.web.edu.services.BookService;
import cr.cdrb.web.edu.services.BookTypeService;
import cr.cdrb.web.edu.services.PostService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import static cr.cdrb.commons.file.FileUtil.removeFile;
import static cr.cdrb.commons.file.FileUtil.removeFiles;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;

/**
 *
 * @author milord
 */
@Controller
@RequestMapping("book/")
public class BookController {
    @Resource(name="configMap")
    private Map config;
    @Autowired
    BookService bs;
    @Autowired
    BookTypeService bts;
    @Autowired
    PostService ps;

    @RequestMapping(value = "list")
    public String getListPage(HttpServletRequest request) {
        String zjcunitid = (String) config.get("zjcunitid");
        request.setAttribute("zjcunitid", zjcunitid);
        EduUser user = UsersService.GetCurrentUser();
        request.setAttribute("user", user);
        boolean iseduuser = false;
        for (Role r : user.getRoles()) {
            if(r.getRolename().equals("ROLE_EDU"))
                iseduuser = true;
        }
        request.setAttribute("iseduuser", iseduuser);
        boolean iszjcuser = false;
        if(user.getCompanyId().equals(zjcunitid))
            iszjcuser = true;
        request.setAttribute("iszjcuser", iszjcuser);
//        String zjcunitid = (String) config.get("zjcunitid");
//        return new ModelAndView("book/list", "zjcunitid", zjcunitid);
        return "book/list";
    }

    @RequestMapping(value = "view")
    public String getViewPage() {
        return "book/view";
    }

    @RequestMapping(value = "edit")
    public String getEditPage() {
        return "book/edit";
    }

    @RequestMapping(value = "/")
    public String getUpPage() {
        return "book/edit";
    }

    @RequestMapping(value = "postbook")
    public ModelAndView getPostBookPage() {
        EduUser user = UsersService.GetCurrentUser();
        return new ModelAndView("book/postbook", "user", user);
//        return  "book/postbook";
    }
    
    @RequestMapping(value = "video")
    public String getVideoPage(HttpServletRequest request) {
        EduUser user = UsersService.GetCurrentUser();
        request.setAttribute("user", user);
        return "book/video";
    }
    
    @RequestMapping(value = "allBooks", method = RequestMethod.GET)
    @ResponseBody
    //@RequestParam int page,  @RequestParam int rows, @RequestParam(required = false) String sort, @RequestParam(required = false) String order, @RequestParam(required = false) String search
    public Object getAllBooks(QueryModel model,String upid) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();//model.getPage() - 1) * rows;
        String sort = StringUtils.isBlank(model.getSort()) ? "id" : model.getSort();
        String order = StringUtils.isBlank(model.getOrder()) ? "asc" : model.getOrder();
        List<String> param = new ArrayList<>();
        
        String whereStr = "1=1";
        List<FilterRule> frlist = JSON.parseArray(model.getFilterRules(), FilterRule.class);
        if (frlist != null) {
            for (FilterRule item : frlist) {
                String field = item.getField();
                String op = item.getOp();
                String value = item.getValue();
                switch (op) {
                    case "equals":
                        whereStr += " and " + field + " = ?";
                        param.add(value);
                        break;
                    case "contains":
                        whereStr += " and " + field + " like ?";
                        param.add("%"+value+"%");
                        break;
                    case "less":
                        whereStr += " and " + field + " > ?";
                        param.add(value);
                        break;
                    case "greater":
                        whereStr += " and " + field + " < ?";
                        param.add(value);
                        break;
                    case "custom":
                        if("post".equals(field)){
                            if ("--未绑定资料--".equals(value)) {
                                whereStr += " and id not in(select bookid from 资料工种 group by bookid)";
                            } else {
                                whereStr += " and id in(select bookid from 资料工种 where post=? group by bookid)";
                                param.add(value);
                            }
                        }
                        else if("collection".equals(field)){
                            whereStr += " and id in(select bookid from BookCollection where userid=?)";
                            param.add(value);
                        }
                        else if("other".equals(field)){
                            whereStr += " and type2Id=? and id not in(select bookid from 资料工种 group by bookid)";
                            param.add(value);
                        }
                        break;
                }
            }
        }
        //return JSON.toJSONString(bs.getBooksPaging(page, rows, sort, order, whereStr, model.getSearch(), upid, param.toArray()));
        return bs.getBooksPaging(page, rows, sort, order, whereStr, model.getSearch(), upid, param.toArray());
    }

    @RequestMapping(value = "book/{bookId}", method = RequestMethod.GET)
    @ResponseBody
    public Object getBookById(@PathVariable int bookId) throws Exception {
        return bs.getBookById(bookId);
    }

    @RequestMapping(value = "book", method = RequestMethod.POST)
    @ResponseBody
    public Object updateBookById(Book book) throws Exception {
        return bs.updateBook(book);
    }

    @RequestMapping(value = "book/{bookId}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteBookById(@PathVariable int bookId) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        DataModel dm = (DataModel)bs.getBookById(bookId);
        Book book = (Book)dm.getRows();
        return bs.deleteBook(book,user.getUsername(),user.getWorkername());
    }
    
    @RequestMapping(value = "shbook", method = RequestMethod.POST)
    @ResponseBody
    public Object shBookById(int bookid,String ty) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return bs.shBook(bookid,user.getUsername(),user.getWorkername(),df.format(new Date()),ty);
    }

    @RequestMapping(value = "addBook", method = RequestMethod.POST)
    @ResponseBody
    public Object insertBook(Book book) throws Exception {
        EduUser user = UsersService.GetCurrentUser();
        book.setPublishUser(user.getWorkername());//当前登录用户姓名
        book.setPublishUserId(user.getUsername());
        book.setPublishUserUnitId(user.getCompany());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        book.setPublishTime(df.format(new Date()));
        return bs.insertBook(book);
    }

    //获取大类
    @RequestMapping(value = "bigType", method = RequestMethod.GET)
    @ResponseBody
    public Object getBigType() throws Exception {
        return JSON.toJSONString(bts.getBigType());
    }

    //获取小类
    @RequestMapping(value = "smallType", method = RequestMethod.GET)
    @ResponseBody
    public Object getSmallTypeByCode(String code) throws Exception {
        return JSON.toJSONString(bts.getSmallTypeByCode(code));
    }

    //获取类型
    @RequestMapping(value = "bookType", method = RequestMethod.GET)
    @ResponseBody
    public Object getBookType() throws Exception {
        return JSON.toJSONString(bts.getBookType());
    }

    //获取工种
    @RequestMapping(value = "allPost", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllPost(String system) throws Exception {
        return JSON.toJSONString(ps.getAllPost(system));
    }
    
    //获取工种
    @RequestMapping(value = "allPostTree", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllPostTree(String system) throws Exception {
        return JSON.toJSONString(ps.getAllPostTree(system));
    }

    //获取已绑定工种
    @RequestMapping(value = "bindedPost", method = RequestMethod.GET)
    @ResponseBody
    public Object getBindedPost() throws Exception {
        return JSON.toJSONString(ps.getBindedPost());
    }

    @RequestMapping(value = "bookBindPost", method = RequestMethod.POST)
    @ResponseBody
    public Object bookBindPost(String bookids, String posts) throws Exception {
        return JSON.toJSONString(bs.bookBindPost(bookids, posts));
    }

    @RequestMapping(value = "collectionBook", method = RequestMethod.POST)
    @ResponseBody
    public Object collectionBook(String bookids, String userid,String opt) throws Exception {
        return JSON.toJSONString(bs.collectionBook(bookids, userid, opt));
    }
    
    @RequestMapping(value = "bookPost", method = RequestMethod.GET)
    @ResponseBody
    public Object getPostByBookId(String bookid) throws Exception {
        return bs.getPostByBookId(bookid);
    }

    @RequestMapping(value = "Upload", method = RequestMethod.POST)
    public void Upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<Boolean, String> resultMap = new HashMap<>();
        PrintWriter out = response.getWriter();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> mapLinkList = multipartRequest.getFileMap();
        MultipartFile file = null;
        for (String mf : mapLinkList.keySet()) {
            file = mapLinkList.get(mf);
        }

        String fileRootPath = (String) config.get("fileUploadPath");
        String filepath = fileRootPath + multipartRequest.getParameterValues("filepath")[0];
        // 文件保存目录路径，可从配置文件读取
//        String savePath = request.getServletContext().getRealPath("/") + filepath;
        String savePath = filepath;
        // 文件保存目录URL
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
        String fileName = file.getOriginalFilename();
        if(fileName.toLowerCase().endsWith(".mp4")) {
            byte[] avc1 = new byte[] {'a', 'v', 'c', '1'};
            byte[] flag1 = new byte[4];
            byte[] flag2 = new byte[4];
            try(InputStream fis = file.getInputStream())
            {
                fis.skip(20);
                fis.read(flag1);
                fis.read(flag2);
            }
            if(!(Arrays.equals(flag1, avc1) || Arrays.equals(flag2, avc1))) {
                out.printf(JSON.toJSONString(new DataModel().withErr("上传失败，视频格式不正确，请将视频格式转换为AVC(H.264)！")));
                return;
            }
        }
        // imgFile.getOriginalFilename();
        File targetFile = new File(savePath, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        try {
            // 保存
            file.transferTo(targetFile);
            out.printf(JSON.toJSONString(new DataModel().withInfo("上传成功！")));
        } catch (Exception e) {
            out.printf(JSON.toJSONString(new DataModel().withErr("上传失败！")));
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "delFolder", method = RequestMethod.POST)
    @ResponseBody
    public Object delFolder(String folderPath,HttpServletRequest request) throws Exception {
//        removeFiles(request.getServletContext().getRealPath("/")+folderPath,true);
        String fileRootPath = (String) config.get("fileUploadPath");
        removeFiles(fileRootPath + folderPath,true);
        return "ok";
    }

    @RequestMapping(value = "moveFolder", method = RequestMethod.POST)
    @ResponseBody
    public Object movesFolder(String oldPath, String newPath) throws Exception {
        String fileRootPath = (String) config.get("fileUploadPath");
        moveFolder(fileRootPath + oldPath,fileRootPath + newPath);
        removeFiles(fileRootPath + oldPath,true);
        return "ok";
    }
    
    @RequestMapping(value = "delFile", method = RequestMethod.POST)
    @ResponseBody
    public Object delFile(String filePath) throws Exception {
        String fileRootPath = (String) config.get("fileUploadPath");
        removeFile(fileRootPath + filePath);
        return "ok";
    }
    
    @RequestMapping(value = "getSgspProfessional", method = RequestMethod.GET)
    @ResponseBody
    public Object getSgspProfessional() throws Exception {
        return ps.getSgspProfessional();
    }
    
    @RequestMapping(value = "getSgspBooks", method = RequestMethod.GET)
    @ResponseBody
    public Object getSgspBooks(QueryModel model) throws Exception {
        int rows = model.getRows();
        int page = model.getPage();//model.getPage() - 1) * rows;
        String sort = StringUtils.isBlank(model.getSort()) ? "professional" : model.getSort();
        String order = StringUtils.isBlank(model.getOrder()) ? "asc" : model.getOrder();
        List<String> param = new ArrayList<>();
        
        String whereStr = "1=1";
        List<FilterRule> frlist = JSON.parseArray(model.getFilterRules(), FilterRule.class);
        if (frlist != null) {
            for (FilterRule item : frlist) {
                String field = item.getField();
                String op = item.getOp();
                String value = item.getValue();
                switch (op) {
                    case "equals":
                        whereStr += " and " + field + " = ?";
                        param.add(value);
                        break;
                    case "contains":
                        whereStr += " and " + field + " like ?";
                        param.add("%"+value+"%");
                        break;
                    case "less":
                        whereStr += " and " + field + " > ?";
                        param.add(value);
                        break;
                    case "greater":
                        whereStr += " and " + field + " < ?";
                        param.add(value);
                        break;
                    case "custom":
                        break;
                }
            }
        }
        //return JSON.toJSONString(bs.getBooksPaging(page, rows, sort, order, whereStr, model.getSearch(), upid, param.toArray()));
        return bs.getSgspBooks(page, rows, sort, order, whereStr, model.getSearch(), param.toArray());
    }
}
