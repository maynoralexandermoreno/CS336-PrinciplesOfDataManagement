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
			String custName = request.getParameter("custName");
			
			ResultSet result = db.selectTicketWhere("\"" + custName + "\"");

			out.print("For Customer Name:" + custName);
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("ticketID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Customer Name");
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
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current ticket ID:
				out.print(result.getInt("ticketID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("accountID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDouble("ticketPrice"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDouble("bookingFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDouble("cancelFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getInt("isOneWay"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDate("purchaseDateTime"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDate("travelDateTime"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("meal"));
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