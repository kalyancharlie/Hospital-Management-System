package com.tcs.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;
import com.tcs.util.DbConnection;

public class PatientDaoImpl extends PatientDao{

	@Override
	public String validateLogin(String username, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String role = null;
		try {
			con = DbConnection.getConnection();
			ps = con.prepareStatement("SELECT role from userstore where username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
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
	public boolean patientRegistration(Patient patient) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DbConnection.getConnection();
			ps = con.prepareStatement("insert into patient(ssn_id,name,age,doj,bed,address,city,state,status) values(?,?,?,?,?,?,?,?,?)");
			ps.setLong(1, patient.getSsnId());
			ps.setString(2, patient.getName());
			ps.setInt(3, patient.getAge());
			ps.setDate(4, patient.getDoj());
			ps.setString(5, patient.getTypeOfBed());
			ps.setString(6, patient.getAddress());
			ps.setString(7, patient.getCity());
			ps.setString(8, patient.getState());
			ps.setString(9, "active");
			int i=ps.executeUpdate();
			if(i==1) {
				return true;
			} else {
				return false;
			}
		} catch(SQLException e) {
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return false;
		}
	}

	@Override
	public boolean updatePatient(Patient patient) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deletePatient(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Patient searchPatient(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Patient[] viewAllPatients() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Medicine[] viewMedcines(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Diagnostic[] viewDiagnostics(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public double generateBill(int id) {
		// TODO Auto-generated method stub
		return 0;
	}
}
