package com.tcs.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.dao.PatientDaoImpl;
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
		
		// LOGIN ROLE CHECK
		if(option.equalsIgnoreCase("LOGIN")) {
			String role = null;
			User user = new User();
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			user.setUsername(username);
			user.setPassword(password);
			role = service.validate(user);
			
			// ADMISSION DESK EXECUTIVE ROUTE
			if(role.equalsIgnoreCase("A")) {
				System.out.println("Admission Executive Loggged In. Role: "+role);
				request.getRequestDispatcher("/jsp/registration.jsp").forward(request, response);
			}
			
			// PHARMACIST ROUTE
			else if(role.equalsIgnoreCase("P")) {
				System.out.println("Pharmacist Logged In. Role: "+role);
				request.getRequestDispatcher("/jsp/patientMedicineIssue.jsp");
			} 
			
			// DIAGNOSTIC ROUTE
			else if(role.equalsIgnoreCase("D")) {
				System.out.println("Diagnostic Executive Logged In. Role: "+role);
				request.getRequestDispatcher("/jsp/patientDiagnosticIssue.jsp");
			} 
			
			// LOGIN FAILED
			else {
				request.setAttribute("msg", "Error! Login Failed");
				System.out.println("Login Failed");
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
		
		// VIEW PATIENT
		else if(option.equalsIgnoreCase("getPatientObject")) {
			long id= Long.parseLong(request.getParameter("ssnId"));
			Patient patient=service.get(id); 
			
			// VIEW PATIENT SUCCESSFUL
			if(patient!=null) {
				request.setAttribute("patient", patient);
				request.getRequestDispatcher("/jsp/viewPatient.jsp").include(request, response);
			} 
			
			// VIEW PATIENT FAILED
			else {
				request.setAttribute("msg", "Invalid SSN ID");
				request.getRequestDispatcher("/jsp/viewPatient.jsp").include(request, response);
			}
		}
		
		// DELETE PATIENT
		else if(option.equalsIgnoreCase("deletePatient")) {
			long id = Long.parseLong(request.getParameter("id"));
			
			// DELETE PATIENT SUCCESSFUL
			if(service.delete(id)) {
				request.setAttribute("msg", "Patient Deleted Successfully");
				request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
			}
			else {
				request.setAttribute("msg", "Invalid SSN ID");
				request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
			}
		}
	}
}
