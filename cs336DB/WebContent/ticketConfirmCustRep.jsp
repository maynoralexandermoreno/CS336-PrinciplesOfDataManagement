<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%-- Created By Naveenan Yogeswaran --%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Select Ticket</title>
	</head>
	<body>
	
		<br>Below is the flight you are purchasing a ticket for<br/>
		<%
			String name = request.getParameter("custID");
			String airlineID = request.getParameter("airlineID");
			String flightID = request.getParameter("flightID");
			String airlineID2 = request.getParameter("airlineID2");
			String flightID2 = request.getParameter("flightID2");
			try{
				DBConnection db = new DBConnection();
				
				ResultSet result = db.selectFlightSpecific(airlineID, flightID);
				result.next();
				
				//Make an HTML table to show the results in:
				out.print("<table cellspacing=15>");
		
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
				out.print("Departure Airport");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Departure Time");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Arrival Airport");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Arrival Time");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Economy Price");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Business Price");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("First Class Price");
				out.print("</td>");
				out.print("</tr>");
		
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
				//Print out current aircraft ID:
				out.print(result.getInt("aircraftID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current departureAirport:
				out.print(result.getString("departureAirport"));
				out.print("</td>");
				out.print("<td>");
				//Print out current departureDateTime:
				out.print(result.getString("departureDateTime"));
				out.print("</td>");
				out.print("<td>");
				//Print out current arrivalAirport:
				out.print(result.getString("arrivalAirport"));
				out.print("</td>");
				out.print("<td>");
				//Print out current arrivalDateTime:
				out.print(result.getString("arrivalDateTime"));
				out.print("</td>");
				out.print("<td>");
				//Print out current economyPrice:
				out.print("$ " + result.getString("economyPrice") + " USD");
				out.print("</td>");
				out.print("<td>");
				//Print out current businessPrice:
				out.print("$ " + result.getString("businessPrice") + " USD");
				out.print("</td>");
				out.print("<td>");
				//Print out current firstPrice:
				out.print("$ " + result.getString("firstPrice") + " USD");
				out.print("</td>");
				
				out.print("</tr>");
				
				if(request.getParameter("isOneWay").equals("0")){
					result = db.selectFlightSpecific(airlineID2, flightID2);
					result.next();
					
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
					//Print out current aircraft ID:
					out.print(result.getInt("aircraftID"));
					out.print("</td>");
					out.print("<td>");
					//Print out current departureAirport:
					out.print(result.getString("departureAirport"));
					out.print("</td>");
					out.print("<td>");
					//Print out current departureDateTime:
					out.print(result.getString("departureDateTime"));
					out.print("</td>");
					out.print("<td>");
					//Print out current arrivalAirport:
					out.print(result.getString("arrivalAirport"));
					out.print("</td>");
					out.print("<td>");
					//Print out current arrivalDateTime:
					out.print(result.getString("arrivalDateTime"));
					out.print("</td>");
					out.print("<td>");
					//Print out current economyPrice:
					out.print("$ " + result.getString("economyPrice") + " USD");
					out.print("</td>");
					out.print("<td>");
					//Print out current businessPrice:
					out.print("$ " + result.getString("businessPrice") + " USD");
					out.print("</td>");
					out.print("<td>");
					//Print out current firstPrice:
					out.print("$ " + result.getString("firstPrice") + " USD");
					out.print("</td>");
					
					out.print("</tr>");
				}
				
				out.print("</table>");
				
				db.closeConnection();
			}catch(Exception e){
				out.print("An unexpected occur while querying, please return to the main page and ensure you entered all inputs in the proper format.");
			}
		%>
		
		<br><br/>
		
		<form action="confirmedResCustRep.jsp" method="POST">
			<input type="hidden" name="custID" value=<%=name %> />
			<br>What class ticket would you like to purchase?<br/>
			<select name="class" size=1>
				<option value="ECONOMY">Economy</option>
				<option value="BUSINESS">Business</option>
				<option value="FIRST">First</option>
			</select>
		
			<br>What meal plan?<br/>
			<select name="meal" size=1>
				<option value="Regular">Regular</option>
				<option value="Vegetarian">Vegetarian</option>
				<option value="Vegan">Vegan</option>
				<option value="Kosher">Kosher</option>
				<option value="Halal">Halal</option>
			</select>
			
			<input type="hidden" id="airlineID" name="airlineID" value=<%=airlineID%>>
			<input type="hidden" id="flightID" name="flightID" value=<%=flightID%>>
			<%
				if(request.getParameter("isOneWay").equals("0")){
					%>
						<input type="hidden" id="airlineID2" name="airlineID2" value=<%=airlineID2%>>
						<input type="hidden" id="flightID2" name="flightID2" value=<%=flightID2%>>
					<%
				}
			%>
			<input type="hidden" id="isOneWay" name="isOneWay" value=<%=request.getParameter("isOneWay")%>>
			
			<br><input type="submit" value="Submit"/><br/>
		</form>
		
		<br><br/>
		
		<%-- This will return user back to the search results--%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>