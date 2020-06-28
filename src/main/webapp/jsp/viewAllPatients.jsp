<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<title>View All Patients</title>
</head>
<body>
	<div class="heading">
        <h1>ABC Hospital Management System</h1>
        <div class="ad-functions dropdown">
            <button class="admission dropbtn"><span>Patient</span></button>
            <div class="admission-functions dropdown-content">
                <a id="link" href="#">Register Patient</a><br/>
                <a id="link" href="#">Update Patient</a><br/>
                <a id="link" href="#">Delete Patient</a><br/>
                <a id="link" href="#">Search Patient</a><br/>
                <a id="link" href="#">View All Patients</a><br/>
                <a id="link" href="#">Patient Billing</a><br/>
            </div>
        </div>
        <div class="ph-functions dropdown">
            <button class="pharmacist dropbtn"><span>Pharmacy</span></button>
            <div class="pharmacist-functions dropdown-content">
                <a id="link" href="#">Search Patient</a><br/>
                <a id="link" href="#">Issue Medicines</a><br/>
            </div>
        </div>
        <div class="di-functions dropdown">
            <button class="diagnostic dropbtn"><span>Diagnostics</span></button>
            <div class="diagnostic-functions dropdown-content">
                <a id="link" href="#">Search Patient</a><br/>
                <a id="link" href="#">Add Diagnostics</a><br/>
            </div>
        </div>
    </div>
    <div class="view-patients-form">
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
</body>
</html>