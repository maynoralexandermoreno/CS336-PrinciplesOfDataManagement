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
			boolean admin=false;
			String employeeID =request.getParameter("employeeID");
			String isAdmin= request.getParameter("isAdmin"); 
			String fName= request.getParameter("fName"); 
			String lName= request.getParameter("lName"); 
			if(isAdmin.equals("yes")){		
			admin= true;
			}			
			DBConnection db = new DBConnection();
			db.insertEmployee(employeeID,admin,fName,lName);
			
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