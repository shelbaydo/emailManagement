package com.ncu.emailManagement.controller;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * emailManagement-com.ncu.emailManagement.controller
 * created by LI LICHUNYAN at 2019/8/20
 */
@Controller
public class LoginController extends BaseController {
    @Autowired
    UserService userService;
    @RequestMapping(value = "/to_login")
    public String to_login(){
        return "login";
    }
    @RequestMapping("/login")
    public String login(Model model, @RequestParam(value = "userName",required = true) String userName,
                        @RequestParam(value = "password", required=true) String password)
    {
        model.addAttribute("userName",userName);
        model.addAttribute("password",password);
        User user = userService.findUserByUserName(userName);
        if(user==null){
            model.addAttribute("error","userName_fail");
            return "login";
        }else if(user.getPassword().equals(password)==false){
            model.addAttribute("error","pwd_fail");
            return "login";
        }
        getSession().setAttribute("user",user);
        model.addAttribute("user",user);
        return "jsp/personal/index";
    }
}
