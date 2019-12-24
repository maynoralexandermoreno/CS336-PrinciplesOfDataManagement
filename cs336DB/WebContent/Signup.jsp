<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%--
M. Alex:
This will take in input from the textboxes and pass them to AttemptCreateUser.jsp
This is just like Login.jsp
If unsuccessful, there is the attribute "UnsuccessfulSignup" that is set to either true or false depending on if successful

I Think this page is done. Thoughts?
 --%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
		<title>Group 20 Signup</title>
	</head>
	
	<body>
		CREATE NEW ACCOUNT:<br/><br/>
		
		<%-- This will attempt to create a user; will return here if not successful --%>
		<%-- Ideally, once the first attempt is made  --%>
		<form action="AttemptCreateUser.jsp" method="POST">
			Username: <input type="text" name="username"/><br/>
			Password: <input type="password" name="password"/><br/>
			First Name: <input type="text" name="firstName"/><br/>
			Last Name: <input type="text" name="lastName"/><br/>
			<br/>
			
			<input type="submit" value="Create New Account"/>
		</form>
		
		<%-- This will return user back to login page (without creating user) --%>
		<form action="Login.jsp" method="POST">
			<input type="submit" value="Return to Login Page"/><br/><br/>
		</form>
<%
 	if((session.getAttribute("UnsuccessfulSignup") == "true")){
 %>
		<p style="color:red">SIGNUP FAILED: TRY ANOTHER USERNAME</p>
 		<br/>
		<% session.setAttribute("UnsuccessfulSignup", "false"); %>
 <%}
 %>			
	</body>
</html>