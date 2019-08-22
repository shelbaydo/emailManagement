package com.ncu.emailManagement.dao;


import com.ncu.emailManagement.pojo.User;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

public interface UserMapper extends Mapper<User> {

    /**
     * 查询所有role类型用户
     * @return
     */
    List<User> selectAllPersonalUser(Long role);


    List<User> page(Map<String, Object> params);

    int count(Map<String, Object> params);
}