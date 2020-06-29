package com.tcs.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.model.Patient;
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
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String role = service.validate(username, password);
			if(role.equalsIgnoreCase("A")) {
				System.out.println("Admission Executive Loggged In. Role:"+role);
				request.getRequestDispatcher("/jsp/registration.jsp").forward(request, response);
			} else if(role.equalsIgnoreCase("P")) {
				System.out.println("Pharmacist Logged In. Role:"+role);
				request.getRequestDispatcher("/jsp/patientMedicineIssue.jsp");
			} else if(role.equalsIgnoreCase("D")) {
				System.out.println("Diagnostic Executive Logged In. Role:"+role);
				request.getRequestDispatcher("/jsp/patientDiagnosticIssue.jsp");
			} else {
				request.setAttribute("msg", "Error! Login Failed");
				System.out.println("Login Failed");
				request.getRequestDispatcher("/jsp/index.jsp").include(request, response);
			}
		}
		
		// PATIENT REGISTRATION
		else if(option.equalsIgnoreCase("REGISTRATION")) {
			Patient pt = new Patient();
			pt.setSsnId(Integer.parseInt(request.getParameter("ssnId")));
			pt.setName(request.getParameter("patientName"));
			pt.setAge(Integer.parseInt(request.getParameter("patientAge")));
			pt.setAddress(request.getParameter("address"));
			pt.setDoj(Date.valueOf(request.getParameter("dateOfAdmission")));
			pt.setCity(request.getParameter("city"));
			pt.setState(request.getParameter("state"));
			if(service.register(pt)) {
				PrintWriter out = response.getWriter();
				out.print("Patient creation initiated successfully");
			} else {
				request.setAttribute("msg", "Patient not Registered");
				request.getRequestDispatcher("/jsp/registration.jsp").include(request, response);
			}
		}else if(option.equalsIgnoreCase("getPatientObject")) {
			long id= Long.parseLong(request.getParameter("ssnId"));
			Patient pt=service.get(id); 
			if(pt!=null) {
				request.setAttribute("pt", pt);
				request.getRequestDispatcher("/jsp/delete.jsp").include(request, response);
			}else {
				request.setAttribute("msg", "Invalid SSN ID");
				request.getRequestDispatcher("/jsp/registration.jsp").include(request, response);
			}
		}else if(option.equalsIgnoreCase("deletePatient")) {
			long id = Long.parseLong(request.getParameter("id"));
			if(service.delete(id)) {
				PrintWriter out = response.getWriter();
				out.print("Patient deleted successfully");
			}
			}
	}
}
