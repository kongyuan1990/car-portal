package com.smartparking.car.portal.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.DefaultServletHttpRequestHandler;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.project.HttpClientUtil;

public class UserMemberLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        TUserMember loginUserMember = (TUserMember) request.getSession().getAttribute("loginUserMember");

        if(handler instanceof DefaultServletHttpRequestHandler) {
            return true;
        }
        
        if (loginUserMember == null) {

            Cookie[] cookies = request.getCookies();

            if (cookies != null && cookies.length > 0) {
                for (Cookie cookie : cookies) {

                    if ("userMemberAutoLogin".equals(cookie.getName())) {
                        String account = cookie.getValue().split(":")[0];
                        String password = cookie.getValue().split(":")[1];

                        /*TUserMember userMember = new TUserMember();
                        userMember.setAccount(account);
                        userMember.setPassword(password);
                        Map<String, Object> map = new HashMap<>();
                        map.put("userMember", userMember);*/
                        
                        Map<String, Object> map = new HashMap<>();
                        map.put("account", account);
                        map.put("password", password);

                        String url = "http://localhost:8081/car-restapi/getUserMember";
                        String postRequest = HttpClientUtil.httpPostRequest(url, map);
                        TUserMember userMember2 =new ObjectMapper().readValue(postRequest.getBytes(),
                                new TypeReference<TUserMember>() {
                                });

                        if (userMember2 != null) {
                            request.getSession().setAttribute("loginUserMember", userMember2);
                        } else {
                            response.sendRedirect("/login.jsp");
                            return false;
                        }
                    }
                }

            }

        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub

    }

}
