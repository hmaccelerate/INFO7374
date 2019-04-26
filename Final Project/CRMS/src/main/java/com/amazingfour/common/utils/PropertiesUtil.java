package com.amazingfour.common.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.ResourceBundle;


public class PropertiesUtil {
    //private static final String QINIU_PROP = "qiniu.properties";

    //利用java自带类来获得属性(此方法使用有问题，不可用)
    public static String getProp(String uri,String key){
        return ResourceBundle.getBundle(uri).getString(key);
    }

    //自定义获得属性方法
    public String getProperty(String uri,String key) {
        Properties prop = new Properties();
        InputStream in = getClass().getResourceAsStream(uri);
        try {
            prop.load(in);
            String property = prop.getProperty (key);
            return property;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }finally {
            try{
                in.close();
            }catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
