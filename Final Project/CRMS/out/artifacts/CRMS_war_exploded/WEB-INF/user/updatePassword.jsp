
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

    <title>Update Password</title>
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>

</head>

<body>
<form id="passForm"><%-- action="/user/update.htm" method="post" onsubmit="return checkForm()">--%>
    <table class="table table-bordered table-striped table-condensed">
        <tbody>
        <tr>
            <th scope="row">Original Password：</th>
            <td><input id="pass" class="form-control" type="password" name="password" placeholder="Please input original password">
                <div>
                    <font color="red" id="error"></font>
                </div>
            </td>

        </tr>

            <th scope="row">New Password：</th>
            <td><input id="pass1" class="form-control" type="password" name="password1" placeholder="Please input new password" required></td>
        </tr>
        <tr>
            <th scope="row">Ensure new password：</th>
            <td><input id="pass2" class="form-control" type="password" name="password2" placeholder="Please input new password again"　required></td>
            <div>
                <font color="red" id="errorMsg"></font>
            </div>
        </tr>
        <tr>
            <th scope="row"></th>
            <td class="text-right">
                <%--<a class="btn btn-primary" href="javascript:$('#euserForm').submit();" role="button" target="_parent">修改2</a>--%>
                <button id="euserBtn" type="button" class="btn btn-primary">Submit</button>&nbsp;
                <button id="fileCance2" type="reset" class="btn btn-default">Reset</button>&nbsp;
                <%--<button id="fileCance3" type="button" class="btn btn-default" onclick="window.location='/user/list.htm'">返回</button>--%>
            </td>
        </tr>
        </tbody>
    </table>
</form>


<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>
<script type="text/javascript" src="/assets/js/plupload/plupload.full.min.js"></script>

<script type="text/javascript">
    $(function(){
        $("#euserBtn").click(function(){
            if($("#pass").val()==""){
                layer.tips('Password cannot be null!', '#pass',{tips: 4});
            }
            if($("#pass1").val()==""){
                layer.tips('Password cannot be null!!', '#pass1',{tips: 4,tipsMore:true});
            }
            if($("#pass2").val()=="") {
                layer.tips('Password cannot be null!!', '#pass2', {tips: 4, tipsMore: true});
            }else{
                var userdata = $("#passForm").serializeArray();
                $.ajax({
                    type:"POST",
                    url:"/user/updatepassword.htm",
                    data:userdata,
                    cache:false,
                    success:function(data,status){
                        if(data.error!=undefined){
                            layer.tips(data.error, '#pass', {tips: [3, 'red'], tipsMore: true});
                        }
                        if(data.errorMsg!=undefined){
                            layer.tips(data.errorMsg, '#pass1', {tips: [3, 'red'], tipsMore: true});
                        }
                        if(data.mes!=undefined){
                            parent.layer.alert(data.mes,{icon:1},function(){
                                parent.window.location="/user/logout.htm";
                            });
                        }
                    },
                    error:function(xhr,status,ex){
                        alert(status+":Failed to update!");
                    }
                });
            }
        });
    });
</script>

</body>
</html>
