<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%-- Created By Naveenan Yogeswaran --%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Economy Cancel</title>
	</head>
	<body>
		<%
			DBConnection db = new DBConnection();
			ResultSet result = db.selectFlight_TicketSpecific(request.getParameter("airlineID"), request.getParameter("flightID"), request.getParameter("ticketID"));
			//if(result.getInt("isOneWay") == 1){
				result.next();
				int seat = result.getInt("seatID");
				String airlineID = request.getParameter("airlineID");
				int flightID = result.getInt("flightID");
				String flightClass = result.getString("class");
				int capacity = db.getCapacity(airlineID, flightID, flightClass);
				out.print(capacity);
				String query = "UPDATE Flight_Ticket SET seatID = " + seat + " WHERE airlineID = \"" + result.getString("airlineID") +  "\" AND flightID = " + result.getInt("flightID") + " AND seatID = " + (capacity + 1);
				db.update(query);
				query = "UPDATE Flight_Ticket SET seatID = seatID-1 WHERE airlineID = \"" + result.getString("airlineID") +  "\" AND flightID = " + result.getInt("flightID") + " AND seatID > " + capacity;
				db.update(query);
			//}
			db.delete("Flight_Ticket", "ticketID = " + request.getParameter("ticketID"));
			db.delete("Ticket", "ticketID = " + request.getParameter("ticketID"));
			out.print("Successfully removed ticket #" + request.getParameter("ticketID"));
			db.closeConnection();
		%>
		
		<%-- This will return user back to main page --%>
		<form action="UserMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>