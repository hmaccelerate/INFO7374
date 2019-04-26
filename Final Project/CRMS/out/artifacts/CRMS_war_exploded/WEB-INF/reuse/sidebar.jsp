<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--sidebar start-->

<aside>
    <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">

            <p class="centered"><a href="javascript:openEditUserInfo()">

                <c:if test="${sessionScope.currentUser.imgUrl==null}">
                <img src="/assets/img/ui-sam.jpg" class="img-circle" width="60" ></a></p>
                    </c:if>
            <c:if test="${sessionScope.currentUser.imgUrl!=null}">
                <img src="${sessionScope.currentUser.imgUrl}" class="img-circle" width="60"></a></p>
            </c:if>
            <h5 class="centered">${sessionScope.currentUser.userName}</h5>
            <li class="sub">
                <a id="myUpLoadId" href="/task/listMyFile.htm">
                    <i class="fa fa-tasks"></i>
                    <%--<span>${menu.name}</span>--%>
                    <span>My Documents</span>
                </a>
            </li>
            <%--<c:forEach items="${sessionScope.menuList}" var="menu">--%>
                <%--<c:if test="${menu.name == '用户管理'}">--%>
                    <%--<li class="mt">--%>
                        <%--<a id="userMainId" href="${menu.url}">--%>
                            <%--<i class="fa fa-user"></i>--%>
                            <%--<span>${menu.name}</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</c:if>--%>
                <%--<c:if test="${menu.name == '角色管理'}">--%>
                    <%--<li class="sub">--%>
                        <%--<a id="roleMainId" href="${menu.url}">--%>
                            <%--<i class="fa fa-dashboard"></i>--%>
                            <%--<span>${menu.name}</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</c:if>--%>
                <%--<c:if test="${menu.name == '资源管理'}">--%>
                    <%--<li class="sub">--%>
                        <%--<a id="fileMainId" href="${menu.url}">--%>
                            <%--<i class="fa fa-desktop"></i>--%>
                            <%--<span>${menu.name}</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</c:if>--%>
            <%--&lt;%&ndash;<c:if test="${menu.name == '资源共享库'}">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<li class="sub">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<a id="fileLibId" href="${menu.url}">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<i class="fa fa-cloud"></i>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<span>${menu.name}</span>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                <%--<c:if test="${menu.name == '我的资源'}">--%>
                    <%--<li class="sub">--%>
                        <%--<a id="myUpLoadId" href="${menu.url}">--%>
                            <%--<i class="fa fa-tasks"></i>--%>
                            <%--&lt;%&ndash;<span>${menu.name}</span>&ndash;%&gt;--%>
                            <%--<span>My Documents</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</c:if>--%>
                <%--</c:forEach>--%>

        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
<!--sidebar end-->
<script src="/assets/js/jquery.js"></script>
<script>
    $(function(){
        checkUserInfo();
    })
    //编辑用户基本信息
    function openEditUserInfo(){
        var userUrl = "/user/preUserInfo.htm?userId="+${sessionScope.currentUser.userId};
        layer.open({
            type: 2,
            title: ['Edit personal information','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
            shade: 0.5,
            area: ['600px', '355px'],
            content: [userUrl,'no'],
            move:false
        });
    }

    function checkUserInfo(){
        if(${requestScope.userMsg=='1'}){
            openEditUserInfo();
            layer.msg("Please fill your personal information！",{icon:5,offset:100,shift:6});
        }else if(${userMsg=='2'}){
            openEditUserInfo();
            layer.msg("Binding your email can help you find password",{icon:5,offset:100,shift:6});
        }
    }
</script>
