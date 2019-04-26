package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository("userDao")
public interface UserDao extends BaseDao<User,Long>{
    public User login(User user);
    public int existUserByName(String userName);
    public int findUserRole(Long id);
    public int defriend(Long id);
    public int updatePassword(User user);
    public int removeBlack(Long id);
    public User findOneById(User user);
    public int bindEmail(User user);
    public int updateUserInfo(User user);
    public int activated(User user);
    public int saveEmailMes(User user);
    public List<Integer> findByRoleName(String roleName);
    //批量删除文件
    public int deleteBatch(List<String> userId);
}
