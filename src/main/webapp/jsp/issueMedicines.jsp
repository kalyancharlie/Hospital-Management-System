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
            <button class="admission dropbtn" title="Admission Desk Functions"><span>Patient</span></button>
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
    	ArrayList<Medicine> newMedicine = new ArrayList<Medicine>();
    		newMedicine = (ArrayList<Medicine>)session.getAttribute("newMedicine");
    %>
    <div class="logout">
    	<a href="${pageContext.request.contextPath}/jsp/index.jsp" title="Click here to logout">Logout</a>
	</div>
    <div class="form-search-action" style="margin-top: 6%;margin-top: 80px">
    	<form action="${pageContext.request.contextPath}/Controller" name="search" method="POST" onsubmit="return validateDelete()">
    		<input type="text" name="option" value="getPatientForMedicine" hidden>
    		<input type="text" name="operation" value="getAllObjects" hidden>
    		<input type="text" name="id" placeholder="Enter patient id" autofocus required value="<%= patientId %>">
        	<% session.setAttribute("sid", request.getParameter("id")); %>
        	<button type="submit" title="Click here to search">Search</button>
    	</form>
    </div>
    <p id="message"><%= msg %></p>
    <p id="message"><%= success %></p>
    <div class="view-patients-form" style="margin-top:0px">
        <h2 class="center">Pharmacy</h2>
        <% 
    	if(patient != null) { 
    	%>
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
    <% session.setAttribute("sid", patient.getId()); %>
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
                    <td>Rs.<%= patientMedicine.get(i).getAmount() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %> 
    <form action="${pageContext.request.contextPath}/Controller" method="POST">
    	<input type="text" name="option" value="getPatientForMedicine" hidden>
    	<input type="text" name="operation" value="showMedicine" hidden>
    	<input type="text" name="id" value="<%= patientId %>" hidden required>
    	<div>
    		<p id="btn"><button type="submit" title="Click here to issue medicines">Issue Medicines</button></p>
    	</div>
    </form>
    <% } %>
    <% if(showMedicine != null && !showMedicine.equals("")) { %>
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
            <% if(newMedicine != null) { %>
            <tbody>
            	<% for(int i=0; i<newMedicine.size(); i++) { %>
                <tr>
                    <td id="medicineNameCheck"><%= newMedicine.get(i).getName() %></td>
                    <td><%= newMedicine.get(i).getQty() %></td>
                    <td>Rs.<%= newMedicine.get(i).getRate() %></td>
                    <td>Rs.<%= newMedicine.get(i).getAmount() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %> 
    <div class="view-add-medicines">
        <div class="left-table">
            <table>
            <form action="${pageContext.request.contextPath}/Controller" name="addMedicines" method="POST" onsubmit="return confirmAddMedicines()">
            	<input type="text" name="option" value="getPatientForMedicine" hidden>
    			<input type="text" name="operation" value="addMedicine" hidden>
    			<input type="text" name="id" value="<%= patientId %>" hidden required>
                <tbody>
                    <tr>
                        <td width="30%">
                            <select name="medicineName" id="medicineName" onchange="getMedicineByName1()">
                            	<option value="none" selected disabled hidden>
                            	<% for(int i=0; i<masterMedicine.size(); i++) { %>
                                <option value="<%= masterMedicine.get(i).getName() %>"><%= masterMedicine.get(i).getName() %></option>
                                <% } %>
                            </select></td>
                        <td style="visibility: hidden; display: none;">
                        	<select name="medicineQuantity" id="medicineQuantity">
                        		<option value="none" selected disabled hidden></option>
                        		<% for(int i=0; i<masterMedicine.size(); i++) { %>
                        		<option value="<%= masterMedicine.get(i).getQty() %>" hidden><%= masterMedicine.get(i).getQty() %></option>
                        		<% } %>
                        	</select>
                        </td>
                        <td style="visibility: hidden; display: none;">
                        	<select name="medicineRate" id="medicineRate">
                        		<option value="none" selected disabled hidden></option>
                        		<% for(int i=0; i<masterMedicine.size(); i++) { %>
                        		<option value="<%= masterMedicine.get(i).getRate() %>" hidden><%= masterMedicine.get(i).getRate() %></option>
                        		<% } %>
                        	</select>
                        </td>
                        <td width="10%"><input type="text" name="qtyy" id="qty" onblur="getMedicineByName2()"></td>
                        <td id="injectMedicineRate"></td>
                        <td width="20%" id="injectMedicineAmount"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="right-button">
        	<input type="text" name="medicineId" id="injectMedicineId" hidden>
        	<input type="text" name="qty" id="injectMedicineQuantity" hidden>
        	<% request.setAttribute("newMedicine", newMedicine); %>
            <button id="btnnew" type="submit" onclick="getMedicineByName2()" title="Click here to add medicines">Add</button>
        </div>
        </form>
    </div>
    <div class="form-controls-action update-medicines">
        <form action="${pageContext.request.contextPath}/Controller" name="pushMedicines" method="POST" onsubmit="return confirmMedicines()">
        	<input type="text" name="option" value="getPatientForMedicine" hidden>
        	<input type="text" name="operation" value="addMedicineToPatient" hidden>
        	<input type="text" name="id" value="<%= patient.getId() %>" hidden>
            <button type="submit" id="diagnosticSubmit" title="Click here to update medicines">Update</button>
        </form>
    </div>
    <% } %>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>