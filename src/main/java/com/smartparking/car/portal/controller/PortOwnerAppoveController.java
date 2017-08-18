package com.smartparking.car.portal.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TCarport;
import com.smartparking.car.manager.bean.TCert;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.car.manager.bean.TUserPortowner;
import com.smartparking.car.manager.constant.Constants;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;
import com.smartparking.project.MyStringUtils;

@RequestMapping("/portownerApprove")
@Controller
public class PortOwnerAppoveController {

	private final String AUTO_INFO = "auto_info";

	@Value("${restapi.server.ip}")
	private String restapiip;

	@Value("${restapi.server.port}")
	private String restapiport;

	@Value("${restapi.server.apppath}")
	private String apppath;

	private String getRestApiURL() {
		return "http://" + restapiip + ":" + restapiport + "/" + apppath;
	}

	/**
	 * 完成账户类型选择
	 * 
	 * @Description (TODO这里用一句话描述这个方法的作用)
	 * @return
	 */
	@RequestMapping("/applyPage.html")
	public String finishCheckAccountType(HttpSession session) {
		// 获取登陆对象
		Object attribute = session.getAttribute(Constants.LOGIN_USER_PORTOWNER);
		session.setAttribute(AUTO_INFO, attribute);
		return "portownerApprove/portownerApprove";
	}

	@RequestMapping("/apply.html")
	public String apply() {
		return "portownerApprove/apply";
	}

	@RequestMapping("/apply1.html")
	public String apply1(TUserPortowner tUserPortowner, HttpSession session) {
		TUserPortowner portowner = (TUserPortowner) session
				.getAttribute(AUTO_INFO);
		if (portowner == null) {
			// member 为空返回登陆页面
			return "login";
		}
		if (tUserPortowner.getName() != ""
				&& tUserPortowner.getGender() != null
				&& tUserPortowner.getPhoneNumber() != "") {
			tUserPortowner.setId(portowner.getId());
			// 基本信息收集
			 session.setAttribute("tUserPortowner", tUserPortowner);
			Map<String, Object> param = new HashMap<>();
			param.put("id", portowner.getId());
			param.put("name", tUserPortowner.getName());
			param.put("gender", tUserPortowner.getGender());
			param.put("phoneNumber", tUserPortowner.getPhoneNumber());
			// param.put("type", 2);
			
			String result = null;
			try {
				result = HttpClientUtil.httpPostRequest(getRestApiURL()
						+ "/PortOwnerAppove/updatePortownerInfo", param);
				ObjectMapper objectMapper = new ObjectMapper();
				SmartCarReturn<Object> readValue = null;
				try {
					readValue = objectMapper.readValue(result.getBytes(),
							new TypeReference<SmartCarReturn<Object>>() {
							});
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (readValue.getCode() == 1) {
					return "portownerApprove/apply-1";
				} else {
					return "portownerApprove/apply";
				}
			} catch (Exception e) {
				e.printStackTrace();
				return "portownerApprove/apply";
			}
		}
		if(session.getAttribute("tUserPortowner")!=null){
			return "portownerApprove/apply-1";
		}
		return "portownerApprove/apply";

	}

	@RequestMapping("/apply2.html")
	public String apply2(TCarport cartPort, HttpSession session, Model model) {
		TUserPortowner portowner = (TUserPortowner) session
				.getAttribute(AUTO_INFO);
		if (portowner == null) {
			// member 为空返回登陆页面
			return "login";
		}
		if (cartPort.getName()==null
				|| cartPort.getAddress()==null
				|| cartPort.getTotalPlace()==null
				|| cartPort.getPrice()==null
				|| cartPort.getAddressCity()==null) {
			model.addAttribute("msg", "请输入完整信息");
			return "portownerApprove/apply-1";
		}
		session.setAttribute("cartPort", cartPort);
		Map<String, Object> map = new HashMap<>();
//		map.put("portownerId", portowner.getId());
//		map.put("name", cartPort.getName());
//		map.put("address", cartPort.getAddress());
//		map.put("totalPlace", cartPort.getTotalPlace());
//		map.put("price", cartPort.getPrice());
//		map.put("addressCity", cartPort.getAddressCity());
		map.put("type", 1);
		String result = null;
		try {
			result = HttpClientUtil.httpPostRequest(getRestApiURL()
					+ "/PortOwnerAppove/addCarPort", map);
			System.out.println(result);
			ObjectMapper objectMapper = new ObjectMapper();
			SmartCarReturn<List<TCert>> readValue = null;
			try {
				readValue = objectMapper.readValue(result.getBytes(),
						new TypeReference<SmartCarReturn<List<TCert>>>() {
						});
			} catch (Exception e) {
				e.printStackTrace();

			}
			if (readValue.getCode() == 1) {
				List<TCert> content = readValue.getContent();
				session.setAttribute("certs", content);
				return "portownerApprove/apply-2";
			} else {
				model.addAttribute("msg", "信息填写有误");
				return "portownerApprove/apply-1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "信息填写有误");
			return "portownerApprove/apply-1";
		}
		
//		return "portownerApprove/apply-2";
		
	}
	
	@RequestMapping("/apply3.html")
	public String apply2(HttpSession session,Model model) {
		TUserPortowner portowner = (TUserPortowner) session
				.getAttribute(AUTO_INFO);
		
		TCarport cartPort = (TCarport) session.getAttribute("cartPort");
		
		if (portowner == null) {
			// member 为空返回登陆页面
			return "login";
		}else{
			Map<String, Object> map = new HashMap<>();
			map.put("portownerId", portowner.getId());
			map.put("status",1);
			
			map.put("portownerId", portowner.getId());
			map.put("name", cartPort.getName());
			map.put("address", cartPort.getAddress());
			map.put("totalPlace", cartPort.getTotalPlace());
			map.put("price", cartPort.getPrice());
			map.put("addressCity", cartPort.getAddressCity());
			
			
			String result = null;
			try {
				result = HttpClientUtil.httpPostRequest(getRestApiURL()
						+ "/PortOwnerAppove/endInfo", map);
				System.out.println(result);
				ObjectMapper objectMapper = new ObjectMapper();
				SmartCarReturn<Object> readValue = null;
				try {
					readValue = objectMapper.readValue(result.getBytes(),
							new TypeReference<SmartCarReturn<Object>>() {
							});
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (readValue.getCode() == 1) {
					model.addAttribute("msg", "您的信息以提交，请耐心等待3-5个工作日");
				} else {
					model.addAttribute("msg", "信息提交错误，请重新提交");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "portownerApprove/apply-3";
		}
	}
}
