package com.tcs.service;

import com.tcs.dao.PatientDaoImpl;
import com.tcs.model.Patient;

public class Service {
	PatientDaoImpl obj = new PatientDaoImpl();
	
	public String validate(String username, String password) {
		return obj.validateLogin(username, password);
	}
	public boolean register(Patient pt) {
		return obj.patientRegistration(pt);
	}
	public Patient get(long id) {
		// TODO Auto-generated method stub
		return obj.searchPatient(id);
	}
	public boolean delete(long id) {
		// TODO Auto-generated method stub
		return obj.deletePatient(id);
	}
}