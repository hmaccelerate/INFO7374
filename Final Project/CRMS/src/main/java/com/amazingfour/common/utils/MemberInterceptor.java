package com.amazingfour.common.utils;

import com.amazingfour.crms.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;


public class MemberInterceptor implements HandlerInterceptor {

    public final static String SEESION_USER = "currentUser";
    public final static String SEESION_MENU = "menuList";
    public final static String SEESION_OPER = "operList";
    private List<String> excludedUrls;

    public List<String> getExcludedUrls() {
        return excludedUrls;
    }

    public void setExcludedUrls(List<String> excludedUrls) {
        this.excludedUrls = excludedUrls;
    }

    /*
         * (non-Javadoc)
         *
         * @see org.springframework.web.servlet.HandlerInterceptor#afterCompletion(javax.servlet.http.HttpServletRequest,
         * javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)
         */
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
                                Exception arg3) throws Exception {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     *
     * @see org.springframework.web.servlet.HandlerInterceptor#postHandle(javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.web.servlet.ModelAndView)
     */
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
                           ModelAndView arg3) throws Exception {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     * 拦截mvc.xml配置的/member/**路径的请求
     * @see org.springframework.web.servlet.HandlerInterceptor#preHandle(javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse, java.lang.Object)
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        //这里配置放行的路径
        excludedUrls.add("/user/preUserInfo.htm");      //用户个人信息修改前置
        excludedUrls.add("/user/login.htm");            //用户登录界面
        excludedUrls.add("/code.htm");                  //验证码
        excludedUrls.add("/user/logout.htm");           //退出登录
        excludedUrls.add("/user/bindEmail.htm");        //绑定邮箱
        excludedUrls.add("/user/upload.htm");           //修改头像
        excludedUrls.add("/user/update.htm");   //用户更新
        excludedUrls.add("/user/passPre.htm");          //修改密码
        excludedUrls.add("/user/comInformation.htm");   //判断用户基本信息是否完善
        excludedUrls.add("/user/activated.htm");   //激活邮箱
        excludedUrls.add("/user/insert.htm");   //用户新增
        excludedUrls.add("/user/findPassByEmail.htm");   //发送邮件
        excludedUrls.add("/user/findPassPre.htm");   //重置密码
        excludedUrls.add("/user/findPass.htm");   //找回密码重置密码
        excludedUrls.add("/user/findPass.htm");   //找回密码重置密码
        excludedUrls.add("/user/delUsers.htm");   //用户批量删除

        excludedUrls.add("/role/addRole.htm");          //角色新增前置
        excludedUrls.add("/role/insert.htm");           //角色新增
        excludedUrls.add("/role/updateRole.htm");       //修改用户菜单
        excludedUrls.add("/role/updateMenu.htm");
        excludedUrls.add("/role/updateOper.htm");       //修改用户功能
        excludedUrls.add("/role/updateOperByMenu.htm");

        excludedUrls.add("/filec/gotoUpload.htm");   //新增文件弹窗
        excludedUrls.add("/filec/shareFile.htm");   //资源共享
        excludedUrls.add("/filec/getTokenJs.htm");   //获得上传凭证
        excludedUrls.add("/filec/addFile.htm");   //新增文件
        excludedUrls.add("/filec/getReTokenJs.htm");   //获得重新上传凭证
        excludedUrls.add("/filec/updateFile.htm");   //更新文件
        excludedUrls.add("/filec/viewFileMes.htm");   //查看文件详情
        excludedUrls.add("/filec/getDownloadUrl.htm");   //下载文件
        excludedUrls.add("/filec/delFiles.htm");   //下载文件
        excludedUrls.add("/filec/preUpdate.htm");   //资源编辑前置


        excludedUrls.add("/task/taskClaim.htm");   // 签收任务
        excludedUrls.add("/task/taskFinish.htm");   // 审核通过
        excludedUrls.add("/task/gotoRejectForm.htm");   // 准备审核拒绝界面
        excludedUrls.add("/task/taskReject.htm");   // 审核拒绝
        excludedUrls.add("/task/taskUp.htm");   // 申请二级审核
        excludedUrls.add("/task/lookReseaon.htm");   // 查看拒绝理由
        excludedUrls.add("/task/preAdjust.htm");   // 准备接受调整界面
        excludedUrls.add("/task/receiveAdjust.htm");   // 接受调整
        excludedUrls.add("/task/rejectAdjust.htm");   // 拒绝调整




        String requestUri = request.getRequestURI();
        for (String url : excludedUrls) {
            if (requestUri.endsWith(url)) {
                return true;
            }
        }
        //请求的路径
        String contextPath=request.getContextPath();
        String  url=request.getServletPath().toString();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(SEESION_USER);
//        List<Menu> menuList = (List<Menu>) session.getAttribute(SEESION_MENU);
//        List<Operation> operList = (List<Operation>) session.getAttribute(SEESION_OPER);
        //这里可以根据session的用户来判断角色的权限，根据权限来重定向不同的页面，简单起见，这里只是做了一个重定向
        if (user==null||user.equals("")) {
            //被拦截，重定向到login界面
            response.sendRedirect(contextPath+"/user/logout.htm");
            return false;
        }
//        for(Menu menu : menuList){
//            if(requestUri.endsWith(menu.getUrl())){
//                return true;
//            }
//        }
//        if(operList!=null) {
//            for (Operation oper : operList) {
//                if (requestUri.endsWith(oper.getAction())) {
//                    return true;
//                }
//            }
//        }
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("您没有访问该地址的权限！");
            return false;
    }

}