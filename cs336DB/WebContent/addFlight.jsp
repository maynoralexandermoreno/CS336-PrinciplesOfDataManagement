<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Add Flight Page</title>
</head>
<body>
	<%
		try{
			String airlineID = request.getParameter("airlineID");
			int flightID = Integer.parseInt(request.getParameter("flightID"));
			int aircraftID = Integer.parseInt(request.getParameter("aircraftID"));
			boolean isDomestic = Boolean.parseBoolean(request.getParameter("isDomestic"));
			String departAir = request.getParameter("departAir");
			String arrivalAir = request.getParameter("arrivalAir");	
			String departdt = request.getParameter("departTime");
			String arrivaldt = request.getParameter("arrivalTime");
			double bprice = Double.parseDouble(request.getParameter("bprice"));
			double eprice = Double.parseDouble(request.getParameter("eprice"));
			double fprice = Double.parseDouble(request.getParameter("fprice"));
			
			Date departTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(departdt);
			Date arrivalTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(arrivaldt);
			
			DBConnection db = new DBConnection();
			db.insertFlight(airlineID, flightID, aircraftID, isDomestic, departAir, departTime, arrivalAir, departTime);
			db.insertFlight_Price(airlineID, flightID, fprice, bprice, eprice);
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