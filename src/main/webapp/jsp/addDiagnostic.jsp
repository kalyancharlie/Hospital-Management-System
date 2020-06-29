<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Add Diagnostics</title>
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
        <h2 class="center">Diagnostics</h2>
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
        <h2 class="center">Diagnostics Conducted</h2>
        <table>
            <thead>
                <tr>
                    <th>Name of the test</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>CBP</td>
                    <td>RS.2000</td>
                </tr>
            </tbody>
        </table>
    </div>
    <form action="${pageContext.request.contextPath}/jsp" method="POST">
    	<div>
    		<p id="btn"><button type="submit">Add Diagnostics</button></p>
    	</div>
    </form>
    <div class="view-issued-medicines">
        <table>
            <thead>
                <tr>
                    <th>Name of the test</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>CBP</td>
                    <td>RS.2000</td>
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
                        <td>
                            <select name="testName">
                                <option value="CBP">CBP</option>
                                <option value="X-RAY">X-RAY</option>
                            </select></td>
                        <td width="38%">Amount From DB</td>
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
        <form action="${pageContext.request.contextPath}/jsp/addDiagnostic.jsp" method="POST">
            <button type="submit" id="diagnosticSubmit">Update</button>
        </form>
    </div>
</body>
</html>