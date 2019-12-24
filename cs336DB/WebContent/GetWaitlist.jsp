<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Get Waitlist</title>
	</head>
	<body>
		<%
			try{
				DBConnection db = new DBConnection();
				
				String airlineID = request.getParameter("airlineID");
				String flightID = request.getParameter("flightID");
				
				out.print("Airline ID - " + airlineID);
				out.print(" Flight ID - " + flightID);
				
				ResultSet first = db.getWaitlist(airlineID, Integer.parseInt(flightID), "FIRST");
				ResultSet business = db.getWaitlist(airlineID, Integer.parseInt(flightID), "BUSINESS");
				ResultSet economy = db.getWaitlist(airlineID, Integer.parseInt(flightID), "ECONOMY");
				
				out.print("<br><br><b>First Class</b></br>");
				while(first.next()){
					out.print("<br>"+first.getString("Ticket.accountID") + "<br/>");
				}
				out.print("<br><b>Business Class</b><br>");
				while(business.next()){
					out.print("<br>"+business.getString("Ticket.accountID") + "<br/>");
				}
				out.print("<br><b>Economy Class</b><br/>");
				while(economy.next()){
					out.print("<br>"+economy.getString("Ticket.accountID") + "<br/>");
				}
				
				db.closeConnection();
			}catch(Exception e){
				
			}
		%>
		
		<%-- This will return user back to the main page--%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>