package com.amazingfour.crms.domain;


public class UserFile {
    private int id;
    private Long user_id;
    private String bussinessKey;

    public UserFile() {
    }

    public UserFile(Long user_id, String bussinessKey) {
        this.user_id = user_id;
        this.bussinessKey = bussinessKey;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Long getUser_id() {
        return user_id;
    }

    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    public String getBussinessKey() {
        return bussinessKey;
    }

    public void setBussinessKey(String bussinessKey) {
        this.bussinessKey = bussinessKey;
    }
}
