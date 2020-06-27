package com.tcs.service;

import com.tcs.dao.PatientDaoImpl;

public class Service {
	PatientDaoImpl obj = new PatientDaoImpl();
	
	public boolean validate(String username, String password) {
		return obj.validateLogin(username, password);
	}
}