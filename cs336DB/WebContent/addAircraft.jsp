<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Aircraft Page</title>
</head>
<body>
	<%
		try{
			String airlineID = request.getParameter("c_airlineID");
			int aircraftID = Integer.parseInt(request.getParameter("c_aircraftID"));
			String model = request.getParameter("model");
			int firstSeats = Integer.parseInt(request.getParameter("firstSeats"));
			int businessSeats = Integer.parseInt(request.getParameter("businessSeats"));
			int economySeats = Integer.parseInt(request.getParameter("economySeats"));
			
			
			DBConnection db = new DBConnection();
			db.insertAircraft(airlineID, aircraftID, model, firstSeats, businessSeats, economySeats);
			db.closeConnection();
			session.setAttribute("Successful", "true");
			out.println("Success\n");
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