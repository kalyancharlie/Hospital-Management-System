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

	/* Method to Validate User Credentials */
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
	
	/* Method to Get number of patients registered from Database*/ 
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

	/* Method to register a patient in the Database */
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

	/* Method to update patient details in the Database using patient Id*/
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
			System.err.println(new java.util.Date()+" || "+"Patient with Id: "+patient.getId()+" Details Failed to Update");
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return false;
		}
		return false;
	}

	/* Method to delete a patient record from Database using patient Id */
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
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Delete Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return flag;
	}

	/* Method to get Patient's details
	 * Using Patient Id
	 * From Database
	 */	
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
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		System.out.println(new java.util.Date()+" || "+"Failed to Retrieve Patient with Id: "+id);
		return null;
	}

	/* Method to get all patients record, Those who are still active
	 * Using patient Id
	 * From Database
	 */
	@Override
	public List<Patient> viewAllPatients(long start, long end) {
		List<Patient> patients = new ArrayList<Patient>();
		try {
			ps = con.prepareStatement("SELECT * FROM patient where status='active' limit ?,?");
			ps.setLong(1, start-1);
			ps.setLong(2, end-start+1);
			rs = ps.executeQuery();
			while(rs.next()) {
				Patient patient = new Patient();
				if(rs.getString(10).equalsIgnoreCase("ACTIVE")) {
					patient.setId(rs.getLong(2));
					patient.setName(rs.getString(3));
					patient.setAge(rs.getInt(4));
					patient.setDoj(rs.getDate(5));
					patient.setTypeOfBed(rs.getString(6));
					patient.setAddress(rs.getString(7));
					patient.setCity(rs.getString(8));
					patient.setState(rs.getString(9));
					patient.setStatus(rs.getString(10));
					patients.add(patient);
				}
			}
			if(patients != null && patients.size() > 0) {
				System.out.println(new java.util.Date()+" || "+"Got All Patient Details");
				return patients;
			} 
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve All Patient Details");
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	}

	/* Method to get previously purchased medicines by Patient
	 * Using Patient Id
	 * from Database 
	 */
	@Override
	public List<Medicine> viewPatientMedcines(long id) {
		List<Medicine> medicines = new ArrayList<Medicine>();
		long mid = 0;
		int qty =0;
		try {
			ps = con.prepareStatement("SELECT mid, qty FROM patient_medicine WHERE pid = ?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				mid = rs.getLong(1);
				qty = rs.getInt(2);
				PreparedStatement ps2 = con.prepareStatement("SELECT * FROM medicine WHERE mid=?");
				ps2.setLong(1, mid);
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()) {
					Medicine medicine = new Medicine();
					medicine.setMid(rs2.getLong(1));
					medicine.setName(rs2.getString(2));
					medicine.setQty(qty);
					medicine.setRate(rs2.getLong(4));
					medicine.setAmount();
					medicines.add(medicine);
				}
			}
			if(medicines != null & medicines.size() > 0) {
				System.out.println(new java.util.Date()+" || "+"Got All Medicines Details with Patient Id: "+id);
				return medicines;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve Medicines for Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	}

	/* Method to get Medicine details using Medicine Id from Database */
	@Override
	public Medicine viewMedicineById(long mid, int qty) {
		Medicine medicine = new Medicine();
		try {
			ps = con.prepareStatement("SELECT * FROM medicine WHERE mid=?");
			ps.setLong(1, mid);
			rs = ps.executeQuery();
			while(rs.next()) {
				medicine.setMid(mid);
				medicine.setName(rs.getString(2));
				medicine.setQty(qty);
				medicine.setRate(rs.getLong(4));
				medicine.setAmount();
			}
			if(medicine != null) {
				System.out.println(new java.util.Date()+" || "+"Got Medicine with Id: "+mid);
				return medicine;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve Medicine with Id: "+mid);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	}

	/* Method to get all medicines from database */
	@Override
	public List<Medicine> viewMedicines() {
		List<Medicine> medicines = new ArrayList<Medicine>();
		try {
			ps = con.prepareStatement("SELECT * FROM medicine");
			rs = ps.executeQuery();
			while(rs.next()) {
				Medicine medicine = new Medicine();
				medicine.setMid(rs.getLong(1));
				medicine.setName(rs.getString(2));
				medicine.setQty(rs.getInt(3));
				medicine.setRate(rs.getLong(4));
				medicines.add(medicine);
			}
			if(medicines != null && medicines.size() > 0) {
				System.out.println(new java.util.Date()+" || "+"Got All Master Medicines Details");
				return medicines;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve All Master Medicines Details");
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	} 

	/* Method to get all diagnostics from database */
	@Override
	public List<Diagnostic> viewDiagnostics() {
		List<Diagnostic> diagnostics = new ArrayList<Diagnostic>();
		try {
			ps = con.prepareStatement("SELECT * FROM diagnostic");
			rs = ps.executeQuery();
			while(rs.next()) {
				Diagnostic diagnostic = new Diagnostic();
				diagnostic.setId(rs.getLong(1));
				diagnostic.setName(rs.getString(2));
				diagnostic.setAmount(rs.getDouble(3));
				diagnostics.add(diagnostic);
			}
			if(diagnostics != null && diagnostics.size() > 0) {
				System.out.println(new java.util.Date()+" || "+"Got All Master Diagnostics Details");
				return diagnostics;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve All Master Diagnostics Details");
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	}

	/*
	 * Method to get previous diagnostic check up's done to the patient
	 */	@Override
	public List<Diagnostic> viewPatientDiagnostics(long id) {
		long did = 0;
		List<Diagnostic> diagnostics = new ArrayList<Diagnostic>();
		try {
			ps = con.prepareStatement("SELECT did FROM patient_diagnostic WHERE pid=?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				did = rs.getLong(1);
				PreparedStatement ps2 = con.prepareStatement("SELECT * FROM diagnostic WHERE did=?");
				ps2.setLong(1, did);
				ResultSet rs2 = ps2.executeQuery();
					while(rs2.next()) {
						Diagnostic diagnostic = new Diagnostic();
						diagnostic.setId(rs2.getLong(1));
						diagnostic.setName(rs2.getString(2));
						diagnostic.setAmount(rs2.getDouble(3));
						diagnostics.add(diagnostic);
					}
			}
			if(diagnostics != null & diagnostics.size() > 0) {
				System.out.println(new java.util.Date()+" || "+"Got All Diagnostics Details with Patient Id: "+id);
				return diagnostics;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve Diagnostics Details for Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	}

	/* Method to issue medicine to the patient */
	@Override
	public boolean addPatientMedicines(long id, ArrayList<Medicine> medicines) {
		int count = 0;
		int flag = 0;
		try {
			for(int i=0; i<medicines.size(); i++) {
				ps = con.prepareStatement("INSERT INTO patient_medicine VALUES(?, ?, ?)");
				ps.setLong(1, id);
				ps.setLong(2, medicines.get(i).getMid());
				ps.setLong(3, medicines.get(i).getQty());
				flag = ps.executeUpdate();
				if(flag == 1)
				count++;
			}
			if(count > 0) {
				System.out.println(new java.util.Date()+" || "+"Added "+medicines.size()+"/"+count+" Medicines to Patient with Id: "+id);
				return true;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Add Medicines to Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return false;
		}
		return false;
	}

	/* Method to get Diagnostic test details by using diagnostic id from database */
	@Override
	public Diagnostic viewDiagnosticById(long did) {
		Diagnostic diagnostic = new Diagnostic();
		try {
			ps = con.prepareStatement("SELECT * FROM diagnostic WHERE did=?");
			ps.setLong(1, did);
			rs = ps.executeQuery();
			while(rs.next()) {
				diagnostic.setId(rs.getLong(1));
				diagnostic.setName(rs.getString(2));
				diagnostic.setAmount(rs.getLong(3));
			}
			if(diagnostic != null) {
				System.out.println(new java.util.Date()+" || "+"Got Diagnostic with Id: "+did);
				return diagnostic;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve Diagnostic with Id: "+did);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return null;
	}

	/* Method to add diagnostics to patient in the database */
	@Override
	public boolean addPatientDiagnostics(long id, ArrayList<Diagnostic> diagnostics) {
		int count = 0;
		int flag = 0;
		try {
			for(int i=0; i<diagnostics.size(); i++) {
				ps = con.prepareStatement("INSERT INTO patient_diagnostic VALUES(?, ?)");
				ps.setLong(1, id);
				ps.setLong(2, diagnostics.get(i).getId());
				flag = ps.executeUpdate();
				if(flag == 1)
				count++;
			}
			if(count > 0) {
				System.out.println(new java.util.Date()+" || "+"Added "+diagnostics.size()+"/"+count+" Diagnostics to Patient with Id: "+id);
				return true;
			}
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Add Diagnostics to Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return false;
		}
		return false;
	}

	/* Method to generate bill for medicine, diagnostic and Room */
	@Override
	public double[] generateBill(long id) {
		double diagnostic_amount = 0;
		double medicine_amount = 0;
		Date doj = null;
		String bed = null;
		double rate = 0;
		long days = 1;
		double[] bill = new double[] {0, 0, 0, 0, 0};
		List<Diagnostic> diag = null;
		List<Medicine> medicine = null;
		try {
			ps = con.prepareStatement("SELECT doj, bed FROM patient WHERE id=?");
			ps.setLong(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				doj = rs.getDate(1);
				bed = rs.getString(2);
				days = Utility.numberOfDays(doj);
				bill[0] = (double)days;
				if(bed.equalsIgnoreCase(BED1))
					rate = 2000;
				else if(bed.equalsIgnoreCase(BED2))
					rate = 4000;
				else if(bed.equalsIgnoreCase(BED3))
					rate = 8000;
				if(days == 0) {
					days = 1;
				}
				bill[1] = rate*days;
				medicine = viewPatientMedcines(id);
				if(medicine != null && medicine.size() > 0)
				for(int i=0;i<medicine.size();i++) {
					medicine_amount += medicine.get(i).getAmount();
				}
				bill[2] = medicine_amount;
				diag = viewPatientDiagnostics(id);
				if(diag != null && diag.size() > 0)
				for(int i=0;i<diag.size();i++) {
					diagnostic_amount+= diag.get(i).getAmount();
				}
				bill[3] = diagnostic_amount;
				bill[4] = bill[1]+bill[2]+bill[3];
			}
			System.out.println("Generated Bill for Patient with Id: "+id);
		} catch(SQLException e) {
			System.err.println("Failed to Generate Bill for Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return bill;
	}

	/* Method to discharge a patient from hospital in the database */
	@Override
	public boolean dischargePatient(long id) {
		int i = 0;
		try {
			ps = con.prepareStatement("UPDATE patient SET status=? where id=?");
			ps.setString(1, "DISCHARGED");
			ps.setLong(2, id);
			i = ps.executeUpdate();
			if(i > 0) {
				System.out.println("Patient with Id: "+id+" Discharged From Hospital");
				return true;
			}
		} catch(SQLException e) {
			System.err.println("Failed to Discharge Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return false;
	}

	/*
	 * Method to update hospital's Medicine data after issuing medicine to patient
	 */	@Override
	public boolean updateMasterMedicines(ArrayList<Medicine> newMedicines) {
		int count = 0;
		try {
			for(int i=0; i<newMedicines.size(); i++) {
				ps = con.prepareStatement("UPDATE medicine SET qty=qty-? where mid=?");
				ps.setInt(1, newMedicines.get(i).getQty());
				ps.setLong(2, newMedicines.get(i).getMid());
				i = ps.executeUpdate();
				if(i > 0) {
					count++;
				}
			}
			if(count > 0) {
				System.out.println("Master Medicines Record Updated "+newMedicines.size()+"/"+count);
				return true;
			}
		} catch(SQLException e) {
			System.err.println("Failed to Update Master Medicines Record Updated "+newMedicines.size()+"/"+count);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
			return false;
		}
		return false;
	}

	/* Method to get maximum id from the patient data table in the database */
	@Override
	public long viewMaxId() {
		long id = 0;
		try {
			ps = con.prepareStatement("SELECT MAX(id) FROM patient");
			rs = ps.executeQuery();
			while(rs.next()) {
				id = rs.getLong(1);
			}
			return id;
		} catch(SQLException e) {
			System.err.println("Failed to Fetch Max Id from Patient");
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		return 0;
	}

	/* Method to get active patient details from the database */
	@Override
	public Patient viewActivePatient(long id) {
		Patient patient = new Patient();
		try {
			ps = con.prepareStatement("SELECT * FROM patient WHERE id = ? AND status='active'");
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
		} catch(SQLException e) {
			System.err.println(new java.util.Date()+" || "+"Failed to Retrieve Patient with Id: "+id);
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		}
		System.out.println(new java.util.Date()+" || "+"Failed to Retrieve Patient with Id: "+id);
		return null;
	}
}
