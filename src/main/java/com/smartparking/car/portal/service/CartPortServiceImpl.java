package com.smartparking.car.portal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smartparking.car.manager.bean.TCarport;
import com.smartparking.car.manager.dao.TCarportMapper;
import com.smartparking.car.portal.servicd.impl.CartPortServied;

@Service
public class CartPortServiceImpl implements CartPortServied{

	@Autowired
	TCarportMapper carportMapper;
	
	@Override
	public TCarport getCarPort(int id) {
		TCarport carport = carportMapper.selectByPrimaryKey(id);
		return carport;
	}

}
