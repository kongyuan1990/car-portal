package com.smartparking.car.portal.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.car.manager.bean.TUserPortowner;
import com.smartparking.car.manager.constant.Constants;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;

@Controller
public class MemberController {

    @Autowired
    RestApiServerInfo restApiServerInfo;
    
    /**
     * 车主登录
     */
    @RequestMapping("/carownerLogin")
    public String carownerLogin(TUserMember userMember, HttpSession session, Model model, HttpServletResponse response,
            @RequestParam(value = "loginkeeping", defaultValue = "") String loginKeeping) {
        String url = restApiServerInfo.getRestApiURL() + "/carownerLogin";
        Map<String, Object> params = new HashMap<>();
        params.put("account", userMember.getAccount());
        params.put("password", userMember.getPassword());
        System.out.println("params: " + params);
        System.out.println("url: " + url);

        try {
            String postRequest = HttpClientUtil.httpPostRequest(url, params);
            SmartCarReturn<TUserMember> readValue = null;
            try {
                readValue = new ObjectMapper().readValue(postRequest.getBytes(),
                        new TypeReference<SmartCarReturn<TUserMember>>() {
                        });
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (readValue.getCode() == 1) {
                // 登录成功
                session.setAttribute(Constants.LOGIN_USER_MEMBER, readValue.getContent());
                // 自动登录
                if ("true".equals(loginKeeping)) {
                    String account = userMember.getAccount();
                    String password = userMember.getPassword();
                    String value = account + ":" + password;

                    Cookie cookie = new Cookie("userMemberAutoLogin", value);
                    cookie.setMaxAge(60 * 60 * 24 * 7);
                    cookie.setPath("/");

                    response.addCookie(cookie);
                }
                return "redirect:/main.jsp";
            } else {
                model.addAttribute("msg", "用户名或密码错误，请重新登录");
                model.addAttribute("wrongUserInfo", userMember);
                return "forward:/login.jsp";
            }
        } catch (UnsupportedEncodingException e) {
            model.addAttribute("msg", "登录异常，请重新登录");
            return "forward:/login.jsp";
        }
        // return "redirect:/main.jsp";

    }
    
    /**
     * 车库商户登录
     */
    @RequestMapping("/portownerLogin")
    public String portownerLogin(TUserPortowner userPortowner, HttpSession session, Model model,
            HttpServletResponse response, @RequestParam(value = "loginkeeping", defaultValue = "") String loginKeeping) {
        String url = restApiServerInfo.getRestApiURL() + "/portownerLogin";
        Map<String, Object> params = new HashMap<>();
        params.put("account", userPortowner.getAccount());
        params.put("password", userPortowner.getPassword());

        try {
            String postRequest = HttpClientUtil.httpPostRequest(url, params);
            SmartCarReturn<TUserPortowner> readValue = null;
            try {
                readValue = new ObjectMapper().readValue(postRequest.getBytes(),
                        new TypeReference<SmartCarReturn<TUserPortowner>>() {
                        });

            } catch (Exception e) {
                e.printStackTrace();
            }

            if (readValue.getCode() == 1) {
                // 登录成功
                session.setAttribute(Constants.LOGIN_USER_PORTOWNER, readValue.getContent());

                if ("true".equals(loginKeeping)) {
                    String account = userPortowner.getAccount();
                    String password = userPortowner.getPassword();
                    String value = account + ":" + password;

                    Cookie cookie = new Cookie("portownerAutoLogin", value);
                    cookie.setMaxAge(60 * 60 * 24 * 7);
                    cookie.setPath("/");

                    response.addCookie(cookie);

                }
                return "redirect:/main.jsp";
            } else {
                model.addAttribute("msg", "用户名或密码错误，请重新登录");
                model.addAttribute("wrongUserInfo", userPortowner);
                return "forward:/login.jsp";
            }
        } catch (UnsupportedEncodingException e) {
            model.addAttribute("msg", "登录异常，请重新登录");
            return "forward:/login.jsp";
        }
    }
    
    /**
     * 来到忘记密码页面
     */
    @RequestMapping("/forgetpwd")
    public String forgetPassword() {
        
        return "forward:/WEB-INF/views/forgetpwd.jsp";
    }
    
    @RequestMapping("/sendEmail")
    public String sendEmail(@RequestParam("email")String email, @RequestParam("userType")String userType){
        
        String url = restApiServerInfo.getRestApiURL() + "/sendEmail";
        Map<String,Object> map = new HashMap<>();
        map.put("email", email);
        map.put("userType", userType);
        
        try {
            String postRequest = HttpClientUtil.httpPostRequest(url, map);
            try {
                SmartCarReturn<Object> readValue = new ObjectMapper().readValue(postRequest.getBytes(), new TypeReference<SmartCarReturn<Object>>() {
                });
                
               System.out.println(readValue.getMsg());
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return "success";
        
    }

}
