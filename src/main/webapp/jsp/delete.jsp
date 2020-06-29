<%@ page import="com.tcs.model.Patient" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Delete Patient</title>
</head>
<body>
	<div class="heading">
        <h1>ABC Hospital Management System</h1>
        <div class="ad-functions dropdown">
            <button class="admission dropbtn"><span>Patient</span></button>
            <div class="admission-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/registration.jsp">Register Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/update.jsp">Update Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/delete.jsp">Delete Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewAllPatients.jsp">View All Patients</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/patientBillingIssue.jsp">Patient Billing</a><br/>
            </div>
        </div>
        <div class="ph-functions dropdown">
            <button class="pharmacist dropbtn"><span>Pharmacy</span></button>
            <div class="pharmacist-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/patientMedicineIssue.jsp">Issue Medicines</a><br/>
            </div>
        </div>
        <div class="di-functions dropdown">
            <button class="diagnostic dropbtn"><span>Diagnostics</span></button>
            <div class="diagnostic-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/patientDiagnosticIssue.jsp">Add Diagnostics</a><br/>
            </div>
        </div>
    </div>
    <%
    	Patient patient = null;
        String name = "";
        String age = "";
        String doj = "";
        String typeOfBed = "";
        String address = "";
        String state = "";
        String city = "";
        String selectedId = "";
        String bedSelected = "";
        String stateSelected = "";
        String citySelected = "";
        if(request.getAttribute("patient") != null) {
        	patient = (Patient)request.getAttribute("patient"); 
        	selectedId = String.valueOf(patient.getId());
            name = patient.getName();
            age = String.valueOf(patient.getAge());
            doj = String.valueOf(patient.getDoj());
            typeOfBed = String.valueOf(patient.getTypeOfBed());
            address = String.valueOf(patient.getAddress());
            state = String.valueOf(patient.getState());
            city = String.valueOf(patient.getCity());                		
        }
        String msg = (String)request.getAttribute("msg");
    	if(msg == null) {
    		msg = "";
    	}
    %>
    <div class="registration-form">
    	<h2 class="center">Delete Patient</h2>
    	<p id="message"><%= msg %></p>
    	<form></form>
            <div class="form">
            	<div class="form-labels">
                    <label for="ssnId">Patient ID *</label>
                    <label for="patientName">Patient Name *</label>
                    <label for="patientAge">Patient Age *</label>
                    <label for="dateOfAdmission">Date of Admission *</label>
                    <label for="typeOfBed">Type of bed *</label>
                    <label for="address" id="address">Address *</label>
                    <label for="state">State *</label>
                    <label for="city">City *</label>                
                </div>
                <div class="form-inputs">
                <form action="${pageContext.request.contextPath}/Controller" method="POST">                	
                	<input type="text" name="option" value="getPatient" hidden>
                	<input type="text" name="page" value="delete" hidden>
                    <input type="text" placeholder="" id="id" name="id" autofocus required value="<%= selectedId %>"><button type="submit">Get</button><br/>
                </form>
                <form action="${pageContext.request.contextPath}/Controller" method="POST">
                	<input type="text" name="operation" value="deletePatient" hidden>
                	<input type="text" name="id" value="<%= selectedId %>" hidden>
                    <input type="text" placeholder="" id="patientName" name="patientName" value="<%= name %>"/><br/>
                    <input type="text" placeholder="" id="patientAge" name="patientAge" value="<%= age %>"/><br/>
                    <input type="date" placeholder=" " id="dateOfAdmission" name="dateOfAdmission" value="<%= doj %>"/><br/>
                    <select name="typeOfBed" id="typeOfBed">
                        <option value="none" selected disabled hidden></option>
                    	  <option value="General Ward" <%= bedSelected = typeOfBed.equalsIgnoreCase("General Ward") ? "Selected" : "" %>>General ward</option>
  						  <option value="Semi Sharing" <%= bedSelected = typeOfBed.equalsIgnoreCase("Semi Sharing") ? "Selected" : "" %>>Semi sharing</option>
  						  <option value="Single Room" <%= bedSelected = typeOfBed.equalsIgnoreCase("Single Room") ? "Selected" : "" %>>Single room</option>
                    </select><br/>
                    <textarea placeholder="" id="addresas" name="address" rows="3"><%= address %></textarea><br/>
                    <select name="state" id="state">
                        <option value="none" selected disabled hidden></option>
                 		<option value="Andhra Pradesh" <%= stateSelected = state.equalsIgnoreCase("Andhra Pradesh") ? "Selected" : "" %>>Andhra Pradesh</option>
                 		<option value="Telangana" <%= stateSelected = state.equalsIgnoreCase("Telangana") ? "Selected" : "" %>>Telangana</option>
                 		<option value="Odisa" <%= stateSelected = state.equalsIgnoreCase("Odisa") ? "Selected" : "" %>>Odisa</option>
                    </select><br/>
                    <select name="city" id="city">
                        <option value="none" selected disabled hidden></option>
                    	<option value="Visakhapatnam" <%= citySelected = city.equalsIgnoreCase("Visakhapatnam") ? "Selected" : "" %>>Visakhapatnam</option>
                    	<option value="Vijayawada" <%= citySelected = city.equalsIgnoreCase("Vijayawada") ? "Selected" : "" %>>Vijayawada</option>
                    </select><br/> 
                    <div class="form-controls-action">
                    	<button type="submit">Delete</button>
                	</div>
        		</form>
                </div>
            </div>
    </div>
</body>
</html>