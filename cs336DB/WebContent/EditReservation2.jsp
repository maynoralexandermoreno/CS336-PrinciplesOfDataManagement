<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Edit Reservation</title>
	</head>
	<body>
		<form action="EditReservation3.jsp" method="POST">
			Select New Meal: 
			<select name="meal" size=1>
				<option value="Regular">Regular</option>
				<option value="Vegetarian">Vegetarian</option>
				<option value="Vegan">Vegan</option>
				<option value="Kosher">Kosher</option>
				<option value="Halal">Halal</option>
			</select>
			<input type="hidden" id="ticketID" name="ticketID" value=<%=request.getParameter("ticketID")%>>
			<input type="submit" value="Change Meal"/>
		</form>
		
		<%-- This will return user back to the main page--%>
		<form action="custRepMain.jsp" method="POST">
			<input type="submit" value="Return to Main Page"/><br/><br/>
		</form>
	</body>
</html>