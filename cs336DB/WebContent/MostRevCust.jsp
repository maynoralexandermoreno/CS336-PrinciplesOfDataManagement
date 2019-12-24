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
			;
			
			ResultSet rev = db.getMostRevCust();
			rev.next();
			
			out.print("Customer: " + rev.getString("accountID") + " produced the most revenue: $" + rev.getDouble(2));
			
			
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
</body>
</html>