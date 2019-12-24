<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%--
M. Alex:
This adds a user into the database.

I think that this page should remain the same, and that AttemptCreateEmployee should be another jsp page.

Thoughts?

Corrections: I added db.CloseConnection();
 --%>
<%
	/* Gets the username and password from Login.jsp and attempt to sign in */
	String newUser = request.getParameter("username");
	String newPassword = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");

	/* 	
	 *	Create a new DBConnection object with the general username and password
	 *	If the connection can be successfully made, then the session will redirect to login page
	 *	If connection fails, then redirect back to the signup gae
	 *	Ideally, a message would also be returned to both pages saying if successful or not
	 */
	try{
		DBConnection db = new DBConnection();
		db.addUser(newUser, newPassword, firstName, lastName);
		db.closeConnection();
		session.setAttribute("SuccessfulSignup", "true");
		response.sendRedirect("Login.jsp");
	}catch (Exception e){
		session.setAttribute("UnsuccessfulSignup", "true");
		response.sendRedirect("Signup.jsp");
	}	
%>