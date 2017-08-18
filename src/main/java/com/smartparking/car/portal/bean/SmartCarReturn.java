package com.smartparking.car.portal.bean;

import java.util.Map;


public class SmartCarReturn<T> {
    
    private int code;//状态码  1：表示成功   0:表示失败
    private String msg;//要给的提示信息 
    private T content; //响应的内容
    private Map<String, Object> ext;//额外的数据
    
    public int getCode() {
        return code;
    }
    
    public void setCode(int code) {
        this.code = code;
    }
    
    public String getMsg() {
        return msg;
    }
    
    public void setMsg(String msg) {
        this.msg = msg;
    }
    
    public T getContent() {
        return content;
    }
    
    public void setContent(T content) {
        this.content = content;
    }
    
    public Map<String, Object> getExt() {
        return ext;
    }
    
    public void setExt(Map<String, Object> ext) {
        this.ext = ext;
    }
    
    public static<T> SmartCarReturn<T> success(String msg, T content, Map<String, Object> ext){
        SmartCarReturn<T> scr = new SmartCarReturn<T>();
        scr.setCode(1);
        scr.setMsg(msg);
        scr.setContent(content);
        scr.setExt(ext);
        
        return scr;
    }
    
    public static<T> SmartCarReturn<T> fail(String msg, T content, Map<String, Object> ext){
        SmartCarReturn<T> scr = new SmartCarReturn<T>();
        scr.setCode(1);
        scr.setMsg(msg);
        scr.setContent(content);
        scr.setExt(ext);
        
        return scr;
    }

    @Override
    public String toString() {
        return "SmartCarReturn [code=" + code + ", msg=" + msg + ", content=" + content + ", ext=" + ext + "]";
    }
    

}
