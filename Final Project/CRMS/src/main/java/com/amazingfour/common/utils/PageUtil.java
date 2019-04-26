package com.amazingfour.common.utils;

import java.util.Iterator;
import java.util.Map;

public class PageUtil {

    /**
     * 获取分页代码
     * @param targetUrl 目标地址
     * @param params 传入参数
     * @param totalNum 总记录数
     * @param currentPage 当前页
     * @param pageSize 每页大小
     * @return 分页栏HTML代码
     */
    public static String getPagation(String targetUrl,Map<String,Object> params,int totalNum,int currentPage,int pageSize){
        //判断查询出来的总数目是否为0
        if(totalNum==0){
            return "<font color=red>未查询到数据！</font>";
        }

        //计算总页数
        int totalPage=totalNum%pageSize==0?totalNum/pageSize:totalNum/pageSize+1;

        //构造查询字符串
        StringBuffer paramsStr = new StringBuffer();
        if(params!=null && !params.isEmpty()) {
            Iterator it = params.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                if (entry.getValue() != null) {
                    paramsStr.append("&" + entry.getKey() + "=" + entry.getValue().toString());
                }
            }
        }
        String paramsString = paramsStr.toString();

        //构造分页栏
        StringBuffer pageCode=new StringBuffer();
        pageCode.append("<li><a href='"+targetUrl+"?page=1"+paramsString+"'>First Page</a></li>");
        if(currentPage==1){
            pageCode.append("<li class='disabled'><a href='javascript:void(0)'>Previous</a></li>");
        }else{
            pageCode.append("<li><a href='"+targetUrl+"?page="+(currentPage-1)+paramsString+"'>Previous</a></li>");
        }

        for(int i=currentPage-2;i<=currentPage+2;i++){
            if(i<1 || i>totalPage){
                continue;
            }
            if(i==currentPage){
                pageCode.append("<li class='active'><a href='javascript:void(0)'>"+i+"</a></li>");
            }else{
                pageCode.append("<li><a href='"+targetUrl+"?page="+i+paramsString+"'>"+i+"</a></li>");
            }

        }

        if(currentPage==totalPage){
            pageCode.append("<li class='disabled'><a href='javascript:void(0)'>Next</a></li>");
        }else{
            pageCode.append("<li><a href='"+targetUrl+"?page="+(currentPage+1)+paramsString+"'>Next</a></li>");
        }
        pageCode.append("<li><a href='"+targetUrl+"?page="+totalPage+paramsString+"'>Last Page</a></li>");
        return pageCode.toString();
    }
}
