<%@ page import="com.tcs.model.*, java.util.*, com.tcs.util.Utility, java.math.BigDecimal" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Patient Billing</title>
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
            <%-- <div class="pharmacist-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/issueMedicines.jsp">Issue Medicines</a><br/>
            </div> --%>
        </div>
        <div class="di-functions dropdown">
            <button class="diagnostic dropbtn"><span>Diagnostics</span></button>
            <%-- <div class="diagnostic-functions dropdown-content">
                <a id="link" href="${pageContext.request.contextPath}/jsp/viewPatient.jsp">Search Patient</a><br/>
                <a id="link" href="${pageContext.request.contextPath}/jsp/addDiagnostic.jsp">Add Diagnostics</a><br/>
            </div> --%>
        </div>
    </div>
    <%
    	// PATIENT RECORD
    	Patient patient = null;
    	String patientId = "";
        if(request.getAttribute("patient") != null) {
        	patient = (Patient)request.getAttribute("patient");
        	patientId = String.valueOf(patient.getId());               		
        }
        String msg = "";
    	if(request.getAttribute("msg") != null) {
    		msg = (String)request.getAttribute("msg");
    	}
    	
    	String success = "";
    	if(request.getAttribute("success") != null) {
    		success = (String)request.getAttribute("success");
    	}
    	
    	String done = "";
    	if(request.getAttribute("done") != null) {
    		done = (String)request.getAttribute("done");
    	}
    	
    	// PATIENT MEDICINES RECORD
    	ArrayList<Medicine> patientMedicine = null;
    	if(request.getAttribute("patientMedicine") != null) {
    		patientMedicine = (ArrayList<Medicine>)request.getAttribute("patientMedicine");
    	}
    	
    	// PATIENT DIAGNOSTIC RECORD
    	ArrayList<Diagnostic> patientDiagnostic = null;
    	if(request.getAttribute("patientDiagnostic") != null) {
    		patientDiagnostic = (ArrayList<Diagnostic>)request.getAttribute("patientDiagnostic");
    	}
    	
    	// PATIENT BILL 
    	double[] bill = null;
    	if(request.getAttribute("patientBill") != null) {
    		bill = (double[])request.getAttribute("patientBill");
    	}
    %>
    <div class="logout">
    	<a href="${pageContext.request.contextPath}/jsp/index.jsp">Logout</a>
	</div>
    <div class="form-search-action" style="margin-top: 6%">
    	<form action="${pageContext.request.contextPath}/Controller" name="search" method="POST" onsubmit="return validateBilling()">
    		<input type="text" name="option" value="getPatientForBilling" hidden>
    		<input type="text" name="operation" value="getAllObjects" hidden>
    		<input type="text" name="id" placeholder="Enter patient id" autofocus required value="<%= patientId %>">
        	<button type="submit">Search</button>
    	</form>
    </div>
    <div class="view-patients-form" style="margin-top:0px">
        <h2 class="center">Patient Billing</h2>
        <p id="message"><%= success %></p>
        <% if(patient != null) { %>
        <% if(msg != null || !msg.equals("") && done != null ) { %>
        <table>
            <thead>
                <tr>
                    <th>Patient Id</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Address</th>
                    <th>DOJ</th>
                    <th>Date of Discharge</th>
                    <th>Type of Room</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= patient.getId() %></td>
                    <td><%= patient.getName() %></td>
                    <td><%= patient.getAge() %></td>
                    <td><%= patient.getAddress() %></td>
                    <td><%= patient.getDoj() %></td>
                    <td><%= Utility.today() %></td>
                    <td><%= patient.getTypeOfBed() %></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="billing-text">
        <p id="text"><strong>No.of days: </strong><%= new BigDecimal(bill[0]).toPlainString() %></p><p id="text"><strong>Bill for Room: </strong></p><p id="text">Rs.<%= new BigDecimal(bill[1]).toPlainString() %></p>
    </div>
    <% if(patientMedicine != null) { %>
    <div class="view-issued-medicines">
        <h2 class="center">Pharmacy Charges</h2>
        
        <table>
            <thead>
                <tr>
                    <th>Medicine</th>
                    <th>Quantity</th>
                    <th>Rate</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
            	<% for(int i=0; i<patientMedicine.size(); i++) { %>
                <tr>
                    <td><%= patientMedicine.get(i).getName() %></td>
                    <td><%= patientMedicine.get(i).getQty() %></td>
                    <td><%= patientMedicine.get(i).getRate() %></td>
                    <td>Rs.<%= patientMedicine.get(i).getQty() * patientMedicine.get(i).getRate() %></td>
                </tr>
                <% } %>
                <tr class="column">
                	<td colspan="3" id="text-column"><p id="text"><strong>Bill for Pharmacy: </strong></p></td>
                	<td id="text-column"><p id="text">Rs.<%= new BigDecimal(bill[2]).toPlainString() %></p></td>
                </tr>
            </tbody>
        </table>
    </div>
    <% } if(patientDiagnostic != null) { %>
    <div class="billing-text">
    </div>
    <div class="view-add-medicines">
        <h2 class="center">Diagnostics Charges</h2>
        <table>
            <thead>
                <tr>
                    <th>Name of the test</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
            	<% for(int i=0; i<patientDiagnostic.size(); i++) { %>
                <tr>
                    <td><%= patientDiagnostic.get(i).getName() %></td>
                    <td><%= patientDiagnostic.get(i).getAmount() %></td>
                </tr>
                <% } %>
                <tr class="column">
                	<td id="text-column"><p id="text"><strong>Bill for Diagnostics: </strong></p></td>
                	<td id="text-column"><p id="text">Rs. <%= new BigDecimal(bill[3]).toPlainString() %></p></td>
                </tr>
            </tbody>
        </table>
    </div>
    <% } %>
    <div class="billing-text">
    </div>
    <div class="form-controls-action update-medicines">
    	<form action="${pageContext.request.contextPath}/Controller" method="POST" onsubmit="return confirmBilling()">
    		<input type="text" name="option" value="getPatientForBilling" hidden>
    		<input type="text" name="operation" value="dischargePatient" hidden>
    		<input type="text" name="id" value="<%= patient.getId() %>" hidden>
    		<button id="diagnosticSubmit" type="submit">Confirm</button><p id="text">Grand Total<span id="text">Rs.<%= new BigDecimal(bill[4]).toPlainString() %></span></p>
    	</form>
    </div>
    <% } %>
    <% } %>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>