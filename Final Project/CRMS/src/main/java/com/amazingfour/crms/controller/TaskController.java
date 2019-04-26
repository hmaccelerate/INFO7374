package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.PageUtil;
import com.amazingfour.common.utils.ResponseUtil;
import com.amazingfour.common.utils.qiniu.MyUploadToken;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.domain.User;
import com.amazingfour.crms.service.CloudFileService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/task")
public class TaskController {

    @Autowired
    private CloudFileService cloudFileService;
    static Logger logger = Logger.getLogger(TaskController.class.getName());



    @RequestMapping("/listMyFile")
    public ModelAndView listMyFile(
            @RequestParam(value = "page", required = false) String page,
            CloudFile cloudFile, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        int pageSize = 9; // 页容量
        if (page == null || page == "") {
            page = "1";
        }
        String fileName = cloudFile.getFileName();
        Byte fileState = cloudFile.getFileState();
        Map<String, Object> map = new HashMap<String, Object>(); // 使用Map传值到mapper处理
        map.put("start", (Integer.parseInt(page) - 1) * pageSize); // 起始记录
        map.put("size", pageSize);
        map.put("fileName", fileName);
        map.put("fileState", fileState);
        User user = (User) session.getAttribute("currentUser");
        map.put("user_id", user.getUserId());
        //查询数据库并加入视频帧地址
        List<CloudFile> cloudFileList = MyUploadToken.getVframes(cloudFileService.findByUserId(map));
        int total = cloudFileService.countById(map);   //查询记录总数
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("fileName", fileName);
        params.put("fileState", fileState);
        String pageCode = PageUtil.getPagation("/task/listMyFile.htm", params,
                total, Integer.parseInt(page), pageSize);
        mav.addObject("pageCode", pageCode);
        mav.addObject("cloudFileList", cloudFileList);
//        String proDefId = taskServiceImp.getProDefId();
//        if (proDefId != null) {
//            mav.addObject("proDefId", proDefId);
//        }
        mav.setViewName("task/myList");
        return mav;
    }




}
