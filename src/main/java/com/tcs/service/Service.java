package com.tcs.service;

import com.tcs.dao.PatientDaoImpl;
import com.tcs.model.Patient;
import com.tcs.model.User;

public class Service {
	PatientDaoImpl obj = new PatientDaoImpl();
	
	public String validate(User user) {
		return obj.validateLogin(user);
	}
	
	public boolean register(Patient pt) {
		return obj.patientRegistration(pt);
	}
	
	public Patient get(long id) {
		return obj.searchPatient(id);
	}
	
	public boolean delete(long id) {
		return obj.deletePatient(id);
	}
}