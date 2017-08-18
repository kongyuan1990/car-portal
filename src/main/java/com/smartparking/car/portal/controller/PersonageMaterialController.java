package com.smartparking.car.portal.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TUserPortowner;
import com.smartparking.car.manager.bean.TWallet;
import com.smartparking.car.manager.constant.Constants;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;


@Controller
@RequestMapping("/personage")
public class PersonageMaterialController {
	
	@Autowired
	RestApiServerInfo info;
	
	private final String PERSIONAGE = "persionage";
	
	@RequestMapping("/toPersonage.html")
	public String toPersonage(){
		
		return "redirect:/personage/toPersonagePage";
	}
	
	/**
	 * 网页端入口（protal）我的头像文件上传
	 * @param session
	 * @param file
	 * @param uId
	 * @throws Exception
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/uploadFile")
	public Object uploadFile(HttpSession session, @RequestParam("file")CommonsMultipartFile file,
			@RequestParam("id")Integer uId) throws Exception, Exception{
//		System.out.println("来到方法了");
		//获取文件夹的真实路径
		String realPath = session.getServletContext().getRealPath("deposit");
		System.out.println(realPath);
		//为文件命名
		String fileName = UUID.randomUUID().toString().replace("-", "").subSequence(0, 10)+"-file-"+file.getOriginalFilename();
		//上传文件到此位置
		file.transferTo(new File(realPath+"/"+fileName));
		//上传后的网络路径
		String netUrl = "deposit/"+fileName;
		//构建请求参数
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uId", uId);
		param.put("netUrl", netUrl);
		//发送请求
		String string = HttpClientUtil.httpPostRequest(info.getRestApiURL()+"/persionage/apiUploadFile", param);
		
		SmartCarReturn<TUserPortowner> user = new ObjectMapper().readValue(string.getBytes(), new TypeReference<SmartCarReturn<TUserPortowner>>() {
		});
		
		System.out.println(user.getContent());
		
		return user;
	}
	
    
    /**
     * 
     * @Description (转到个人资料页面并展示信息)
     * @return
     * @throws Exception 
     */
    @RequestMapping("/toPersonagePage")
    public String toPersonagePage(HttpSession session, Model model) throws Exception {
        
    	//实际登录后使用此方法
    	//TUserPortowner userPortowner2 = (TUserPortowner)session.getAttribute(Constants.LOGIN_USER);
    	//获取到登录用户的ID
    	//Integer id = userPortowner2.getId();
    	//userPortowner.setId(id);
    	TUserPortowner userPortowner = (TUserPortowner) session.getAttribute(Constants.LOGIN_USER_PORTOWNER);
    	//假设已登录
    	//把登录ID放到session域中,为了测试写死id
    	//userPortowner.setId(1);
    	//session.setAttribute(PERSIONAGE, userPortowner);
    	//构建URL
    	//String url = info.getRestApiURL()+"/persionage/getPersionage";
    	//构建请求参数
    	//Map<String,Object > param = new HashMap<String,Object>();
    	//param.put("id", userPortowner.getId());
    	//响应的内容
    	//String string = HttpClientUtil.httpPostRequest(url, param);
    	//逆向响应内容
    	//SmartCarReturn<TUserPortowner> user = new ObjectMapper().readValue(string.getBytes(), 
    	//    	new TypeReference<SmartCarReturn<TUserPortowner>>() {
    	//});
    	 //TUserPortowner content = user.getContent();
    	// System.out.println("123"+content);
    	 model.addAttribute("user", userPortowner);
    	 
    	 //获取钱包信息
    	 userPortowner.setWalletId(1);
    	 Map<String, Object> params = new HashMap<String,Object>();
    	 params.put("walletId", userPortowner.getWalletId());
    	 String wallet = HttpClientUtil.httpPostRequest(info.getRestApiURL()+"/wallet/getWallet",params);
    	 SmartCarReturn<TWallet> wallets = new ObjectMapper().readValue(wallet.getBytes(), 
    			 new TypeReference<SmartCarReturn<TWallet>>() {
		});
    	 TWallet tWallet = wallets.getContent();
    	 System.out.println("钱包信息"+tWallet);
    	 model.addAttribute("wallet", tWallet);
        return "personage_material";
    }
    
    /**
     * 我的钱包提现功能实现
     * @param value
     * @param wId
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/lessenMoney")
    public void updateBalance(@RequestParam("value")Double value,@RequestParam("wId")Integer wId) throws Exception{
    	Map<String,Object > param2 = new HashMap<String,Object>();
    	param2.put("value", value);
    	param2.put("wId", wId);
    	HttpClientUtil.httpPostRequest(info.getRestApiURL()+"/wallet/lessenMoney", param2);
    	//return "redirect:/personage/toPersonagePage";
    }

}
