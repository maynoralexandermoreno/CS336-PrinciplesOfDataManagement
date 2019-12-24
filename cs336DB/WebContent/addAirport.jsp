<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Airport Page</title>
</head>
<body>
	<%
		try{
			String airportID = request.getParameter("airportID");
			String cityName = request.getParameter("cityName");
			
			
			DBConnection db = new DBConnection();
			db.insertAirport(airportID, cityName);
			db.closeConnection();
			session.setAttribute("Successful", "true");
			out.println("Success");
		}
	
		catch (Exception e){
			out.println("Error: " + e);			
		}
	
	%>
	
	<form action="custRepMain.jsp" method="POST">
		<input type="submit" value="Go Back to Customer Rep Page"/>
	</form>
	
</body>
</html>