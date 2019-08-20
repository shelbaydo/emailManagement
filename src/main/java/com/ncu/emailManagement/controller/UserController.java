package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * emailManagement-com.ncu.emailManagement.controller
 * created by LI LICHUNYAN at 2019/8/20
 */
@Controller
public class UserController extends BaseController{
    @Autowired
    private UserService userService;
    @RequestMapping("UserDetail")
    public String UserDetail(Model model){
        User user = (User)getSession().getAttribute("user");
        if(user==null){
            return "index";
        }else{
            model.addAttribute("user",user);
            return "jsp/personal/UserDetail";
        }
    }
    @RequestMapping("alterUserInfo")
    @ResponseBody
    public Map<String,Object> alterDevUserInfo(@RequestParam(value = "password") String password)
    {
        Map<String ,Object> resultMap = new HashMap<String ,Object>();
        User user = (User)getSession().getAttribute("user");
        if(password!=null&&password.equals("")==false){
            user.setPassword(password);
        }
        if(userService.updateUser(user)>0){
            resultMap.put("message","ok");
        }else{
            resultMap.put("message","fail");
        }
        return resultMap;
    }
}
