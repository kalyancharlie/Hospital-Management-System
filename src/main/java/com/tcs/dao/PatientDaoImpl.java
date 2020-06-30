package com.tcs.dao;

import java.sql.Connection;
import java.sql.Date;
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
import com.tcs.util.Utility;

public class PatientDaoImpl implements PatientDao{
	private Connection con = DbConnection.getConnection();
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private static final String BED1= "General Ward";
	private static final String BED2= "Semi Sharing";
	private static final String BED3= "Single Room";
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
	public List<Patient> viewAllPatients() {
		return null;
	}

	@Override
	public List<Medicine> viewPatientMedcines(long id) {
		return null;
	}
	
	@Override
	public List<Medicine> viewMedicines(long id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Diagnostic> viewDiagnostics(long id) {
		List<Diagnostic> diagnosticList = new ArrayList<Diagnostic>();
		try {
			ps = con.prepareStatement("select * from diagnostic");
			rs = ps.executeQuery();
			while(rs.next()) {
				Diagnostic diagnostic = new Diagnostic();
				diagnostic.setId(rs.getLong(1));
				diagnostic.setName(rs.getString(2));
				diagnostic.setAmount(rs.getDouble(3));
				diagnosticList.add(diagnostic);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return diagnosticList;
	}

	@Override
	public List<Diagnostic> viewPatientDiagnostics(long id) {
		long did;
		List<Diagnostic> diagnosticList = new ArrayList<Diagnostic>();
		try {
			ps = con.prepareStatement("SELECT did FROM patient_diagnostic WHERE pid=?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
			did = rs.getLong(1);
			PreparedStatement ps1 = con.prepareStatement("SELECT * FROM diagnostic WHERE did=?");
			ps1.setLong(1, did);
			ResultSet rs1 = ps.executeQuery();
			while(rs1.next()) {
				Diagnostic diagnostic = new Diagnostic();
				diagnostic.setId(rs1.getLong(1));
				diagnostic.setName(rs1.getString(2));
				diagnostic.setAmount(rs1.getDouble(3));
				diagnosticList.add(diagnostic);
			}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return diagnosticList;
	}

	@Override
	public Double[] generateBill(long id) {
		double diagnostic_ammount = 0;
		double medicine_ammount = 0;
		Date doj=null;
		String bed=null;
		double rate=0;
		int days;
		Double[] bill = new Double[5];
		List<Diagnostic> diag;
		List<Medicine> medicine;
		try {
			ps = con.prepareStatement("select doj, bed from patient where id=?");
			rs = ps.executeQuery();
			while(rs.next()) {
				doj = rs.getDate(1);
				bed = rs.getString(2);
			}
			days = Utility.numberOfDays(doj);
			bill[0] = (double) days;
			if(bed==BED1)
				rate = 2000;
			else if(bed==BED2)
				rate = 4000;
			else if(bed==BED3)
				rate = 8000;
			bill[1] = rate*days;
			diag = viewPatientDiagnostics(id);
			for(int i=0;i<diag.size();i++) {
				diagnostic_ammount+= diag.get(i).getAmount();
			}
			bill[2] = diagnostic_ammount;
			medicine = viewPatientMedcines(id);
			for(int i=0;i<medicine.size();i++) {
				medicine_ammount+= (medicine.get(i).getAmount()*medicine.get(i).getAmount());
			}
			bill[3] = medicine_ammount;
			bill[4] = bill[1]+bill[2]+bill[3];
		}catch(Exception e) {
			e.printStackTrace();
		}
		return bill;
	}
}
