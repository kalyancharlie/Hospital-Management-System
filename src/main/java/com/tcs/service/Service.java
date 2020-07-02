package com.tcs.service;

import java.util.ArrayList;
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
	
	public List<Diagnostic> getPatientDiagnostics(long id){
		return obj.viewPatientDiagnostics(id);
	}
	
	public Diagnostic getDiagnosticById(long did) {
		return obj.viewDiagnosticById(did);
	}
	
	public List<Diagnostic> getDiagnostics(){
		return obj.viewDiagnostics();
	}
	
	public boolean addDiagnostics(long id, ArrayList<Diagnostic> diagnostics) {
		return obj.addPatientDiagnostics(id, diagnostics);
	}
	
	public double[] getBill(long id) {
		return obj.generateBill(id);
	}
	
	public List<Medicine> getMedicines(){
		return obj.viewMedicines();
	}
	
	public List<Medicine> getPatientMedicines(long id){
		return obj.viewPatientMedcines(id);
	}
	
	public Medicine getMedicineById(long mid, int qty) {
		return obj.viewMedicineById(mid, qty);
	}
	
	public boolean addMedicines(long id, ArrayList<Medicine> medicines) {
		return obj.addPatientMedicines(id, medicines);
	}
	
	public boolean updateMedicines(ArrayList<Medicine> newMedicine) {
		return obj.updateMasterMedicines(newMedicine);
	}
	
	public List<Patient> getAllPatients(long start, long end) {
		return obj.viewAllPatients(start, end);
	}
	
	public boolean discharge(long id) {
		return obj.dischargePatient(id);
	}

	public long getPatientCount() {
		return obj.patientCount();
	}

}