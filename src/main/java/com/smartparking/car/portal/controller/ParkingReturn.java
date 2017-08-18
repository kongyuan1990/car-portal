package com.smartparking.car.portal.controller;

import java.util.Map;


public class ParkingReturn<T> {
    
    private int code;//状态码  1：表示成功   0:表示失败
    private String msg;//要给的提示信息   
    private T content;//响应的内容；
    private Map<String, Object> ext;//额外的数据
    public ParkingReturn() {
        super();
        // TODO Auto-generated constructor stub
    }
    public ParkingReturn(int code, String msg, T content, Map<String, Object> ext) {
        super();
        this.code = code;
        this.msg = msg;
        this.content = content;
        this.ext = ext;
    }
    
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
    @Override
    public String toString() {
        return "ScwReturn [code=" + code + ", msg=" + msg + ", content=" + content + ", ext=" + ext + "]";
    }
  //两个快速的成功失败方法
    public static<T> ParkingReturn<T> success(String msg,T content,Map<String, Object> ext){
        ParkingReturn<T> t = new ParkingReturn<T>();
        t.setCode(1);
        t.setMsg(msg);
        t.setContent(content);
        t.setExt(ext);
        return t;
    }
    
    public static<T> ParkingReturn<T> fail(String msg,T content,Map<String, Object> ext){
        ParkingReturn<T> t = new ParkingReturn<T>();
        t.setCode(0);
        t.setMsg(msg);
        t.setContent(content);
        t.setExt(ext);
        return t;
    }
    
}
