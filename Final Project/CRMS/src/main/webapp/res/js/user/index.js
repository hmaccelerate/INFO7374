//新增用户弹窗
function openAddUser(url){
    layer.open({
        type: 2,
        title: ['新增用户','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '305px'],
        content: [url,'no'],
        move:false
    });
}

//编辑用户弹窗
function openEditUser(userId,url){
    var userUrl = ""+url+"?userId="+userId;
    layer.open({
        type: 2,
        title: ['编辑用户','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '355px'],
        content: [userUrl,'no'],
        move:false
    });
}

//编辑用户基本信息
/*
function openEditUserInfo(){
    var userUrl = "/user/preUserInfo.htm";
    layer.open({
        type: 2,
        title: ['编辑用户信息','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '355px'],
        content: [userUrl,'no'],
        move:false
    });
}*/
