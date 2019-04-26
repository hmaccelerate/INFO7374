package com.amazingfour.crms.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;


public interface BaseDao<T,ID extends Serializable> {
    //查询所有
    public List<T> find(Map<String, Object> map);   //map可以存放一些其它数据，如用于分页查询的start(起始页)和size(每页数量)
    //根据id查一个
    public T findById(ID id);
    //查询数量
    public int count(T domain);
    //增
    public void insert(T domain);
    //删
    public int delete(ID id);
    //改
    public int update(T domain);
}
