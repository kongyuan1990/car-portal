package com.smartparking.car.portal.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

@Controller
public class RestApiServerInfo {
    
    @Value("${restapi.server.ip}")
    private String restApiServerIP;
    
    @Value("${restapi.server.port}")
    private String restApiServerPort;
    
    @Value("${restapi.server.apppath}")
    private String restApiServerAppPath;
    
    public String getRestApiURL(){
        
        return "http://"+restApiServerIP+":"+restApiServerPort+restApiServerAppPath;
    }
    
    
}
