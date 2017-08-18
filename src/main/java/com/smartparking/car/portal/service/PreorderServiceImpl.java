package com.smartparking.car.portal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smartparking.car.manager.bean.TPreorder;
import com.smartparking.car.manager.dao.TPreorderMapper;
import com.smartparking.car.portal.servicd.impl.PreorderService;

@Service
public class PreorderServiceImpl implements PreorderService{

	@Autowired
	TPreorderMapper preorderMapper;


	@Override
	public TPreorder getReserveTime(int id) {
		TPreorder preorder = preorderMapper.selectByPrimaryKey(id);
		return preorder;
	}}
