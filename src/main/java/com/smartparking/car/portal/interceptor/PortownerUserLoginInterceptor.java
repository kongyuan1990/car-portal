package com.smartparking.car.portal.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TUserPortowner;
import com.smartparking.project.HttpClientUtil;

public class PortownerUserLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        TUserPortowner loginUserPortowner = (TUserPortowner) request.getSession().getAttribute("loginUserPortowner");

        if (loginUserPortowner == null) {

            Cookie[] cookies = request.getCookies();
            if(cookies == null)
            	return false;
            for (Cookie cookie : cookies) {
                if ("portownerAutoLogin".equals(cookie.getName())) {
                    String account = cookie.getValue().split(":")[0];
                    String password = cookie.getValue().split(":")[1];

                    Map<String, Object> map = new HashMap<>();
                    map.put("account", account);
                    map.put("password", password);

                    String url = "http://localhost:8081/car-restapi/getUserPortowner";
                    String postRequest = HttpClientUtil.httpPostRequest(url, map);
                    TUserPortowner userPortowner = new ObjectMapper().readValue(postRequest.getBytes(),
                            new TypeReference<TUserPortowner>() {
                            });

                    if (userPortowner != null) {
                        request.getSession().setAttribute("loginUserPortowner", userPortowner);
                    }else{
                        response.sendRedirect("/login.jsp");
                        return false;
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
