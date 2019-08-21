package com.ncu.emailManagement.service.impl;
import com.ncu.emailManagement.dao.EmailMapper;
import com.ncu.emailManagement.pojo.Email;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;
/**
 * emailManagement-com.ncu.emailManagement.service.impl
 * created by LI LICHUNYAN at 2019/8/20
 */
@Service
public class EmailServiceImpl implements EmailService {
    @Autowired
    private EmailMapper emailMapper;
    @Override
    public List<Email> selectAll() {
        return emailMapper.selectAll();
    }

    @Override
    public int insertEmail(Email email) {
        return emailMapper.insert(email);
    }

    @Override
    public List<Email> selectBySenderId(Long id) {
        Example example = new Example(Email.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("sendId",id);
        return emailMapper.selectByExample(example);
    }

    @Override
    public List<Email> selectByReceiverId(Long id) {
        Example example = new Example(Email.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("receiveId",id);
        return emailMapper.selectByExample(example);
    }

    @Override
    public int updateIsRead(Email email) {
        return emailMapper.updateByPrimaryKeySelective(email);
    }

    @Override
    public Email selectByEmailId(Long id) {
        Email email = new Email();
        email.setEmailId(id);
        return emailMapper.selectOne(email);
    }

    @Override
    public void deleteByEmailId(long emailId) {
        Email email = new Email();
        email.setEmailId(emailId);
        emailMapper.deleteByPrimaryKey(email);
    }
}