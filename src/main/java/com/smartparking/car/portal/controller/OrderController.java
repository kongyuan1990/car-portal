package com.smartparking.car.portal.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.math3.geometry.partitioning.BSPTreeVisitor.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TOrder;
import com.smartparking.project.HttpClientUtil;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
    RestApiServiceInfo restApiServiceInfo;
	
	@RequestMapping("/orderdetails")
	public String orderdetails(Integer orderId,HttpSession session,Model model) {
		
		String Url = restApiServiceInfo.getRestApiUrl() + "/order/orderdetails";
		Map<String, Object> params = new HashMap<>();
		
		try {
			params.put("orderId", orderId);
			String response = HttpClientUtil.httpPostRequest(Url, params);
			 System.out.println(response);
			 ParkingReturn<TOrder> result = new ObjectMapper().readValue(response.getBytes(),
	                    new TypeReference<ParkingReturn<TOrder>>() {});
	            if(result.getCode() == 1){
	                session.setAttribute("order", result.getContent());
	                return "order";
	            }else{
	                model.addAttribute("msg", "获取订单信息失败!!!");
	                return "fail";
	            }
		} catch (Exception e) {
			e.printStackTrace();
		}
       
		return "";
	}
	
	@RequestMapping("/pay")
	public String checkout(HttpSession session) {
		TOrder order = new TOrder();
		order = (TOrder) session.getAttribute("order");
		
		if(order.getTotalTime() == null ) {
			session.setAttribute("msg", "订单未完成，不能结算");
			return "order";
		}
		if(order.getStatus()==1) {
			String Url = restApiServiceInfo.getRestApiUrl() + "/order/pay";
			Map<String, Object> params = new HashMap<>();
			
			try {
				params.put("orderId", order.getId());
				String response = HttpClientUtil.httpPostRequest(Url, params);
				 System.out.println(response);
				 
				 ParkingReturn<TOrder> result = new ObjectMapper().readValue(response.getBytes(),
		                    new TypeReference<ParkingReturn<TOrder>>() {});
				 session.setAttribute("msg", result.getMsg());
		            if(result.getCode() == 1){
		            	//结账成功后删除session域信息，防止重复结账。
		                session.removeAttribute("order");
		                return "redirect:/index.jsp";
		            }else{
		                return "redirect:/payfail.jsp";
		            }
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			session.setAttribute("msg", "订单关闭或已经结算");
			
		}
		return "redirect:/index.jsp";
	}
		
}
