<%@ page import="com.tcs.model.Diagnostic, com.tcs.model.Patient, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Add Diagnostics</title>
</head>
<body>
	<%
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expires",0);
		if(session.getAttribute("userId")==null)
			{
			response.sendRedirect("${pageContext.request.contextPath}/jsp/index.jsp");
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
    	
    	// PATIENT OLD DIAGNOSTIC RECORD
    	ArrayList<Diagnostic> patientDiagnostic = null;
    	if(request.getAttribute("patientDiagnostic") != null) {
    		patientDiagnostic = (ArrayList<Diagnostic>)request.getAttribute("patientDiagnostic");
    	}
    	
    	// PATIENT MASTER DIAGNOSTIC RECORD
    	ArrayList<Diagnostic> masterDiagnostic = null;
    	if(request.getAttribute("masterDiagnostic") != null) {
    		masterDiagnostic = (ArrayList<Diagnostic>)request.getAttribute("masterDiagnostic");
    	}
    	
    	// SHOW DIAGNOSTICS CHECK
    	String showDiagnostic = "";
    	if(request.getAttribute("showDiagnostic") != null) {
    		showDiagnostic = (String)request.getAttribute("showDiagnostic");
    	}
    	
    	// PATIENT NEW DIAGNOSTICS RECORD
    	ArrayList<Diagnostic> newDiagnostic = new ArrayList<Diagnostic>();
    		newDiagnostic = (ArrayList<Diagnostic>)session.getAttribute("newDiagnostic");
    	
    %>
    <div class="form-search-action" style="margin-top: 6%;margin-top: 80px">
    	<form action="${pageContext.request.contextPath}/Controller" name="search" method="POST" onsubmit="return validateDiagnostics()">
    		<input type="text" name="option" value="getPatientForDiagnostic" hidden>
    		<input type="text" name="operation" value="getAllObjects" hidden>
    		<input type="text" name="id" placeholder="Enter patient id" autofocus required value="<%= patientId %>">
    		<% session.setAttribute("sid", request.getParameter("id")); %>
        	<button type="submit">Search</button>
    	</form>
    </div>
    <p id="message"><%= msg %></p>
    <p id="message"><%= success %></p>
    <% 
    	if(patient != null) { 
    %>
    <div class="view-patients-form" style="margin-top:0px">
        <h2 class="center">Diagnostics</h2>
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
    <% if(patientDiagnostic == null) { %>
    <div class="view-issued-medicines">
        <h2 class="center">No Diagnostics Conducted</h2>
    </div>
    <% } else { %>
    <div class="view-issued-medicines">
        <h2 class="center">Diagnostics Conducted</h2>
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
                    <td>RS.<%= patientDiagnostic.get(i).getAmount() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>    
    <form action="${pageContext.request.contextPath}/Controller" method="POST">
    	<input type="text" name="option" value="getPatientForDiagnostic" hidden>
    	<input type="text" name="operation" value="showDiagnostic" hidden>
    	<input type="text" name="id" value="<%= patientId %>" hidden required>
    	<div>
    		<p id="btn"><button type="submit">Add Diagnostics</button></p>
    	</div>
    </form>
    <% } %>
    <% if(showDiagnostic != null && !showDiagnostic.equals("")) { %>
    <div class="view-issued-medicines">
        <table>
            <thead>
                <tr>
                    <th>Name of the test</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <% if(newDiagnostic != null) { %>
            <tbody>
            	<% for(int i=0; i<newDiagnostic.size(); i++) { %>
                <tr>
                    <td id="diagnosticNameCheck"><%= newDiagnostic.get(i).getName() %></td>
                    <td>RS.<%= newDiagnostic.get(i).getAmount() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>   
    <div class="view-add-medicines">
        <div class="left-table">
            <table>
            <form action="${pageContext.request.contextPath}/Controller" name="addDiagnostics" method="POST" onsubmit="return confirmAddDiagnostics()">
            	<input type="text" name="option" value="getPatientForDiagnostic" hidden>
    			<input type="text" name="operation" value="addDiagnostic" hidden>
    			<input type="text" name="id" value="<%= patientId %>" hidden required>
                <tbody>
                    <tr>
                        <td>
                            <select name="testName" id="testName" onchange="getRateByName()">
                            	<option value="none" selected disabled hidden>
                            	<% for(int i=0; i<masterDiagnostic.size(); i++) { %>
                                <option value="<%= masterDiagnostic.get(i).getName() %>"><%= masterDiagnostic.get(i).getName() %></option>
                                <% } %>
                            </select></td>
                        <td width="38%" id="injectAmount"></td>
                        	<select id="options" style="visibility: hidden; display: none;">
                                <option value="none" selected disabled hidden></option>
                        		<% for(int i=0; i<masterDiagnostic.size(); i++) { %>
                        		<option value="<%= masterDiagnostic.get(i).getAmount() %>" hidden><%= masterDiagnostic.get(i).getAmount() %></option>
                        		<% } %>
                        	</select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="right-button">
        	<input type="text" name="diagnosticId" id="injectDiagnosticId" hidden>
        	<% session.setAttribute("newDiagnostic", newDiagnostic);
        	%>
            <button id="btnnew" type="submit">Add</button>
        </div>
        </form>
    </div>
    <div class="form-controls-action update-medicines">
        <form action="${pageContext.request.contextPath}/Controller" name="pushDiagnostics" method="POST" onsubmit="return confirmDiagnostics()">
            <input type="text" name="option" value="getPatientForDiagnostic" hidden>
        	<input type="text" name="operation" value="addDiagnosticToPatient" hidden>
        	<input type="text" name="id" value="<%= patient.getId() %>" hidden>
            <button type="submit" id="diagnosticSubmit">Update</button>
        </form>
    </div>
    <% } %>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>