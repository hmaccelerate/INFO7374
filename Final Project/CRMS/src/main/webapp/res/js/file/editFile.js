//修改文件信息
$(function() {
    var hasFile = false;    //用于判断是否有选择文件
    var fileUrlStr = $("#fileUrlId").val();
    var frameIndex = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //若点击了提交按钮，执行以下操作
    parent.$(".layui-layer-btn0").click(function(){
        if($("#fileNameId").val()==""){
            layer.tips('文件名不能为空!', '#fileNameId',{tips: 4});
            return;
        }
        if($("#efileStateId").val()==""){
            layer.tips('审核状态不能为空!', '#fileStateId',{tips: 4,tipsMore: true});
            return;
        }
        if(!hasFile){  //若没有选择文件，直接保存
            //序列化表单数据
            var formData = $("#fileForm").serializeArray();
            //异步保存文件信息
            $.ajax({
                type:"POST",
                url:"/filec/updateFile.htm",
                data:formData,
                cache:false,
                success:function(data,status){
                    parent.layer.msg(status + data.mes,{shade:0.1,time:1000},function(){
                        parent.window.location = "/filec/listFile.htm";
                    });
                },
                error:function(xhr,status,ex){
                    alert(status+":更新失败!");
                }
            });
        }else{
            //启动上传
            uploader.start();
        }

    });

    //初始化上传参数
    var uploader = Qiniu.uploader({
        runtimes: 'html5,html4',    //上传模式,依次退化
        browse_button: 'pickfiles',       //上传选择的点选按钮，**必需**
        uptoken_url: '/filec/getReTokenJs.htm?key='+fileUrlStr,//'/filec/getTokenJs.htm',   //Ajax请求upToken的Url，**强烈建议设置**（服务端提供）
        // uptoken : '<Your upload token>',
        //若未指定uptoken_url,则必须指定 uptoken ,uptoken由其他程序生成
        //unique_names: true, // 默认 false，key为文件名。若开启该选项，SDK会为每个文件自动生成key（文件名）
        // save_key: true,
        // 默认 false。若在服务端生成uptoken的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
        domain: 'http://7xpdvw.com1.z0.glb.clouddn.com/',   //bucket 域名，下载资源时用到，**必需**
        container: 'container',           //上传区域DOM ID，默认是browser_button的父元素，
        max_file_size: '100mb',           //最大文件体积限制
        //flash_swf_url: 'js/plupload/Moxie.swf',  //引入flash,相对路径
        max_retries: 3,                   //上传失败最大重试次数
        dragdrop: true,                   //开启可拖曳上传
        drop_element: 'container',        //拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
        chunk_size: '4mb',                //分块上传时，每片的体积
        auto_start: false,                //选择文件后自动上传，若关闭需要自己绑定事件触发上传
        multi_selection: false,           //设置一次只能选择单个文件上传
        init: {
            'FilesAdded': function (up, files) {
                plupload.each(files, function (file) {
                    // 文件添加进队列后,处理相关的事情
                    //限制为单文件上传
                    //console.log("文件为:"+file.name);
                    if (up.files.length <= 1) {
                        //return;
                    }else{
                        up.removeFile(up.files[0]);    //删除之前已添加的文件
                        //up.splice(1,99);  //表示删除从1到99的文件，不包括1
                    }
                    var fName = up.files[0].name;
                    //var fsname = fName.substring(0,fName.lastIndexOf("."));
                    var nt = fName.split('.');
                    var fSize = bytesToSize(file.size);
                    hasFile = true;
                    $("#fileNameId").val(nt[0]);
                    $("#fileTypeId").val(nt[1]);
                    $("#fileSizeId").val(fSize);
                });
            },
            'BeforeUpload': function (up, file) {
                // 每个文件上传前,处理相关的事情
                $("#fileForm").find("input,textarea").prop('readonly',true);
                $("#efileStateId").attr("disabled","disabled");
                $("#container").hide();
                $("#upproId").show();
                parent.$(".layui-layer-btn0").unbind('click')
                    .removeAttr('href').removeAttr('onclick').css("cursor","not-allowed");
            },
            'UploadProgress': function (up, file) {
                // 每个文件上传时,处理相关的事情
                /*1、文件对象file
                文件总大小:size
                文件已上传大小：loaded
                文件已上传百分比：percent
                2、QueueProgress对象（up.total）
                文件上传速率：bytePerSec
                文件上传剩余时间:(size-loaded)/bytePerSec

                格式:速率 - 已上传(loaded)MB，共(size)MB，剩余时间*/
                var frate,floaded,fsize,ftime,fpercent;
                frate = up.total.bytesPerSec;
                floaded = file.loaded;
                fsize = file.size;
                ftime = (fsize-floaded)/frate;
                fpercent = file.percent;
                var arr = new Array(8);
                arr[0] = bytesToSize(frate);
                arr[1] = "/s - 已上传";
                arr[2] = bytesToSize(floaded);
                arr[3] = "，共";
                arr[4] = bytesToSize(fsize);
                arr[5] = "，剩余";
                arr[6] = (ftime).formatTime();
                arr[7] = "时间";
                var str = arr.join('');
                $("#persId").text(str);
                var barId = $("#barDivId");
                barId.attr("aria-valuenow",fpercent);
                barId.width(fpercent+"%");
            },
            'FileUploaded': function (up, file, info) {
                // 每个文件上传成功后,处理相关的事情
                // 其中 info 是文件上传成功后，服务端返回的json，形式如
                // {
                //    "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                //    "key": "gogopher.jpg"
                //  }
                // 参考http://developer.qiniu.com/docs/v6/api/overview/up/response/simple-response.html
                //var domain = up.getOption('domain');
                $("#descId").text("正在保存数据");
                $("#efileStateId").removeAttr("disabled");
                var res = Qiniu.parseJSON(info);
                var keyName = res.key;
                //序列化表单数据
                $("#fileUrlId").val(keyName);
                var params = $("#fileForm").serializeArray();
                //params.push({name:"key",value:fileUrlStr});
                //异步保存上传文件信息
                $.ajax({
                    type:"POST",
                    url:"/filec/updateFile.htm",
                    data:params,
                    cache:false,
                    success:function(data,status){
                        //alert(status + data.mes);
                        parent.layer.msg(status+data.mes,{shade:0.1,time:2000},function(){
                            parent.window.location = "/filec/listFile.htm";
                        });
                    },
                    error:function(xhr,status,ex){
                        alert(status+":更新失败!");
                    }
                });

            },
            'Error': function (up, err, errTip) {
                //上传出错时,处理相关的事情
                alert(errTip+"上传出错了!");

            },
            'UploadComplete': function () {
                //队列文件处理完毕后,处理相关的事情
            },
            'Key': function (up, file) {
                // 若想在前端对每个文件的key进行个性化处理，可以配置该函数
                // 该配置必须要在 unique_names: false , save_key: false 时才生效
                var key = fileUrlStr;   //若要覆盖上传，业务服务端要指定key外，客户端也要指定同名的key
                // do something with key here
                return key;
            }
        }
    });
    // domain 为七牛空间（bucket)对应的域名，选择某个空间后，可通过"空间设置->基本设置->域名设置"查看获取
    // uploader 为一个plupload对象，继承了所有plupload的方法，参考http://plupload.com/docs

});


// 格式化秒数到时间格式
Number.prototype.formatTime=function(){
    // 计算
    var h=0,i=0,s=parseInt(this);
    if(s>60){
        i=parseInt(s/60);
        s=parseInt(s%60);
        if(i > 60) {
            h=parseInt(i/60);
            i = parseInt(i%60);
        }
    }
    // 补零
    var zero=function(v){
        return (v>>0)<10?"0"+v:v;
    };
    return [zero(h),zero(i),zero(s)].join(":");
};

//数据字节换算
var k = 1000, // or 1024
    sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
function bytesToSize(bytes) {
    if (bytes === 0) return '0 B';
    var i = Math.floor(Math.log(bytes) / Math.log(k));
    return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
}

