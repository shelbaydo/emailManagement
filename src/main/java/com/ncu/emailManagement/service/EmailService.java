package com.ncu.emailManagement.service;

import com.ncu.emailManagement.dto.PageInfo;
import com.ncu.emailManagement.pojo.Email;

import java.util.List;

/**
 * emailManagement-com.ncu.emailManagement.service
 * created by LI LICHUNYAN at 2019/8/20
 */
public interface EmailService {

    PageInfo<Email> page(int draw, int start, int length, Email email);

    int delete(Long id);
    List<Email> selectAll();

    /**
     * 插入邮件
     * @param email
     * @return
     */
    int insertEmail(Email email);

    /**
     * 根据发送者id获取所有相关邮件
     * @param id
     * @return
     */
    List<Email> selectBySenderId(Long id);

    /**
     * 根据接收者id获取所有相关邮件
     * @param id
     * @return
     */
    List<Email> selectByReceiverId(Long id);

    /**
     * 更新已读
     * @param email
     * @return
     */
    int updateIsRead(Email email);

    /**
     * 根据邮件id获取指定邮件
     * @param id
     * @return
     */
    Email selectByEmailId(Long id);

    void deleteByEmailId(long emailId);
}
