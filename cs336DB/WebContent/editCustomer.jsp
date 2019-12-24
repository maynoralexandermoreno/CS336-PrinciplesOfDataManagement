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
			String accountID =request.getParameter("accountID");			
			String column =request.getParameter("column");
			String value= request.getParameter("value");
			
			DBConnection db = new DBConnection();
			String u = "UPDATE Customer SET " + column + " = \"" + value + "\" WHERE accountID = \"" + accountID + "\"";	
			
			db.update(u);			
			db.closeConnection();
			session.setAttribute("SuccessfulUpdate", "true");
			out.println("Success\n");
			
		}
	
		catch (Exception e){
			out.println("Error: " + e);
			
		}
	
	%>
	
	<form action="AdminMain.jsp" method="POST">
		<input type="submit" value="Go Back to Admin Main Page"/>
	</form>
	
</body>
</html>