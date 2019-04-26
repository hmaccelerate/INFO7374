
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

  <title>Email Hint</title>
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
  </style>
</head>

<body>

<!-- **********************************************************************************************************************************************************
MAIN CONTENT
*********************************************************************************************************************************************************** -->


  <div class="container" style="color: white">
      <h2 class="form-login-heading">Hint：</h2>
      <div class="login-wrap text-center">
        <h3>${tip}</h3>
        <hr>

        <div class="registration">
          <a href="login.jsp">Cloud Resource System</a><br/>
        </div>
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


</body>
</html>

