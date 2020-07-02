package com.tcs.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		HttpSession session = request.getSession(true);
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
			session.setAttribute("userId", role);
			
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
			long id = 0;
			id = service.getMaxId();
			if(id == 0) {
				id = 100000000;
			} else {
				id += 1;
			}
			
			patient.setSsnId(Integer.parseInt(request.getParameter("ssnId")));
			patient.setId(id);
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
			String stringPid = String.valueOf(id);
			String stringSid = String.valueOf(session.getAttribute("sid"));
			System.out.println("PID:"+stringPid+" SID:"+stringSid);
			operation = request.getParameter("operation");
			Patient patient = service.get(id);
			ArrayList<Diagnostic> patientDiagnostic = (ArrayList<Diagnostic>)service.getPatientDiagnostics(id);
			ArrayList<Diagnostic> masterDiagnostic = (ArrayList<Diagnostic>) service.getDiagnostics();
			
			// PATIENT SEARCH AND RETRIEVING OLD DIAGNOSTICS
			if(operation.equalsIgnoreCase("GETALLOBJECTS")) {
				if(patient != null) {
					if(stringPid.equals(stringSid)) {
						System.out.println("Equals");
					} else {
						session.setAttribute("newDiagnostic", new ArrayList<Diagnostic>());
						System.out.println("Not Equals");
					}
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
				request.setAttribute("patient", patient);
				request.setAttribute("patientDiagnostic", patientDiagnostic);
				request.setAttribute("masterDiagnostic", masterDiagnostic);
				request.setAttribute("showDiagnostic", "TRUE");
				request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
			}
			
			// ADD NEW DIAGNOSTICS TO PAGE
			else if(operation.equalsIgnoreCase("ADDDIAGNOSTIC")) {
				long did = Long.parseLong(request.getParameter("diagnosticId"));
				Diagnostic diagnostic = (Diagnostic)service.getDiagnosticById(did);
				System.out.println(diagnostic.getName());
				ArrayList<Diagnostic> new2 = (ArrayList<Diagnostic>) session.getAttribute("newDiagnostic");
				if(new2 == null) {
					new2 = new ArrayList<Diagnostic>();
				}
				new2.add(diagnostic);
				System.out.println(new2.size());
				request.setAttribute("patient", patient);
				request.setAttribute("patientDiagnostic", patientDiagnostic);
				request.setAttribute("masterDiagnostic", masterDiagnostic);
				if(stringPid.equals(stringSid)) {
					session.setAttribute("newDiagnostic", new2);
					System.out.println("Equals");
				} else {
					session.setAttribute("newDiagnostic", new ArrayList<Diagnostic>());
					System.out.println("Not Equals");
				}
				request.setAttribute("showDiagnostic", "TRUE");
				request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
			}
			
			// ADD NEW DIAGNOSTICS TO PATIENT
			else if(operation.equalsIgnoreCase("ADDDIAGNOSTICTOPATIENT")) {
				@SuppressWarnings("unchecked")
				ArrayList<Diagnostic> allObjects = (ArrayList<Diagnostic>)session.getAttribute("newDiagnostic");
				if(service.addDiagnostics(id, allObjects)) {
					request.setAttribute("success", "Patient Diagnostics Added Succcessfully");
					session.setAttribute("newDiagnostic", new ArrayList<Diagnostic>());
					request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
				} else {
					request.setAttribute("success", "Patient Diagnostics Added Succcessfully");
					session.setAttribute("newDiagnostic", new ArrayList<Diagnostic>());
					request.getRequestDispatcher("/jsp/addDiagnostic.jsp").include(request, response);
				}
			}
		}
		
		// ADD MEDICINES TO PATIENT ROUTE
		else if(option.equalsIgnoreCase("GETPATIENTFORMEDICINE")) {
			long id = Long.parseLong(request.getParameter("id"));
			String stringPid = String.valueOf(id);
			String stringSid = String.valueOf(session.getAttribute("sid"));
			operation = request.getParameter("operation");
			Patient patient = service.get(id);
			ArrayList<Medicine> patientMedicine = (ArrayList<Medicine>)service.getPatientMedicines(id);
			//ArrayList<Medicine> newMedicine = (ArrayList<Medicine>)request.getAttribute("newMedicine");
			ArrayList<Medicine> masterMedicine = (ArrayList<Medicine>)service.getMedicines();

			// PATIENT SEARCH AND RETRIEVING OLD MEDICINES
			if(operation.equalsIgnoreCase("GETALLOBJECTS")) {
				if(patient != null) {
					if(stringPid.equals(stringSid)) {
					} else {
						session.setAttribute("newMedicine", new ArrayList<Diagnostic>());
					}
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
				request.setAttribute("patient", patient);
				request.setAttribute("patientMedicine", patientMedicine);
				request.setAttribute("masterMedicine", masterMedicine);
				request.setAttribute("showMedicine", "TRUE");
				request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
			}

			// ADD NEW MEDICINES TO PAGE
			else if(operation.equalsIgnoreCase("ADDMEDICINE")) {
				long mid = Long.parseLong(request.getParameter("medicineId"));
				int qty = Integer.parseInt(request.getParameter("qty"));
				Medicine medicine = (Medicine)service.getMedicineById(mid, qty);
				System.out.println(medicine.getName());
				ArrayList<Medicine> new3 = (ArrayList<Medicine>)session.getAttribute("newMedicine");
				if(new3 == null) {
					new3 = new ArrayList<Medicine>();
				}
				new3.add(medicine);
				System.out.println(new3.size());
				request.setAttribute("patient", patient);
				request.setAttribute("patientMedicine", patientMedicine);
				request.setAttribute("masterMedicine", masterMedicine);
				if(stringPid.equals(stringSid)) {
					session.setAttribute("newMedicine", new3);
				} else {
					session.setAttribute("newMedicine", new ArrayList<Medicine>());
				}
				request.setAttribute("showMedicine", "TRUE");
				request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
			}

			// ADD NEW MEDICINES TO PATIENT
			else if(operation.equalsIgnoreCase("ADDMEDICINETOPATIENT")) {
				@SuppressWarnings("unchecked")
				ArrayList<Medicine> allObjects = (ArrayList<Medicine>)session.getAttribute("newMedicine");
				if(service.addMedicines(id, allObjects)) {
					service.updateMedicines(allObjects);
					request.setAttribute("success", "Patient Medicines Added Succcessfully");
					session.setAttribute("newMedicine", new ArrayList<Medicine>());
					request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
				} else {
					request.setAttribute("success", "Patient Medicines Added Succcessfully");
					session.setAttribute("newMedicine", new ArrayList<Medicine>());
					request.getRequestDispatcher("/jsp/issueMedicines.jsp").include(request, response);
				}
			}
		}
		
		// GENERATE BILL FOR PATIENT
		else if(option.equalsIgnoreCase("GETPATIENTFORBILLING")) {
			long id = Long.parseLong(request.getParameter("id"));
			operation = (String)request.getParameter("operation");
			Patient patient = service.get(id);
			ArrayList<Diagnostic> patientDiagnostic = (ArrayList<Diagnostic>)service.getPatientDiagnostics(id);
			ArrayList<Medicine> patientMedicine = (ArrayList<Medicine>)service.getPatientMedicines(id);
			double[] patientBill = service.getBill(id);
			if(operation.equalsIgnoreCase("GETALLOBJECTS")) {
				if(patient != null) {
					request.setAttribute("patientDiagnostic", patientDiagnostic);
					request.setAttribute("patientMedicine", patientMedicine);
					request.setAttribute("patient", patient);
					request.setAttribute("patientBill", patientBill);
					request.setAttribute("msg", "TRUE");
					request.setAttribute("done", "TRUE");
					request.getRequestDispatcher("/jsp/patientBilling.jsp").include(request, response);
				} else {
					request.setAttribute("msg", null);
					request.setAttribute("success", "Patient Details Not Found with id: "+id);
					request.getRequestDispatcher("/jsp/patientBilling.jsp").include(request, response);
				}
			}
			else if (operation.equalsIgnoreCase("DISCHARGEPATIENT")) {
				if(service.discharge(id)) { //-----------------------------
					request.setAttribute("success", "Patient with Id: "+id +" Discharged Successfully");
					request.getRequestDispatcher("/jsp/patientBilling.jsp").include(request, response);
				} else {
					request.setAttribute("success", "Failed to Discharge Patient with Id: "+id);
					request.getRequestDispatcher("/jsp/paitentBilling.jsp").include(request, response);
				}
			}
		}
		
		// VIEW ALL PATIENTS PAGINATION
		else if(operation.equalsIgnoreCase("NAVIGATION")) {
			int page = 1;
			String pageNo = (String) request.getParameter("pageNo");
			String customPageNumber = (String)request.getParameter("customPageNumber");
			long noOfPatients = service.getPatientCount();
			double total = Math.ceil((double)noOfPatients/10);
			System.out.println((int)total);
			String totalPages = String.valueOf((int)total);
			if(customPageNumber != null) {
				System.out.println("Page Number:"+customPageNumber);
				page = Integer.parseInt(customPageNumber)-1;
			} else {
				page = Integer.parseInt(pageNo)-1;
			}
			long start = (page*10)+1;
			long end = ((start+10)<noOfPatients)?(start+10):noOfPatients;
			List<Patient> patientList = (List<Patient>)service.getAllPatients(start, end);
			if(patientList!=null) {
				request.setAttribute("patientList", patientList);
				request.setAttribute("pageNo",pageNo);
				request.setAttribute("totalPages", totalPages);
				request.getRequestDispatcher("/jsp/viewAllPatients.jsp").include(request, response);
			} else {
				request.getRequestDispatcher("jsp/viewAllPatients.jsp").include(request, response);
			}
		}
	}
}
