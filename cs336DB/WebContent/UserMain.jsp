<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<%-- Created By Naveenan Yogeswaran --%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Main Page</title>
	</head>
	<body>
		<font size="17">Welcome <%=session.getAttribute("user")%> </font><br></br>
		<font size="5">View your current reservations here</font>
		<%-- This is the button that will take user to their reservation list --%>
     	<form action="MyReserve.jsp" method="POST">
     		<input type="submit" value="View My Reservations"/>
     	</form>
     	<br></br>
     	
		<font size="5">You may search available flights below</font>
		<form action="UserQuery.jsp" method="POST">
				<%
					//Get the database connection
					DBConnection db = new DBConnection();	
					//Run the query against the database.
					ResultSet result = db.selectAirport();
				%>
				
			<br>Select Your Departure Airport</br>
			<select name="departure_airport" size=1>
				<%
					while(result.next()){ 
				%>
						<option value=<%= result.getString("airportID") %>> <%= result.getString("airportID")%> </option>
				<% 	} %>
			</select>
			
			<br>Select Your Arrival Airport</br>
			<select name="arrival_airport" size=1>
				<%
					result = db.selectAirport();
					while(result.next()){ 
				%>
						<option value=<%= result.getString("airportID") %>> <%= result.getString("airportID")%> </option>
				<% 	} %>
			</select>
			
			<br>Enter Departure Date in Following Format: YYYY-MM-DD<br/>
			<input type="text" name="date"/>
			
			<br><br/>
			
			<br>Are you searching for a One Way Flight or a Round Trip Flight?<br/>
			<select name="isOneWay" size=1>
				<option value="1">One Way</option>
				<option value="0">Round Trip</option>
			</select> 
			<br>Are you flexible by +-3 days?<br/>
			<select name="flexibility" size=1>
				<option value="0">No</option>
				<option value="1">Yes</option>
			</select>
			
			<br><br/>
			
			<br>How would you like to sort by?<br/>
			<select name="sort" size=1>
				<option value="0">None</option>
				<option value="1">Price (Lowest to Highest)</option>
				<option value="2">Price (Highest to Lowest)</option>
				<option value="3">Take-off Time (Early to Late)</option>
				<option value="4">Take-off Time (Late to Early)</option>
				<option value="5">Landing Time (Early to Late)</option>
				<option value="6">Landing Time (Late to Early)</option>
			</select> 
			
			<br><br/>
			
			<br>Price Range?<br/>
			<input type="text" name = "lowerPrice"> to <input type="text" name="upperPrice">
			
			<br>Would you like a specific airline?<br/>
			<select name="airline" size=1>
				<option value="None">None</option>
				<%
					result = db.selectAirline();
					while(result.next()){ 
				%>
						<option value=<%= result.getString("airlineID") %>> <%= result.getString("airlineID")%> </option>
				<% 	} db.closeConnection();%>
			</select>
			
			<br><br/>
			
       		<br><input type="submit" value="Submit"/><br/>
     	</form>
     	
     	<form action="Logout.jsp" method="POST">
			<br/><br/><input type="submit" value="Log Out"/><br/><br/>
		</form>
	</body>
</html>