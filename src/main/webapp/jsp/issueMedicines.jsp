<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
                    <th>Date of Discharge</th>
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
                    <td>10-May-2020</td>
                    <td>Single</td>
                </tr>
            </tbody>
        </table>
    </div>
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
                <tr>
                    <td>Acebutolol</td>
                    <td>10</td>
                    <td>Rs.55</td>
                    <td>Rs.550</td>
                </tr>
            </tbody>
        </table>
    </div>
    <form action="${pageContext.request.contextPath}/jsp" method="POST">
    	<div>
    		<p id="btn"><button type="submit">Issue Medicines</button></p>
    	</div>
    </form>
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
                <tr>
                    <td>Acebutolol</td>
                    <td>10</td>
                    <td>Rs.55</td>
                    <td>Rs.550</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="view-add-medicines">
        <div class="left-table">
            <table>
            <form action="${pageContext.request.contextPath}" method="POST">
                <tbody>
                    <tr>
                        <td width="">
                            <select name="testName">
                                <option value="Acebutolol">adfdfadfadfaCBP</option>
                                <option value="Paracetomal">X-RAdfadfdfY</option>
                            </select></td>
                        <td><input type="text" name="qty"></td>
                        <td>Rs.120</td>
                        <td>Rs.120</td>
                        <td width="38%">Rs.12000</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="right-button">
            <button id="btnnew" type="submit">Add</button>
        </div>
        </form>
    </div>
    <div class="form-controls-action update-medicines">
        <form action="${pageContext.request.contextPath}/jsp/issueMedicines.jsp" method="POST">
            <button type="submit" id="diagnosticSubmit">Update</button>
        </form>
    </div>
</body>
</html>