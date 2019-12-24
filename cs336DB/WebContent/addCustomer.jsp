<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>
<%
try{
			String CustomerID =request.getParameter("accountID");
			String fName= request.getParameter("fName");			
			String lName= request.getParameter("lName");
			DBConnection db = new DBConnection();
			db.insertCustomer(CustomerID,fName,lName);
			db.closeConnection();
			session.setAttribute("Successful", "true");
			out.println("Success\n");
		}
	
		catch (Exception e){
			out.println("Error: " + e);
			
		}
%>
</title>
</head>
<body>
	<form action="AdminMain.jsp" method="POST">
		<input type="submit" value="Go Back to Admin Main Page"/>
	</form>

</body>
</html>