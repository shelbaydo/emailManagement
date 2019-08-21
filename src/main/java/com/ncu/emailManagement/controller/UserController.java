package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
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
 * @create: 2019-08-20 15:14
 **/
@Controller
@RequestMapping("user")
public class UserController extends BaseController{
    @Autowired
    private UserService userService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model){
        List<User> userList = userService.selectAll();
        model.addAttribute("userList",userList);
        return "/jsp/admin/user_list";
    }

    @RequestMapping(value = "page", method = RequestMethod.GET)
    public String page(){
        return null;
    }
}