package com.smartparking.car.portal.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

@Controller
public class RestApiServiceInfo {
    
    @Value("${restapi.server.ip}")
    private String restapiserver;
    
    @Value("${restapi.server.port}")
    private String restapiport;
    
    @Value("${restapi.server.apppath}")
    private String appPath;
    
    public String getRestApiUrl(){
        System.out.println("http://" + restapiserver + ":" + restapiport + "/" + appPath);
        return  "http://" + restapiserver + ":" + restapiport + "/" + appPath;
    }
}
