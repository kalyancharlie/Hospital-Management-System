<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<title>Patient Registration</title>
</head>
<body>
	<div class="heading">
        <h1>ABC Hospital Management System</h1>
    </div>
    <div class="registration-form">
    	<h2 align="center">Create Patient</h2>
        <form action="/" method="POST">
            <div class="form">
            	<div class="form-labels">
                    <label for="ssnId">Patient SSN ID *</label>
                    <label for="patientName">Patient Name *</label>
                    <label for="patientAge">Patient Age *</label>
                    <label for="dateOfAdmission">Date of Admission *</label>
                    <label for="typeOfBed">Type of bed *</label>
                    <label for="address">Address *</label>
                    <label for="state">State *</label>
                    <label for="city">City *</label>                
                </div>
                <div class="form-inputs">
                    <input type="text" placeholder="" id="ssnId" name="ssnId" required><br/>
                    <input type="text" placeholder="" id="patientName" name="patientName" required><br/>
                    <input type="text" placeholder="" id="patientAge" name="patientAge" required/><br/>
                    <input type="date" placeholder="" id="dateOfAdmission" name="dateOfAdmission" required/><br/>
                    <select name="typeOfBed" id="typeOfBed">
                    	  <option value="General ward">General ward</option>
  						  <option value="Semi sharing">Semi sharing</option>
  						  <option value="Single room">Single room</option>
                    </select><br/>
                    <input type="text" placeholder="" id="address" name="address" required/><br/>
                    <select name="state" id="state">
                 		<option value="Andhra Pradesh">Andhra Pradesh</option>
                 		<option value="Telangana">Telangana</option>
                 		<option value="Odisa">Odisa</option>
                    </select><br/>
                    <select name="city" id="city">
                    	<option value="Visakhapatnam">Visakhapatnam</option>
                    	<option value="Vijayawada">Vijayawada</option>
                    </select><br/>
                </div>
                <div class="form-controls">
                    <input type="submit" value="Submit">
                    <input type="reset" value="Reset">
                </div>
            </div>
        </form>
    </div>


</body>
</html>