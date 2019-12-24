<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Aircraft Page</title>
</head>
<body>
	<%
		try{
			String airlineID = request.getParameter("airlineID");
			int aircraftID = Integer.parseInt(request.getParameter("aircraftID"));
			String attribute = request.getParameter("replace");
			String newValue = request.getParameter("updateVal");
			
			
			DBConnection db = new DBConnection();
			String u = "UPDATE Aircraft SET " + attribute + " = \"" + newValue + "\" WHERE aircraftID = " + aircraftID + " AND airlineID = \"" + airlineID + "\"";
			db.update(u);
			
			db.closeConnection();
			session.setAttribute("SuccessfulUpdate", "true");
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