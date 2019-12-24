<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%-- 
M. Alex:
The Login page will take in the username and password within the textboxes
When the button for Login is pressed, it will pass on the values in the textboxes to AttemptLogin.jsp to try to sign in

The second button will go to Signup.jsp

There are attributes called "FailedLogin" and "SuccessfulSignup" that are being passed between the pages in order to display error messages

Please let me know if there are any changes made on this level 
--%>
<!DOCTYPE html>
<html>
   <head>
      <title>Group 20 Login</title>
   </head>
   <body>
   	   PLEASE LOGIN: <br/><br/>
   	   
   	 <%-- This is the button that will attempt a login --%>
     <form action="AttemptLogin.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password: <input type="password" name="password"/><br/><br/>
       <input type="submit" value="Submit"/>
     </form>
     
     <%-- This is the button that will take user to the signup page --%>
     <form action="Signup.jsp" method="POST">
     	<input type="submit" value="Create Account"/><br/><br/>
     </form>
     
	<%-- If a previous attempt was bad, it will come back here and display a message --%>
 <%
 	if((session.getAttribute("FailedLogin") == "true")){
 %>
 		<p style="color:red">LOGIN FAILED</p>
 		<br/>
 		
 		<% session.setAttribute("FailedLogin", "false"); %>
 <%}
 	if((session.getAttribute("SuccessfulSignup") == "true")){
 %>
		<p style="color:blue">SIGNUP SUCCESSFUL; PLEASE LOG IN
		</p>
		<br/>
		
		<% session.setAttribute("SuccessfulSignup", "false"); %>
 <%}
 %>
   </body>
</html>