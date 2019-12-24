<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Purchase Screen</title>
	</head>
	<body>
		<%
			try{
				String user = request.getParameter("custID");
				String airlineID = request.getParameter("airlineID");
				String flightID = request.getParameter("flightID");
				
				DBConnection db = new DBConnection();
				ResultSet result = db.selectFlightSpecific(airlineID, flightID);
				result.next();
				
				int seat = Integer.parseInt(request.getParameter("seatID"));
				String flightClass = request.getParameter("class");
				double price = Double.parseDouble(request.getParameter("price"));
				double bookingFee = Double.parseDouble(request.getParameter("bookingFee"));
				double cancelFee = Double.parseDouble(request.getParameter("cancelFee"));
				int isOneWay = Integer.parseInt(request.getParameter("isOneWay"));
				String departureDate = result.getString("departureDateTime");
				String meal = request.getParameter("meal");
				
				int ticketID = db.insertTicket(user, price, bookingFee, cancelFee, isOneWay, departureDate, meal); 
				db.insertFlight_Ticket(ticketID, airlineID, Integer.parseInt(flightID), seat, flightClass);
				if(isOneWay == 0){
					String airlineID2 = request.getParameter("airlineID2");
					String flightID2 = request.getParameter("flightID2");
					int seat2 = Integer.parseInt(request.getParameter("seatID2"));
					db.insertFlight_Ticket(ticketID, airlineID2, Integer.parseInt(flightID2), seat2, flightClass);
				}
				db.closeConnection();
				out.print("<br>Thank you for your purchase! You may look at your tickets under View My Reservations<br/>");
				
			}catch(Exception e){
				throw e;
				
			}
		%>
		
		<%-- This will return user back to the main page--%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>