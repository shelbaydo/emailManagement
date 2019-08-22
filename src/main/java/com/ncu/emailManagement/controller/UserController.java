package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.dto.PageInfo;
import com.ncu.emailManagement.pojo.User;
import com.ncu.emailManagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public String list(){
        return "/jsp/admin/user_list";
    }

    @ResponseBody
    @RequestMapping(value = "page", method = RequestMethod.GET)
    public PageInfo<User> page(HttpServletRequest request, User user){
        //DataTables参数
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        int intDraw = draw == null ? 0 : Integer.parseInt(draw);
        int intStart = start == null ? 0 : Integer.parseInt(start);
        int intLength = length == null ? 5 : Integer.parseInt(length);
        //封装 DataTables 需要的数据
        return userService.page(intDraw, intStart, intLength, user);
    }

    @ResponseBody
    @RequestMapping(value = "lock/{id}",method = RequestMethod.GET)
    public Map<String,Object> lock(@PathVariable Long id){
        Map<String,Object> map = new HashMap<>();
        int i = userService.lockUser(id);
        if (i <= 0){
            map.put("message","fail");
        } else {
            map.put("message","success");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "unlock/{id}",method = RequestMethod.GET)
    public Map<String,Object> unlock(@PathVariable Long id){
        Map<String,Object> map = new HashMap<>();
        int i = userService.unLockUser(id);
        if (i <= 0){
            map.put("message","fail");
        } else {
            map.put("message","success");
        }
        return map;
    }
}