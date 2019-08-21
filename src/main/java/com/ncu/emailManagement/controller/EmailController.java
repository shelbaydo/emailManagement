package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.pojo.Email;
import com.ncu.emailManagement.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @program: emailManagement
 * @description:
 * @author: Leo
 * @create: 2019-08-20 15:57
 **/
@Controller
@RequestMapping("email")
public class EmailController extends BaseController{
    @Autowired
    private EmailService emailService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model){
        List<Email> emails = emailService.selectAll();
        model.addAttribute("emailList",emails);
        return "/jsp/admin/email_list";
    }
}