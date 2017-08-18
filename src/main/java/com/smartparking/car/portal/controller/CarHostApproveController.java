package com.smartparking.car.portal.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TCert;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.car.manager.constant.Constants;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;

@RequestMapping("/auth")
@Controller
public class CarHostApproveController {

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
		Object attribute = session.getAttribute(Constants.LOGIN_USER_MEMBER);
		session.setAttribute(AUTO_INFO, attribute);
		return "carhostApprove/carhostApprove";
	}

	@RequestMapping("/apply.html")
	public String apply(HttpSession session) {
		return "carhostApprove/apply";
	}

	@RequestMapping("/apply1.html")
	public String apply1(TUserMember userMember, HttpSession session,Model model) {
		TUserMember member = (TUserMember) session.getAttribute(AUTO_INFO);
		if (member == null) {
			// member 为空返回登陆页面
			return "login";
		}
		if (userMember.getName() != "" && userMember.getGender() != null
				&& userMember.getIdCardNumber() != ""
				&& userMember.getPhoneNumber() != ""
				&& userMember.getCarNumber() != "") {
			userMember.setId(member.getId());
			// 基本信息收集
			session.setAttribute("baseinfo", userMember);
			Map<String, Object> param = new HashMap<>();
			param.put("id", member.getId());
			param.put("name", userMember.getName());
			param.put("gender", userMember.getGender());
			param.put("idCardNumber", userMember.getIdCardNumber());
			param.put("phoneNumber", userMember.getPhoneNumber());
			param.put("carNumber", userMember.getCarNumber());

			param.put("type", 2);
			String result = null;
			try {
				result = HttpClientUtil.httpPostRequest(getRestApiURL()
						+ "/cert/getCerts", param);
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
				} else {
					System.out.println("获取失败");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "carhostApprove/apply-1";
		}
		model.addAttribute("baseinfo", userMember);
		model.addAttribute("msg", "请输入完整信息");
		return "carhostApprove/apply";

	}

	@RequestMapping("/apply2.html")
	public String apply2(HttpSession session,Model model) {
		TUserMember member = (TUserMember) session.getAttribute(AUTO_INFO);
		if (member == null) {
			// member 为空返回登陆页面
			return "login";
		}else{
			Map<String, Object> map = new HashMap<>();
			map.put("id", member.getId());
			map.put("status",1);
			String result = null;
			try {
				result = HttpClientUtil.httpPostRequest(getRestApiURL()
						+ "/cert/endInfo", map);
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
			return "carhostApprove/apply-2";
		}
	}

//	@RequestMapping("/apply3.html")
//	public String apply3(HttpSession session) {
//		TUserMember member = (TUserMember) session.getAttribute(AUTO_INFO);
//		if (member == null) {
//			return "login";
//		}else{
//			Map<String, Object> map = new HashMap<>();
//			map.put("id", member.getId());
//			map.put("email", member.getEmail());
//			String result = null;
//			try {
//				result = HttpClientUtil.httpPostRequest(getRestApiURL()
//						+ "/cert/sendEmail", map);
//				System.out.println(result);
//				ObjectMapper objectMapper = new ObjectMapper();
//				SmartCarReturn<List<TCert>> readValue = null;
//				try {
//					readValue = objectMapper.readValue(result.getBytes(),
//							new TypeReference<SmartCarReturn<List<TCert>>>() {
//							});
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//				if (readValue.getCode() == 1) {
//					List<TCert> content = readValue.getContent();
//					session.setAttribute("certs", content);
//				} else {
//					System.out.println("获取失败");
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//			return "carhostApprove/apply-3";
//		}
//		
//	}

}
