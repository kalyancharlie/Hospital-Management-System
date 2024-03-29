<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<title>Login</title>
</head>
<body>
    <% session.invalidate(); %>
    <div class="heading">
        <h1>ABC Hospital Management System</h1>
    </div>
    <%
    	String msg = (String)request.getAttribute("msg");
    	if(msg == null) {
    		msg = "";
    	}
    %>
    <div class="login-form">
        <form action="${pageContext.request.contextPath}/Controller" name="login" method="POST" onsubmit="return validateLogin()">
            <div class="form">
                <div class="form-labels">
                    <label for="username">Username</label>
                    <label for="password">Password</label>                    
                </div>
                <div class="form-all-inputs">
                	<input type="text" name="option" value="login" hidden="true">
                    <input type="text" placeholder="Enter username" id="username" name="username" autofocus required><br/>
                    <input type="password" placeholder="******" id="password" name="password" required>
                </div>
                <p id="message"><%= msg %></p>
                <div class="form-controls">
                    <input type="submit" value="Login" title="Click here to login">
                    <input type="reset" value="Reset" title="Click here to reset form">
                </div>
            </div>
        </form>
    </div>
</body>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</html>