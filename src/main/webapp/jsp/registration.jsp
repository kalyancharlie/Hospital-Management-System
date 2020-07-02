<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<title>Patient Registration</title>
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
            <button class="admission dropbtn"><span>Patient</span></button>
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
            <button class="pharmacist dropbtn"><span>Pharmacy</span></button>
            <div class="pharmacist-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/issueMedicines.jsp">Issue Medicines</a><br/>
            </div>
        </div>
        <div class="di-functions dropdown">
            <button class="diagnostic dropbtn"><span>Diagnostics</span></button>
            <div class="diagnostic-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/addDiagnostic.jsp">Add Diagnostics</a><br/>
            </div>
        </div>
    </div>
    <div class="logout">
    	<a href="${pageContext.request.contextPath}/jsp/index.jsp">Logout</a>
	</div>
    <%
    	String msg = (String)request.getAttribute("msg");
    	if(msg == null) {
    		msg = "";
    	}
    %>
    <div class="registration-form">
    	<h2 class="center">Patient Registration</h2>
    	<p id="message"><%= msg %></p>
        <form action="${pageContext.request.contextPath}/Controller" method="POST" name="register" onsubmit="return validateRegistration()">
        	<input type="hidden" name="option" value="registration"/>
            <div class="form">
            	<div class="form-labels" style="width:35%; margin-left:-7%;">
                    <label for="ssnId">Patient SSN ID *</label>
                    <label for="patientName">Patient Name *</label>
                    <label for="patientAge">Patient Age *</label>
                    <label for="dateOfAdmission">Date of Admission *</label>
                    <label for="typeOfBed">Type of bed *</label>
                    <label for="address">Address *</label><br/><br/>
                    <label for="state">State *</label>
                    <label for="city">City *</label>                
                </div>
                <div class="form-inputs">
                    <input type="text" placeholder="" id="ssnId" name="ssnId" autofocus required><br/>
                    <input type="text" placeholder="" id="patientName" name="patientName" required><br/>
                    <input type="text" placeholder="" id="patientAge" name="patientAge" required/><br/>
                    <input type="date" placeholder=" " id="dateOfAdmission" name="dateOfAdmission" required/><br/>
                    <select name="typeOfBed" id="typeOfBed">
                        <option value="none" selected disabled hidden></option>
                    	  <option value="General Ward">General ward</option>
  						  <option value="Semi Sharing">Semi sharing</option>
  						  <option value="Single Room">Single room</option>
                    </select><br/>
                    <textarea type="text" placeholder="" id="address" name="address" rows="3" required></textarea><br/>
                    <select name="state" id="state">
                        <option value="none" selected disabled hidden></option>
                 		<option value="Andhra Pradesh">Andhra Pradesh</option>
                 		<option value="Telangana">Telangana</option>
                 		<option value="Odisa">Odisa</option>
                    </select><br/>
                    <select name="city" id="city">
                        <option value="none" selected disabled hidden></option>
                    	<option value="Visakhapatnam">Visakhapatnam</option>
                    	<option value="Vijayawada">Vijayawada</option>
                    	<option value="Hyderabad">Hyderabad</option>
                    	<option value="Warangal">warangal</option>
                    	<option value="Bhubaneswar">Bhubaneswar</option>
                    </select><br/>
                </div>
                <div class="note">
                    <p>* Fields are mandatory</p>
                </div>
                <div class="form-controls">
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </div>
            </div>
        </form>
    </div>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>