
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keyword" content="">

    <title>Add User</title>

        <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>

<body>
<form id="auserForm"> <%--action="/user/insert.htm" method="post" onsubmit="return checkForm()">--%>
    <table class="table table-bordered table-striped table-condensed">
        <tbody>
        <tr>
            <th scope="row">User Name：</th>
            <td><input id="userName" class="form-control" type="text" name="userName" value="" placeholder="Please input user name" required>
                <div>
                    <span id="userError"></span>
                    <%--<span font color="red">${errorMsg2}</span>--%>
                </div>
            </td>

        </tr>
        <tr>
            <th scope="row">Role：</th>
            <td>
                <div id="container">
                    <select id="roleSel" name="role.roleId" class="form-control" style="width:152px">
                        <option value="">------</option>
                        <c:forEach var="b" items="${roleList}" varStatus="status">
                        <option value="${b.roleId}">${b.roleName}</option>
                    </c:forEach>
                    </select>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row">Password：</th>
            <td><input id="passwordId" class="form-control" type="password" name="password" value="" placeholder="Please input password" required></td>
        </tr>
        <tr>
            <th scope="row">Description：</th>
            <td><textarea id="fileIntroId" class="form-control" name="userDescript" rows="3" placeholder="Please input user description"></textarea></td>
        </tr>
        <tr>
            <th scope="row"></th>
            <td class="text-right">
                <button id="auserBtn" type="button" class="btn btn-primary">Submit</button>&nbsp;
                <button id="fileCance2" type="reset" class="btn btn-default">Reset</button>&nbsp;
                <%--<button id="fileCance3" type="button" class="btn btn-default" onclick="window.location='/user/list.htm'">返回</button>--%>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>

<script type="text/javascript">
$(function(){
    $("#auserBtn").click(function(){
        if($("#userName").val()==""){
            layer.tips('User Name cannot be null!', '#userName',{tips: 4});
            return;
        }
        if($("#roleSel").val()==""){
            layer.tips('Please choose role!', '#roleSel',{tips: 4,tipsMore:true});
            return;
        }
        if($("#passwordId").val()==""){
            layer.tips('Password cannot be null!', '#passwordId',{tips: 4,tipsMore:true});
        }else {
            var userdata = $("#auserForm").serializeArray();
            $.ajax({
                type: "POST",
                url: "/user/insert.htm",
                data: userdata,
                cache: false,
                success: function (data, status) {
                    var utip = data.usertip;
                    if (utip == 0) {
                        //$("#userError").text(reData.mes);
                        layer.tips(data.mes, '#userName', {tips: [3, 'red'], tipsMore: true});
                    } else if (utip == 1) {
                        parent.layer.msg(status + data.mes, {shade: 0.1, time: 2000}, function () {
                            parent.window.location = "/user/list.htm";
                        });
                    } else {
                        //do nothing
                        alert("do nothing");
                    }
                },
                error: function (xhr, status, ex) {
                    alert(status + ":Failed to save!");
                }
            });
        }
    });
});

</script>

</body>
</html>
