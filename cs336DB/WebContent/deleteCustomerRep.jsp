<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		try{
			
			String employeeID = request.getParameter("employeeID");
			
			DBConnection db = new DBConnection();
			String d = "DELETE FROM Employee WHERE employeeID = \"" + employeeID+ "\"";
			db.delete(d);						
			db.closeConnection();
			session.setAttribute("SuccessfulDelete", "true");
			out.println("Success\n");
			
		}
	
		catch (Exception e){
			out.println("Error: " + e);
		}

	
	
	%>
	<form action="AdminMain.jsp" method="POST">
		<input type="submit" value="Go Back to Admin Page"/>
	</form>
	
</body>
</html>