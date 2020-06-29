package com.tcs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;
import com.tcs.model.User;
import com.tcs.util.DbConnection;

public class PatientDaoImpl implements PatientDao{

	@Override
	public String validateLogin(User user) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String role = null;
		try {
			con = DbConnection.getConnection();
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
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DbConnection.getConnection();
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
		Connection con = null;
		PreparedStatement ps = null;
		boolean flag = false;
		try {
			con = DbConnection.getConnection();
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
				System.out.println("Patient Registered Successfully with Id: "+patient.getId());
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
		return false;
	}

	@Override
	public boolean deletePatient(long id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = DbConnection.getConnection();
			ps = con.prepareStatement("delete from patient where id=?");
			ps.setLong(1, id);
			if(ps.executeUpdate()==1) {
				System.out.println("Deleted Patient with Id: "+id);
				flag=true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Patient searchPatient(long id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Patient pt = new Patient();
		try {
			con = DbConnection.getConnection();
			ps = con.prepareStatement("select * from patient where id=?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				pt.setId(rs.getLong(2));
				pt.setName(rs.getString(3));
				pt.setAge(rs.getInt(4));
				pt.setDoj(rs.getDate(5));
				pt.setTypeOfBed(rs.getString(6));
				pt.setAddress(rs.getString(7));
				pt.setCity(rs.getString(8));
				pt.setState(rs.getString(9));	
			}
			System.out.println("Got Detail with Patient Id: "+id);
			return pt;
		}catch(SQLException e) {
				System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
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
	public Diagnostic[] viewDiagnostics(long id) {
		return null;
	}

	@Override
	public double generateBill(long id) {
		return 0;
	}
}
