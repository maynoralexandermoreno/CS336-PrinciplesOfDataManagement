<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.Date,java.util.Calendar,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			int month = Integer.parseInt(request.getParameter("month")) - 1;
			int year = Integer.parseInt(request.getParameter("year"));
			
			try{
				if(month >= 0 && month <= 11){
					DBConnection db = new DBConnection();
					
					Calendar calendar = Calendar.getInstance();
					calendar.clear();
					
					calendar.set(Calendar.MONTH, month);
					calendar.set(Calendar.YEAR, year);
					Date startDate = calendar.getTime();
					
					calendar.clear();
					if(month == 12){
						calendar.set(Calendar.MONTH, 1);//Starts at Jan
						calendar.set(Calendar.YEAR, year+1);
					}
					else{
						calendar.set(Calendar.MONTH, month+1);
						calendar.set(Calendar.YEAR, year);
					}
					Date endDate = calendar.getTime();
					
					Double report = db.getSalesReport(startDate, endDate);
					
					out.print("report for " + (month + 1) + "/" + year + " is $" + report);
				}
			}catch (Exception e){
			}
		%>
		<%-- This will return user back to main page --%>
		<br/>
		<br/>
		<form action="AdminMain.jsp" method="POST">
			<input type="submit" value="Return to Admin Page"/><br/><br/>
		</form>
		
	</body>
</html>