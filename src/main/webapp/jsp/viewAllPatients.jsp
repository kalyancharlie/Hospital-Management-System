<%@ page import="com.tcs.model.Patient, com.tcs.service.Service, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>View All Patients</title>
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
    <%
    	Service service = new Service();
    	ArrayList<Patient> patients = (ArrayList<Patient>)service.getAllPatients();
    %>
    <div class="view-patients-form">
    	<% if(patients == null || patients.size() == 0) { %>
    	<h2 class="center">There are no Patients in Database</h2>
    	<% } else { %>
        <h2 class="center">View Patients</h2>
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
            	<% for (int i=0; i<patients.size(); i++) { %>
                <tr>
                   <td><%= patients.get(i).getId() %></td>
                    <td><%= patients.get(i).getName() %></td>
                    <td><%= patients.get(i).getAge() %></td>
                    <td><%= patients.get(i).getAddress() %></td>
                    <td><%= patients.get(i).getDoj() %></td>
                    <td><%= patients.get(i).getTypeOfBed() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>