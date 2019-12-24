<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Confirm</title>
	</head>
	<body>
		<br>Below is the flight you are purchasing a ticket for<br/>
		<%
			String name = request.getParameter("custID");
			String airlineID = request.getParameter("airlineID");
			String flightID = request.getParameter("flightID");
			String airlineID2 = request.getParameter("airlineID2");
			String flightID2 = request.getParameter("flightID2");
			String flightClass = request.getParameter("class");
			int seat = 0;
			int seat2 = 0;
			int capacity = 0;
			int capacity2 = 0;
			String classPrice = "economyPrice";
			double bookingFee = 0;
			double price = 0;
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
		
		<br>Class Selected<br/>
		<br><%=flightClass %><br/>
		<br>Meal Plan Selected<br/>
		<br><%=request.getParameter("meal") %><br/>
		
		<%if(request.getParameter("isOneWay").equals("1")){%>
			<br>Seat Number<br/>
			<%
				try{
					DBConnection db = new DBConnection();
					seat = db.getNextSeatNumber(request.getParameter("airlineID"), Integer.parseInt(request.getParameter("flightID")), request.getParameter("class"));
					capacity = db.getCapacity(airlineID,Integer.parseInt(request.getParameter("flightID")), flightClass);
					if(seat <= capacity){
						out.print("<br>" + seat + "</br>");
					}
					else{
						out.print("<br> WAITING LIST #" + (seat-capacity));
					}
					db.closeConnection();
				}catch(Exception e){
					
				}
			%>
		<%}else{%>
			<br>Seat Number For Flight 1<br/>
			<%
				try{
					DBConnection db = new DBConnection();
					seat = db.getNextSeatNumber(request.getParameter("airlineID"), Integer.parseInt(request.getParameter("flightID")), request.getParameter("class"));
					capacity = db.getCapacity(airlineID, Integer.parseInt(request.getParameter("flightID")), flightClass);
					if(seat <= capacity){
						out.print("<br>" + seat + "</br>");
					}
					else{
						out.print("<br> WAITING LIST #" + (seat-capacity));
					}
					db.closeConnection();
				}catch(Exception e){
					
				}
			%>
			<br>Seat Number For Flight 2<br/>
			<%
				try{
					DBConnection db = new DBConnection();
					seat2 = db.getNextSeatNumber(request.getParameter("airlineID2"), Integer.parseInt(request.getParameter("flightID2")), request.getParameter("class"));
					capacity2 = db.getCapacity(airlineID2, Integer.parseInt(request.getParameter("flightID2")), flightClass);
					if(seat2 <= capacity2){
						out.print("<br>" + seat2 + "</br>");
					}
					else{
						out.print("<br> WAITING LIST #" + (seat2-capacity2));
					}
					db.closeConnection();
				}catch(Exception e){
					
				}
			%>
		<%} %>
		<br>Payment Info<br/>
		<table>
			<tr>
				<td>Fee</td>
				<td>Cost</td>
			</tr>
			<tr>
				<td>Ticket</td>
				<td><%
						try{
							DBConnection db = new DBConnection();
							ResultSet result = db.selectFlightSpecific(airlineID, flightID);
							result.next();
							classPrice = "economyPrice";
							if(request.getParameter("class").equals("FIRST CLASS")){
								classPrice = "firstPrice";
							}
							else if(request.getParameter("class").equals("BUSINESS CLASS")){
								classPrice = "businessPrice";
							}
							price = result.getDouble(classPrice);
							if(request.getParameter("isOneWay").equals("0")){
								result = db.selectFlightSpecific(airlineID2, flightID2);
								result.next();
								price = price + result.getDouble(classPrice);
							}
							out.print("$ " + price + " USD");
							db.closeConnection();
						}catch(Exception e){
						}
					%>
				</td>
			</tr>
			<tr>
				<td>Booking Fee</td>
				<td><% 
						try{
							DBConnection db = new DBConnection();
							ResultSet result = db.selectFlightSpecific(airlineID, flightID);
							result.next();
							classPrice = "economyPrice";
							if(request.getParameter("class").equals("FIRST CLASS")){
								classPrice = "firstPrice";
							}
							else if(request.getParameter("class").equals("BUSINESS CLASS")){
								classPrice = "businessPrice";
							}
							bookingFee = result.getDouble(classPrice)/10;
							if(request.getParameter("isOneWay").equals("0")){
								result = db.selectFlightSpecific(airlineID2, flightID2);
								result.next();
								bookingFee = bookingFee + result.getDouble(classPrice)/10;
							}
							out.print("$ " + bookingFee + " USD");
							db.closeConnection();
						}catch(Exception e){
						}
					%>
				</td>
			</tr>
			<tr>
				<td>Total Cost</td>
				<td>
					<%
						out.print("$ " + (price + bookingFee) + " USD");
					%>
				</td>
			</tr>
			
		</table>
		
		<br><br/>
		
		<%-- This will return user back to the search results--%>
		<form action="purchasedTicketCustRep.jsp" method="POST">
			<input type="hidden" id="airlineID" name="airlineID" value=<%=airlineID%>>
			<input type="hidden" id="flightID" name="flightID" value=<%=flightID%>>
			<%
				if(request.getParameter("isOneWay").equals("0")){
					%>
						<input type="hidden" id="airlineID2" name="airlineID2" value=<%=airlineID2%>>
						<input type="hidden" id="flightID2" name="flightID2" value=<%=flightID2%>>
						<input type="hidden" id="seatID2" name="seatID2" value=<%=seat2%>>
					<%
				}
			%>
			<input type="hidden" name="custID" value=<%=name %> />
			<input type="hidden" id="seatID" name="seatID" value=<%=seat%>>
			<input type="hidden" id="class" name="class" value=<%=request.getParameter("class")%>>
			<input type="hidden" id="price" name="price" value=<%=price%>>
			<input type="hidden" id="bookingFee" name="bookingFee" value=<%=bookingFee%>>
			<input type="hidden" id="cancelFee" name="cancelFee" value=<%=bookingFee%>>
			<input type="hidden" id="meal" name="meal" value=<%=request.getParameter("meal") %>>
			<input type="hidden" id="isOneWay" name="isOneWay" value=<%=request.getParameter("isOneWay")%>>
			<input type="submit" value="Pay"/><br/><br/>
		</form>
		
		<%-- This will return user back to the main page--%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>