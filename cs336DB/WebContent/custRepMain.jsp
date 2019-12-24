<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Rep Page</title>
</head>
<body>
	Welcome to the Customer Rep Page <br></br>
	<b>Make flight reservation</b>
	<form action="makeReservation.jsp" method="POST">
		Enter Customer ID: <input type="text" name="custID"/> 
		<input type="submit" value="Make reservation"/>
	</form>
	<br></br>
	
	<b>Edit Flight Reservation</b>
	<form action="EditReservation.jsp" method="POST">
		Enter Customer ID: <input type="text" name="custID" /> <br>
		<input type="submit" value="Edit reservations"/>
	</form> 
	<br></br>
	
	<b>Add Aircraft Information</b>
	<form action="addAircraft.jsp" method="POST">
		Enter Airline ID: <input type="text" name="c_airlineID"/> <br>
		Enter Aircraft ID: <input type="text" name="c_aircraftID"/> <br>
		Enter Model: <input type="text" name="model"/> <br>
		Enter First Class Seat Count: <input type="text" name="firstSeats"/> <br>
		Enter Business Class Seat Count: <input type="text" name="businessSeats"/> <br>
		Enter Economy Class Seat Count: <input type="text" name="economySeats"/> <br>
				
		<input type="submit" value="Add Info"/>
	</form>
	<br></br>
	
	<b>Add Airport Information</b>
	<form action="addAirport.jsp" method="POST">
		Enter Airport ID: <input type="text" name="airportID"/> <br>
		Enter City: <input type="text" name="cityName"/> <br>
		<input type="submit" value="Add Info"/>
	</form>
	<br></br>
	
	<b>Add Flight Information</b>
	<form action="addFlight.jsp" method="POST">
		Enter Airline ID: <input type="text" name="airlineID"/> <br>
		Enter Flight ID: <input type="text" name="flightID"/> <br>
		Enter Aircraft ID: <input type="text" name="aircraftID"/> <br>
		Enter Is Domestic: <input type="text" name="isDomestic"/> <br>
		Enter Departure Airport: <input type="text" name="departAir"/> <br>
		Enter Department Date-Time: <input type="text" placeholder="yyyy-MM-dd HH:mm:ss" name="departTime"/> <br>
		Enter Arrival Airport: <input type="text" name="arrivalAir"/> <br>
		Enter Arrival Date-Time: <input type="text" placeholder="yyyy-MM-dd HH:mm:ss" name="arrivalTime"/> <br>
		Enter Economy Class Price: <input type="text" name="eprice" /> <br>
		Enter Business Class Price: <input type="text" name="bprice" /> <br>
		Enter First Class Price: <input type="text" name="fprice" /> <br>
		<input type="submit" value="Add Info"/>
	</form>
	<br></br>
	
	<b>Edit Aircraft Information</b>
	<form action="updateAircraft.jsp" method="POST">
		Airline ID: <input type="text" name="airlineID" /> <br>
		Aircraft ID: <input type="text" name="aircraftID"/> <br>
		Attribute: <input type="text" name="replace"/> <br>
		New Value: <input type="text" name="updateVal" /> <br>
		<input type="submit" value="Edit Info"/>
	</form>
	<br></br>
	
	<b>Edit Airport Information</b>
	<form action="updateAirport.jsp" method="POST">
		Airport ID: <input type="text" name="airportID"/> <br>
		Attribute: <input type="text" name="replace"/> <br>
		New Value: <input type="text" name="updateVal" /> <br>
		<input type="submit" value="Edit Info"/>
	</form>
	<br></br>
	
	<b>Edit Flight Information</b>
	<form action="updateFlight.jsp" method="POST">
		Airline ID: <input type="text" name="airlineID"/> <br>
		Flight ID: <input type="text" name="flightID"/> <br>
		Attribute: <input type="text" name="replace"/> <br>
		New Value: <input type="text" name="updateVal" /> <br>
		<input type="submit" value="Edit Info"/>
	</form>
	<br></br>
	
	<b>Delete Aircraft Information</b>
	<form action="deleteAircraft.jsp" method="POST">
		Aircraft ID: <input type="text" name="aircraftID" /> <br>
		Airline ID: <input type="text" name="airlineID" /> <br>
		<input type="submit" value="Delete Info"/> <br>
	</form>
	<br></br>
	
	<b>Delete Airport Information</b>
	<form action="deleteAirport.jsp" method="POST">
		Airport ID: <input type="text" name="airportID" /> <br>
		<input type="submit" value="Delete Info"/> <br>
	</form>
	<br></br>
	
	<b>Delete Flight Information</b>
	<form action="deleteFlight.jsp" method="POST">
		Flight ID: <input type="text" name="flightID"/> <br>
		Airline ID: <input type="text" name="airlineID" /> <br>
		<input type="submit" value="Delete Info"/>
	</form>
	<br></br>
	
	
	<b>Get Waitlist Info</b>
	<form action="GetWaitlist.jsp" method="POST">
		Flight ID: <input type="text" name="flightID"/> <br>
		Airline ID: <input type="text" name="airlineID" /> <br>
		<input type="submit" value="Get Info"/>
	</form>
	
	<form action="Logout.jsp" method="POST">
		<br/><br/><input type="submit" value="Log Out"/><br/><br/>
	</form>
</body>
</html>