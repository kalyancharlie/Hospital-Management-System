package com.tcs.service;

import java.util.List;

import com.tcs.dao.PatientDaoImpl;
import com.tcs.model.Patient;
import com.tcs.model.User;
import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;

public class Service {
	PatientDaoImpl obj = new PatientDaoImpl();
	
	public String validate(User user) {
		return obj.validateLogin(user);
	}
	
	public boolean register(Patient patient) {
		return obj.patientRegistration(patient);
	}
	
	public boolean update(Patient patient) {
		return obj.updatePatient(patient);
	}
	
	public Patient get(long id) {
		return obj.searchPatient(id);
	}
	
	public boolean delete(long id) {
		return obj.deletePatient(id);
	}
	
	public List<Diagnostic> getPatientDiagnstics(long id){
		return obj.viewPatientDiagnostics(id);
	}
	public List<Diagnostic> getDiagnstics(long id){
		return obj.viewDiagnostics(id);
	}
	public double[] getBill(long id) {
		return obj.generateBill(id);
	}
	public List<Medicine> getMedicines(long id){
		return obj.viewMedicines(id);
	}
	public List<Medicine> getPatientMedicines(long id){
		return obj.viewPatientMedcines(id);
	}
	public List<Patient> getAllPatients(){
		return obj.viewAllPatients();
	}
}