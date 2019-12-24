<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Flight Page</title>
</head>
<body>
	<%
		try{
			int flightID = Integer.parseInt(request.getParameter("flightID"));
			String airlineID = request.getParameter("airlineID");
			String attribute = request.getParameter("replace");
			String newValue = request.getParameter("updateVal");
			
			
			DBConnection db = new DBConnection();
			
			if(attribute.equals("aircraftID")){
				int intValue = Integer.parseInt(newValue);
				String u = "UPDATE Flight SET " + attribute + " = " + intValue + " WHERE flightID = " + flightID + " AND airlineID = \"" + airlineID + "\"";
				db.update(u);
			}
			else if(attribute.equals("isDomestic")){
				boolean boolValue = Boolean.parseBoolean(newValue);
				String u = "UPDATE Flight SET " + attribute + " = " + boolValue + " WHERE flightID = " + flightID + " AND airlineID = \"" + airlineID + "\"";
				db.update(u);
				
			}
			else{
				String u = "UPDATE Flight SET " + attribute + " = \"" + newValue + "\" WHERE flightID = " + flightID + " AND airlineID = \"" + airlineID + "\"";
				db.update(u);	
			}
			
			
			
			db.closeConnection();
			session.setAttribute("SuccessfulUpdate", "true");
			out.println("Success\n");
			
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