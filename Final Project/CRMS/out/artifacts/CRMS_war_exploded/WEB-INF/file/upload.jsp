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

  <title>上传文件页面</title>
  <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>

<body>
  <%--<div class="">--%>
    <%--<h4 class="mb"><i class="fa fa-angle-right"></i> 新增视频</h4>--%>
    <form id="fileForm" class="panel">
      <table class="table table-bordered">  <%-- table-striped table-condensed --%>
        <tbody>
        <tr>
          <th scope="row">Document Name：</th>
          <td><input id="fileNameId" class="form-control" type="text" name="fileName" value="" placeholder="Please input document name" required></td>
        </tr>
        <tr>
          <th scope="row">Upload Document：</th>
          <td width="435px">
            <div id="container">
              <a class="btn btn-default btn-lg " id="pickfiles" href="#">
                <i class="glyphicon glyphicon-plus"></i>
                <span>Choose Document</span>
              </a>
            </div>

            <!--上传进度div，默认隐藏-->
            <div id="upproId" style="display:none">
              <div class="task-info">
                <div id="descId" class="desc">Uploading</div>
              </div>
              <div class="progress progress-striped" style="margin-bottom:0;margin-top:5px;height:10px;">
                <div id="barDivId" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0"
                     aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                  <span class="sr-only">0% Complete (success)</span>
                </div>
              </div>
              <div class="percent">
                <span><small id="persId">......</small></span>
              </div>
            </div><!-- /上传进度end -->

          </td>
        </tr>
        <tr>
          <th scope="row">Document Atrribute：</th>
          <td>Document Type：
            <input style="border:0" id="fileTypeId" type="text" name="fileType" value="" size="10" readonly required>
            &nbsp;Document Size：
            <input style="border:0" id="fileSizeId" type="text" name="fileSize" value="" size="10" readonly required>
          </td>
        </tr>
        <tr>
          <th scope="row">Document Summarization：</th>
          <td><textarea id="fileIntroId" class="form-control" name="fileDescript" rows="3" placeholder="Please input summarization"></textarea></td>
        </tr>
        <%--<tr>
          <th scope="row"></th>
          <td>
            <button id="start_upload" type="button" class="btn btn-primary">提交</button>
            <button id="fileCancel" type="button" class="btn btn-default">取消</button>
          </td>
        </tr>--%>
        </tbody>
      </table>
    </form>
<%--<div id="container">
  <a class="btn btn-default btn-lg " id="pickfiles" href="#" >
    <i class="glyphicon glyphicon-plus"></i>
    <span>选择文件</span>
  </a>
</div>--%>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>
<!--used for this page -->
<script type="text/javascript" src="/assets/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="/assets/js/qiniu.js"></script>
<script type="text/javascript" src="/res/js/file/initUpload.js"></script>

</body>
</html>
