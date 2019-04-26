<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="header black-bg">
    <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
    </div>
    <!--logo start-->
    <a href="javascript:void(0);" class="logo"><b>Cloud Resources Manage System</b></a>
    <div class="top-menu">
        <ul class="nav pull-right top-menu">
            <li><a class="logout" href="javascript:openEditPass();">Update Password</a></li>
            <li><a class="logout" href="/user/logout.htm">Log Out</a></li>
        </ul>
    </div>
</header>
<!--header end-->
<script>
    function openEditPass(){
        layer.open({
            type: 2,
            title: ['Update Password','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
            shade: 0.5,
            area: ['400px', '220px'],
            content: ["/user/passPre.htm",'no'],
            move:false
        });
    }
</script>