package com.ncu.emailManagement.dao;


import com.ncu.emailManagement.pojo.Email;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


public interface EmailMapper extends Mapper<Email> {
    List<Email> selectAll();
}