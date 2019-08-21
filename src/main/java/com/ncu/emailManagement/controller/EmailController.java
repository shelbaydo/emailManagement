package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.EmailService;

import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;


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
    @RequestMapping(value = "/writeEmail",method = RequestMethod.GET)
    public String write(Model model){
        User user = (User)getSession().getAttribute("user");
        model.addAttribute("user",user);
        return "jsp/personal/writeEmail";
    }
    @RequestMapping(value = "/replyEmail/{sendId}",method = RequestMethod.GET)
    public String reply(Model model,@PathVariable long sendId){
        User user = (User)getSession().getAttribute("user");
        model.addAttribute("user",user);
        User send = userService.findUserById(sendId);
        model.addAttribute("send",send);
        return "jsp/personal/writeEmail";
    }
    @RequestMapping(value = "/deleteEmail/{emailId}",method = RequestMethod.GET)
    public String delete(Model model,@PathVariable long emailId){
        User user = (User)getSession().getAttribute("user");
        long sendId = emailService.selectByEmailId(emailId).getSendId();
        emailService.deleteByEmailId(emailId);
        model.addAttribute("user",user);
        if(sendId==user.getId()){
            return "redirect:/sent";
        }else {
            return "redirect:/EmailBox";
        }

    }
    @RequestMapping("/getAddress")
    @ResponseBody
    public List<User> getAddress(){
        return userService.findAllUser();
    }
}
