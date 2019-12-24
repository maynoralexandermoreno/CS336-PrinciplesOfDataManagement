<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%--
M.Alex: This just invalidates session and returns to login page
 --%>
<%

	/* This will invalidate the session (remove the credentials) and redirect back to the login page */
	session.invalidate();
	response.sendRedirect("Login.jsp");
	
%>