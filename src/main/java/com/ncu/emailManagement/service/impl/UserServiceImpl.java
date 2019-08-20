package com.ncu.emailManagement.service.impl;

import com.ncu.emailManagement.dao.UserMapper;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * emailManagement-com.ncu.emailManagement.service.impl
 * created by LI LICHUNYAN at 2019/8/20
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
    public User addUser(User user){
        userMapper.insert(user);
        return  user;
    }
    public User updateUser(User user){
        userMapper.updateByPrimaryKeySelective(user);
        return user;
    }
    public User findUserByUserName(String userName){
        User user = new User();
        user.setUserName(userName);
        return userMapper.selectOne(user);
    }
}
