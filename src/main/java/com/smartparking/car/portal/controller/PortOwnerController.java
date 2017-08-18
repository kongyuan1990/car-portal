package com.smartparking.car.portal.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.car.manager.bean.TUserPortowner;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;

@Controller
@RequestMapping("/portowner")
public class PortOwnerController {

    @Value("${restapi.server.ip}")
    private String restapiip;
    
    @Value("${restapi.server.port}")
    private String restapiport;
    
    @Value("${restapi.server.apppath}")
    private String apppath;
    
    private String getRestApiURL(){
        return "http://"+ restapiip + ":" + restapiport +"/"+ apppath;
    }
    
    @RequestMapping("/portownerRegist")
    public String regist(TUserPortowner portOwner,Model model,HttpSession session){
        String url = getRestApiURL() + "/portowner/portownerRegist";
        Map<String,Object> params = new HashMap<>();
        params.put("account", portOwner.getAccount());
        params.put("password", portOwner.getPassword());
        params.put("email", portOwner.getEmail());
        try {
            String response = HttpClientUtil.httpPostRequest(url,params);
            System.out.println(response);
            ObjectMapper objectMapper = new ObjectMapper();
            SmartCarReturn<TUserPortowner> readValue = null;
            try {
                 readValue = objectMapper.readValue(response.getBytes(), new TypeReference<SmartCarReturn<TUserPortowner>>() {
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
            if(readValue.getCode()==1){
                System.out.println("注册成功");
                return "redirect:/login.jsp";
            }else{
                model.addAttribute("msg", "注册失败，用户名或邮箱已被使用");
                model.addAttribute("account", portOwner.getAccount());
                model.addAttribute("active", "商家注册");
                return "forward:/register.jsp";
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}
