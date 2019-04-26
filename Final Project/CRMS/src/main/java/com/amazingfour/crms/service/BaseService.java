package com.amazingfour.crms.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;


public interface BaseService<T,ID extends Serializable> {
    //void setBaseDao();
    //查询所有
    public List<T> find(Map<String, Object> map);
    //根据id查一个
    public T findById(ID id);
    //查询数量
    public int count(T domain);
    //增
    public void insert(T domain);
    //删
    public boolean delete(ID id);
    //改
    public boolean update(T domain);
}
