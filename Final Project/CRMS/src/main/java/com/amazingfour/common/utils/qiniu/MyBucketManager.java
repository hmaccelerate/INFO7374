package com.amazingfour.common.utils.qiniu;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.model.BatchStatus;
import com.qiniu.storage.model.FileInfo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.List;

public class MyBucketManager {
    private BucketManager bucketManager = new ConfigToken().getBucketManager();
    private BucketManager.BatchOperations  ops = new BucketManager.BatchOperations ();    //批量操作
    public static Log log = LogFactory.getLog(MyBucketManager.class);

    /**
     * 删除一个文件
     * @param key
     * @return
     */
    public boolean delete(String key){
        try {
            bucketManager.delete(ConfigToken.BUCKETNAME, key);
            return true;
        }catch (QiniuException e){
            Response r = e.response;
            // 请求失败时简单状态信息
            log.error(r.toString());
            try {
                // 响应的文本信息
                log.error(r.bodyString());
            } catch (QiniuException e1) {
                //ignore
            }
            return false;
        }
    }

    /**
     * 批量删除七牛云文件
     * @param keys
     * @return 删除成功的keys列表
     */
    public List<String> deleteBatch(String... keys){
        List<String> delKeys = new ArrayList<String>();  //存放七牛云删除成功的keys
        ops.addDeleteOp(ConfigToken.BUCKETNAME,keys);
        try {
            Response r = bucketManager.batch(ops);
            BatchStatus[] bs = r.jsonToObject(BatchStatus[].class);
            for (int i = 0;i<bs.length;i++) {
                BatchStatus b = bs[i];
                if(b.code==200 || b.code==612){
                    delKeys.add(keys[i]);
                }else{
                    log.error(b.code+":"+keys[i]+"删除失败!\n");
                }
            }
            return delKeys;
        } catch (QiniuException e) {
            Response r = e.response;
            // 请求失败时简单状态信息
            log.error(r.toString());
            try {
                // 响应的文本信息
                log.error(r.bodyString());
            } catch (QiniuException e1) {
                //ignore
            }
            return delKeys;
        }
    }

    /**
     * 批量操作并进行响应处理
     * @return
     */
    public boolean batchHandle(){
        try {
            Response r = bucketManager.batch(ops);
            BatchStatus[] bs = r.jsonToObject(BatchStatus[].class);
            for (BatchStatus b : bs) {
                if(b.code!=200){
                    log.error("批处理出错："+b.code);
                    return false;
                    //return "批处理出错："+b.code;
                }
            }
            return true;
        } catch (QiniuException e) {
            Response r = e.response;
            // 请求失败时简单状态信息
            log.error(r.toString());
            try {
                // 响应的文本信息
                log.error(r.bodyString());
            } catch (QiniuException e1) {
                //ignore
            }
            return false;
        }
    }

    /**
     * 查看文件元信息
     * @param key
     * @return
     */
    public FileInfo statFile(String key){
        FileInfo info = null;
        try {
            info = bucketManager.stat(ConfigToken.BUCKETNAME, key);
        }catch (QiniuException e){
            Response r = e.response;
            // 请求失败时简单状态信息
            log.error(r.toString());
            try {
                // 响应的文本信息
                log.error(r.bodyString());
            } catch (QiniuException e1) {
                //ignore
            }
        }
        return info;    //返回四个字段json{"fsize"(文件大小),"hash","mimeType","putTime"(最后上传时间)}
    }

}
