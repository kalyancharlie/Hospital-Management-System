package com.tcs.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.dao.PatientDaoImpl;
import com.tcs.model.Diagnostic;
import com.tcs.model.Medicine;
import com.tcs.model.Patient;
import com.tcs.model.User;
import com.tcs.service.Service;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Controller() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Service service = new Service();
		String option = request.getParameter("option");
		String operation = request.getParameter("operation");
		if(option == null) {
			option = "";
		} if(operation == null) {
			operation = "";
		}
		
		// LOGIN ROLE CHECK
		if(option.equalsIgnoreCase("LOGIN")) {
			String role = null;
			User user = new User();
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			user.setUsername(username);
			user.setPassword(password);
			role = service.validate(user);
			role = role != null ? role: "";
			
			// ADMISSION DESK EXECUTIVE ROUTE
			if(role.equalsIgnoreCase("A")) {
				System.out.println(new java.util.Date()+" || "+"Admission Executive Loggged In. Role: "+role);
				request.getRequestDispatcher("/jsp/registration.jsp").forward(request, response);
			}
			
			// PHARMACIST ROUTE
			else if(role.equalsIgnoreCase("P")) {
				System.out.println(new java.util.Date()+" || "+"Pharmacist Logged In. Role: "+role);
				request.getRequestDispatcher("/jsp/patientMedicineIssue.jsp");
			} 
			
			// DIAGNOSTIC ROUTE
			else if(role.equalsIgnoreCase("D")) {
				System.out.println(new java.util.Date()+" || "+"Diagnostic Executive Logged In. Role: "+role);
				request.getRequestDispatcher("/jsp/patientDiagnosticIssue.jsp");
			} 
			
			// LOGIN FAILED
			else {
				request.setAttribute("msg", "Error! Login Failed");
				System.out.println(new java.util.Date()+" || "+"Login Failed");
				request.getRequestDispatcher("/jsp/index.jsp").include(request, response);
			}
		}
		
		// PATIENT REGISTRATION
		else if(option.equalsIgnoreCase("REGISTRATION")) {
			Patient patient = new Patient();
			PatientDaoImpl patientDaoImpl = new PatientDaoImpl();
			
			patient.setSsnId(Integer.parseInt(request.getParameter("ssnId")));
			patient.setId(100000000 + patientDaoImpl.patientCount());
			patient.setName(request.getParameter("patientName"));
			patient.setAge(Integer.parseInt(request.getParameter("patientAge")));
			patient.setTypeOfBed(request.getParameter("typeOfBed"));
			patient.setAddress(request.getParameter("address"));
			patient.setDoj(Date.valueOf(request.getParameter("dateOfAdmission")));
			patient.setCity(request.getParameter("city"));
			patient.setState(request.getParameter("state"));
			
			// PATIENT REGISTRATION SUCCESS
			if(service.register(patient)) {
				request.setAttribute("msg", "Patient Registration Success");
				request.getRequestDispatcher("/jsp/registration.jsp").include(request, response);
			}
			
			// PATIENT REGISTRATION FAILED
			else {
				request.setAttribute("msg", "Patient Registration Failed");
				request.getRequestDispatcher("/jsp/registration.jsp").include(request, response);
			}
		}
		
		// GET PATIENT OBJECT
		else if(option.equalsIgnoreCase("GETPATIENT")) {
			long id= Long.parseLong(request.getParameter("id"));
			String page = request.getParameter("page");
			Patient patient = service.get(id);
			
			// GET PATIENT OBJECT FOR UPDATING
			if(page.equalsIgnoreCase("UPDATE")) {
				if(patient != null) {
					request.setAttribute("patient", patient);
					request.getRequestDispatcher("/jsp/update.jsp").include(request, response);
				} else {
					request.setAttribute("msg", "Patient Details Not Found with Id: ".concat(String.valueOf(id)));
					request.getRequestDispatcher("/jsp/update.jsp").include(request, response);
				}
			}
			
			// GET PATIENT OBJECT FOR DELETING
			else if(page.equalsIgnoreCase("DELETE")) {
				if(patient != null) {
					request.setAttribute("patient", patient);
					request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
				} else {
					request.setAttribute("msg", "Patient Details Not Found with Id: ".concat(String.valueOf(id)));
					request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
				}
			}
			
			// GET PATIENT OBJECT FOR VIEWING
			else if(page.equalsIgnoreCase("SEARCH")) {
				if(patient!=null) {
					request.setAttribute("patient", patient);
					request.getRequestDispatcher("/jsp/viewPatient.jsp").include(request, response);
				}
				else {
					request.setAttribute("msg", "Patient Details Not Found with Id: ".concat(String.valueOf(id)));
					request.getRequestDispatcher("/jsp/viewPatient.jsp").include(request, response);
				}
			}
			
//			// GET PATIENT OBJECT FOR MEDICINE ISSUE
//			else if(page.equalsIgnoreCase("PATIENTMEDICINEISSUE")) {
//				if(patient!=null) {
//					request.setAttribute("patient", patient);
//					request.getRequestDispatcher("/jsp/patientMedicineIssue.jsp").include(request, response);
//				}
//				else {
//					request.setAttribute("msg", "Patient Details Not Found with Id: ".concat(String.valueOf(id)));
//					request.getRequestDispatcher("/jsp/patientMedicineIssue.jsp").include(request, response);
//				}
//			}
//			
//			// GET PATIENT OBJECT FOR DIAGNOSTIC ISSUE
//			else if(page.equalsIgnoreCase("PATIENTDIAGNOSTICISSUE")) {
//				if(patient!=null) {
//					request.setAttribute("patient", patient);
//					request.getRequestDispatcher("/jsp/patientDiagnosticIssue.jsp").include(request, response);
//				}
//				else {
//					request.setAttribute("msg", "Patient Details Not Found with Id: ".concat(String.valueOf(id)));
//					request.getRequestDispatcher("/jsp/patientDiagnosticIssue.jsp").include(request, response);
//				}
//			}
		}
		
		// UPDATE PATIENT
		else if(operation.equalsIgnoreCase("updatePatient")) {
			Patient patient = new Patient();
			patient.setId(Long.parseLong(request.getParameter("id")));
			patient.setName(request.getParameter("patientName"));
			patient.setAge(Integer.parseInt(request.getParameter("patientAge")));
			patient.setDoj(Date.valueOf(request.getParameter("dateOfAdmission")));
			patient.setTypeOfBed(request.getParameter("typeOfBed"));
			patient.setAddress(request.getParameter("address"));
			patient.setState(request.getParameter("state"));
			patient.setCity(request.getParameter("city"));
			
			// UPDATE PATIENT SUCCESS
			if(service.update(patient)) {
				request.setAttribute("msg", "Patient Details Updated Successfully");
				request.getRequestDispatcher("/jsp/update.jsp").include(request, response);
			} 
			
			// UPDATE PATIENT FAILED
			else {
				request.setAttribute("msg", "Patient Details Update Failed");
				request.getRequestDispatcher("/jsp/update.jsp").include(request, response);
			}
		}
		
		// DELETE PATIENT
		else if(operation.equalsIgnoreCase("DELETEPATIENT")) {
			long id = Long.parseLong(request.getParameter("id"));
			
			// DELETE PATIENT SUCCESSFUL
			if(service.delete(id)) {
				request.setAttribute("msg", "Patient Deleted Successfully");
				request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
			}
			
			// DELETE PATIENT FAILED
			else {
				request.setAttribute("msg", "Deletion Failed for Patient ID: "+id);
				request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
			}
		}	
		
		// ADD DIAGNOSTICS TO PATIENT ROUTE
		else if(option.equalsIgnoreCase("GETPATIENTFORDIAGNOSTIC")) {
			long id = Long.parseLong(request.getParameter("id"));
			operation = request.getParameter("operation");
			Patient patient = service.get(id);
			ArrayList<Diagnostic> patientDiagnostic = null;//------------------
			ArrayList<Diagnostic> newDiagnostic = null;//-----------------
			ArrayList<Diagnostic> masterDiagnostic = null;//----------------
			
			// PATIENT SEARCH AND RETRIEVING OLD DIAGNOSTICS
			if(operation.equalsIgnoreCase("GETALLOBJECTS")) {
				if(patient != null) {
					request.setAttribute("patient", patient);
					request.setAttribute("patientDiagnostic", patientDiagnostic);
					request.setAttribute("masterDiagnostic", masterDiagnostic);
					request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
				} else {
					request.setAttribute("msg", "Patient Not Found with the Id: "+id);
					request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
				}
			}
			
			// SHOW DIAGNOSTICS TO ADD NEW ONES
			else if(operation.equalsIgnoreCase("SHOWDIAGNOSTIC")) {
				request.setAttribute("showDiagnostic", "TRUE");
				request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
			}
			
			// ADD NEW DIAGNOSTICS TO PAGE
			else if(operation.equalsIgnoreCase("ADDDIAGNOSTIC")) {
				String did = request.getParameter("diagnosticId");
				Diagnostic diagnostic = null; //----------------------------
				newDiagnostic.add(diagnostic); //-------------------------
				request.setAttribute("newDiagnostic", newDiagnostic);
			}
			
			// ADD NEW DIAGNOSTICS TO PATIENT
			else if(operation.equalsIgnoreCase("ADDDIAGNOSTICTOPATIENT")) {
				@SuppressWarnings("unchecked")
				ArrayList<Diagnostic> allObjects = (ArrayList<Diagnostic>)request.getAttribute("newDiagnostics");
				if(allObjects!=null) { //-------------------------
					request.setAttribute("success", "Patient Diagnostics Added Succcessfully");
					request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
				} else {
					request.setAttribute("success", "Patient Diagnostics Added Succcessfully");
					request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
				}
			}
		}
		
		// ADD MEDICINES TO PATIENT ROUTE
		else if(option.equalsIgnoreCase("GETPATIENTFORMEDICINE")) {
			long id = Long.parseLong(request.getParameter("id"));
			operation = request.getParameter("operation");
			Patient patient = service.get(id);
			ArrayList<Medicine> patientMedicine = null;//------------------
			ArrayList<Medicine> newMedicine = null;//-----------------
			ArrayList<Medicine> masterMedicine = null;//----------------

			// PATIENT SEARCH AND RETRIEVING OLD MEDICINES
			if(operation.equalsIgnoreCase("GETALLOBJECTS")) {
				if(patient != null) {
					request.setAttribute("patient", patient);
					request.setAttribute("patientMedicine", patientMedicine);
					request.setAttribute("masterMedicine", masterMedicine);
					request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
				} else {
					request.setAttribute("msg", "Patient Not Found with the Id: "+id);
					request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
				}
			}

			// SHOW MEDICINES TO ADD NEW ONES
			else if(operation.equalsIgnoreCase("SHOWMEDICINE")) {
				request.setAttribute("showMedicine", "TRUE");
				request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
			}

			// ADD NEW MEDICINES TO PAGE
			else if(operation.equalsIgnoreCase("ADDMEDICINE")) {
				String did = request.getParameter("medicineId");
				Medicine medicine = null; //----------------------------
				newMedicine.add(medicine); //-------------------------
				request.setAttribute("newMedicine", newMedicine);
			}

			// ADD NEW MEDICINES TO PATIENT
			else if(operation.equalsIgnoreCase("ADDMEDICINETOPATIENT")) {
				@SuppressWarnings("unchecked")
				ArrayList<Medicine> allObjects = (ArrayList<Medicine>)request.getAttribute("newMedicine");
				if(allObjects!=null) { //-------------------------
					request.setAttribute("success", "Patient Medicines Added Succcessfully");
					request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
				} else {
					request.setAttribute("success", "Patient Medicines Added Succcessfully");
					request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
				}
			}
		}
		
		// GENERATE BILL FOR PATIENT
		else if(option.equalsIgnoreCase("GETPATIENTFORBILLING")) {
			long id = Long.parseLong(request.getParameter("id"));
			operation = request.getParameter("operation");
			Patient patient = service.get(id);
			ArrayList<Diagnostic> patientDiagnostic = null;//----------------------
			ArrayList<Medicine> patientMedicine = null;//-------------------------
			if(operation.equalsIgnoreCase("GETALLOBJECTS")) {
				if(patient != null) {
					request.setAttribute("patientDiagnostic", patientDiagnostic);
					request.setAttribute("patientMedicine", patientMedicine);
					request.setAttribute("patient", patient);
					request.setAttribute("msg", "TRUE");
					request.setAttribute("done", "TRUE");
					request.getRequestDispatcher("/jsp/patientBilling.jsp");
				} else {
					request.setAttribute("msg", null);
					request.setAttribute("success", "Patient Details Not Found with id: "+id);
					request.getRequestDispatcher("/jsp/patientBilling.jsp");
				}
			}
			else if (operation.equalsIgnoreCase("DISCHARGEPATIENT")) {
				// CALL SERVICE METHOD AND CHECK FOR DISCHARGE
				if(patient != null) { //-----------------------------
					request.setAttribute("success", "Patient with Id: "+id +" Discharged Successfully");
					request.getRequestDispatcher("/jsp/patientBilling.jsp").include(request, response);
				} else {
					request.setAttribute("success", "Failed to Discharge Patient with Id: "+id);
					request.getRequestDispatcher("/jsp/paitentBilling.jsp").include(request, response);
				}
			}
		}
	}
}
