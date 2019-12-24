<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Edit Reservation</title>
	</head>
	<body>
		<%
		String meal  = request.getParameter("meal");
		String ticketID = request.getParameter("ticketID");
		String query = "UPDATE Ticket SET meal = \"" + meal + "\" WHERE ticketID = " + ticketID;
		
		DBConnection db = new DBConnection();
		db.update(query);
		db.closeConnection();
		
		out.print("Meal Successfully Changed");
		%>
		
		<%-- This will return user back to the main page--%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>