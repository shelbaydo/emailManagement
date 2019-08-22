package com.ncu.emailManagement.controller;

import com.ncu.emailManagement.dto.PageInfo;
import com.ncu.emailManagement.pojo.Email;
import com.ncu.emailManagement.service.EmailService;
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

    @ResponseBody
    @RequestMapping(value = "page", method = RequestMethod.GET)
    public PageInfo<Email> page(HttpServletRequest request, Email email){
        //DataTables参数
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        int intDraw = draw == null ? 0 : Integer.parseInt(draw);
        int intStart = start == null ? 0 : Integer.parseInt(start);
        int intLength = length == null ? 5 : Integer.parseInt(length);

        //封装 DataTables 需要的数据
        return emailService.page(intDraw, intStart, intLength, email);
    }

    @ResponseBody
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public Map<String,Object> delete(@PathVariable Long id){
        Map<String,Object> result = new HashMap<>();
        int delete = emailService.delete(id);
        if (delete <= 0){
            result.put("message","fail");
        } else {
            result.put("message","success");
        }
        return result;
    }
}