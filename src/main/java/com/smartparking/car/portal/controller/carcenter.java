package com.smartparking.car.portal.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TOrder;
import com.smartparking.car.manager.bean.TUserMember;
import com.smartparking.car.manager.bean.TWallet;
import com.smartparking.car.manager.constant.Constants;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;

@RequestMapping("/member")
@Controller
public class carcenter {
	
	@Autowired
	RestApiServerInfo rasi;
	


	/**
	 * 
	 * @param tUserMember
	 * @param session
	 * @return
	 * @throws JsonProcessingException 
	 */
	@ResponseBody
	@RequestMapping("/editinformation")
	public TUserMember editinformation(TUserMember tUserMember,HttpSession session,Model model) throws JsonProcessingException{
		TUserMember tUserMember1 = (TUserMember) session.getAttribute(Constants.LOGIN_USER_MEMBER);
		TUserMember userMember = null;
		tUserMember.setId(tUserMember1.getId());
		ObjectMapper objectMapper = new ObjectMapper();
		String string1 = objectMapper.writeValueAsString(tUserMember);
		Map<String, Object> params = new HashMap<>();
		params.put("string1", string1);
		try {
			String string = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/editinformation", params );
			try {
				SmartCarReturn<TUserMember> user = new ObjectMapper().readValue(string.getBytes(), new TypeReference<SmartCarReturn<TUserMember>>() {});
				userMember = user.getContent();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return userMember;
	}
	
	/**
	 * 修改密码
	 * @param old_password
	 * @param new_password
	 * @param repeat_new_password
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/forgetpassword")
	public SmartCarReturn<Object> forgetpassword(@RequestParam("old_password")String old_password,
								@RequestParam("new_password")String new_password,
								@RequestParam("repeat_new_password")String repeat_new_password,
								HttpSession session){
		System.out.println("新密码："+new_password+"旧密码"+old_password+"再次输入"+repeat_new_password);
		SmartCarReturn<Object> a = new SmartCarReturn<>();
		
		if(!new_password.equals(repeat_new_password)){
			a.setMsg("两次密码输入不相同，请重新确认");
		}else if(old_password.equals(new_password)){
			a.setMsg("原密码不能与新密码相同");
		}else{
			Map<String, Object> params = new HashMap<>();
			TUserMember tUserMember = (TUserMember) session.getAttribute(Constants.LOGIN_USER_MEMBER);
			params.put("id", tUserMember.getId());
			params.put("old_password", old_password);
			params.put("new_password", new_password);
			try {
				String changepassword = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/changepassword", params );
				try {
					SmartCarReturn<Object> user = new ObjectMapper().readValue(changepassword.getBytes(), new TypeReference<SmartCarReturn<Object>>() {});
					String msg = user.getMsg();
					a.setMsg(msg);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return a;
	}
	
	
	/**
	 * 上传头像
	 */
	@RequestMapping("/toportrait")
	public String toportrait(HttpSession session,
			@RequestParam("file") MultipartFile file){
		String iconpath = null;
		if(file.isEmpty()){
			return "redirect:/member/carcenter.html";
		}else{
			try {
				ServletContext context = session.getServletContext();
				String realPath = context.getRealPath("/portrait");
				String name = UUID.randomUUID().toString().replace("-", "").substring(0, 10) +"_file_"+file.getOriginalFilename();
				try {
					File file2 = new File(realPath);
					if(!file2.exists()){
						file2.mkdir();
					}
					file.transferTo(new File(realPath+"/"+name));
					System.out.println("realPath+/+name----------->"+realPath+"/"+name);
				} catch (Exception e) {
				}
				iconpath="/portrait"+"/"+name;
				TUserMember userMember = (TUserMember) session.getAttribute(Constants.LOGIN_USER_MEMBER);
				Map<String, Object> params = new HashMap<>();
				params.put("iconpath", iconpath);
				params.put("id", userMember.getId());
				String string = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/portrait", params );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/member/carcenter.html";
	}
	
	
	@RequestMapping("/portrait.html")
	public String portrait(){
		return "member/portrait";
	}
	
	@RequestMapping("/changepassword.html")
	public String changepassword(){
		return "member/changepassword";
	}
	
	@RequestMapping("/perfectpage.html")
	public String perfectpage(){
		return "member/perfectpage";
	}
	
	/**
	 * 提现
	 * @param money
	 * @param session
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/todelmoney")
	public SmartCarReturn<TWallet> todelmoney(@Param(value="money")Integer money,HttpSession session,Model model){
		TUserMember tUserMember1 = (TUserMember) session.getAttribute(Constants.LOGIN_USER_MEMBER);
		SmartCarReturn<TWallet> wallet = null;
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("id", tUserMember1.getId());
		params1.put("money", money);
		try {
			String string = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/todelmoney", params1);
			try {
				wallet = new ObjectMapper().readValue(string.getBytes(), new TypeReference<SmartCarReturn<TWallet>>() {});
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return wallet;
	}
	
	/**
	 * 充值
	 * @param money
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/toaddmoney")
	public SmartCarReturn<TWallet> toaddmoney(@Param(value="money")Integer money,HttpSession session){
		TUserMember tUserMember1 = (TUserMember) session.getAttribute(Constants.LOGIN_USER_MEMBER);
		SmartCarReturn<TWallet> wallet = null;
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("id", tUserMember1.getId());
		params1.put("money", money);
		try {
			String httpPostRequest = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/addmoney", params1);
			try {
				wallet = new ObjectMapper().readValue(httpPostRequest.getBytes(), new TypeReference<SmartCarReturn<TWallet>>() {});
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return wallet;
	}
	
	
	/**
	 * 获取个人页面返回数据
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/carcenter.html")
	public String carcenter(HttpSession session,Model model){
		TUserMember tUserMember = new TUserMember();
		tUserMember.setId(1);
		session.setAttribute(Constants.LOGIN_USER_MEMBER, tUserMember);//假设用户登录了
		TUserMember tUserMember1 = (TUserMember) session.getAttribute(Constants.LOGIN_USER_MEMBER);
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("id", tUserMember1.getId());
		try {
			String basic = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/basic", params1);
			try {
				SmartCarReturn<TUserMember> user = new ObjectMapper().readValue(basic.getBytes(), new TypeReference<SmartCarReturn<TUserMember>>() {});
				model.addAttribute("user", user.getContent());
			} catch (Exception e) {
				e.printStackTrace();
			}
			String stringwallet = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/wallet", params1);
			try {
				SmartCarReturn<TWallet> wallet = new ObjectMapper().readValue(stringwallet.getBytes(), new TypeReference<SmartCarReturn<TWallet>>() {});
				model.addAttribute("wallet", wallet.getContent());
			} catch (Exception e) {
				e.printStackTrace();
			}
			String carcard = HttpClientUtil.httpPostRequest(rasi.getRestApiURL()+"/carcenter/carcard", params1);
			try {
				SmartCarReturn<List<TOrder>> cards = new ObjectMapper().readValue(carcard.getBytes(), new TypeReference<SmartCarReturn<List<TOrder>>>() {});
				model.addAttribute("cards", cards.getContent());
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "member/carcenter";
	}
	
}
