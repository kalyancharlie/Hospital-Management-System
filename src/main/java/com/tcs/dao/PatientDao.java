package com.tcs.dao;

import java.util.List;

import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;
import com.tcs.model.User;

public interface PatientDao {
	String validateLogin(User user);
	long patientCount();
	boolean patientRegistration(Patient patient);
	boolean updatePatient(Patient patient);
	boolean deletePatient(long id);
	Patient searchPatient(long id);
	abstract Patient[] viewAllPatients();
	Medicine[] viewMedcines(long id);
	List<Diagnostic> viewDiagnostics(long id);
	double generateBill(long id);
}