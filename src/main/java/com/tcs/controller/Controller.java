package com.tcs.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		// LOGIN CHECK
		if(option.equalsIgnoreCase("LOGIN")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			if(service.validate(username, password)) {
				PrintWriter out = response.getWriter();
				out.print("Success");
			} else {
				request.setAttribute("msg", "Error! Login Failed");
				request.getRequestDispatcher("/jsp/index.jsp").include(request, response);
			}
		}
	}
}
