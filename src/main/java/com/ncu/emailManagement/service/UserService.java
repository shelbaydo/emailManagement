package com.ncu.emailManagement.service;

import com.ncu.emailManagement.pojo.User;

/**
 * emailManagement-com.ncu.emailManagement.service
 * created by LI LICHUNYAN at 2019/8/20
 */
public interface UserService {
    public User addUser(User user);
    public User updateUser(User user);
    public User findUserByUserName(String UserName);
}