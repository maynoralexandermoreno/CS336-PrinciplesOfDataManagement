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
			
			//Create a SQL statement
			String flightNum = request.getParameter("flightNum");
			String airlineNum = request.getParameter("airlineNum");
			
			//Make a SELECT query
			String q = "WHERE airlineID = \"" + airlineNum + "\" AND flightID = \"" + flightNum + "\"";
			//Run the query against the database.
			ResultSet result = db.selectFlight_TicketWithWhere(q);

			out.print("For flight number:" + flightNum + " and airline number:" + airlineNum);
			
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
			out.print("ticketID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("accountID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("ticketPrice");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("bookingFee");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("cancelFee");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("isOneWay");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("purchaseDateTime");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("travelDateTime");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("meal");
			out.print("</td>");
			
			//parse out the results
			while (result.next()) {
				ResultSet ticketResult = db.selectTicketWithTicketID(result.getInt("ticketID"));
				if(ticketResult == null){
					continue;
				}
				ticketResult.next();
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
				out.print(result.getInt("ticketID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getString("accountID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getDouble("ticketPrice"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getDouble("bookingFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getDouble("cancelFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getInt("isOneWay"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getDate("purchaseDateTime"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getDate("travelDateTime"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(ticketResult.getString("meal"));
				out.print("</td>");
				
				out.print("</tr>");
				ticketResult.close();

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