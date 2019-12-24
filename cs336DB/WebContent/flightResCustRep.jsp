<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Search Results</title>
	</head>
	<body>
	
	<%
		String name = request.getParameter("custID");
		if(request.getParameter("isOneWay").equals("1")){
			try{
				
				//Get the database connection
				DBConnection db = new DBConnection();
				
				String departure = request.getParameter("departure_airport");
				String arrival = request.getParameter("arrival_airport");
				String date = request.getParameter("date");
				
				//display info 
				out.print(departure + " to ");
				out.print(arrival);
				out.print(" on " + date);
				
				String flexibility = request.getParameter("flexibility");
				String isOneWay = request.getParameter("isOneWay");
				String airline = request.getParameter("airline");
				String lowerPrice = request.getParameter("lowerPrice");
				String upperPrice = request.getParameter("upperPrice");
				String sort = request.getParameter("sort");
	
				//Run the query against the database.
				ResultSet result = db.selectFlightUser(departure, arrival, date, flexibility, isOneWay, airline, lowerPrice, upperPrice, sort);
	
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
						//Create Select button
						out.print("<td>");
						out.print("<form action=\"ticketConfirmCustRep.jsp\" method=\"POST\">");
						out.print("<input type=\"hidden\" name=\"custID\" value=\"" + name + "\">");
						out.print("<input type=\"hidden\" id=\"airlineID\" name=\"airlineID\" value=\"" + result.getString("airlineID") + "\">");
						out.print("<input type=\"hidden\" id=\"flightID\" name=\"flightID\" value=\"" + result.getString("flightID") + "\">");
						out.print("<input type=\"hidden\" id=\"isOneWay\" name=\"isOneWay\" value=\"" + request.getParameter("isOneWay") + "\">");
						out.print("<input type=\"submit\" value=\"Select\"/>");
						out.print("</form>");
						out.print("</td>");
						out.print("</tr>");
		
					}
					out.print("</table>");
				}
				else{
					out.print("No flights were found with the given criteria.");
				}
				
				db.closeConnection();
	
			} catch (Exception e) {
				out.print("An unexpected occur while querying, please return to the main page and ensure you entered all inputs in the proper format.");
			}
		}
		else{
			try{
				
				//Get the database connection
				DBConnection db = new DBConnection();
				
				String departure = request.getParameter("departure_airport");
				String arrival = request.getParameter("arrival_airport");
				String date = request.getParameter("date");
				
				//display info 
				out.print(departure + " to ");
				out.print(arrival);
				out.print(" on " + date);
				
				String flexibility = request.getParameter("flexibility");
				String isOneWay = request.getParameter("isOneWay");
				String airline = request.getParameter("airline");
				String lowerPrice = request.getParameter("lowerPrice");
				String upperPrice = request.getParameter("upperPrice");
				String sort = request.getParameter("sort");
	
				//Run the query against the database.
				ResultSet result = db.selectFlightUserRound(departure, arrival, date, flexibility, isOneWay, airline, lowerPrice, upperPrice, sort);
				
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
		
					//parse out the results
					while (result.next()) {
						//make a row
						out.print("<tr>");
						//make a column
						out.print("<td>");
						//Print out current airline ID:
						out.print(result.getString("f1.airlineID"));
						out.print("</td>");
						out.print("<td>");
						//Print out current flight ID:
						out.print(result.getInt("f1.flightID"));
						out.print("</td>");
						out.print("<td>");
						//Print out current aircraft ID:
						out.print(result.getInt("f1.aircraftID"));
						out.print("</td>");
						out.print("<td>");
						//Print out current departureAirport:
						out.print(result.getString("f1.departureAirport"));
						out.print("</td>");
						out.print("<td>");
						//Print out current departureDateTime:
						out.print(result.getString("f1.departureDateTime"));
						out.print("</td>");
						out.print("<td>");
						//Print out current arrivalAirport:
						out.print(result.getString("f1.arrivalAirport"));
						out.print("</td>");
						out.print("<td>");
						//Print out current arrivalDateTime:
						out.print(result.getString("f1.arrivalDateTime"));
						out.print("</td>");
						out.print("<td>");
						//Print out current economyPrice:
						out.print("$ " + result.getString("p1.economyPrice") + " USD");
						out.print("</td>");
						out.print("<td>");
						//Print out current businessPrice:
						out.print("$ " + result.getString("p1.businessPrice") + " USD");
						out.print("</td>");
						out.print("<td>");
						//Print out current firstPrice:
						out.print("$ " + result.getString("p1.firstPrice") + " USD");
						out.print("</td>");
						//Create Select button
						out.print("<td>");
						out.print("<form action=\"ticketConfirmCustRep.jsp\" method=\"POST\">");
						out.print("<input type=\"hidden\" name=\"custID\" value=\"" + name + "\">");
						out.print("<input type=\"hidden\" id=\"airlineID\" name=\"airlineID\" value=\"" + result.getString("f1.airlineID") + "\">");
						out.print("<input type=\"hidden\" id=\"flightID\" name=\"flightID\" value=\"" + result.getString("f1.flightID") + "\">");
						out.print("<input type=\"hidden\" id=\"isOneWay\" name=\"isOneWay\" value=\"" + request.getParameter("isOneWay") + "\">");
						out.print("<input type=\"hidden\" id=\"airlineID2\" name=\"airlineID2\" value=\"" + result.getString("f2.airlineID") + "\">");
						out.print("<input type=\"hidden\" id=\"flightID2\" name=\"flightID2\" value=\"" + result.getString("f2.flightID") + "\">");
						out.print("<input type=\"submit\" value=\"Select\"/>");
						out.print("</form>");
						//make a row
						out.print("<tr>");
						//make a column
						out.print("<td>");
						//Print out current airline ID:
						out.print(result.getString("f2.airlineID"));
						out.print("</td>");
						out.print("<td>");
						//Print out current flight ID:
						out.print(result.getInt("f2.flightID"));
						out.print("</td>");
						out.print("<td>");
						//Print out current aircraft ID:
						out.print(result.getInt("f2.aircraftID"));
						out.print("</td>");
						out.print("<td>");
						//Print out current departureAirport:
						out.print(result.getString("f2.departureAirport"));
						out.print("</td>");
						out.print("<td>");
						//Print out current departureDateTime:
						out.print(result.getString("f2.departureDateTime"));
						out.print("</td>");
						out.print("<td>");
						//Print out current arrivalAirport:
						out.print(result.getString("f2.arrivalAirport"));
						out.print("</td>");
						out.print("<td>");
						//Print out current arrivalDateTime:
						out.print(result.getString("f2.arrivalDateTime"));
						out.print("</td>");
						out.print("<td>");
						//Print out current economyPrice:
						out.print("$ " + result.getString("p2.economyPrice") + " USD");
						out.print("</td>");
						out.print("<td>");
						//Print out current businessPrice:
						out.print("$ " + result.getString("p2.businessPrice") + " USD");
						out.print("</td>");
						out.print("<td>");
						//Print out current firstPrice:
						out.print("$ " + result.getString("p2.firstPrice") + " USD");
						out.print("</td>");
						//Create Select button
						out.print("<td>");
						out.print("</td>");
						out.print("</tr>");
		
					}
					out.print("</table>");
				}
				else{
					out.print("No flights were found with the given criteria.");
				}
				
				db.closeConnection();
	
			} catch (Exception e) {
				out.print("An unexpected occur while querying, please return to the main page and ensure you entered all inputs in the proper format.");
			}
		}
	%>
		<%-- This will return user back to main page --%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>