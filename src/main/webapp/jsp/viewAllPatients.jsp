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
    <%
    	
    	Service service = new Service();
    	ArrayList<Patient> patients = null;
    	String pageNo = "";
    	long noOfPatients = service.getPatientCount();
		double total = Math.ceil((double)noOfPatients/10);
		System.out.println((int)total);
		String totalPages = String.valueOf((int)total);
    	if(pageNo.equals("") || pageNo == null) {
    		patients = (ArrayList<Patient>)service.getAllPatients(1, 10);
    	}
    	if(request.getAttribute("pageNo") != null) {
    		pageNo = (String)request.getAttribute("pageNo");
    	}
    	if(request.getAttribute("patientList") != null) {
    		patients = (ArrayList<Patient>)request.getAttribute("patientList");
    	}
    %>
    <div class="logout">
    	<a href="${pageContext.request.contextPath}/jsp/index.jsp">Logout</a>
	</div>
    <div class="view-patients-form">
    	<% if(patients == null || patients.size() == 0) { %>
    	<h2 class="center">There are no Patients in Database</h2>
    	<% } else { %>
        <h2 class="center">View Patients</h2>
        <div>
            <div class="current-page">
            	<% if(pageNo.equals("") || pageNo == null) { %>
            	<p id="currentNumber">Page: <%= 1 %>/<%= totalPages %></p>
            	<% } else { %>
                <p id="currentNumber">Page: <%= pageNo %>/<%= totalPages %></p>
                <% } %>
            </div>
            <div class="right-search">
                <form class="page-search-form" action="${pageContext.request.contextPath}/Controller" name="searchpage" method="POST" onsubmit="return validateSearchPageNumber()">
                    <input type="text" name="operation" value="navigation" hidden>
                    <input type="text" name="customPageNumber" placeholder="Enter page number">
                    <button type="submit" style="cursor: pointer;">Search Page</button>
             </form>
        </div>
        </div>
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
    <div class="page-numbers">
    	<div class="previous-page">
    		<form action="${pageContext.request.contextPath}/Controller" name="previouspage" method="POST">
    			<input type="text" value="<%= totalPages %>" name="total" hidden> 
	    		<input type="text" name="operation" value="navigation" hidden>
	    		<% if(pageNo.equals("") || pageNo == null) { %>
	    		<input type="text" name="pageNo" value="1" hidden>
	    		<% } else { %>
	    		<input type="text" name="pageNo" value="<%= Integer.parseInt(pageNo)-1 %>" hidden>
	    		<% } %>
	    		<button type="submit" id="prev" style="cursor: pointer;">Prev</button>
    		</form>
    	</div>
    	<div class="next-page">
    		<form action="${pageContext.request.contextPath}/Controller" name="nextpage" method="POST">
	    		<input type="text" name="operation" value="navigation" hidden>
	    		<% if(pageNo.equals("") || pageNo == null) { %>
	    		<input type="text" name="pageNo" value="2" hidden>
	    		<% } else { %>
	    		<input type="text" name="pageNo" value="<%= Integer.parseInt(pageNo)+1 %>" hidden>
	    		<% } %>
	    		<input type="text" value="<%= totalPages %>" name="total" hidden> 
	    		<button type="submit" id="next" style="cursor: pointer;">Next</button>
	    	</form>
    	</div>
    </div>
    <% } %>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>