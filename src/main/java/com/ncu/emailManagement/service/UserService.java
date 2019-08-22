package com.ncu.emailManagement.service;

import com.ncu.emailManagement.dto.PageInfo;
import com.ncu.emailManagement.pojo.User;

import java.util.List;

/**
 * emailManagement-com.ncu.emailManagement.service
 * created by LI LICHUNYAN at 2019/8/20
 */
public interface UserService {
    public User addUser(User user);
    public int updateUser(User user);
    public User findUserByUserName(String UserName);
    public List<User> findAllUser();

    public User findUserById(long sendId);

    int unLockUser(Long id);
    PageInfo<User> page(int draw, int start, int length, User user);

    int lockUser(Long id);

    List<User> selectAllPersonalUser(Long role);

    List<User> selectAll();
}
