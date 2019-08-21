package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.pojo.Email;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
public class ExtraController {
    @Autowired
    EmailService emailService;

    /**
     * 写邮箱Post请求
     * @param address
     * @param emailTitle
     * @param emailContent
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/writeEmail",method = RequestMethod.POST)
    public String writeEmailPost(Long address, String emailTitle, String emailContent, MultipartFile emailAttach, HttpServletRequest request, HttpSession httpSession){
        Email email = new Email();
        User user = (User) httpSession.getAttribute("user");
        email.setSendId(user.getId());
        email.setReceiveId(address);
        email.setEmailTitle(emailTitle);
        email.setEmailContent(emailContent);
        email.setIsRead(0l);
        if(!emailAttach.isEmpty()){
            String path = request.getSession().getServletContext().getRealPath("//WEB-INF//file//");
            String originalFileName = emailAttach.getOriginalFilename();
            // 新的文件名称
            String newFileName = UUID.randomUUID() + originalFileName.substring(originalFileName.lastIndexOf("."));
            // 新的文件
            File newFile = new File(path +"//"+ newFileName);
            // 将内存中的数据写入磁盘
            try {
                emailAttach.transferTo(newFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            String location="/file/"+newFileName;
            email.setEmailAttach(location);
        }
        emailService.insertEmail(email);
        return "redirect:/sent";
    }

    /**
     * 收件箱页面
     * @param model
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/EmailBox",method = RequestMethod.GET)
    public String emailBox(Model model, HttpSession httpSession){
        User user = (User) httpSession.getAttribute("user");
        List<Email> emails = emailService.selectByReceiverId(user.getId());
        model.addAttribute("emails",emails);
        return "jsp/personal/EmailBox";
    }

    /**
     * 已发送页面
     * @param model
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/sent",method = RequestMethod.GET)
    public String sent(Model model, HttpSession httpSession){
        User user = (User) httpSession.getAttribute("user");
        List<Email> emails = emailService.selectBySenderId(user.getId());
        model.addAttribute("emails",emails);
        return "jsp/personal/sent";
    }

    @RequestMapping(value = "/readEmail/{id}",method = RequestMethod.GET)
    public String readEmail(@PathVariable Long id,Model model){
        Email email = emailService.selectByEmailId(id);
        email.setIsRead(1l);
        emailService.updateIsRead(email);
        model.addAttribute("email",email);
        return "jsp/personal/readEmail";
    }

}
