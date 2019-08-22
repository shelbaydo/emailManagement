package com.ncu.emailManagement.dao;


import com.ncu.emailManagement.pojo.Email;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;


public interface EmailMapper extends Mapper<Email> {
    List<Email> selectAll();

    List<Email> page(Map<String, Object> params);

    int count(Map<String, Object> params);
}