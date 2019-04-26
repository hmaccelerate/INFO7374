package com.amazingfour.common.utils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Encrypt {
    public static String Encrypt_md5(String strSrc)
    {
        //MD5加密算法
        MessageDigest md = null;    //md为加密类实例
        String strDes = null;       //strDes为密文

        try {
            md = MessageDigest.getInstance("MD5");  //获取MD5加密实例
            md.update(strSrc.getBytes());  //封装明文，得到字节数组的加密对象,MD5只对字节数组进行加密计算
            byte[] bt = md.digest();    //进行加密运算，返回密文的字节数组bt
            strDes = bytes2Hex(bt);   //将字节数组转换成十六进制字符串，形成最终的密文
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Invalid algorithm.");
            return null;
        }
        return strDes;
    }

    //转十六进制字符串
    public static String bytes2Hex(byte[] bts)
    {
        String des = "";
        String tmp = null;
        for (int i = 0; i < bts.length; i++) {
            tmp = (Integer.toHexString(bts[i] & 0xFF));  //转十六进制字符
            if (tmp.length() == 1) {
                des = des + "0";
            }
            des = des + tmp;
        }
        return des;
    }
}
