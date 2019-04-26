<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Reset Password</title>
    <!-- 引入全局css样式 -->
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>

	<style>
		.form-login h2.form-login-heading{
			background: #428BCA;
		}

		.btn-theme:hover, .btn-theme:focus, .btn-theme:active, .btn-theme.active, .open .dropdown-toggle.btn-theme{
			color: #fff;
			background-color: #31708f;
			border-color: #31708f;
		}

		.btn-theme {
			color: #fff;
			background-color: #428bca;
			border-color: #428bca;
		}
		.modal-header {
			background: #a94442;
		}
	</style>
  </head>

  <body>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->

	  <div id="login-page">
	  	<div class="container">
	  	
		      <form id="fpForm" class="form-login">
		        <h2 class="form-login-heading">Reset Password</h2>
		        <div class="login-wrap">
					<input type="hidden" name="emailKey" value="${sid}">

					用户名：
		            <input type="text" class="form-control" id="userName" name="userName" value="${username}" required readonly>
		            <br>新密码：
		            <input type="password" class="form-control" id="password1"  name="password1" required>
					<br>确认密码：
					<input type="password" class="form-control" id="password2"  name="password2" required>
		            <label class="checkbox">
		                <span class="pull-right">
		                    <a href="login.jsp"> Return to Login page</a>
		                </span>
		            </label>
		            <button id="passBtn" class="btn btn-theme btn-block" type="button"><i class="fa fa-lock"></i> Submit</button>
		            <hr>

		            <div class="registration">
		                Cloud Resource Manage System<br/>
		            </div>
		        </div>
			  </form>

			<!-- Modal -->
			<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade bs-example-modal-sm">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h5 class="modal-title">Hint</h5>
						</div>
						<div class="modal-body">
							<h5 id="ph"></h5>
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
    <!--layer用于制作弹出层-->
    <script type="text/javascript" src="assets/js/layer/layer.js"></script>

  <script type="text/javascript">
	  $(function(){
		  $("#passBtn").click(function(){
			  var pass1 = $("#password1").val();
			  var pass2 = $("#password2").val();
			  if(pass1==""){
				  layer.tips('Password cannot be null!', '#password1',{tips: 4});
			  }else if(pass2==""){
				  layer.tips('Ensured passwrod cannot be null!', '#password2',{tips: 4,tipsMore:true});
			  }else if(pass1!=pass2){
				  layer.tips('Password and ensured password are not same!', '#password2',{tips: 4,tipsMore:true});
			  }else{
				  var passdata = $("#fpForm").serializeArray();
				  $.ajax({
					  type:"POST",
					  url:"/user/findPass.htm",
					  data:passdata,
					  cache:false,
					  success:function(data,status){
						  if(data!=undefined){
							  $("#ph").text(data);
							  $("#myModal").modal();
							  //layer.alert(data,{offset: '100px'});
						  }
					  },
					  error:function(xhr,status,ex){
						  layer.alert(status+":出现异常，请重试!",{offset: '100px'});
					  }
				  });
			  }
		  });
	  });
	  </script>


  </body>
</html>
