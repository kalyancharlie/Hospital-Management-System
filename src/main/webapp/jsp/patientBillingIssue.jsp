<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Search & Generate Bill</title>
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
    </div><br/><br/><br/>
    <div class="form-search-action">
    	<form action="${pageContext.request.contextPath}/Controller" method="POST">
    		<input type="text" name="option" value="getPatient" hidden>
    		<input type="text" name="id" placeholder="Enter patient id" autofocus required>
        	<button type="submit">Search</button>
    	</form>
    </div>
    <div class="view-patients-form-new">
        <table>
            <thead>
                <tr>
                    <th>Patient Id</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Address</th>
                    <th>DOJ</th>
                    <th>Type of Room</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1234</td>
                    <td>Joseph</td>
                    <td>36</td>
                    <td>Rick Street, Ameerpet, Hyderabad</td>
                    <td>03-May-2020</td>
                    <td>Single</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="form-controls-action">
    	<form action="${pageContext.request.contextPath}/Controller" method="POST">
    		<input type="text" name="option" value="routeToBilling" hidden>
    		<input type="text" name="id" value="" hidden>
    		<button id="search" type="submit">Generate Bill</button>
    	</form>
    </div>
</body>
</html>