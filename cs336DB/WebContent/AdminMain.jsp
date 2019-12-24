<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	Welcome <%=session.getAttribute("user")%> to the Admin Page <br></br>
	Obtain Sales report
	<form action="SalesReport.jsp" method="POST">
		Month: <input type="number" name="month"/> 
		Year: <input type="number" name="year"/> <br/>
		<input type="submit" value="Search for report"/>
	</form>
	<br></br>
	Search for Reservation by Flight Number
	<form action="ReservListByFlightNum.jsp" method="POST">
		Enter Flight Number: <input type="text" name="flightNum"/> 
		Enter Airline ID: <input type="text" name="airlineNum"/> <br/>
		<input type="submit" value="Search for reservations"/>
	</form>
	Search For Reservation by Customer Name
	<form action="ReservListByCustName.jsp" method="POST">
		Enter Customer's Name: <input type="text" name="custName"/> <br/>
		<input type="submit" value="Search for reservations"/>
	</form>
	<br></br>
	Produce Revenue by flight
	<form action="RevenueByFlight.jsp" method="POST">
		Enter Flight Number: <input type="text" name="flightNum"/> 
		Enter Airline ID: <input type="text" name="airlineNum"/> <br/>
		<input type="submit" value="Produce Revenue"/>
	</form>
	Produce Revenue by Airline
	<form action="RevenueByAirline.jsp" method="POST">
		Enter Airline ID: <input type="text" name="airlineNum"/> <br/>
		<input type="submit" value="Produce Revenue"/>
	</form>
	Produce Revenue by Customer
	<form action="RevenueByCustomer.jsp" method="POST">
		Enter Customer's AccountID: <input type="text" name="accountID"/> <br/>
		<input type="submit" value="Produce Revenue"/>
	</form>
	<br></br>
	<form action="MostRevCust.jsp" method="POST">
		Find Which Customer produced the most total revenue?<input type="submit" value="Find Customer"/>
	</form>
	
	<br></br>
	
	Produce a list of most active flights
	<form action="MostActiveFlights.jsp" method="POST">
		Enter how many you want to query: <input type="number" name="limit" value="2"/> <br/>
		<input type="submit" value="Produce List"/>
	</form>
	
	<br></br>
	
	Produce a list of flights given the following airport
	<form action="FindFlightsByAirport.jsp" method="POST">
		Enter Airport: <input type="text" name="airportName"/> <br/>
		<input type="submit" value="Produce List"/>
	</form>
	<br></br>
	<b>Add Customer Information</b>
	<form action="addCustomer.jsp" method="POST">
		Enter Account ID: <input type="text" name="accountID"/> <br>
		Enter First Name: <input type="text" name="fName"/> <br>
		Enter Last Name: <input type="text" name="lName"/> <br>
		<input type="submit" value="Add Info"/>
	</form>
	<br></br>
	
	<br></br>
	<b>Delete Customer Information</b>
	<form action="deleteCustomer.jsp" method="POST">
		Enter Account ID: <input type="text" name="accountID"/> <br>
		<input type="submit" value="Delete Info"/>
	</form>
	<br></br>
	
	<br></br>
	<b>Edit Customer Information</b>
	<form action="editCustomer.jsp" method="POST">
		Enter Account ID: <input type="text" name="accountID"/> <br>
		Enter Column: <input type="text" name="column"/> <br>
		Enter New Value: <input type="text" name="value"/> <br>		
		<input type="submit" value="Edit Info"/>
		
	</form>
	<br></br>
	
	
	
	
	<b>Add Customer Representative Information</b>
	<form action="addCustomerRep.jsp" method="POST">
		Enter Employee ID: <input type="text" name="employeeID"/> <br>
		Enter First Name: <input type="text" name="fName"/> <br>
		Enter Last Name: <input type="text" name="lName"/> <br>
		Is this Employee an Admin(yes/no): <input type="text" name="isAdmin"/> <br>		
		<input type="submit" value="Add Customer Rep"/>
	</form>
	<br></br>
	
	<b>Delete Customer Representative</b>
	<form action="deleteCustomerRep.jsp" method="POST">
		Enter Employee ID: <input type="text" name="employeeID"/> <br>
		<input type="submit" value="Delete Customer Rep"/>
	</form>
	<br></br>
	
	<b>Edit Customer Representative</b>
	<form action="editCustomerRep.jsp" method="POST">
		Enter Employee ID: <input type="text" name="employeeID"/> <br>
		Enter column: <input type="text" name="column"/> <br>
		Enter value: <input type="text" name="value"/> <br>
	
		<input type="submit" value="Edit Customer Rep"/>
	</form>
	<br></br>
	<form action="Logout.jsp" method="POST">
		<br/><br/><input type="submit" value="Log Out"/><br/><br/>
	</form>
</body>
</html>