package com.amazingfour.common.utils.qiniu;

import com.amazingfour.crms.domain.CloudFile;
import com.qiniu.util.StringMap;

import java.util.Iterator;
import java.util.List;

public class MyUploadToken {
    //自定义上传凭证
    public static String getMyUpToken(){
        ConfigToken ct = new ConfigToken();
        long expires = 3600*24;     //设置Token失效时长为24小时
        StringMap policy = new StringMap();
        boolean strict = true;

        //policy.put("returnBody", "filesize=$(fsize)");

        String token = ct.getUpToken(null,expires,policy,strict);
        return token;
    }

    //用于更新文件的重新上传凭证
    public static String getReUpToken(String key){
        ConfigToken ct = new ConfigToken();
        long expires = 3600*24;     //设置Token失效时长为24小时
        StringMap policy = new StringMap();
        boolean strict = true;

        //policy.put("returnBody", "filesize=$(fsize)");

        String token = ct.getUpToken(key,expires,policy,strict);
        return token;
    }

    //用于查询时视频帧地址的批量获取
    public static List<CloudFile> getVframes(List<CloudFile> cloudFiles){
        ConfigToken ct = new ConfigToken();
        if(cloudFiles != null && !cloudFiles.isEmpty()){
            Iterator<CloudFile> it = cloudFiles.iterator();
            while (it.hasNext()){
                CloudFile cf = it.next();
                String vUrl = ct.getVfUrl(cf.getFileUrl());
                cf.setVframeUrl(vUrl);
            }
        }
        return cloudFiles;
    }
}
