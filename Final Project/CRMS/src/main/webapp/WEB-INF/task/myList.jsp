<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Documents</title>
    <!-- import css -->
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>
        <style>
        .checkDiv {
            padding: 0;
            margin: 0;
            /*margin-top:0;*/
            top: 0;
            left: 0;
            position: absolute;
            display: none;
        }

        .cb {
            width: 15px;
            height: 15px;
            /*padding: 0 5px 0 0;
            clear: left;
            float: left;*/
        }

        .Atag a:link, .Atag a:visited, .Atag a:hover, .Atag a:active {
            color: #000000;
            text-decoration: none;
        }

        .black_overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1100;
            -moz-opacity: 0.8;
            opacity: .85;
            filter: alpha(opacity=88);
        }

        .white_content {
            display: none;
            position: fixed;
            top: 18%;
            left: 20%;
            width: 800px;
            height: 450px;
            /*padding: 20px;
            border: 2px solid black;*/
            background-color: black;
            z-index: 1101;
            overflow: hidden;
        }

        .nowrap {
            white-space: nowrap;
            padding-top: 5px;
            padding-bottom: 5px;
            margin-left: 5px;
        }
    </style>
</head>
<body style="overflow: hidden;">

<section id="container">
    <!-- **********************************************************************************************************************************************************
    TOP BAR CONTENT & NOTIFICATIONS
    *********************************************************************************************************************************************************** -->
    <!--header-->
    <jsp:include page="/WEB-INF/reuse/header.jsp"/>

    <!-- **********************************************************************************************************************************************************
    MAIN SIDEBAR MENU
    *********************************************************************************************************************************************************** -->
    <!--sidebar-->
    <jsp:include page="/WEB-INF/reuse/sidebar.jsp"/>

    <!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper site-min-height">
            <h3><i class="fa fa-angle-right"></i>My Documents</h3>

            <!-- DEL ADD SEARCH FORM -->
            <div class="row mt">
                <div class="col-lg-12">
                    <div class="col-lg-6">

                        <%--<button type="button" class="btn btn-theme03" onclick="selectFiles2()">全选</button>--%>
                        <button type="button" class="btn btn-theme04" onclick="deleteFiles()"><i class="glyphicon glyphicon-trash"></i>Delete</button>

                        <button type="button" class="btn btn-theme02" onclick="openAddFile()"><i class="glyphicon glyphicon-plus"></i>Add</button>

                        <button type="button" class="btn btn-theme05" onclick="classifyFiles()"><i class="glyphicon glyphicon-file"></i>Auto Classify </button>

                        <button type="button" class="btn btn-theme05" onclick="autoTagging()"><i class="glyphicon glyphicon-file"></i>Auto Tagging </button>

                         <button type="button" class="btn btn-theme05" onclick="summarize()"><i class="glyphicon glyphicon-file"></i>Summerize </button>
                            <%--<a id="iframe" class="btn btn-theme02" href="/filec/gotoUpload.htm" role="button"><i class="glyphicon glyphicon-plus"></i>新增</a>--%>

                    </div>

                    <div class="col-lg-6">
                        <div class="pull-right">
                            <form id="actionId" class="form-inline" role="form" method="post" action="/task/listMyFile.htm">
                                <div class="form-group">
                                    <label class="control-label" for="fileNameSearchId">FileName：</label>
                                    <input type="text" class="form-control" id="fileNameSearchId" name="fileName"
                                           placeholder="">
                                </div>
                                <button type="submit" class="btn btn-theme">Search<i class="glyphicon glyphicon-search"></i>
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- /form-panel -->
                </div>
            </div>
            <!-- /col-lg-12 -->
            </div><!-- /row -->


            <!-- document list -->

            <div class="row mt">
                <div class="col-lg-12">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th width="30px">
                                <input style=" width:15px;height:15px;" type="checkbox" onclick="selectFiles2()" title="全选/全不选">
                            </th>
                            <th>
                                <center>No</center>
                            </th>
                            <th>
                                <center>Document Name</center>
                            </th>
                            <th>
                                <center>Upload Time</center>
                            </th>
                            <th>
                                <center>Document Summarization</center>
                            </th>
                            <th>
                                <center>Category</center>
                            </th>
                            <th>
                                <center>Tag</center>
                            </th>
                            <th>
                                <center>Operation</center>
                            </th>

                        </tr>
                        <form id="fileMainForm">
                            <c:forEach var="cloudFile" items="${cloudFileList}" varStatus="status">
                                <tr>
                                    <td>
                                        <input class="cb" type="checkbox" name="fileUrlID" value="${cloudFile.fileUrl}&${cloudFile.fileId}"/>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${status.index+1 }
                                        </center>
                                    </td>
                                    <td width="150px">
                                        <center>
                                            <a href='javascript:viewFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>
                                                ${cloudFile.fileName}
                                            </a>
                                        </center>
                                    </td>
                                    <td width="100px">
                                        <center>${cloudFile.fileDate.toLocaleString()} </center>
                                    </td>
                                    <td width="400px">${cloudFile.fileDescript} </td>
                                    <td width="50px">
                                        <center>
                                                ${cloudFile.label}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${cloudFile.tag}
                                        </center>
                                    </td>
                                    <td width="200px">
                                        <center>
                                            <div style="text-align:center">
                                                <a href='javascript:downloadFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>Download</a>  <%--<i class="glyphicon glyphicon-download-alt">下载</i>--%>
                                                <a class="Atag nowrap" href='javascript:viewFileMes("${cloudFile.fileId}","${cloudFile.fileUrl}","${cloudFile.fileName}");'>
                                                    Detail
                                                </a>
                                            </div>
                                        </center>
                                    </td>
                                </tr>
                            </c:forEach>
                        </form>
                    </table>
                </div>
            </div>

            <!--分页栏row-->
            <div class="row centered">
                <nav>
                    <ul class="pagination">${pageCode}</ul>
                </nav>
            </div>
            <!-- /row -->

        </section>
        <! --/wrapper -->
    </section>
    <!-- /MAIN CONTENT -->

    <!--弹出层-->
    <div id="light" class="white_content" onmouseover="$(this).find('div').show();"
         onmouseout="$(this).find('div').hide();">
        <div id="lightDiv" style="position:absolute;z-index:1102;display:none;color: white"><h4>&nbsp;</h4></div>
    </div>
    <div id="fade" class="black_overlay"></div>
    <!--/弹出层结束-->

    <!--main content end-->

    <!--footer start-->
    <jsp:include page="/WEB-INF/reuse/footer.jsp"/>
    <!--footer end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/js.jsp"/>

<script>$("#myUpLoadId").attr({"class": "active"});</script>
<!--引入此页面的js-->
<script type="text/javascript" src="/res/js/file/fileMain.js"></script>
<script type="text/javascript" src="/res/js/task/taskMain.js"></script>
<script type="text/javascript" src="/res/js/task/adjustFile.js"></script>
</body>
</html>


