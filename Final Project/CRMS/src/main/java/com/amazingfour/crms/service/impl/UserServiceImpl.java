package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.UserDao;
import com.amazingfour.crms.domain.User;
import com.amazingfour.crms.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userService")
public class UserServiceImpl extends AbstractService<User,Long> implements UserService{
    @Resource
    private UserDao userDao;

    @Resource
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
        super.setBaseDao(this.userDao);
    }

    //用户登录
    public User login(User user) {

        return userDao.login(user);
    }
    //验证用户是否存在
    public boolean existUserByName(String userName) {
        int i = userDao.existUserByName(userName);
        if (i > 0) {
            return true;
        } else {
            return false;
        }
    }

    //查找角色是否已被使用
    public boolean findUserRole(Long id) {
        if(userDao.findUserRole(id)>0){
            return true;
        }else{
            return false;
        }

    }

    //拉黑用户
    public boolean defriend(Long id){
        if(userDao.defriend(id)>0){
             return true;
        }
        else{
            return false;
        }
    }
    //确认密码是否存在
    public boolean updatePassword(User user){
        if(userDao.updatePassword(user)>0){
            return true;
        }else{
            return false;
        }
    }
    //解除用户黑名单
    public boolean removeBlack(Long id){
        if(userDao.removeBlack(id)>0){
            return true;
        }
        else{
            return false;
        }
    }

    //通过用户ID或用户名查找一个用户
    public User findOneById(User user){
        return userDao.findOneById(user);
    }

    //判断邮箱是否已绑定
    public boolean existEmail(User user){
        User oneUser = userDao.findOneById(user);
        if(user.getUserEmail().equals(oneUser.getUserEmail()) && oneUser.getActivated()==1){
            return true;
        }else{
            return false;
        }
    }

    //绑定邮箱
    public boolean bindEmail(User user){
        if(userDao.bindEmail(user)>0){
            return true;
        }
        else{
            return false;
        }
    }

    //激活邮箱
    public boolean activated(User user){
        if(userDao.activated(user)>0){
            return true;
        }
        else{
            return false;
        }
    }
    //忘记密码时判断用户是否存在和邮箱是否已绑定
    public int existUserEmail(User user){
        User oneUser = userDao.findOneById(user);
        if(oneUser==null){
            return 0;   //用户不存在
        }else if(user.getUserEmail().equals(oneUser.getUserEmail()) && oneUser.getActivated()==1){
            return 2;   //用户存在且已绑定邮箱
        }else{
            return 1;   //用户存在但未绑定邮箱
        }
    }

    //修改用户基本信息
    public boolean updateUserInifo(User user) {
        if(userDao.updateUserInfo(user)>0){
            return true;
        }
        else{
            return false;
        }
    }

    //找回密码发邮件时保存验证信息
    public boolean saveEmailMes(User user){
        if (userDao.saveEmailMes(user)>0){
            return true;
        }
        else{
            return false;
        }
    }

    public List<Integer> findByRoleName(String roleName) {
        return userDao.findByRoleName(roleName);
    }
    //批量删除文件
    public int deleteBatch(List<String> userId) {
        return userDao.deleteBatch(userId);
        /*if(rows==fileUrls.size()){
            return true;
        }else{
            return false;
        }*/
    }
}
