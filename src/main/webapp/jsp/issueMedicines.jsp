<%@ page import="com.tcs.model.Medicine, com.tcs.model.Patient, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Issue Medicines</title>
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
    	// PATIENT RECORD
    	Patient patient = null;
    	String patientId = "";
        if(request.getAttribute("patient") != null) {
        	patient = (Patient)request.getAttribute("patient");
        	patientId = String.valueOf(patient.getId());               		
        }
        String msg = (String)request.getAttribute("msg");
    	if(msg == null) {
    		msg = "";
    	}
    	
    	String success = (String)request.getAttribute("success");
    	if(success == null) {
    		success = "";
    	}
    	
    	// PATIENT OLD MEDICINE RECORD
    	ArrayList<Medicine> patientMedicine = null;
    	if(request.getAttribute("patientMedicine") != null) {
    		patientMedicine = (ArrayList<Medicine>)request.getAttribute("patientMedicine");
    	}
    	
    	// PATIENT MASTER MEDICINE RECORD
    	ArrayList<Medicine> masterMedicine = null;
    	if(request.getAttribute("masterMedicine") != null) {
    		masterMedicine = (ArrayList<Medicine>)request.getAttribute("masterMedicine");
    	}
    	
    	// SHOW MEDICINES CHECK
    	String showMedicine = "";
    	if(request.getAttribute("showMedicine") != null) {
    		showMedicine = (String)request.getAttribute("showMedicine");
    	}
    	
    	// PATIENT NEW MEDICINES RECORD
    	ArrayList<Medicine> newMedicine = null;
    	if(request.getAttribute("newDiagnostic") != null) {
    		newMedicine = (ArrayList<Medicine>)request.getAttribute("newMedicine");
    	}
    %>
    <div class="form-search-action">
    	<form action="${pageContext.request.contextPath}/Controller" method="POST">
    		<input type="text" name="option" value="getPatientForMedicine" hidden>
    		<input type="text" name="operation" value="getAllObjects" hidden>
    		<input type="text" name="id" placeholder="Enter patient id" autofocus required value="<%= patientId %>">
        	<button type="submit">Search</button>
    	</form>
    </div>
    <p id="message"><%= msg %></p>
    <p id="message"><%= success %></p>
    <% 
    	if(patient != null) { 
    %>
    <div class="view-patients-form">
        <h2 class="center">Pharmacy</h2>
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
                    <td><%= patient.getId() %></td>
                    <td><%= patient.getName() %></td>
                    <td><%= patient.getAge() %></td>
                    <td><%= patient.getAddress() %></td>
                    <td><%= patient.getDoj() %></td>
                    <td><%= patient.getTypeOfBed() %></td>
                </tr>
            </tbody>
        </table>
    </div>
    <% if(patientMedicine == null) { %>
    <div class="view-issued-medicines">
        <h2 class="center">No Medicines Record Found</h2>
    </div>
    <% } else { %>
    <div class="view-issued-medicines">
        <h2 class="center">Medicines Issued</h2>
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
                    <td>Rs.<%= patientMedicine.get(i).getRate() %></td>
                    <td>Rs.<%= patientMedicine.get(i).getRate()*patientMedicine.get(i).getQty() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %> 
    <form action="${pageContext.request.contextPath}/Controller" method="POST">
    	<input type="text" name="option" value="getPatientForMedicine" hidden>
    	<input type="text" name="operation" value="showMedicine" hidden>
    	<div>
    		<p id="btn"><button type="submit">Issue Medicines</button></p>
    	</div>
    </form>
    <% } %>
    
    <% if(showMedicine != null && !showMedicine.equals("")) {
    		if(newMedicine != null) {
    %>
    <div class="view-issued-medicines">
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
            	<% for(int i=0; i<newMedicine.size(); i++) { %>
                <tr>
                    <td><%= newMedicine.get(i).getName() %></td>
                    <td><%= newMedicine.get(i).getQty() %></td>
                    <td>Rs.<%= newMedicine.get(i).getRate() %></td>
                    <td>Rs.<%= newMedicine.get(i).getRate()*newMedicine.get(i).getQty() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %> 
    <div class="view-add-medicines">
        <div class="left-table">
            <table>
            <form action="${pageContext.request.contextPath}/Controller" method="POST">
            	<input type="text" name="option" value="getPatientForMedicine" hidden>
    			<input type="text" name="operation" value="addMedicine" hidden>
                <tbody>
                    <tr>
                        <td>
                            <select name="medicineName">
                            	<option value="none" selected disabled hidden>
                            	<% for(int i=0; i<masterMedicine.size(); i++) { %>
                                <option value="Acebutolol"><%= masterMedicine.get(i).getName() %></option>
                                <% } %>
                            </select></td>
                        <td><input type="text" name="qty"></td>
                        <%
                        	String selectedMedicine = "";
                        	long medicineId = 0;
                        	double selectedQuantity = 0;
                        	double selectedRate = 0;
                        	double totalAmount = 0;
                        	if(request.getParameter("medicineName") != null)
                        		selectedMedicine = (String)request.getParameter("medicineName");
                        	if(request.getParameter("qty") != null)
                        		selectedQuantity = Double.valueOf(request.getParameter("qty"));
                        	if(selectedQuantity != 0 && selectedMedicine.equals(""))
                        		for(int i=0; i<masterMedicine.size(); i++) {
                        			if(selectedMedicine.equals(masterMedicine.get(i).getName())) {
                        				medicineId = masterMedicine.get(i).getMid();
                        				selectedRate = masterMedicine.get(i).getRate();
                        				totalAmount = masterMedicine.get(i).getRate()*selectedQuantity;
                        				break;
                        			}
                        		}
                        %>
                        <td>Rs.<%= selectedRate %></td>
                        <td width="38%">Rs.<%= totalAmount %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="right-button">
        	<input type="text" name="medicineId" value="<%= medicineId %>">
            <button id="btnnew" type="submit">Add</button>
        </div>
        </form>
    </div>
    <div class="form-controls-action update-medicines">
        <form action="${pageContext.request.contextPath}/Controller" method="POST">
        	<input type="text" name="option" value="getPatientForMedicine" hidden>
        	<input type="text" name="operation" value="addMedicineToPatient" hidden>
        	<input type="text" name="id" value="<%= patient.getId() %>">
        	<% request.setAttribute("newMedicine", newMedicine); %>
            <button type="submit" id="diagnosticSubmit">Update</button>
        </form>
    </div>
    <% } %>
</body>
</html>