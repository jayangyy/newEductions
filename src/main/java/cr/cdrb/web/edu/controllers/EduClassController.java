/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.controllers;

import com.alibaba.fastjson.JSON;
import cr.cdrb.web.edu.domains.easyui.DataModel;
import cr.cdrb.web.edu.domains.easyui.QueryModel;
import cr.cdrb.web.edu.domains.educlass.ClassCostsSearch;
import cr.cdrb.web.edu.domains.educlass.EduClass;
import cr.cdrb.web.edu.domains.educlass.EduNewPost;
import cr.cdrb.web.edu.domains.educlass.EduProf;
import cr.cdrb.web.edu.domains.educlass.EduTrainingCategory;
import cr.cdrb.web.edu.domains.educlass.PlanClassCostDto;
import cr.cdrb.web.edu.domains.educlass.UnitsPersons;
import cr.cdrb.web.edu.domains.eduplans.EduPlans;
import cr.cdrb.web.edu.domains.eduplans.EduReviewSimpleStatus;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import cr.cdrb.web.edu.domains.eduplans.EduReviewsStatus;
import cr.cdrb.web.edu.security.domains.EduUnit;
import cr.cdrb.web.edu.security.domains.EduUser;
import cr.cdrb.web.edu.services.IServices.IEduClassService;
import cr.cdrb.web.edu.services.IServices.IPlansService;
import cr.cdrb.web.edu.services.IServices.IUnitService;
import cr.cdrb.web.edu.services.UsersService;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jayang
 */
@Controller
@RequestMapping("/educlass")
public class EduClassController {

    @Autowired
    IEduClassService classService;
    @Autowired
    IUnitService unitService;
    @Resource(name = "configMap")
    java.util.HashMap configMap;
    @Autowired
    IPlansService planService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(ServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("user", UsersService.GetCurrentUser());
        mv.addObject("isadmin", UsersService.IsAdmin());
        mv.setViewName("/educlass/index");
        return mv;
    }

    @RequestMapping(value = "/selectUnits", method = RequestMethod.GET)
    public ModelAndView selectUnits() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("user", UsersService.GetCurrentUser());
        mv.addObject("isadmin", UsersService.IsAdmin());
        mv.setViewName("/educlass/selectUnits");
        return mv;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(ServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("companyId", UsersService.GetCurrentUser().getCompanyId());
        mv.addObject("company", UsersService.GetCurrentUser().getCompany());
        mv.setViewName("/educlass/edit");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/putClass", method = RequestMethod.POST)
    public DataModel pubClass(EduClass model, String persnum) throws Throwable {
        if (!StringUtils.isBlank(persnum)) {
            model.setUnitpers(JSON.parseArray(persnum, UnitsPersons.class));
        }
        EduUser user = UsersService.GetCurrentUser();
        model.setAdd_user(user.getUsername());
        model.setAdd_user_name(user.getWorkername());
        return classService.addClass(model);
    }

    @ResponseBody
    @RequestMapping(value = "/patchClass", method = RequestMethod.POST)
    public DataModel putClpatchClassass(EduClass model, String persnum) throws Throwable {
        if (!StringUtils.isBlank(persnum)) {
            model.setUnitpers(JSON.parseArray(persnum, UnitsPersons.class));
        }
        return classService.updateClass(model);
    }

    @ResponseBody
    @RequestMapping(value = "/deleteClass", method = RequestMethod.POST)
    public DataModel deleteClass(String id) throws Throwable {
        return classService.deleteClass(id);
    }

    @ResponseBody
    @RequestMapping(value = "/getUnitsGroup", method = RequestMethod.GET)
    public List<EduUnit> getUnitsGroup() throws Throwable {
        return unitService.getUnitsGroups("9999000200140006","","");
    }

    @ResponseBody
    @RequestMapping(value = "/getClass", method = RequestMethod.GET)
    public EduClass getClass(String id) throws Throwable {
        return classService.getClassSingal(id);
    }

    @ResponseBody
    @RequestMapping(value = "/getClassList", method = RequestMethod.GET)
    public List<EduClass> getClassList(String ids) throws Throwable {
        return classService.getClassList(ids);
    }

    @ResponseBody
    @RequestMapping(value = "/getClassPage", method = RequestMethod.GET)
    public DataModel getClassPage(QueryModel model) throws Throwable {
        EduUser user = UsersService.GetCurrentUser();
        if (!UsersService.IsAdmin()) {
            if (!user.getCompanyId().equalsIgnoreCase(configMap.get("zjcunitid").toString())) {
                model.setSearch(model.getSearch() == null ? user.getCompany() : model.getSearch());
            }
        }
        return classService.getClassPages(model);
    }

    @ResponseBody
    @RequestMapping(value = "/getProfs", method = RequestMethod.GET)
    public List<EduProf> getProfs(String id) throws Throwable {
        return classService.getProfs(id);
    }

    //获取单位
    @ResponseBody
    @RequestMapping(value = "/getUnits", method = RequestMethod.GET)
    public List<EduUnit> getUnits(String uid, String uname, int levelId, int searchType) throws Throwable {
        String pid = null;
        EduUser user = UsersService.GetCurrentUser();
        if (searchType == 0) {
            //处室
            pid = configMap.get("cspid").toString().replace(",", "','");
        } else if (searchType == 1) {
            //
            pid = configMap.get("zdpid").toString();
        }
//        if (levelId == 0 && !UsersService.IsAdmin()) {
//            uid = UsersService.GetCurrentUser().getCompanyId();
//        }
        if (!UsersService.IsAdmin()) {
            if (levelId == 0 && !user.getCompanyId().equalsIgnoreCase(configMap.get("zjcunitid").toString())) {
                uid = user.getCompanyId();
            }
        }
        List<EduUnit> list = unitService.getUnits(uid, pid, uname, "");
        if (UsersService.IsAdmin()) {
            EduUnit unit = new EduUnit();
            unit.setU_id("");
            unit.setName("全部单位");
            list.add(0, unit);
        }
        return list;
    }

    //获取培训类型
    @ResponseBody
    @RequestMapping(value = "/getTrainings", method = RequestMethod.GET)
    public List<EduTrainingCategory> getTrainings(String id) throws Throwable {
        return classService.getTrains(id);
    }

    //获取新任工种
    @ResponseBody
    @RequestMapping(value = "/getNposts", method = RequestMethod.GET)
    public List<EduNewPost> getNposts(String id) throws Throwable {
        return classService.getPosts();
    }

    //获取培训计划
    @ResponseBody
    @RequestMapping(value = "/getPlans", method = RequestMethod.GET)
    public List<EduPlans> getPlans(String planunit, int levelId) throws Throwable {
        //. planunit = levelId == 0 ? UsersService.GetCurrentUser().getCompanypid() : planunit;
        if (levelId == 1) {
            return planService.getPlans("", UsersService.GetCurrentUser().getCompany(), EduReviewSimpleStatus.处室经办.getStats(), UsersService.GetCurrentUser().getCompany(), "");
        } else {
            // return //planService.getPlans("", "", EduReviewSimpleStatus.处室经办.getStats(), UsersService.GetCurrentUser().getCompany(), UsersService.GetCurrentUser().getUsername());
//路外培训只跟制定计划人有关
            return planService.getPlans("", "", EduReviewSimpleStatus.处室经办.getStats(), "", UsersService.GetCurrentUser().getUsername());
        }
    }
    //获取培训计划经费

    @ResponseBody
    @RequestMapping(value = "/getPlanCosts", method = RequestMethod.GET)
    public List<PlanClassCostDto> getPlanCosts(ClassCostsSearch search) throws Throwable {
        if (search.getIsUpdate() == 0) {
            search.setCoststatus(EduReviewSimpleStatus.财务经办.getStats() + "," + EduReviewSimpleStatus.开始建班.getStats());
        } else {
            search.setCoststatus(EduReviewSimpleStatus.开始建班.getStats() + "," + EduReviewSimpleStatus.建班结束.getStats());
        }
        search.setPlanstatus(EduReviewSimpleStatus.处室经办.getStats() + "");
        if (search.getLevelId() == 2||search.getLevelId() == 3||search.getLevelId() == 4) {
            ////路外培训只跟制定计划人有关
            search.setUsername(UsersService.GetCurrentUser().getUsername());
        }
        search.setTraintype(search.getLevelId() + "");
        return classService.getPlansCosts(search);
    }

    //获取单个培训计划
    @ResponseBody
    @RequestMapping(value = "/getPlan", method = RequestMethod.GET)
    public EduPlans getPlan(String id) throws Throwable {
        return planService.getPlan(id);
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public void uploadFile(HttpServletResponse response, HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile file) throws IOException {
        byte[] bytes = file.getBytes();
        System.out.println(file.getOriginalFilename());
        String uploadDir = request.getRealPath("/") + "upload";
        File dirPath = new File(uploadDir);
        if (!dirPath.exists()) {
            dirPath.mkdirs();
        }
        String sep = System.getProperty("file.separator");
        File uploadedFile = new File(uploadDir + sep
                + file.getOriginalFilename());
        FileCopyUtils.copy(bytes, uploadedFile);
        response.getWriter().write("true");
    }

    @RequestMapping(value = "Upload", method = RequestMethod.POST)
    public void Upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> mapLinkList = multipartRequest.getFileMap();
        MultipartFile file = null;
        PrintWriter out = response.getWriter();
        for (String mf : mapLinkList.keySet()) {
            file = mapLinkList.get(mf);
        }
        String fileRootPath = (String) configMap.get("fileUploadPath");
        String filepath = request.getServletContext().getRealPath("/") + "/s/upload/refdoc/" + multipartRequest.getParameterValues("Filename")[0];
        // 文件保存目录路径，可从配置文件读取
        String savePath = filepath;
        String saveUrl = request.getRequestURL().toString().replace(request.getRequestURI(), "") + request.getContextPath() + "/s/upload/refdoc/" + multipartRequest.getParameterValues("Filename")[0] + "/" + multipartRequest.getParameterValues("Filename")[0];
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
        // imgFile.getOriginalFilename();
        File targetFile = new File(savePath, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        try {
            // 保存
            file.transferTo(targetFile);
            out.printf(saveUrl);
        } catch (Exception e) {
            out.printf("false");
            e.printStackTrace();
        }
    }
}
