package com.smartparking.car.portal.controller;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartparking.car.manager.bean.TCarport;
import com.smartparking.car.portal.bean.CarReturn;
import com.smartparking.car.portal.bean.SmartCarReturn;
import com.smartparking.project.HttpClientUtil;


/**
 * 停车场控制器
 * @author mxs
 * 2017年8月14日
 * @version 1.0.0
 */
@RequestMapping("/carport")
@Controller
public class CarportController {
    @Value("${restapi.server.ip}")
    private String restapiserver;
    @Value("${restapi.server.port}")
    private String restapiport;
    @Value("${restapi.server.apppath}")
    private String appPath;
    
    
    @Autowired
    RestApiServerInfo serverInfo;
    
    private String getRestApiURL() {
        return "http://" + restapiserver + ":" + restapiport + "/" + appPath;
    }
    
    @RequestMapping("/list")
    public String carportList(Model model) throws JsonParseException, JsonMappingException, IOException{
        System.out.println("carportList_portal");
//        String response = HttpClientUtil.httpPostRequest("http://127.0.0.1:8081/car-restapi/carport/list");
//        
//        CarReturn<List<TCarport>> result = new ObjectMapper().readValue(response.getBytes(), new TypeReference<CarReturn<List<TCarport>>>() {
//        });
        
        String restUrl = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL() + "/map/getDisplayData");
        //System.out.println("PORTAL--------restUrl"+restUrl);
        
        List<Map<String, Object>> data = new ObjectMapper().readValue(restUrl.getBytes(),List.class);
        
        //if(result.getCode()==1){
        	
            //List<TCarport> content = result.getContent();
        	//List<TCarport[]> cartportsList = myfunction(result);
            List<Map<String, Object>[]> cartportsList = myfunction(data);
            
            model.addAttribute("cartportsList", cartportsList);
        //}
        return "main";
    }

    /**
     * 抽取的方法
     * @Description
     * @param content
     * @return
     */
    private <T> List<T[]> myfunction(List<T> content) {
        List<T[]> tList = new ArrayList<T[]>(); 
        int size = content.size();
        int lastnum = size%4;
        int num = size/4;
        for (int i = 0; i < num; i++) {
            @SuppressWarnings("unchecked")
            T[] ts = (T[]) new Object[4]; 
            ts[0] = content.get(4*i+0);
            ts[1] = content.get(4*i+1);
            ts[2] = content.get(4*i+2);
            ts[3] = content.get(4*i+3);
            tList.add(ts);
        }
        if(lastnum != 0){
            @SuppressWarnings("unchecked")
            T[] lastts =(T[]) new Object[lastnum];
            for (int i = 0; i < lastnum; i++){
                lastts[i] = content.get(4*num+i);
            }
            tList.add(lastts);
        }
        return tList;
    }
    
    @ResponseBody
    @RequestMapping("/carportByCond")
    public List<TCarport[]> getCarportByCondition(@RequestParam(value="cond",required=false)String cond,
            @RequestParam(value="name",required=false)String name) throws JsonParseException, JsonMappingException, IOException{
        System.out.println("carportByCond.....");
        System.out.println(cond);
        
        Map<String, Object> params = new HashMap<>();
        params.put("cond", cond);
        params.put("name", name);
        String response = HttpClientUtil.httpPostRequest("http://127.0.0.1:8081/car-restapi/carport/carportByCond",params);
        
        CarReturn<List<TCarport>> result = new ObjectMapper().readValue(response.getBytes(), new TypeReference<CarReturn<List<TCarport>>>() {
        });
        
         List<TCarport> content = result.getContent();
            
            
            List<TCarport[]> list = myfunction(content);
            
            return list;
    }
    
    @RequestMapping("/toCarportPage")
	public String toCarportPage(){
		
		return "redirect:/carport/toCarport";
	}
	
	/**
	 * 网页端入口（portal）文件上传
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/uploadCarportPhone")
	public Object uploadFile(HttpSession session, @RequestParam("file")CommonsMultipartFile file,
			@RequestParam("carportId")Integer carportId) throws Exception{
		System.out.println("进入方法了");
		//获取文件夹在服务器中的真实位置
		String realPath = session.getServletContext().getRealPath("/deposit");
		System.out.println(realPath);
		//为文件命名
		String fileNmae = UUID.randomUUID().toString().replace("-", "").subSequence(0, 5) +"-file-"+file.getOriginalFilename();
		//上传文件到这个位置
		file.transferTo(new File(realPath+"/"+fileNmae));
		//文件上传后的网络路径
		String netUrl = "deposit/"+ fileNmae;
		//构建请求参数
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("carportId", carportId);
		param.put("netUrl", netUrl);
		//发送请求
		String string = HttpClientUtil.httpPostRequest(serverInfo.getRestApiURL()+"/carport/apiUploadCarportPhone", param);
		//逆向响应内容
		SmartCarReturn<TCarport> carport = new ObjectMapper().readValue(string.getBytes(), new TypeReference<SmartCarReturn<TCarport>>() {
		});
		
		return carport;
	}
	
	/**
	 * 转到我的车库修改页面
	 * @param carportId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateCarport")
	public String updateCarport(@RequestParam("carportId")Integer carportId, Model model) throws Exception{
		//构建请求地址
		String url = serverInfo.getRestApiURL()+"/carport/getCarport";
		//构建请求参数
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("carportId", carportId);
		//返回数据
		String string = HttpClientUtil.httpPostRequest(url, param);
		//逆向返回数据
		SmartCarReturn<TCarport> carport = new ObjectMapper().readValue(string.getBytes(), 
				new TypeReference<SmartCarReturn<TCarport>>() {
		});
		
		TCarport content = carport.getContent();
		
		System.out.println("修改车库信息————>"+content);
		
		model.addAttribute("carport", content);

		
		return "edit";
	}
	
	/**
	 * 查询车库所有信息去我的车库页面
	 * @param carportId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toCarport")
	public String toCarport(@RequestParam("carportId")Integer carportId, Model model) throws Exception {
		//构建请求地址
		String url = serverInfo.getRestApiURL()+"/carport/getCarport";
		//构建请求参数
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("carportId", carportId);
		//返回数据
		String string = HttpClientUtil.httpPostRequest(url, param);
		//逆向返回数据
		SmartCarReturn<TCarport> carport = new ObjectMapper().readValue(string.getBytes(), 
				new TypeReference<SmartCarReturn<TCarport>>() {
		});
		
		TCarport content = carport.getContent();
		
		System.out.println("我的车库页面——>"+content);
		
		model.addAttribute("carport", content);
		//去我的车库信息页面
		return "carport";
	}
}
