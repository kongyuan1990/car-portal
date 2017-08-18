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
import com.smartparking.project.HttpClientUtil;
import com.smartparking.project.MyStringUtils;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.car.portal.bean.SmartCarReturn;

@RequestMapping("/carhost")
@Controller
public class CarHostController {

    @Value("${restapi.server.ip}")
    private String restapiip;
    
    @Value("${restapi.server.port}")
    private String restapiport;
    
    @Value("${restapi.server.apppath}")
    private String apppath;
    
    private String getRestApiURL(){
        return "http://"+ restapiip + ":" + restapiport +"/"+ apppath;
    }
    
    @RequestMapping("/carhostRegist")
    public String regist(TUserMember member,Model model,HttpSession session){
        String url = getRestApiURL() + "/carhostmember/carhostRegist";
        System.out.println("车主注册");
        if(MyStringUtils.isEmpty(member.getAccount()) ||
        		MyStringUtils.isEmpty(member.getPassword())||
        		MyStringUtils.isEmpty(member.getPassword())){
        	model.addAttribute("msg", "请填写完整信息");
        	return "forward:/register.jsp";
        }
        Map<String,Object> params = new HashMap<>();
        params.put("account", member.getAccount());
        params.put("password", member.getPassword());
        params.put("email", member.getEmail());
        
        try {
            String response = HttpClientUtil.httpPostRequest(url,params);
            System.out.println(response);
            ObjectMapper objectMapper = new ObjectMapper();
            SmartCarReturn<TUserMember> readValue = null;
            try {
                 readValue = objectMapper.readValue(response.getBytes(), new TypeReference<SmartCarReturn<TUserMember>>() {
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
            if(readValue.getCode()==1){
                System.out.println("注册成功");
                return "redirect:/login.jsp";
            }else{
                model.addAttribute("msg", "注册失败，用户名或邮箱已被使用");
                model.addAttribute("account", member.getAccount());
                model.addAttribute("active", "车主注册");
                return "forward:/register.jsp";
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
