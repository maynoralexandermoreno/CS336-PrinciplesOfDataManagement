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
			
			int limit = Integer.parseInt(request.getParameter("limit"));
			
			ResultSet result = db.getMostActiveFlights(limit);
			
			out.print("Top " + limit + " Most Active Flights");
			
			
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
			out.print("Number of Tickets sold");
			out.print("</td>");
			
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
				out.print(result.getInt("num"));
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