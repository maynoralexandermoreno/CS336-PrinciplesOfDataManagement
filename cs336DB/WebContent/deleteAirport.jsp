<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Aircraft Page</title>
</head>
<body>
	<%
		try{
			
			String airportID = request.getParameter("airportID");
			
			DBConnection db = new DBConnection();
			String d = "DELETE FROM Airport WHERE airportID = \"" + airportID + "\"";
			db.delete(d);
			
			db.closeConnection();
			session.setAttribute("SuccessfulDelete", "true");
			out.println("Success");
			
		}
	
		catch (Exception e){
			out.println("Error: " + e);
			
		}

	
	
	%>
	
	<form action="custRepMain.jsp" method="POST">
		<input type="submit" value="Go Back to Customer Rep Page"/>
	</form>
	
</body>
</html>