package com.smartparking.car.portal.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.smartparking.car.manager.bean.TCarport;
import com.smartparking.car.manager.bean.TPreorder;
import com.smartparking.car.portal.servicd.impl.CartPortServied;
import com.smartparking.car.portal.servicd.impl.PreorderService;

@Controller
public class PreorderController {
	
	@Autowired
	PreorderService preorderService;
	
	@Autowired
	CartPortServied cartPortServied;
	
		
	@RequestMapping("/preorder/time")
	public ModelAndView preOrderPage(@RequestParam("id")int id,ModelAndView modelAndView){
		System.out.println("id:"+id);
//		TPreorder tPreorder = preorderService.getReserveTime(id);
		TCarport carPort = cartPortServied.getCarPort(id);
		System.out.println("cartPort"+carPort);
		System.out.println("cartime"+cartPortServied.getCarPort(id));
		
		/*  SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		   String dateString = formatter.format(formatter);*/
		   
			modelAndView.addObject("cartPort", carPort);
		   modelAndView.addObject("time", new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date(System.currentTimeMillis()+1000*60*30)));
		   modelAndView.setViewName("preorder");
		  	return  modelAndView;
	}
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/getAjax")
	public String getAjax(){
		System.out.println("/getAjax");
		return null;
		
	}
	
}
