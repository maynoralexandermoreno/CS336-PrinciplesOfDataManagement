<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%-- Created By Naveenan Yogeswaran --%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Cancel Ticket</title>
	</head>
	<body>
		<%
			if(request.getParameter("class").equals("ECONOMY")){
				out.print("You will be require to pay the cancel fee. Are you sure?");
				out.print("<form action=\"EconomyCancel.jsp\" method=\"POST\">");
				out.print("<input type=\"submit\" value=\"Pay\"/><br/><br/>");
				out.print("<input type=\"hidden\" id=\"ticketID\" name=\"ticketID\" value=\"" + request.getParameter("ticketID") + "\">");
				out.print("<input type=\"hidden\" id=\"class\" name=\"class\" value=\"" + request.getParameter("class") + "\">");
				out.print("<input type=\"hidden\" id=\"flightID\" name=\"flightID\" value=\"" + request.getParameter("flightID") + "\">");
				out.print("<input type=\"hidden\" id=\"airlineID\" name=\"airlineID\" value=\"" + request.getParameter("airlineID") + "\">");
				out.print("</form>");
			}
			else{
				DBConnection db = new DBConnection();
				ResultSet result = db.selectFlight_TicketSpecific(request.getParameter("airlineID"), request.getParameter("flightID"), request.getParameter("ticketID"));
				//if(result.getInt("isOneWay") == 1){
					result.next();
					int seat = result.getInt("seatID");
					String airlineID = result.getString("airlineID");
					int flightID = result.getInt("flightID");
					String flightClass = result.getString("class");
					int capacity = db.getCapacity(airlineID, flightID, flightClass);
					String query = "UPDATE Flight_Ticket SET seatID = " + seat + " WHERE airlineID = \"" + result.getString("airlineID") +  "\" AND flightID = " + result.getInt("flightID") + " AND seatID = " + (capacity + 1);
					db.update(query);
					query = "UPDATE Flight_Ticket SET seatID = seatID-1 WHERE airlineID = \"" + result.getString("airlineID") +  "\" AND flightID = " + result.getInt("flightID") + " AND seatID > " + capacity;
					db.update(query);
				//}
				db.delete("Flight_Ticket", "ticketID = " + request.getParameter("ticketID"));
				db.delete("Ticket", "ticketID = " + request.getParameter("ticketID"));
				out.print("Successfully removed ticket #" + request.getParameter("ticketID"));
				db.closeConnection();
			}
		%>
		
		<%-- This will return user back to main page --%>
		<form action="UserMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>