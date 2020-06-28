<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Update Patient</title>
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
    <div class="registration-form">
    	<h2 class="center">Update Patient</h2>
        <form action="/" method="POST">
            <div class="form">
            	<div class="form-labels">
                    <label for="ssnId">Patient SSN ID *</label>
                    <label for="patientName">Patient Name *</label>
                    <label for="patientAge">Patient Age *</label>
                    <label for="dateOfAdmission">Date of Admission *</label>
                    <label for="typeOfBed">Type of bed *</label>
                    <label for="address" id="address">Address *</label>
                    <label for="state">State *</label>
                    <label for="city">City *</label>                
                </div>
                <div class="form-inputs">
                <form action="/">
                    <input type="text" placeholder="" id="ssnId" name="ssnId" required><button type="submit">Get</button><br/>
                </form>
                    <input type="text" placeholder="" id="patientName" name="patientName"/><br/>
                    <input type="text" placeholder="" id="patientAge" name="patientAge"/><br/>
                    <input type="date" placeholder=" " id="dateOfAdmission" name="dateOfAdmission"/><br/>
                    <select name="typeOfBed" id="typeOfBed">
                        <option value="none" selected disabled hidden></option>
                    	  <option value="General Ward">General ward</option>
  						  <option value="Semi Sharing">Semi sharing</option>
  						  <option value="Single Room">Single room</option>
                    </select><br/>
                    <textarea type="text" placeholder="" id="addresas" name="address" rows="3"></textarea><br/>
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
                    </select><br/>
                </div>
                <div class="note">
                    <p>* Fields are mandatory</p>
                </div>
                <div class="form-controls-action">
                    <button type="submit">Update</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>