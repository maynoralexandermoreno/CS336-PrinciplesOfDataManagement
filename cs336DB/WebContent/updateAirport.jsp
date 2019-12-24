<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Airport Page</title>
</head>
<body>
	<%
		try{
			String airportID = request.getParameter("airportID");
			String attribute = request.getParameter("replace");
			String newValue = request.getParameter("updateVal");
			
			
			DBConnection db = new DBConnection();
			String u = "UPDATE Airport SET " + attribute + " = \"" + newValue + "\" WHERE airportID = \"" + airportID + "\"";
			db.update(u);
			
			db.closeConnection();
			session.setAttribute("SuccessfulUpdate", "true");
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