package com.tcs.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

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
		List<Patient> patient_list = new ArrayList<Patient>();
		try {
			ps = con.prepareStatement("select * from patient where status=?");
			ps.setString(1, "active");
			rs = ps.executeQuery();
			while(rs.next()) {
				Patient patient = new Patient();
				patient.setId(rs.getLong(2));
				patient.setName(rs.getString(3));
				patient.setAge(rs.getInt(4));
				patient.setDoj(rs.getDate(5));
				patient.setTypeOfBed(rs.getString(6));
				patient.setAddress(rs.getString(7));
				patient_list.add(patient);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return patient_list;
	}

	@Override
	public List<Medicine> viewPatientMedcines(long id) {
		long mid;
		int qty;
		List<Medicine> medicineList = new ArrayList<Medicine>();
		try {
			ps = con.prepareStatement("SELECT did,qty FROM patient_medicine WHERE pid=?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
			mid = rs.getLong(1);
			qty = rs.getInt(2);
			PreparedStatement ps1 = con.prepareStatement("SELECT * FROM medicine WHERE mid=?");
			ps1.setLong(1, mid);
			ResultSet rs1 = ps.executeQuery();
			while(rs1.next()) {
				Medicine medicine = new Medicine();
				medicine.setMid(rs1.getLong(1));
				medicine.setName(rs1.getString(2));
				medicine.setQty(qty);
				medicine.setRate(rs1.getDouble(4));
				medicineList.add(medicine);
			}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return medicineList;
	}
	
	@Override
	public List<Medicine> viewMedicines() {
		List<Medicine> medicineList = new ArrayList<Medicine>();
		try {
			ps = con.prepareStatement("select * from medicine");
			rs = ps.executeQuery();
			while(rs.next()) {
				Medicine medicine = new Medicine();
				medicine.setMid(rs.getLong(1));
				medicine.setName(rs.getString(2));
				medicine.setRate(rs.getDouble(4));
				medicineList.add(medicine);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public List<Diagnostic> viewDiagnostics() {
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
	public boolean addMedicines(long id, List<Medicine> medicineList) {
		int stock = 0;
		try {
			Iterator<Medicine> itr = medicineList.iterator();
			while(itr.hasNext()) {
				Medicine medicine = itr.next();
				ps = con.prepareStatement("select qty from medicine where mid=?");
				ps.setLong(1, medicine.getMid());
				rs = ps.executeQuery();
				if(rs.next()) {
					stock = rs.getInt(1);
				}
				int newQuan = stock-medicine.getQty();
				if(newQuan>=0) {
					ps = con.prepareStatement("insert into patient_medicine(pid,mid,qty) values(?,?,?)");
					ps.setLong(1, id);
					ps.setLong(2, medicine.getMid());
					ps.setInt(3, medicine.getQty());
					ps.execute();
					ps = con.prepareStatement("update medicine set qty=? where mid=?");
					ps.setInt(1, newQuan);
					ps.setLong(2, medicine.getMid());
				}
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	@Override
	public boolean addDiagnostics(long id, List<Diagnostic> diagnosticList) {
		try {
			Iterator<Diagnostic> itr = diagnosticList.iterator();
			while(itr.hasNext()) {
				Diagnostic diag = (Diagnostic)itr.next();
				ps = con.prepareStatement("insert into patient_diagnostic(pid,did) values(?,?)");
				ps.setLong(1, id);
				ps.setLong(2, diag.getId());
				rs = ps.executeQuery();
			}
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	@Override
	public double[] generateBill(long id) {
		double diagnostic_ammount = 0;
		double medicine_ammount = 0;
		Date doj=null;
		String bed=null;
		double rate=0;
		int days;
		double[] bill = new double[5];
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

