<%@ page import="com.tcs.model.Patient" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Update Patient</title>
</head>
<body>
	<%
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expires",0);
		if(session.getAttribute("userId")==null)
			{
				request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
			}
	%>
	<div class="heading">
        <h1>ABC Hospital Management System</h1>
        <div class="ad-functions dropdown">
            <button class="admission dropbtn" title="Admission Functions"><span>Patient</span></button>
            <div class="admission-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/registration.jsp">Register Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/update.jsp">Update Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/delete.jsp">Delete Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewAllPatients.jsp">View All Patients</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/patientBilling.jsp">Patient Billing</a><br/>
            </div>
        </div>
        <div class="ph-functions dropdown">
            <button class="pharmacist dropbtn" title="Pharmacy Functions"><span>Pharmacy</span></button>
            <div class="pharmacist-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/issueMedicines.jsp">Issue Medicines</a><br/>
            </div>
        </div>
        <div class="di-functions dropdown">
            <button class="diagnostic dropbtn" title="Diagnostic Functions"><span>Diagnostics</span></button>
            <div class="diagnostic-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/addDiagnostic.jsp">Add Diagnostics</a><br/>
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
    <div class="logout">
    	<a href="${pageContext.request.contextPath}/jsp/index.jsp" title="Click here to logout">Logout</a>
	</div>
    <div class="registration-form">
    	<h2 class="center">Update Patient</h2>
    	<p id="message"><%= msg %></p>
    	<form></form>
        	<input type="text" name="option" value="updatePatient" hidden>
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
                <form action="${pageContext.request.contextPath}/Controller" name="update" onsubmit="return validateUpdate()" method="POST">                	
                	<input type="text" name="option" value="getPatient" hidden>
                	<input type="text" name="page" value="update" hidden>
                    <input type="text" placeholder="" id="id" name="id" autofocus required value="<%= selectedId %>"><button type="submit" title="Click here to search">Get</button><br/>
                </form>
                <form action="${pageContext.request.contextPath}/Controller" method="POST" name="updates" onsubmit="return confirmUpdate()">
                	<input type="text" name="operation" value="updatePatient" hidden>
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
                    <textarea type="text" placeholder="" id="addresas" name="address" rows="3"><%= address %></textarea><br/>
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
                    	<option value="Warangal" <%= citySelected = city.equalsIgnoreCase("Warangal") ? "Selected" : "" %>>Warangal</option>
                    	<option value="Hyderabad" <%= citySelected = city.equalsIgnoreCase("Hyderabad") ? "Selected" : "" %>>Hyderabad</option>
                    	<option value="Bhubaneswar" <%= citySelected = city.equalsIgnoreCase("Bhubaneswar") ? "Selected" : "" %>>Bhubaneswar</option>
                    </select><br/>
                    <div class="note">
                    	<p>* Fields are mandatory</p>
                	</div>
                    <div class="form-controls-action">
                    	<button type="submit" title="Click here to update patient">Update</button>
                	</div>
        		</form>
                </div>
            </div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>