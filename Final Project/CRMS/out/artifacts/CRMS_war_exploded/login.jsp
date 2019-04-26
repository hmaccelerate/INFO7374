<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="Dashboard">
	<meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

	<title>Login Webpage</title>
	<!-- import css -->
	<jsp:include page="/WEB-INF/reuse/css.jsp"/>

	<script type="text/javascript">


        function changeImg() {
            var imgSrc = $("#imgObj");
            var src = imgSrc.attr("src");
            imgSrc.attr("src", chgUrl(src));
        }
        //in order to generate different photos, and adding time stamp to let browser not to read cache
        function chgUrl(url) {
            var timestamp = (new Date()).valueOf();
            url = url.substring(0, 17);
            if ((url.indexOf("&") >= 0)) {
                url = url + "×tamp=" + timestamp;
            } else {
                url = url + "?timestamp=" + timestamp;
            }
            return url;
        }

	</script>

</head>

<body>

<!-- **********************************************************************************************************************************************************
  MAIN CONTENT
  *********************************************************************************************************************************************************** -->

<div id="login-page">
	<div class="container">

		<form class="form-login" action="/user/login.htm" method="post">
			<h2 class="form-login-heading">User Login</h2>
			<div class="login-wrap">

				<div>
					<span  id="login_err" class="sty_txt2" style="color: red"><font color="red">${errorMsg}${errorMsg1 }${blacklist}</font> </span>
				</div>

				<input type="text" class="form-control" id="userName" name="userName" value="${user.userName }" placeholder="Please input user name" autofocus>
				<br>
				<input type="password" class="form-control" id="password"  name="password" placeholder="Please input password">
				<br>
				<div>
					<span  id="code_err" class="sty_txt2" style="color: red"><font color="red">${msg}</font> </span>
				</div>
				<table cellpadding="2">
					<tr>
						<td>
							<input class="form-control" id="verifyCode" name="verifyCode" type="text" style="width:180px;" /></td>
						<td>&nbsp;
							<a href="javascript:;" onclick="changeImg()">
								<img id="imgObj" alt="Refresh picture code" placeholder="Please input picture code" src="code.htm" />
							</a>
						</td>
					</tr>
				</table>
				<label class="checkbox">
					 <span class="pull-left">
		                    <a data-toggle="modal" href="login.jsp#registerModal"> Register</a>

		                </span>
		                <%--<span class="pull-right">--%>
		                    <%--<a data-toggle="modal" href="login.jsp#myModal"> Forget password?</a>--%>

		                <%--</span>--%>
				</label>
				<button class="btn btn-theme btn-block login-submit-btn" type="submit"><i class="fa fa-lock"></i>Login</button>
				<hr>

				<div class="registration">
					Cloud Resource Manage System<br/>
				</div>

			</div>
		</form>
		<%--<!-- Forget password Modal -->--%>
		<%--<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">--%>
			<%--<div class="modal-dialog">--%>
				<%--<div class="modal-content">--%>
					<%--<div class="modal-header">--%>
						<%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
						<%--<h4 class="modal-title">Find Password</h4>--%>
					<%--</div>--%>
					<%--<div class="modal-body">--%>
						<%--<form id="passForm">--%>
							<%--<p>User Name：</p>--%>
							<%--<input type="text" name="userName" placeholder="Username" autocomplete="off" class="form-control placeholder-no-fix" required>--%>
							<%--<br>--%>
							<%--<p>Activation Email：</p>--%>
							<%--<input type="text" name="userEmail" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix" required>--%>
							<%--<br>--%>
							<%--<p id="pmes" class="text-center" style="color: red"></p>--%>
						<%--</form>--%>
					<%--</div>--%>
					<%--<div class="modal-footer">--%>
						<%--<button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>--%>
						<%--<button class="btn btn-theme" type="button" onclick="findPassByEmail()">Submit</button>--%>
					<%--</div>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
		<!-- modal -->


		<!-- Register Modal -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="registerModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Register</h4>
					</div>
					<div class="modal-body">
						<form id="auserForm">
							<p>User Name：</p>
							<input id="userName" class="form-control" type="text" name="userName" value="" placeholder="Please input user name" required>							<br>
							<p>Password：</p>
							<input id="passwordId" class="form-control" type="password" name="password" value="" placeholder="Please input password" required>							<br>
							<p>Description：</p>
							<textarea id="fileIntroId" class="form-control" name="userDescript" rows="3" placeholder="Please input user description"></textarea>							<p id="pmes" class="text-center" style="color: red"></p>
							<div class="modal-footer">
								<button id="fileCance2"  data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
								<button  id="auserBtn" class="btn btn-theme" type="button" onclick="register()">Submit</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>
		<!-- modal -->



	</div>
</div>

<!-- js placed at the end of the document so the pages load faster -->
<script src="assets/js/jquery.js"></script>
<script src="assets/js/bootstrap.min.js"></script>

<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
<script type="text/javascript" src="assets/js/jquery.backstretch.min.js"></script>
<script>
    $.backstretch("assets/img/login-bg.jpg", {speed: 500});
</script>
<%
	session.removeAttribute("errorMsg1");
%>

<script type="text/javascript">


    $('.login-submit-btn').click(function checkForm(e){
        var form = $('form.form-login');
        var userName=document.getElementById("userName").value;
        var password=document.getElementById("password").value;
        var verifyCode=document.getElementById("verifyCode").value;
        if(userName==null || userName==""){
            document.getElementById("login_err").innerHTML="User name cannot be null";
            return false;
        }
        if(password==null || password==""){
            document.getElementById("login_err").innerHTML="Password cannot be null";
            return false;
        }
        if(verifyCode==null || verifyCode==""){
            document.getElementById("code_err").innerHTML="Photo code cannot be null";
            return false;
        }
        form.onsubmit();
        return true;
    });

    function register(){
        var auserForm = $("#auserForm");
        var userInput = auserForm.children("input[name='userName']");
        var passwordInput = auserForm.children("input[name='password']");
        var pmes = $("#pmes");
        var userVal = userInput.val();
        var passwordVal = passwordInput.val();

        if(userVal==""){
            pmes.text("User name cannot be null");
        }else if(passwordVal==""){
            pmes.text("Password cannot be null");
        }else{
            $.ajax({
                type:"POST",
                url:"/user/insert.htm",
                data:auserForm.serializeArray(),
                cache:false,
                success:function(data,status){
                    $("#pmes").text(data);
                    window.location.href = "login.jsp";
                },
                error:function(xhr,status,ex){
                    $("#pmes").text(status+":Failed to submit!");
                }
            });
        }
    }

    //找回密码
    function findPassByEmail(){
        var passForm = $("#passForm");
        var userInput = passForm.children("input[name='userName']");
        var emailInput = passForm.children("input[name='userEmail']");
        var pmes = $("#pmes");
        var userVal = userInput.val();
        var emailVal = emailInput.val();

        if(userVal==""){
            pmes.text("User name cannot be null");
        }else if(emailVal==""){
            pmes.text("Password cannot be null");
        }else{
            $.ajax({
                type:"POST",
                url:"/user/findPassByEmail.htm",
                data:passForm.serializeArray(),
                cache:false,
                success:function(data,status){
                    $("#pmes").text(data);
                },
                error:function(xhr,status,ex){
                    $("#pmes").text(status+":Failed to submit!");
                }
            });
        }
    }
</script>

</body>
</html>
