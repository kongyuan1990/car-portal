/******************************************************************
 *
 *    Java Lib For Android, Powered By Shenzhen Jiuzhou.
 *
 *    Copyright (c) 2001-2014 Digital Telemedia Co.,Ltd
 *    http://www.d-telemedia.com/
 *
 *    Package:     com.smartparking.car.portal.controller
 *
 *    Filename:    MapController.java
 *
 *    Description: TODO(用一句话描述该文件做什么)
 *
 *    Copyright:   Copyright (c) 2001-2014
 *
 *    Company:     Digital Telemedia Co.,Ltd
 *
 *    @author:     FeicusSmith
 *
 *    @version:    1.0.0
 *
 *    Create at:   2017年8月14日 上午10:26:45
 *
 *    Revision:
 *
 *    2017年8月14日 上午10:26:45
 *        - first revision
 *
 *****************************************************************/
package com.smartparking.car.portal.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TCarport;
import com.smartparking.car.manager.bean.TMap;
import com.smartparking.project.HttpClientUtil;

/**
 * @ClassName MapController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author FeicusSmith
 * @Date 2017年8月14日 上午10:26:45
 * @version 1.0.0
 */
@RequestMapping("/map")
@Controller
public class MapController {
    
    @Autowired
    RestApiServerInfo serverInfo;
    
    
    @ResponseBody
    @RequestMapping("/getChangePlace")
    public Map<String, Object> toGetData(@RequestParam("currentCity")String currentCity,
            @RequestParam("myAdress")String myAdress,
            HttpSession session){
        session.setAttribute("currentCity", currentCity);
        session.setAttribute("myAdress", myAdress);
        Map<String,Object> map=new HashMap<>();
        map.put("currentCity", currentCity);
        map.put("myAdress", myAdress);
        return map;
        
    }
    
    @ResponseBody
    @RequestMapping("/getAllMapsData")
    public List<TCarport> toGetAllMapsData() throws Exception{
        String restUrl = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL() + "/map/getMapsData");
        //System.out.println("PORTAL--------restUrl"+restUrl);
        
        List<TCarport> list = new ObjectMapper().readValue(restUrl.getBytes(), List.class);
        //System.out.println("PORTAL--------mapList:"+mapList);
        
        return list;  
    }
    

//    @RequestMapping("/main")
//    public String toMainPage(Model model) throws Exception{
//        String restUrl = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL() + "/map/getDisplayData");
//        //System.out.println("PORTAL--------restUrl"+restUrl);
//        
//        List<Map<String, Object>> data = new ObjectMapper().readValue(restUrl.getBytes(),List.class);
//        
//        System.out.println("------------"+data);
//        
//        model.addAttribute("mapDisplayData", data);
//        
//        return "main";
//    }
    

    @ResponseBody
    @RequestMapping("/getAbsDistance")
    public Map<String,Object> toGetAbsDistance(@RequestParam("carportId")Integer carportId,
            @RequestParam("absDistance")String absDistance,
            HttpSession session) throws Exception{
       
        Map<String,Object> map=new HashMap<>();
        map.put("carportId", carportId);
        map.put("absDistance", absDistance);
        String restUrl = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL() + "/map/updateAbsDistance",map);   
        return map;
    }
    
    
    
    @RequestMapping("/order/{portId}")
    public String testOrder(@PathVariable("portId")Integer portId,Model model) throws Exception{
        String restUrl = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL() + "/map/getRemainingPlaceNum/"+portId);   
        Map readValue = new ObjectMapper().readValue(restUrl.getBytes(), Map.class);
        
        Integer num = (Integer) readValue.get("num");
        
        if(num>1){
            Integer remainingPlace=num-1;
             String url = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL() + "/map/updateRemainingPlace?portId="+portId+"&remainingPlace="+remainingPlace);   
            Integer row = new ObjectMapper().readValue(url.getBytes(), Integer.class);
            model.addAttribute("portId", portId);
            model.addAttribute("remainingPlace", remainingPlace);
        }

        return "forward:/mapTestPage.jsp";
    }
    
    

}
