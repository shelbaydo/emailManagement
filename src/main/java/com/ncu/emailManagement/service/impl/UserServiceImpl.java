package com.ncu.emailManagement.service.impl;

import com.ncu.emailManagement.dao.UserMapper;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;
import com.ncu.emailManagement.dto.PageInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public int updateUser(User user){
        return userMapper.updateByPrimaryKey(user);
    }
    public User findUserByUserName(String userName){
        User user = new User();
        user.setUserName(userName);
        return userMapper.selectOne(user);
    }
    public List<User> findAllUser(){
        Example example = new Example(User.class);
        Example.Criteria  criteria = example.createCriteria();
        criteria.andEqualTo("role",1);
        return userMapper.selectByExample(example);
    }

    @Override
    public User findUserById(long sendId) {
        User user = new User();
        user.setId(sendId);
        return userMapper.selectOne(user);

    }

    @Override
    public int lockUser(Long id) {
        User user = new User();
        user.setId(id);
        user.setIsActive(0L);
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public List<User> selectAllPersonalUser(Long role) {
        return userMapper.selectAllPersonalUser(role);
    }

    @Override
    public List<User> selectAll() {
        return userMapper.select(new User());
    }
    @Override
    public PageInfo<User> page(int draw, int start, int length, User user) {
        PageInfo<User> pageInfo = new PageInfo<>();
        Map<String,Object> params = new HashMap<>();
        params.put("start",start);
        params.put("length",length);
        params.put("pageParams",user);

        List<User> users = userMapper.page(params);
        //由于可能有查询条件查询，所以须查询出记录总数
        int count = userMapper.count(params);

        pageInfo.setData(users);
        pageInfo.setDraw(draw);
        pageInfo.setRecordsTotal(count);
        pageInfo.setRecordsFiltered(count);
        pageInfo.setError("");
        return pageInfo;
    }
    @Override
    public int unLockUser(Long id) {
        User user = new User();
        user.setId(id);
        user.setIsActive(1L);
        return userMapper.updateByPrimaryKeySelective(user);
    }


}
