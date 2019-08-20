package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.EmailService;

import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * emailManagement-com.ncu.emailManagement.controller
 * created by LI LICHUNYAN at 2019/8/20
 */
@Controller
public class EmailController extends BaseController {
    @Autowired
    EmailService emailService;
    @Autowired
    UserService userService;
    @RequestMapping("/writeEmail")
    public String write(Model model){
        User user = (User)getSession().getAttribute("user");
        model.addAttribute("user",user);
        return "jsp/personal/writeEmail";
    }
    @RequestMapping("/EmailBox")
    public String emailBox(Model model){
        User user = (User)getSession().getAttribute("user");
        model.addAttribute("user",user);
        return "jsp/personal/EmailBox";
    }
    @RequestMapping("/sent")
    public String sent(Model model){
        User user = (User)getSession().getAttribute("user");
        model.addAttribute("user",user);
        return "jsp/personal/sent";
    }
    @RequestMapping("/sendEmail")
    public Map<String ,Object> sendEmail(){
        Map<String,Object> map = new HashMap<String,Object>();
        return map;
    }
    @RequestMapping("/getAddress")
    @ResponseBody
    public List<User> getAddress(){
       return userService.findAllUser();
    }
}
