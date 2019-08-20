package com.ncu.emailManagement.controller;


import com.ncu.emailManagement.common.CodeCaptchaServlet;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.HashMap;
import java.util.Map;

/**
 * app-store-com.ncu.appstore.controller
 * created by LI LICHUNYAN at 2019/8/6
 */
@Controller
public class RegisterController extends BaseController {
    @Autowired
   private UserService userService;
 @RequestMapping(value = "/to_register")
    public String to_register(){
     return "register";
 }
 @RequestMapping( "/register")
    public String register(Model model, User user){
     user.setIsActive(1l);
     userService.addUser(user);
     model.addAttribute("registerMessage","注册成功");
     return "jsp/register/registerSuccess";
 }
    /**
     * 判断验证码是否正确
     *
     * @param code
     * @return
     */
    @RequestMapping("/checkCode")
    @ResponseBody
    public Map<String, Object> checkCode(@RequestParam(value = "code", required = false) String code) {

        Map map = new HashMap<String, Object>();
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        String vcode = (String) attrs.getRequest().getSession().getAttribute(CodeCaptchaServlet.VERCODE_KEY);
        if (code.equals(vcode)) {
            //验证码正确
            map.put("message", "success");
        } else {
            //验证码错误
            map.put("message", "fail");
        }
        return map;
    }
    @RequestMapping("/checkUserName")//判断用户名是否已被注册
    @ResponseBody
    public Map<String, Object> checkDevCode(@RequestParam(value = "userName", required = true) String userName) {
        Map map = new HashMap<String, Object>();
        User user = userService.findUserByUserName(userName);
        if (user == null) {
            //未注册
            map.put("message", "success");
        } else {
            //已注册
            map.put("message", "该用户名已被使用");
        }
        return map;
    }
}
