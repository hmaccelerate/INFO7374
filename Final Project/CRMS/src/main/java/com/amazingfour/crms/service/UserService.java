package com.amazingfour.crms.service;


import com.amazingfour.crms.domain.User;

import java.util.List;


public interface UserService extends BaseService<User,Long> {
    public User login(User user);
    public boolean existUserByName(String userName);
    public boolean findUserRole(Long id);
    public boolean defriend(Long id);
    public boolean updatePassword(User user);
    public boolean removeBlack(Long id);
    public User findOneById(User user);
    public boolean existEmail(User user);
    public boolean bindEmail(User user);
    public boolean activated(User user);
    public int existUserEmail(User user);
    public boolean updateUserInifo(User user);
    public boolean saveEmailMes(User user);
    public List<Integer> findByRoleName(String roleName);
    //批量删除用户
    public int deleteBatch(List<String> userId);
}
