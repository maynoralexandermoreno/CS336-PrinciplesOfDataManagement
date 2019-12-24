<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336DB.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%--
M.Alex: 

I added an addEmployee method; instead of only having an if else statement it should be if, elseif (user), elseif (employee), elseif (admin), else
Or something like that

My comments below should explain well enough how the checking works at this level; each check would follow this

Corrections: I added db.CloseConnection(); authenticate really wasn't needed at this point, since DBConnection automatically creates a connection when constructor called
 --%>
<%
	/* Gets the username and password from Login.jsp and attempt to sign in */
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	/* 	
	 *	Create a new DBConnection object with the attempted username and password 
	 *	If the connection can be successfully made, then the session will store the username
	 *	and redirect to the Main page. 
	 *	If connection fails, then redirect back to the Login page
	 *	Ideally, a message would also be returned to Login.jsp saying login failed
	 */
	try{
		if(username == "" || password == ""){
			throw new Exception();
		}
		else{
			DBConnection authenticate = new DBConnection(username, password);
			authenticate.closeConnection();
			System.out.println("Before thingy");
			DBConnection db = new DBConnection();
			System.out.println("After thingy");
			if(db.isAdmin(username) == true){
				System.out.println("Before admin");
				session.setAttribute("user", username); // the username will be stored in the session
				response.sendRedirect("AdminMain.jsp");
			}
			else if(db.isCustomerRepresentative(username) == true){
				System.out.println("Before customer rep");
				session.setAttribute("user", username); // the username will be stored in the session
				response.sendRedirect("custRepMain.jsp");
			}
			else if(db.isUser(username) == true){
				System.out.println("Before customer");
				session.setAttribute("user", username); // the username will be stored in the session
				response.sendRedirect("UserMain.jsp");
			}
			else{
				System.out.println("Welp");
				throw new Exception();
			}
		}
	}catch (Exception e){
		System.out.println("Hello");
		e.printStackTrace();
		session.setAttribute("FailedLogin", "true");
		response.sendRedirect("Login.jsp");
	}
%>