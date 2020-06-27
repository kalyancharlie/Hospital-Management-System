<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <link rel="stylesheet" href="../css/style.css" type="text/css">
<title>Login</title>
</head>
<body>
    <div class="heading">
        <h1>ABC Hospital Management System</h1>
    </div>
    <div class="login-form">
        <form action="/Controller" method="POST">
            <div class="form">
                <div class="form-labels">
                    <label for="username">Username</label>
                    <label for="password">Password</label>                    
                </div>
                <div class="form-inputs">
                    <input type="text" placeholder="Enter username" id="username" name="username" required><br/>
                    <input type="password" placeholder="******" id="password" name="password" required>
                    <input type="text" name="option" value="login" hidden="true">
                </div>
                <div class="form-controls">
                    <input type="submit" value="Login">
                    <input type="reset" value="Reset">
                </div>
            </div>
        </form>
    </div>
</body>
</html>