<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
	<title>Patient Billing</title>
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
        <h2 class="center">Patient Billing</h2>
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
    <div class="billing-text">
        <p id="text"><strong>No.of days: </strong>7</p><p id="text"><strong>Bill for Room: </strong></p><p id="text">Rs.56000</p>
    </div>
    <div class="view-issued-medicines">
        <h2 class="center">Pharmacy Charges</h2>
        <table>
            <thead>
                <tr>
                    <th>Medicine</th>
                    <th>Qunatity</th>
                    <th>Rate</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Acebutolol</td>
                    <td>10</td>
                    <td>200</td>
                    <td>RS.2000</td>
                </tr>
                <tr class="column">
                	<td colspan="3" id="text-column"><p id="text"><strong>Bill for Pharmacy: </strong></p></td>
                	<td id="text-column"><p id="text">Rs.56000</p></td>
                </tr>
            </tbody>
        </table>
    </div>
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
                <tr>
                    <td>CBP</td>
                    <td>Rs.4000</td>
                </tr>
                <tr class="column">
                	<td id="text-column"><p id="text"><strong>Bill for Diagnostics: </strong></p></td>
                	<td id="text-column"><p id="text">Rs.10500</p></td>
                </tr>
            </tbody>
             
        </table>
    </div>
    <div class="billing-text">
        
    </div>
    <div class="form-controls-action update-medicines">
        <button type="submit">Confirm</button><p id="text">Grand Total<span id="text">Rs.71000</span></p>
    </div>
</body>
</html>