package com.tcs.dao;

import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;

public interface PatientDao {
	String validateLogin(String username, String password);
	public abstract long patientCount();
	public abstract boolean patientRegistration(Patient patient);
	public abstract boolean updatePatient(Patient patient);
	public abstract boolean deletePatient(long id);
	public abstract Patient searchPatient(long id);
	public abstract Patient[] viewAllPatients();
	public abstract Medicine[] viewMedcines(int id);
	public abstract Diagnostic[] viewDiagnostics(int id);
	public abstract double generateBill(int id);
}