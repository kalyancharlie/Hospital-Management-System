package com.tcs.dao;

import java.util.ArrayList;
import java.util.List;

import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;
import com.tcs.model.User;

public interface PatientDao {
	String validateLogin(User user);
	long patientCount();
	long viewMaxId();
	boolean patientRegistration(Patient patient);
	boolean updatePatient(Patient patient);
	boolean deletePatient(long id);
	Patient searchPatient(long id);
	Patient viewActivePatient(long id);
	List<Patient> viewAllPatients(long start, long end);
	List<Medicine> viewPatientMedcines(long id);
	boolean updateMasterMedicines(ArrayList<Medicine> newMedicines);
	Medicine viewMedicineById(long mid, int qty);
	List<Medicine> viewMedicines();
	boolean addPatientMedicines(long id, ArrayList<Medicine> medicines);
	List<Diagnostic> viewPatientDiagnostics(long id);
	Diagnostic viewDiagnosticById(long did);
	boolean addPatientDiagnostics(long id, ArrayList<Diagnostic> diagnostics);
	List<Diagnostic> viewDiagnostics();
	double[] generateBill(long id);
	boolean dischargePatient(long id);
	
}