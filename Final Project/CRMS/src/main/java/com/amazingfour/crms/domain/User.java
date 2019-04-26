package com.amazingfour.crms.domain;

import java.beans.Transient;
import java.util.Date;


public class User {
    private Long userId;
    private String userName;
    private String password;
    private String userDescript;
    private Byte userState;
    private String verifyCode;
    private String userEmail;
    private Byte activated;
    private String emailKey;
    private Date outDate;
    private String imgUrl;
    private Long telPhone;



    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

   @Transient //不需要持久到DB的属性使用该注解
    public String getVerifyCode(){return verifyCode;}
    public void setVerifyCode(String verifyCode){this.verifyCode=verifyCode;}


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserDescript() {
        return userDescript;
    }

    public void setUserDescript(String userDescript) {
        this.userDescript = userDescript;
    }

    public Byte getUserState() {
        return userState;
    }

    public void setUserState(Byte userState) {
        this.userState = userState;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Byte getActivated() {
        return activated;
    }

    public void setActivated(Byte activated) {
        this.activated = activated;
    }

    public String getEmailKey() {
        return emailKey;
    }

    public void setEmailKey(String emailKey) {
        this.emailKey = emailKey;
    }

    public Date getOutDate() {
        return outDate;
    }

    public void setOutDate(Date outDate) {
        this.outDate = outDate;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Long getTelPhone() {
        return telPhone;
    }

    public void setTelPhone(Long telPhone) {
        this.telPhone = telPhone;
    }
}
