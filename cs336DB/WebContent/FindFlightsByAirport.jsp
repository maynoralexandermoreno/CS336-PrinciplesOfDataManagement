<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		try{
			
			//Get the database connection
			DBConnection db = new DBConnection();
			
			String airportName = request.getParameter("airportName");
			
			ResultSet result = db.selectFlightWhere("departureAirport",airportName);
			
			out.print("The Flights from " + airportName + ":");
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("airlineID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("flightID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("aircraftID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("isDomestic");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("departureAirport");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("departureDateTime");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("arrivalAirport");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("arrivalDateTime");
			out.print("</td>");
			
			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current airline ID:
				out.print(result.getString("airlineID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current flight ID:
				out.print(result.getInt("flightID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current ticket ID:
				out.print(result.getInt("aircraftID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getInt("isDomestic"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("departureAirport"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDate("departureDateTime"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("arrivalAirport"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDate("arrivalDateTime"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");
			result.close();
		} catch (Exception e) {
		}
	%>
	<%-- This will return user back to main page --%>
		<br/>
		<br/>
		<form action="AdminMain.jsp" method="POST">
			<input type="submit" value="Return to Admin Page"/><br/><br/>
		</form>
</body>
</html>