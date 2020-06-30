package com.tcs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;
import com.tcs.model.User;
import com.tcs.util.DbConnection;

public class PatientDaoImpl implements PatientDao{
	private Connection con = DbConnection.getConnection();
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	@Override
	public String validateLogin(User user) {
		String role = null;
		try {
			ps = con.prepareStatement("SELECT role FROM userstore WHERE username = ? AND password = ?");
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			rs = ps.executeQuery();
			while(rs.next()) {
				role = rs.getString("role");
			}
			return role;
		} catch(SQLException e) {
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return role;
		}
	}
	
	@Override
	public long patientCount() {
		long count = 0;
		try {
			ps = con.prepareStatement("SELECT COUNT(*) FROM patient");
			rs = ps.executeQuery();
			while(rs.next()) {
				count = rs.getLong(1);
			}
			return count;
		} catch(SQLException e) {
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return count;
		}
	}

	@Override
	public boolean patientRegistration(Patient patient) {
		boolean flag = false;
		try {
			ps = con.prepareStatement("INSERT INTO PATIENT (ssn_id, id, name, age, doj, bed, address, city, state, status) values (?,?,?,?,?,?,?,?,?,?)");
			ps.setLong(1, patient.getSsnId());
			ps.setLong(2, patient.getId());
			ps.setString(3, patient.getName());
			ps.setInt(4, patient.getAge());
			ps.setDate(5, patient.getDoj());
			ps.setString(6, patient.getTypeOfBed());
			ps.setString(7, patient.getAddress());
			ps.setString(8, patient.getCity());
			ps.setString(9, patient.getState());
			ps.setString(10, "active");
			int i = ps.executeUpdate();
			if(i==1) {
				System.out.println(new java.util.Date()+" || "+"Patient Registered Successfully with Id: "+patient.getId());
				flag = true;
			}
			return flag;
		} catch(SQLException e) {
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return flag;
		}
	}

	@Override
	public boolean updatePatient(Patient patient) {
		int i =0;
		try {
			ps = con.prepareStatement("UPDATE patient SET name=?, age=?, doj=?, bed=?, address=?, city=?, state=? WHERE id=?");
			ps.setString(1,patient.getName());
			ps.setInt(2, patient.getAge());
			ps.setDate(3, patient.getDoj());
			ps.setString(4, patient.getTypeOfBed());
			ps.setString(5, patient.getAddress());
			ps.setString(6, patient.getCity());
			ps.setString(7, patient.getState());
			ps.setLong(8, patient.getId());
			i = ps.executeUpdate();
			if(i>0) {
				System.out.println(new java.util.Date()+" || "+"Patient with Id: "+patient.getId()+" Details Updated Successfully");
				return true;
			}
		} catch(SQLException e) {
			System.out.println(new java.util.Date()+" || "+"Patient with Id: "+patient.getId()+" Details Failed to Update");
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return false;
		}
		return false;
	}

	@Override
	public boolean deletePatient(long id) {
		boolean flag = false;
		try {
			ps = con.prepareStatement("DELETE FROM patient WHERE id=?");
			ps.setLong(1, id);
			if(ps.executeUpdate()==1) {
				System.out.println(new java.util.Date()+" || "+"Deleted Patient with Id: "+id);
				flag=true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Patient searchPatient(long id) {
		Patient patient = new Patient();
		try {
			ps = con.prepareStatement("SELECT * FROM patient WHERE id = ?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				patient.setId(rs.getLong(2));
				patient.setName(rs.getString(3));
				patient.setAge(rs.getInt(4));
				patient.setDoj(rs.getDate(5));
				patient.setTypeOfBed(rs.getString(6));
				patient.setAddress(rs.getString(7));
				patient.setCity(rs.getString(8));
				patient.setState(rs.getString(9));
			}
			if(patient.getId() != 0) {
				System.out.println(new java.util.Date()+" || "+"Got Details of Patient with Id: "+patient.getId());
				return patient;
			}
		}catch(SQLException e) {
				System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		System.out.println(new java.util.Date()+" || "+"No Details Found with Id: "+id);
		return null;
	}

	@Override
	public Patient[] viewAllPatients() {
		return null;
	}

	@Override
	public Medicine[] viewMedcines(long id) {
		return null;
	}

	@Override
	public List<Diagnostic> viewDiagnostics(long id) {
		long did;
		List<Diagnostic> diagnostic_list = new ArrayList<Diagnostic>();
		try {
			ps = con.prepareStatement("select did from patient_medicine where pid=?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
			did = rs.getLong(1);
			PreparedStatement ps1 = con.prepareStatement("select * from medicine where did=?");
			ps1.setLong(1, did);
			ResultSet rs1 = ps.executeQuery();
			Diagnostic diagnostic = new Diagnostic();
			while(rs1.next()) {
				diagnostic.setId(rs1.getLong(1));
				diagnostic.setName(rs1.getString(2));
				diagnostic.setAmount(rs1.getDouble(3));
			}
			diagnostic_list.add(diagnostic);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return diagnostic_list;
	}

	@Override
	public double generateBill(long id) {
		return 0;
	}
}
