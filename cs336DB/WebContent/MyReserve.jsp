<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%-- Created By Naveenan Yogeswaran --%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>My Reservations</title>
	</head>
	<body>
		<br>Welcome to your Reservations<br/>
		
		<br>Upcoming Flights<br/>
		<%
		try{
			
			//Get the database connection
			DBConnection db = new DBConnection();
			String user = (String) session.getAttribute("user");
			
			//Run the query against the database.
			ResultSet result = db.selectUpcomingFlights(user);
			if(result.next()){
				//Reset result to first row
				result.beforeFirst();
				
				//Make an HTML table to show the results in:
				out.print("<table cellspacing=15>");
	
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Ticket ID");
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
				out.print("Class");
				out.print("</td>");
				out.print("<td>");
				out.print("Seat");
				out.print("</td>");
				
				out.print("</tr>");
	
				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current ticket ID:
					out.print(result.getString("ticketID"));
					out.print("</td>");
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
					//Print out current class:
					out.print(result.getString("class"));
					out.print("</td>");
					String flightClass;
					if(result.getString("class").equals("FIRST")){
						flightClass = "firstSeats";
					}
					else if(result.getString("class").equals("BUSINESS")){
						flightClass = "buisnessSeats";
					}
					else{
						flightClass = "economySeats";
					}
					if(result.getInt("seatID") <= result.getInt(flightClass)){
						out.print("<td>");
						//Print out current seat:
						out.print(result.getInt("seatID"));
						out.print("</td>");
					}
					else{
						out.print("<td>");
						//Print out current seat:
						out.print("WAITING LIST #" + (result.getInt("seatID") - result.getInt(flightClass)));
						out.print("</td>");
					}
					out.print("<td>");
					//Create Select button
					out.print("<td>");
					out.print("<form action=\"CancelTicket.jsp\" method=\"POST\">");
					out.print("<input type=\"hidden\" id=\"ticketID\" name=\"ticketID\" value=\"" + result.getString("ticketID") + "\">");
					out.print("<input type=\"hidden\" id=\"class\" name=\"class\" value=\"" + result.getString("class") + "\">");
					out.print("<input type=\"hidden\" id=\"flightID\" name=\"flightID\" value=\"" + result.getString("flightID") + "\">");
					out.print("<input type=\"hidden\" id=\"airlineID\" name=\"airlineID\" value=\"" + result.getString("airlineID") + "\">");
					out.print("<input type=\"submit\" value=\"Select\"/>");
					out.print("</form>");
					out.print("</td>");
					out.print("</tr>");
	
				}
				out.print("</table>");
			}
			else{
				out.print("No flights were found.");
			}
			
			db.closeConnection();
		} catch (Exception e) {
			out.print("An unexpected occur while querying, please return to the main page and ensure you entered all inputs in the proper format.");
		}
		%>
		
		<br>Past Flights<br/>
		<%
		try{
			
			//Get the database connection
			DBConnection db = new DBConnection();
			String user = (String) session.getAttribute("user");
			
			//Run the query against the database.
			ResultSet result = db.selectPastFlights(user);
			if(result.next()){
				//Reset result to first row
				result.beforeFirst();
				
				//Make an HTML table to show the results in:
				out.print("<table cellspacing=15>");
	
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Ticket ID");
				//make a column
				out.print("<td>");
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
				out.print("Class");
				out.print("</td>");
				out.print("<td>");
				out.print("Seat");
				out.print("</td>");
				
				out.println("</tr>");
	
				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current ticket ID:
					out.print(result.getString("ticketID"));
					out.print("</td>");
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
					//Print out current class:
					out.print(result.getString("class"));
					out.print("</td>");
					String flightClass;
					if(result.getString("class").equals("FIRST")){
						flightClass = "firstSeats";
					}
					else if(result.getString("class").equals("BUSINESS")){
						flightClass = "buisnessSeats";
					}
					else{
						flightClass = "economySeats";
					}
					if(result.getInt("seatID") <= result.getInt(flightClass)){
						out.print("<td>");
						//Print out current seat:
						out.print(result.getInt("seatID"));
						out.print("</td>");
					}
					else{
						out.print("<td>");
						//Print out current seat:
						out.print("WAITING LIST #" + (result.getInt("seatID") - result.getInt(flightClass)));
						out.print("</td>");
					}
					out.print("<td>");
					//Create Select button
					out.print("<td>");
					out.print("</td>");
					out.print("</tr>");
	
				}
				out.print("</table>");
			}
			else{
				out.print("No flights were found.");
			}
			
			db.closeConnection();
		} catch (Exception e) {
			out.print("An unexpected occur while querying, please return to the main page and ensure you entered all inputs in the proper format.");
		}
		%>
		
		<%-- This will return user back to main page --%>
		<form action="UserMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>