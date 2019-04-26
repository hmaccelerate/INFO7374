
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

  <title>Document Detail</title>
  <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>

<body>
<form id="fileForm" class="panel">
  <table class="table table-bordered">
    <tbody>
    <tr>
      <th scope="row" width="100px">Document Name：</th>
      <td>${cloudFile.fileName}</td>
    </tr>
    <tr>
      <th scope="row">Upload Time：</th>
      <td>${cloudFile.fileDate.toLocaleString()}
    </tr>
    <tr>
      <th scope="row">Document Atrribute：</th>
      <td>Document Type：${cloudFile.fileType}
        &nbsp;&nbsp;&nbsp;Document Size：${cloudFile.fileSize}
      </td>
    </tr>
    <tr>
      <th scope="row" height="100px">Document Summarization：</th>
      <td>
        ${cloudFile.fileDescript}
      </td>
    </tr>

    </tbody>
  </table>
</form>


<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>

</body>
</html>

