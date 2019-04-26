$(function(){
    //设置复选框鼠标事件隐藏和显示
    $(".videoDiv").mouseover(function(){
        $(this).find(".checkDiv").show();
    });
    $(".videoDiv").mouseout(function(){
        $(".cb:checked").parent().show();
        $(".cb:not(:checked)").parent().hide();
    });
});


//观看视频
function opendiv(){
    document.getElementById('light').style.display='block';
    document.getElementById('fade').style.display='block';
    document.body.style.overflow="hidden";	//设置滚动条隐藏
}
function closediv(){
    document.getElementById('light').style.display='none';
    document.getElementById('fade').style.display='none';
    document.body.style.overflow="auto";		//关闭弹窗重新显示滚动条
}
$('#fade').click(function(){    //移除video标签并关闭弹出层
    $('video').remove();
    closediv();
});

function viewFile(fileUrl,fileName){
    $.get("/filec/getDownloadUrl.htm",{key:fileUrl},
        function(data){
            //1.在新窗口播放视频
            //window.open(data.downloadUrl);
            //2.弹出iframe层-多媒体
            /*layer.open({
                type: 2,
                title: false,
                area: ['800px', '450px'],
                shade: 0.8,
                //maxmin: true,
                //closeBtn: 0,
                //shadeClose: true,
                content: data.downloadUrl
                //content:"<video style='position:fixed; top:0; left:0; width:100%; height:100%' src='" + data.downloadUrl +
                //    "' controls='controls' autoplay='autoplay' height='450px' width='800px'></video>"

            });
            $('iframe').attr("allowfullscreen","");
            layer.msg(fileName+'正在播放',{time:2000});*/
            //3.自定义弹出层预览文件
            var fileType = fileUrl.substring(fileUrl.lastIndexOf(".")+1).toLowerCase();

            if(/^(doc|docx|xls|xlsx|ppt|pptx|pdf|txt)$/.test(fileType)){    //文本文件预览
                //window.open("http://officeweb365.com/o/?i="+9755+"&furl="+data.downloadUrl);  //office web 365
                var textUrl = encodeURIComponent(data.downloadUrl);
                //window.open("http://view.officeapps.live.com/op/view.aspx?src="+textUrl);    //微软office
                window.open("http://docs.google.com/viewer?url="+textUrl+"&embedded=true");  //google doc
            }else if(/^(flv|mp4|webm|ogg)$/.test(fileType)){    //视频文件预览
                var videoStr = "<video style='width:100%; height:450px' src='" + data.downloadUrl +
                    "' controls='controls' autoplay='autoplay' height='450px' width='800px'></video>";
                $('#lightDiv').find('h4').append(fileName);
                $('#light').append(videoStr);
                opendiv();
            }else if(/^(mp3|acc)$/.test(fileType)){
                layer.open({
                    type: 1,
                    title: [fileName,'background-color:#A94442;color:white;border-bottom:0;'],
                    closeBtn: 1,
                    area: "auto",
                    offset:'rb',
                    shade: 0,
                    content: "<div style='background-color:#101010'><audio src='"+data.downloadUrl+"' controls autoplay>无法播放音乐，格式不支持!</audio></div>"
                });
            }else if(/^(gif|jpg|jpeg|png)$/.test(fileType)){    //图像预览
                var photoJson = {
                    "title": "", //相册标题
                    "id": 123, //相册id
                    "start": 0, //初始显示的图片序号，默认0
                    "data": [
                        {
                            "alt": fileName,
                            "pid": 0, //图片id
                            "src": data.downloadUrl, //原图地址
                            "thumb": "" //缩略图地址
                        }
                    ]
                };
                layer.ready(function(){ //为了layer.ext.js加载完毕再执行
                    layer.photos({
                        photos: photoJson
                    });
                });
            }else{
                layer.alert(fileName+' 不支持在线预览，请下载文件后用合适的工具打开！', {
                    icon:5,
                    offset:'10%',
                    title:'提示'
                });
            }
        });
}

//下载视频
function downloadFile(fileUrl, fileName) {
    $.get("/filec/getDownloadUrl.htm", {key: fileUrl},
        function(data){

            var ext = fileUrl.substring(fileUrl.lastIndexOf("."));
            var fName = fileName + ext;
            var url = data.downloadUrl;//+"&attname="+fName;
            //var url = encodeURI(downUrl);
            //console.log(url);

            //document.getElementById('downloadFrame').src=url;

            //alert("success");
           /* $.get(data.downloadUrl,
                function(rep,status,xhr){
                    alert(status);
                },"application/x-please-download-me");*/

            /*var xhr = new XMLHttpRequest();
            if( xhr.overrideMimeType ){
                //overrideMimeType() 必须在 send() 之前设置
                xhr.overrideMimeType("application/octet-stream");
            }
            xhr.open('GET',data.downloadUrl,true);
            xhr.send(null);*/

            var link = document.createElement("a");
            link.download = fName;
            link.href = url;
            link.click();
        });
}

//弹出新增视频的iframe层窗口
function openAddFile(){
    layer.open({
        type: 2,
        title: ['新增文件','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '342px'],
        content: ['/filec/gotoUpload.htm','no'],
        btn:['提交','取消'],
        yes:function(index, layero){
            /*var body = layer.getChildFrame('body',index);
             var iframeWin = window[layero.find('iframe')[0]['name']];
             body.find("#start_upload").click();*/
        },
        move:false
    });
}

//点击全选按钮可以全选和反选
var isChecked = true;
function selectFiles(){
    if(isChecked){
        $(".cb").prop('checked', isChecked).parent().show();
        isChecked = false;
        //return;
    }else{
        $(".cb").prop('checked', isChecked).parent().hide();
        isChecked = true;
        //return;
    }
    /*$(".cb").prop('checked', isChecked);
    $(".cb:checked").parent().show();*/
}

//列表复选框的全选和反选
function selectFiles2(){
    if(isChecked){
        $(".cb").prop('checked', isChecked);
        isChecked = false;
    }else{
        $(".cb").prop('checked', isChecked);
        isChecked = true;
    }
}

//资源管理页面点击删除按钮删除选中的文件
function deleteMFiles(url){
    /*if(!confirm("删除后无法恢复,确定要删除吗？")){
     return;
     }*/
    layer.confirm('删除后无法恢复,确定要删除吗？', {icon: 0, title:'警告',offset:30}, function(index){
        if($(".cb:checked").length<=0){
            layer.alert("请至少选择一项!",{icon:3,title:'提醒',offset:30,shift:6});
            return;
        }
        var formdata = $("#fileMainForm").serializeArray();
        $.ajax({
            type:'POST',
            url:url,
            data:formdata,
            cache:false,
            success:function(data,status){
                layer.msg(data.mes, {icon: 1,time:1000,offset:100},function(){
                    window.location.href = "/filec/listFile.htm";
                });
            },
            error:function(xhr,status,ex){
                layer.msg(status+":请求失败!",{icon:5,offset:100,shift:6});
            }
        });
    });
}

function autoTagging(){
    if($(".cb:checked").length<=0){
        layer.alert("请至少选择一项!",{icon:3,title:'提醒',offset:30,shift:6});
        return;
    }
    var formdata = $("#fileMainForm").serializeArray();
    $.ajax({
        type:'POST',
        url:'/filec/autoTagFiles.htm',
        data:formdata,
        cache:false,
        success:function(data,status){
            layer.msg(data.mes, {icon: 1,time:1000,offset:100},function(){
                window.location.href = "/task/listMyFile.htm";
            });
        },
        error:function(xhr,status,ex){
            layer.msg(status+":请求失败!",{icon:5,offset:100,shift:6});
        }
    });
}

function classifyFiles(){
        if($(".cb:checked").length<=0){
            layer.alert("请至少选择一项!",{icon:3,title:'提醒',offset:30,shift:6});
            return;
        }
        var formdata = $("#fileMainForm").serializeArray();
        console.log(formdata);
        $.ajax({
            type:'POST',
            url:'/filec/classifyFiles.htm',
            data:formdata,
            cache:false,
            success:function(data,status){
                layer.msg(data.mes, {icon: 1,time:1000,offset:100},function(){
                    window.location.href = "/task/listMyFile.htm";
                });
            },
            error:function(xhr,status,ex){
                layer.msg(status+":请求失败!",{icon:5,offset:100,shift:6});
            }
        });
}

function summarize(){
    if($(".cb:checked").length<=0){
        layer.alert("请至少选择一项!",{icon:3,title:'提醒',offset:30,shift:6});
        return;
    }
    var formdata = $("#fileMainForm").serializeArray();
    $.ajax({
        type:'POST',
        url:'/filec/summarizeFiles.htm',
        data:formdata,
        cache:false,
        success:function(data,status){
            layer.msg(data.mes, {icon: 1,time:1000,offset:100},function(){
                window.location.href = "/task/listMyFile.htm";
            });
        },
        error:function(xhr,status,ex){
            layer.msg(status+":请求失败!",{icon:5,offset:100,shift:6});
        }
    });
}

//我的资源页面点击删除按钮删除选中的文件
function deleteFiles(){
    layer.confirm('删除后无法恢复,确定要删除吗？', {icon: 0, title:'警告',offset:30}, function(index){
        if($(".cb:checked").length<=0){
            layer.alert("请至少选择一项!",{icon:3,title:'提醒',offset:30,shift:6});
            return;
        }
        var formdata = $("#fileMainForm").serializeArray();
        $.ajax({
            type:'POST',
            url:'/filec/delFiles.htm',
            data:formdata,
            cache:false,
            success:function(data,status){
                layer.msg(data.mes, {icon: 1,time:1000,offset:100},function(){
                    window.location.href = "/task/listMyFile.htm";
                });
            },
            error:function(xhr,status,ex){
                layer.msg(status+":请求失败!",{icon:5,offset:100,shift:6});
            }
        });
    });
}

//编辑视频前置，查询并弹出编辑iframe页面
function editFilePre(fileId) {
    var contentUrl = '/filec/preUpdate.htm?fileId=' + fileId;
    layer.open({
        type: 2,
        title: ['更新文件','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '444px'],
        content: [contentUrl,'no'],
        btn:['提交','取消'],
        yes:function(index, layero){},
        move:false
    });
}

//查看文件详情
function viewFileMes(fileId,fileUrl,fileName){
    var contentUrl = 'filec/viewFileMes.htm?fileId='+fileId;
    layer.open({
        type: 2,
        title: ['文件详情','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['500px', '335px'],
        content: [contentUrl,'no'],
        btn:'下载',
        yes:function(){
            downloadFile(fileUrl,fileName,"/filec/getDownloadUrl.htm")
        },
        move:false
    });
}

//共享文件
function shareFile(fileId,shareState){
    var state = shareState==1?0:1;
    var aText = ["共享","取消共享"];
    $.get("/filec/shareFile.htm",{"fileId":fileId,"shareState":state},
    function(data){
        if(data){
            $("#"+fileId).text(aText[state]);
        }else{
            alert("文件共享出错了!");
        }
    });
}

