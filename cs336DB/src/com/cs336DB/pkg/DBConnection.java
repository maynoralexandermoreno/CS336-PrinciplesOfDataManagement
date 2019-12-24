package com.cs336DB.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.util.Random;

/* M.Alex: 
 * Explanation:
 * The constructor of DBConnection will create a connection object that will remain open until closeConnection() is called by the DBConnection object.
 * createConnection() will create the connection. If the connection is closed, and you need to open it again, you don't need to recreate another DBConnection object
 * 		After calling closeConnection, you can take the original object and call createConnection() and you are good to go
 * The insert methods will insert (yes, really) into the tables;
 * 		Yes, inserts may be done with null values for any value that isn't a primary or foreign key, but I can't see it being needed within this project
 * 			If it is needed, you can create a string with the custom insert parameters that you need and pass it into insert(String insertString);
 * The select statements will return a ResultSet object that you can use while(rs.next){} to get whatever values are needed
 * 		If you need a custom select statement (one not included in the methods provided), use select(String query){}; it will return a ResultSet
 * Update and Delete methods both have the same format regardless of table
 * 		If you use the predefined method, the input is the table and parameters
 * 		I also provided a method to pass directly a string with the custom command
 * IF YOU DECIDE TO PASS A CUSTOM STRING, BE PREPARED TO DEBUG YOUR STRING!
 * 
 * 	Changes made since the last DBConnection file I created:
 * I changed the order between the insert into the customer table to be after the insert into the new customer table
 * I added insert Employee
 * 		Like I said earlier, the "right" way to do privileges would be to do them in mysql.user, buuutt time restrictions cause us to just limit the functionallity
 * 		through the application level
 * I cleared out all close statements in the select statements; They were closing the ResultSet before it was returned... 
 * CLOSE NOW HAS ITS OWN METHOD
 * 		Call close() at the end of your program or whenever you are done with the database
 * Close any ResultSets when you are done using them as well e.g rs.close();
 * I added insert and select for Flight_Price
 * 
 * 
 * Changes made after 12.10
 * Added Jonathan's and Naveen's code into the file
 * 		Jonathan's code is additional functions
 * 			
 * 		Naveen's code adds additional functions and makes edits to some functions
 * I added code to search table to see if user is customer, customer rep, or admin
 * All functions added to the respective categories (INSERT, SELECT, UPDATE, DELETE, HELPER); if you need to search for your own functions search your names
 */

public class DBConnection {
	private String user;
	private String password;
	private String admin;
	private String adminPassword;
	
	/* "jdbc:mysql://[url of host]:[port number]/[database][properties]" */
	private String url = "jdbc:mysql://cs336db.ct13jztniefj.us-east-2.rds.amazonaws.com:3306/TravelReservations?autoReconnect=true&useSSL=false";
	private Connection dbConnection;
	private java.text.SimpleDateFormat mysqlDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/* Using this constructor is for inserting new customers */
	public DBConnection() throws Exception {
		this.user = "group20";
		this.password = "password";
		try {
			this.createConnection();
		} catch (Exception e) {
			throw e;
		}
	}
	
	/* Using this constructor is for accessing the database with any username and password */
	public DBConnection(String username, String password) throws Exception{ 
		this.user = username; 
		this.password = password;
		try {
			this.createConnection();
		} catch (Exception e) {
			throw e;
		}
	}
	
	/*  Uses the url, username, password to create a connection to the database */
	public void createConnection() throws Exception {
		try {
			if(this.user == "" || this.password == "") {
				throw new Exception("EMPTY USERNAME OR PASSWORD");
			}
			Class.forName("com.mysql.jdbc.Driver");
			this.dbConnection = DriverManager.getConnection(this.url, this.user, this.password);		
		} catch(Exception e) {
			throw e;
		}
	}
	
	/* Closes the Connection object */
	public void closeConnection() throws Exception{
		try {
			this.dbConnection.close();
		} catch (Exception e){
			throw e;
		}
	}
	
	/* Done to check if the user and password are correct; Only should use in the login page */
	public void authenticate() throws Exception{
		try {
			this.createConnection();
			this.dbConnection.close();
		}catch (Exception e) {
			throw e;		
		}
	}
	
	public Connection getConnection() {
		return this.dbConnection;
	}
	
/* Adds new users (Customers or Employees) */
	public void addUser(String newUser, String newPassword, String firstName, String lastName) throws Exception {
		try {
			String addUser = "CREATE USER ? IDENTIFIED BY ?";
			String grantUserRights = "GRANT SELECT, UPDATE, INSERT, DELETE ON TravelReservations.* TO ?";
			
			PreparedStatement addingUser = dbConnection.prepareStatement(addUser);
			addingUser.setString(1, newUser);
			addingUser.setString(2, newPassword);
			addingUser.executeUpdate();
			addingUser.close();
			
			PreparedStatement grantUser = dbConnection.prepareStatement(grantUserRights);
			grantUser.setString(1, newUser);
			grantUser.executeUpdate();
			grantUser.close();		
			
			this.insertCustomer(newUser, firstName, lastName);
		}catch (Exception e) {
			
			throw e;
		}
	}

	public void addEmployee(String newUser, String newPassword, Boolean isAdmin, String firstName, String lastName) throws Exception {
		try {	

			String addUser = "CREATE USER ? IDENTIFIED BY ?";
			String grantUserRights = "GRANT SELECT, UPDATE, INSERT, DELETE ON TravelReservations.* TO ?";
	
			PreparedStatement addingUser = dbConnection.prepareStatement(addUser);
			addingUser.setString(1, newUser);
			addingUser.setString(2, newPassword);
			addingUser.executeUpdate();
			addingUser.close();
		
			PreparedStatement grantUser = dbConnection.prepareStatement(grantUserRights);
			grantUser.setString(1, newUser);
			grantUser.executeUpdate();
			grantUser.close();
			
			this.insertEmployee(newUser, isAdmin, firstName, lastName);	
		
		}catch (Exception e) {
			throw e;
		}
	}
	
/* All inserts */
	
	public void insert(String insertString) throws Exception{
		try {
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertString);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
	public void insertAirline(String airlineID) throws Exception {
		try {
			
			String insertAirline = "INSERT INTO Airline (airlineID) VALUES (?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertAirline);
			addRow.setString(1, airlineID);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			
			throw e;
		}
	}
	
	public void insertAirport(String airportID, String city) throws Exception {
		try {
			
			String insertAirport = "INSERT INTO Airport (airportID, city) VALUES (?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertAirport);
			addRow.setString(1, airportID);
			addRow.setString(2, city);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			
			throw e;
		}
	}
	
	public void insertAirline_Airport(String airlineID, String airportID) throws Exception {
		try {

			String insertAirline_Airport = "INSERT INTO Airline_Airport (airlineId, airportID) VALUES (?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertAirline_Airport);
			addRow.setString(1, airlineID);
			addRow.setString(2, airportID);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
	
	public void insertAircraft(String airlineID, int aircraftID, String model, int firstSeats, int buisnessSeats, int economySeats ) throws Exception {
		try {
			
			String insertAircraft = "INSERT INTO Aircraft (airlineID, aircraftID, model, firstSeats, buisnessSeats, economySeats) VALUES (?,?,?,?,?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertAircraft);
			addRow.setString(1, airlineID);
			addRow.setInt(2, aircraftID);
			addRow.setString(3, model);
			addRow.setInt(4, firstSeats);
			addRow.setInt(5, buisnessSeats);
			addRow.setInt(6, economySeats);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			
			throw e;
		}
	}
	
	public void insertCustomer(String accountID, String firstName, String lastName) throws Exception {
		try {

			String insertCustomer = "INSERT INTO Customer (accountID, firstName, LastName) VALUES (?,?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertCustomer);
			addRow.setString(1, accountID);
			addRow.setString(2, firstName);
			addRow.setString(3, lastName);
			addRow.executeUpdate();
			addRow.close();

		}catch (Exception e) {
			
			throw e;
		}
	}
	
	public void insertEmployee(String employeeID, boolean isAdmin, String firstName, String lastName) throws Exception{
		try {
	
			String insertEmployee = "INSERT INTO Employee (employeeID, isAdmin, firstName, lastName) VALUES (?,?,?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertEmployee);
			addRow.setString(1, employeeID);
			addRow.setBoolean(2, isAdmin);
			addRow.setString(3, firstName);
			addRow.setString(4, lastName );
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			
			throw e;
		}
	}
	
	public void insertFlight(String airlineID, int flightID, int aircraftID, boolean isDomestic, String departureAirport, Date departureDateTime, String arrivalAirport, Date arrivalDateTime) throws Exception {
		try {
	
			String departureDateTimeString = this.mysqlDateFormat.format(departureDateTime);
			String arrivalDateTimeString = this.mysqlDateFormat.format(arrivalDateTime);
			
			String insertFlight = "INSERT INTO Flight (airlineID, flightID, aircraftID, isDomestic, departureAirport, departureDateTime, arrivalAirport, arrivalDateTime) VALUES (?,?,?,?,?,?,?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertFlight);
			addRow.setString(1, airlineID);
			addRow.setInt(2, flightID);
			addRow.setInt(3, aircraftID);
			addRow.setBoolean(4, isDomestic);
			addRow.setString(5, departureAirport);
			addRow.setString(6, departureDateTimeString);
			addRow.setString(7, arrivalAirport);
			addRow.setString(8, arrivalDateTimeString);
			addRow.executeUpdate();	
			addRow.close();

		}catch (Exception e) {
			
			throw e;
		}
	}
	
	public void insertFlight_Days(String airlineID, int flightID, String flightDay) throws Exception {
		try {
		
			String insertFlight_Days = "INSERT INTO Flight_Days (airlineID, flightID, flightDay) VALUES (?,?,?)";
			
			PreparedStatement addRow = dbConnection.prepareStatement(insertFlight_Days);
			addRow.setString(1, airlineID);
			addRow.setInt(2, flightID);
			addRow.setString(3, flightDay);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			
			throw e;
		}
	}
	
//	public void insertTicket(String accountID, double ticketPrice, double bookingFee, double cancelFee, boolean isOneWay, Date travelDateTime, String meal) throws Exception {
//		try {
//
//			String travelDateTimeString = this.mysqlDateFormat.format(travelDateTime);
//			Date purchaseDateTime = new Date();
//			
//			String purchaseDateTimeString = this.mysqlDateFormat.format(purchaseDateTime);
//			String insertTicket = "INSERT INTO Ticket (accountID, ticketPrice, bookingFee, cancelFee, isOneWay, purchaseDateTime, travelDateTime, meal) VALUES (?,?,?,?,?,?,?,?)";
//			
//			PreparedStatement addRow = dbConnection.prepareStatement(insertTicket);
//			addRow.setString(1, accountID);
//			addRow.setDouble(2, ticketPrice);
//			addRow.setDouble(3, bookingFee);
//			addRow.setDouble(4, cancelFee);
//			addRow.setBoolean(5, isOneWay);
//			addRow.setString(6, purchaseDateTimeString);
//			addRow.setString(7, travelDateTimeString);
//			addRow.setString(8, meal);
//			addRow.executeUpdate();
//			addRow.close();
//
//		}catch (Exception e) {
//			
//			throw e;
//		}
//	}
//	
//	public void insertTicket(int ticketID, String accountID, double ticketPrice, double bookingFee, double cancelFee, boolean isOneWay, Date travelDateTime, String meal) throws Exception {
//		try {
//
//			String travelDateTimeString = this.mysqlDateFormat.format(travelDateTime);
//			Date purchaseDateTime = new Date();
//			
//			String purchaseDateTimeString = this.mysqlDateFormat.format(purchaseDateTime);
//			String insertTicket = "INSERT INTO Ticket (ticketID, accountID, ticketPrice, bookingFee, cancelFee, isOneWay, purchaseDateTime, travelDateTime, meal) VALUES (?,?,?,?,?,?,?,?,?)";
//			
//			PreparedStatement addRow = dbConnection.prepareStatement(insertTicket);
//			addRow.setInt(1, ticketID);
//			addRow.setString(2, accountID);
//			addRow.setDouble(3, ticketPrice);
//			addRow.setDouble(4, bookingFee);
//			addRow.setDouble(5, cancelFee);
//			addRow.setBoolean(6, isOneWay);
//			addRow.setString(7, purchaseDateTimeString);
//			addRow.setString(8, travelDateTimeString);
//			addRow.setString(9, meal);
//			addRow.executeUpdate();
//			addRow.close();
//
//		}catch (Exception e) {
//			
//			throw e;
//		}
//	}
	
	//Naveenan Yogeswaran: Adjusted method
    public int insertTicket(String accountID, double ticketPrice, double bookingFee, double cancelFee, int isOneWay, String travelDateTime, String meal) throws Exception {
   	 Random rand = new Random();
   	 int ticketID = rand.nextInt(1000000000);
   	 try {

   		 //String travelDateTimeString = this.mysqlDateFormat.format(travelDateTime);
   		 Date purchaseDateTime = new Date();
   		 
   		 String purchaseDateTimeString = this.mysqlDateFormat.format(purchaseDateTime);
   		 
   		 
   		 String insertTicket = "INSERT INTO Ticket (ticketID, accountID, ticketPrice, bookingFee, cancelFee, isOneWay, purchaseDateTime, travelDateTime, meal) VALUES (?,?,?,?,?,?,?,?,?)";
   		 
   		 PreparedStatement addRow = dbConnection.prepareStatement(insertTicket);
   		 addRow.setInt(1, ticketID);
   		 addRow.setString(2, accountID);
   		 addRow.setDouble(3, ticketPrice);
   		 addRow.setDouble(4, bookingFee);
   		 addRow.setDouble(5, cancelFee);
   		 addRow.setInt(6, isOneWay);
   		 addRow.setString(7, purchaseDateTimeString);
   		 addRow.setString(8, travelDateTime);
   		 addRow.setString(9, meal);
   		 addRow.executeUpdate();
   		 addRow.close();
   		 
   	 }catch (Exception e) {
   		 throw e;
   	 }
   	 return ticketID;
    }

	
	public void insertFlight_Ticket(int ticketID, String airlineID, int flightID, int seatID, String flightClass) throws Exception{
		try {

			String insertFlight_TicketString = "INSERT INTO Flight_Ticket (ticketID, airlineID, flightID, seatID, class) VALUES (?,?,?,?,?)";
			PreparedStatement addRow = dbConnection.prepareStatement(insertFlight_TicketString);
			addRow.setInt(1, ticketID);
			addRow.setString(2, airlineID);
			addRow.setInt(3, flightID);
			addRow.setInt(4, seatID);
			addRow.setString(5, flightClass);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
	
	public void insertFlight_Price(String airlineID, int flightID, double firstPrice, double businessPrice, double economyPrice ) throws Exception{
		try {

			String insert = "INSERT INTO Flight_Price (airlineID, flightID, firstPrice, businessPrice, economyPrice) VALUES (?,?,?,?,?)";
			PreparedStatement addRow = dbConnection.prepareStatement(insert);
			addRow.setString(1, airlineID);
			addRow.setInt(2, flightID);
			addRow.setDouble(3, firstPrice);
			addRow.setDouble(4, businessPrice);
			addRow.setDouble(5, economyPrice);
			addRow.executeUpdate();
			addRow.close();
			
		}catch (Exception e) {
			throw e;
		}
	}

/* SELECT STATEMENTS */
	public ResultSet select(String query) throws Exception{
		try{

			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}	
	}
	
	public ResultSet selectAirline() throws Exception{
		try {

			String query = "SELECT * FROM Airline";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectAircraft() throws Exception{
		try {

			String query = "SELECT * FROM Aircraft";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectAirport() throws Exception{
		try {
			
			String query = "SELECT * FROM Airport";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectAirline_Airport() throws Exception{
		try {
			
			String query = "SELECT * FROM Airline_Airport";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectCustomer() throws Exception{
		try {
			
			String query = "SELECT * FROM Customer";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
		
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectEmployee() throws Exception{
		try {
			
			String query = "SELECT * FROM Employee";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();

			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectFlight() throws Exception {
		try {
			
			String query = "SELECT * FROM Flight";
			PreparedStatement selectFlight = dbConnection.prepareStatement(query);
			ResultSet returnset = selectFlight.executeQuery();
			
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightOrderBy(String orderByColumn, boolean ascending) throws Exception{
		String query = "SELECT * FROM Flight ORDER BY " + orderByColumn + " ASC";
		if(ascending == false) {
			query = "SELECT * FROM Flight ORDER BY " + orderByColumn + " DESC";
		}
		
		try {
			
			PreparedStatement selectFlightOrderBy = dbConnection.prepareStatement(query);
			ResultSet returnset = selectFlightOrderBy.executeQuery();
			
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightWhere(String whereClause, String condition) throws Exception{
		
		try {
			
			String query = "SELECT * FROM Flight WHERE " + whereClause + " = ?";
			PreparedStatement selectFlightWhere = dbConnection.prepareStatement(query);
			selectFlightWhere.setString(1, condition);
			ResultSet returnset = selectFlightWhere.executeQuery();
			
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightWhereOrderBy(String whereClause, String equals, String orderByColumn, boolean ascending) throws Exception{
		String updown =  "ASC";
		if(ascending == false) {
			updown = "DESC";
		}
		
		try {
			
			String query = "SELECT * FROM Flight WHERE " + whereClause + " = ? ORDER BY " + orderByColumn + " " + updown;
			PreparedStatement selectFlightWhereOrderBy = dbConnection.prepareStatement(query);
			selectFlightWhereOrderBy.setString(1, equals);
			ResultSet returnset = selectFlightWhereOrderBy.executeQuery();
			
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightFlexible(Date expectedDepartureDate, Date expectedArrivalDate) throws Exception{
		Calendar lowerBoundDepartureCalendar = Calendar.getInstance();
		Calendar upperBoundDepartureCalendar = Calendar.getInstance();
		
		Calendar lowerBoundArrivalCalendar = Calendar.getInstance();
		Calendar upperBoundArrivalCalendar = Calendar.getInstance();
		
		lowerBoundDepartureCalendar.setTime(expectedDepartureDate);
		upperBoundDepartureCalendar.setTime(expectedDepartureDate);
		
		lowerBoundArrivalCalendar.setTime(expectedArrivalDate);
		upperBoundArrivalCalendar.setTime(expectedArrivalDate);
		
		lowerBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		lowerBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		Timestamp lowerBoundDepartureDate = new Timestamp(lowerBoundDepartureCalendar.getTime().getTime());
		Timestamp upperBoundDepartureDate = new Timestamp(upperBoundDepartureCalendar.getTime().getTime());
		
		Timestamp lowerBoundArrivalDate = new Timestamp(lowerBoundArrivalCalendar.getTime().getTime());
		Timestamp upperBoundArrivalDate = new Timestamp(upperBoundArrivalCalendar.getTime().getTime());
		
		try {
			
			String query = "SELECT * FROM Flight WHERE departureDateTime >= ? AND departureDateTime <= ? AND arrivalDateTime >= ? AND arrivalDateTime <= ?";
			PreparedStatement selectFlightFlexible = dbConnection.prepareStatement(query);
			selectFlightFlexible.setTimestamp(1, lowerBoundDepartureDate);
			selectFlightFlexible.setTimestamp(2, upperBoundDepartureDate);
			selectFlightFlexible.setTimestamp(3, lowerBoundArrivalDate);
			selectFlightFlexible.setTimestamp(4, upperBoundArrivalDate);
			ResultSet returnset = selectFlightFlexible.executeQuery();
			
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightFlexibleOrderBy(Date expectedDepartureDate, Date expectedArrivalDate, String orderByColumn, boolean ascending) throws Exception{
		String updown =  "ASC";
		if(ascending == false) {
			updown = "DESC";
		}
		
		Calendar lowerBoundDepartureCalendar = Calendar.getInstance();
		Calendar upperBoundDepartureCalendar = Calendar.getInstance();
		
		Calendar lowerBoundArrivalCalendar = Calendar.getInstance();
		Calendar upperBoundArrivalCalendar = Calendar.getInstance();
		
		lowerBoundDepartureCalendar.setTime(expectedDepartureDate);
		upperBoundDepartureCalendar.setTime(expectedDepartureDate);
		
		lowerBoundArrivalCalendar.setTime(expectedArrivalDate);
		upperBoundArrivalCalendar.setTime(expectedArrivalDate);
		
		lowerBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		lowerBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		Timestamp lowerBoundDepartureDate = new Timestamp(lowerBoundDepartureCalendar.getTime().getTime());
		Timestamp upperBoundDepartureDate = new Timestamp(upperBoundDepartureCalendar.getTime().getTime());
		
		Timestamp lowerBoundArrivalDate = new Timestamp(lowerBoundArrivalCalendar.getTime().getTime());
		Timestamp upperBoundArrivalDate = new Timestamp(upperBoundArrivalCalendar.getTime().getTime());
		
		try {
			
			String query = "SELECT * FROM Flight WHERE departureDateTime >= ? AND departureDateTime <= ? AND arrivalDateTime >= ? AND arrivalDateTime <= ? ORDER BY " + orderByColumn + " " + updown;
			PreparedStatement selectFlightFlexibleOrderBy = dbConnection.prepareStatement(query);
			selectFlightFlexibleOrderBy.setTimestamp(1, lowerBoundDepartureDate);
			selectFlightFlexibleOrderBy.setTimestamp(2, upperBoundDepartureDate);
			selectFlightFlexibleOrderBy.setTimestamp(3, lowerBoundArrivalDate);
			selectFlightFlexibleOrderBy.setTimestamp(4, upperBoundArrivalDate);
			ResultSet returnset = selectFlightFlexibleOrderBy.executeQuery();
			
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightFlexibleWhere(Date expectedDepartureDate, Date expectedArrivalDate, String whereClause, String condition) throws Exception{
		Calendar lowerBoundDepartureCalendar = Calendar.getInstance();
		Calendar upperBoundDepartureCalendar = Calendar.getInstance();
		
		Calendar lowerBoundArrivalCalendar = Calendar.getInstance();
		Calendar upperBoundArrivalCalendar = Calendar.getInstance();
		
		lowerBoundDepartureCalendar.setTime(expectedDepartureDate);
		upperBoundDepartureCalendar.setTime(expectedDepartureDate);
		
		lowerBoundArrivalCalendar.setTime(expectedArrivalDate);
		upperBoundArrivalCalendar.setTime(expectedArrivalDate);
		
		lowerBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		lowerBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		Timestamp lowerBoundDepartureDate = new Timestamp(lowerBoundDepartureCalendar.getTime().getTime());
		Timestamp upperBoundDepartureDate = new Timestamp(upperBoundDepartureCalendar.getTime().getTime());
		
		Timestamp lowerBoundArrivalDate = new Timestamp(lowerBoundArrivalCalendar.getTime().getTime());
		Timestamp upperBoundArrivalDate = new Timestamp(upperBoundArrivalCalendar.getTime().getTime());
		
		try {
			
			String query = "SELECT * FROM Flight WHERE departureDateTime >= ? AND departureDateTime <= ? AND arrivalDateTime >= ? AND arrivalDateTime <= ? AND " + whereClause + " = ?";
			PreparedStatement selectFlightFlexibleWhere = dbConnection.prepareStatement(query);
			selectFlightFlexibleWhere.setTimestamp(1, lowerBoundDepartureDate);
			selectFlightFlexibleWhere.setTimestamp(2, upperBoundDepartureDate);
			selectFlightFlexibleWhere.setTimestamp(3, lowerBoundArrivalDate);
			selectFlightFlexibleWhere.setTimestamp(4, upperBoundArrivalDate);
			selectFlightFlexibleWhere.setString(5, condition);
			ResultSet returnset = selectFlightFlexibleWhere.executeQuery();

			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	public ResultSet selectFlightFlexibleWhereOrderBy(Date expectedDepartureDate, Date expectedArrivalDate, String whereClause, String condition, String orderByColumn, boolean ascending) throws Exception{
		String updown =  "ASC";
		if(ascending == false) {
			updown = "DESC";
		}
		
		Calendar lowerBoundDepartureCalendar = Calendar.getInstance();
		Calendar upperBoundDepartureCalendar = Calendar.getInstance();
		
		Calendar lowerBoundArrivalCalendar = Calendar.getInstance();
		Calendar upperBoundArrivalCalendar = Calendar.getInstance();
		
		lowerBoundDepartureCalendar.setTime(expectedDepartureDate);
		upperBoundDepartureCalendar.setTime(expectedDepartureDate);
		
		lowerBoundArrivalCalendar.setTime(expectedArrivalDate);
		upperBoundArrivalCalendar.setTime(expectedArrivalDate);
		
		lowerBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundDepartureCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		lowerBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, -4);
		upperBoundArrivalCalendar.add(Calendar.DAY_OF_MONTH, 4);
		
		Timestamp lowerBoundDepartureDate = new Timestamp(lowerBoundDepartureCalendar.getTime().getTime());
		Timestamp upperBoundDepartureDate = new Timestamp(upperBoundDepartureCalendar.getTime().getTime());
		
		Timestamp lowerBoundArrivalDate = new Timestamp(lowerBoundArrivalCalendar.getTime().getTime());
		Timestamp upperBoundArrivalDate = new Timestamp(upperBoundArrivalCalendar.getTime().getTime());
		
		try {
			
			String query = "SELECT * FROM Flight WHERE departureDateTime >= ? AND departureDateTime <= ? AND arrivalDateTime >= ? AND arrivalDateTime <= ? AND " + whereClause + " = ? ORDER BY " + orderByColumn + " " + updown;
			PreparedStatement selectFlightFlexibleWhereOrderBy = dbConnection.prepareStatement(query);
			selectFlightFlexibleWhereOrderBy.setTimestamp(1, lowerBoundDepartureDate);
			selectFlightFlexibleWhereOrderBy.setTimestamp(2, upperBoundDepartureDate);
			selectFlightFlexibleWhereOrderBy.setTimestamp(3, lowerBoundArrivalDate);
			selectFlightFlexibleWhereOrderBy.setTimestamp(4, upperBoundArrivalDate);
			selectFlightFlexibleWhereOrderBy.setString(5, condition);
			ResultSet returnset = selectFlightFlexibleWhereOrderBy.executeQuery();
	
			return returnset;
		}catch (Exception e){
			throw e;
		}
	}
	
	//Naveenan Yogeswaran: Created this method to find a specific flight and its prices using its primary key
    public ResultSet selectFlightSpecific(String airlineID, String flightID) throws Exception{
   	 try {
   		 String query = "SELECT Flight.airlineID, Flight.flightID, Flight.aircraftID, Flight.departureAirport, Flight.departureDateTime, Flight.arrivalAirport, Flight.arrivalDateTime, Flight_Price.economyPrice, Flight_Price.businessPrice, Flight_Price.firstPrice " +
   						 "FROM Flight " +
   						 "INNER JOIN Flight_Price " +
   						 "ON Flight.airlineID = Flight_Price.airlineID AND Flight.flightID = Flight_Price.flightID " +
   						 "WHERE Flight.airlineID = \"" + airlineID + "\" AND Flight.flightID = " + flightID;
   		 PreparedStatement stmt = dbConnection.prepareStatement(query);
   		 ResultSet result = stmt.executeQuery();
   		 
   		 return result;
   	 }catch(Exception e) {
   		 throw e;
   	 }
    }

		
	//Naveenan Yogeswaran: Created this method because the queries got complicated
    public ResultSet selectFlightUser(String departure, String arrival, String date, String flexibility, String isOneWay, String airline, String lowerPrice, String upperPrice, String sort) throws Exception{
   	 try {
   		 
   		 //Make initial SELECT query
   		 String query = "SELECT Flight.airlineID, Flight.flightID, Flight.aircraftID, Flight.departureAirport, Flight.departureDateTime, Flight.arrivalAirport, Flight.arrivalDateTime, Flight_Price.economyPrice, Flight_Price.businessPrice, Flight_Price.firstPrice " +
   						 "FROM Flight " +
   						 "INNER JOIN Flight_Price " +
   						 "ON Flight.airlineID = Flight_Price.airlineID AND Flight.flightID = Flight_Price.flightID " +
   						 "WHERE Flight.departureAirport = \"" + departure + "\" AND Flight.arrivalAirport = \"" + arrival + "\"";

   		 //Build Query
   		 //Looks to see if user is flexible by +-3 days
   		 if(flexibility.equals("0")){
   			 query = query + " AND DATE(departureDateTime) = \'" + date + "\'";
   		 }
   		 else if(flexibility.equals("1")){
   			 query = query + " AND (departureDateTime >= (SELECT DATE_SUB(\'" + date + "\', INTERVAL 3 day)) AND departureDateTime <= (SELECT DATE_ADD(\'" + date + "\', INTERVAL 3 day)))";
   		 }
   		 //Looks for whether user wanted One way or Round trip flight
   		 if(isOneWay.equals("0")){
   			 query = query + " AND EXISTS( SELECT * FROM Flight WHERE departureAirport = \"" + arrival + "\" AND arrivalAirport = \"" + departure + "\" AND DATE(departureDateTime) > \'" + date + "\')";
   		 }
   		 //Looks for whether user wanted a specific airline
   		 if(!airline.equals("None")){
   			 query = query + " AND Flight.airlineID = \"" + airline + "\"";
   		 }
   		 //Looks for lower price range
   		 if(!lowerPrice.equals("")){
   			 query = query + " AND Flight_Price.economyPrice >= " + lowerPrice;
   		 }
   		 if(!upperPrice.equals("")){
   			 query = query + " AND Flight_Price.economyPrice <= " + upperPrice;
   		 }
   		 
   		 //Looks for the sorting order of the list
   		 if(sort.equals("1")){
   			 query = query + " ORDER BY economyPrice ASC";
   		 }
   		 else if(sort.equals("2")){
   			 query = query + " ORDER BY economyPrice DESC";
   		 }
   		 else if(sort.equals("3")){
   			 query = query + " ORDER BY departureDateTime ASC";
   		 }
   		 else if(sort.equals("4")){
   			 query = query + " ORDER BY departureDateTime DESC";
   		 }
   		 else if(sort.equals("5")){
   			 query = query + " ORDER BY arrivalDateTime ASC";
   		 }
   		 else if(sort.equals("6")){
   			 query = query + " ORDER BY arrivalDateTime DESC";
   		 }
   		 
   		 PreparedStatement stmt = this.dbConnection.prepareStatement(query);
   		 ResultSet result = stmt.executeQuery();
   		 
   		 return result;
   	 } catch(Exception e) {
   		 throw e;
   	 }
   		 
    }
	
	//Naveenan Yogeswaran: Created This Method for Round Trips
    public ResultSet selectFlightUserRound(String departure, String arrival, String date, String flexibility, String isOneWay, String airline, String lowerPrice, String upperPrice, String sort) throws Exception{
   	 try {
   		 
   		 //Make initial SELECT query
   		 String query = "SELECT * " +
   						 "FROM Flight f1, Flight f2, Flight_Price p1, Flight_Price p2 " +
   						 "WHERE f1.airlineID = p1.airlineID AND f1.flightID = p1.flightID AND f2.airlineID = p2.airlineID AND f2.flightID = p2.flightID "
   							 + "AND f1.departureAirport = \"" + departure + "\" AND f1.arrivalAirport = \"" + arrival + "\" "
   							 + "AND f2.departureAirport = \"" + arrival + "\" AND f2.arrivalAirport = \"" + departure + "\" "
   							 + "AND f1.arrivalDateTime < f2.departureDateTime";

   		 
   		 //Build Query
   		 //Looks to see if user is flexible by +-3 days
   		 if(flexibility.equals("0")){
   			 query = query + " AND DATE(f1.departureDateTime) = \'" + date + "\'";
   		 }
   		 else if(flexibility.equals("1")){
   			 query = query + " AND (f1.departureDateTime >= (SELECT DATE_SUB(\'" + date + "\', INTERVAL 3 day)) AND f1.departureDateTime <= (SELECT DATE_ADD(\'" + date + "\', INTERVAL 3 day)))";
   		 }
   		 //Looks for whether user wanted a specific airline
   		 if(!airline.equals("None")){
   			 query = query + " AND f1.airlineID = \"" + airline + "\" AND f2.airlineID = \"" + airline + "\"";
   		 }
   		 //Looks for lower price range
   		 if(!lowerPrice.equals("")){
   			 query = query + " AND (p1.economyPrice + p2.economyPrice) >= " + lowerPrice;
   		 }
   		 if(!upperPrice.equals("")){
   			 query = query + " AND (p1.economyPrice + p2.economyPrice) <= " + upperPrice;
   		 }
   		 
   		 //Looks for the sorting order of the list
   		 if(sort.equals("1")){
   			 query = query + " ORDER BY (p1.economyPrice + p2.economyPrice) ASC";
   		 }
   		 else if(sort.equals("2")){
   			 query = query + " ORDER BY (p1.economyPrice + p2.economyPrice) DESC";
   		 }
   		 else if(sort.equals("3")){
   			 query = query + " ORDER BY f1.departureDateTime ASC";
   		 }
   		 else if(sort.equals("4")){
   			 query = query + " ORDER BY f1.departureDateTime DESC";
   		 }
   		 else if(sort.equals("5")){
   			 query = query + " ORDER BY f1.arrivalDateTime ASC";
   		 }
   		 else if(sort.equals("6")){
   			 query = query + " ORDER BY f1.arrivalDateTime DESC";
   		 }
   		 
   		 PreparedStatement stmt = this.dbConnection.prepareStatement(query);
   		 ResultSet result = stmt.executeQuery();
   		 
   		 return result;
   	 } catch(Exception e) {
   		 throw e;
   	 }
   		 
    }

	
	//Naveenan Yogeswaran: Created this method to view all flights belonging to user
    public ResultSet selectUpcomingFlights(String user) throws Exception{
   	 try {
   		 
   		 String query = "SELECT * FROM Flight, Flight_Ticket, Ticket, Aircraft "
   					 + "WHERE Flight.flightID = Flight_Ticket.flightID AND Flight.airlineID = Flight_Ticket.airlineID "
   					 + "AND Flight_Ticket.ticketID = Ticket.ticketID "
   					 + "AND Flight.aircraftID = Aircraft.aircraftID "
   					 + "AND Ticket.accountID = \"" + user + "\" AND Flight.departureDateTime >= NOW()";
   		 PreparedStatement selectFlight = dbConnection.prepareStatement(query);
   		 ResultSet returnset = selectFlight.executeQuery();
   		 
   		 return returnset;
   	 }catch (Exception e){
   		 throw e;
   	 }
    }


	//Naveenan Yogeswaran: Created this method to view all flights belonging to user
  	 public ResultSet selectPastFlights(String user) throws Exception{
  		 try {
  			 
  			 String query = "SELECT * FROM Flight "
  						 + "INNER JOIN Flight_Ticket "
  						 + "ON Flight.flightID = Flight_Ticket.flightID AND Flight.airlineID = Flight_Ticket.airlineID "
  						 + "INNER JOIN Ticket ON Flight_Ticket.ticketID = Ticket.ticketID "
  						 + "WHERE Ticket.accountID = \"" + user + "\" AND Flight.departureDateTime < NOW()";
  			 PreparedStatement selectFlight = dbConnection.prepareStatement(query);
  			 ResultSet returnset = selectFlight.executeQuery();
  			 
  			 return returnset;
  		 }catch (Exception e){
  			 throw e;
  		 }
  	 }

	//Naveenan Yogeswaran: Created This Method
    public ResultSet selectFlightByTicket(String ticketID) throws Exception {
   	 try {
   		 
   		 String query = "SELECT * FROM Flight, Flight_Ticket, Ticket "
   				 + "WHERE Flight.airlineID = Flight_Ticket.airlineID AND Flight.flightID = Flight_Ticket.flightID "
   				 + "AND Flight_Ticket.ticketID = Ticket.ticketID";
   		 PreparedStatement selectFlight = dbConnection.prepareStatement(query);
   		 ResultSet returnset = selectFlight.executeQuery();
   		 
   		 return returnset;
   	 }catch (Exception e){
   		 throw e;
   	 }
    }

	
	public ResultSet selectFlight_Days() throws Exception{
		try {
			
			String query = "SELECT * FROM Flight_Days";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectTicket() throws Exception{
		try{
			
			String query = "SELECT * FROM Ticket";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectTicketWhere(String accountID) throws Exception{
		try{
			
			String query = "SELECT * FROM Ticket WHERE accountID = " + accountID;
			PreparedStatement selectTicket = dbConnection.prepareStatement(query);
			ResultSet returnset = selectTicket.executeQuery();
			
			return returnset;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectTicketWhere(String accountID, String whereClause, String inequality, String condition) throws Exception{
		try{
			
			String query = "SELECT * FROM Ticket WHERE accountID = " + accountID + " AND "  + whereClause + " " + inequality + " " + condition;
			PreparedStatement selectTicketWhere = dbConnection.prepareStatement(query);
			ResultSet returnset = selectTicketWhere.executeQuery();
			
			return returnset;
		}catch (Exception e) {
			throw e;
		}
	}
	
	//Added by Jonathan
	public ResultSet selectTicketWithTicketID(int TicketID) throws Exception{
		try{
			
			String query = "SELECT * FROM Ticket WHERE ticketID = " + TicketID;
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public ResultSet selectFlight_Ticket() throws Exception {
		try {
			
			String query = "SELECT * FROM Flight_Ticket";
			PreparedStatement selectFlight_Ticket = dbConnection.prepareStatement(query);
			ResultSet returnset = selectFlight_Ticket.executeQuery();
			
			return returnset;
		}catch (Exception e) {
			throw e;
		}
	}
	
	//Added by Jonathan
	public ResultSet selectFlight_TicketWithWhere(String where) throws Exception {
		try {
			
			String query = "SELECT * FROM Flight_Ticket " + where;
			PreparedStatement selectFlight_Ticket = dbConnection.prepareStatement(query);
			ResultSet returnset = selectFlight_Ticket.executeQuery();
			
			return returnset;
		}catch (Exception e) {
			throw e;
		}
	}
	
	//Naveenan Yogeswaran: Created this method
    public ResultSet selectFlight_TicketSpecific(String airlineID, String flightID, String ticketID) throws Exception {
    	try {
   		 
    		String query = "SELECT * FROM Flight_Ticket WHERE airlineID = \"" + airlineID + "\" AND flightID = " + flightID + " AND ticketID = " + ticketID;
    		PreparedStatement selectFlight_Ticket = dbConnection.prepareStatement(query);
    		ResultSet returnset = selectFlight_Ticket.executeQuery();
   		 
    		return returnset;
   	 	}catch (Exception e) {
   	 		throw e;
   	 	}
    }
	
	public ResultSet selectFlight_Price() throws Exception {
		try {
			
			String query = "SELECT * FROM Flight_Price";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet returnset = select.executeQuery();
			
			return returnset;
		}catch (Exception e) {
			throw e;
		}
	}
	
/* Update methods */
	public void update(String table, String column, String newValue, String whereClause) throws Exception {
		try {
			String query = "UPDATE " + table + " SET " + column + " = " + newValue + " WHERE " + whereClause;
			PreparedStatement update = dbConnection.prepareStatement(query);
			update.executeUpdate();
			update.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
	
	public void update(String query) throws Exception {
		try {
			PreparedStatement update = dbConnection.prepareStatement(query);
			update.executeUpdate();
			update.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
/* Delete method*/
	public void delete(String table, String whereClause) throws Exception {
		try {
			
			String query = "DELETE FROM " + table + " WHERE " + whereClause;
			PreparedStatement delete = dbConnection.prepareStatement(query);
			delete.executeUpdate();
			delete.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
	
	public void delete(String query) throws Exception{
		try {
			
			PreparedStatement delete = dbConnection.prepareStatement(query);
			delete.executeUpdate();
			delete.close();
			
		}catch (Exception e) {
			throw e;
		}
	}
	

/* Helper Methods */
	
/* Method that gets the seat number */	
	
//	public int getNextSeatNumber(String airlineID, int flightID, String flightClass) throws Exception {
//		try {
//			
//			String findMaxSeat = "SELECT airlineID, flightID, max(seatID) FROM Flight_Ticket GROUP BY airlineID, flightID";
//			PreparedStatement getCurrSeat = dbConnection.prepareStatement(findMaxSeat);
//			ResultSet rs = getCurrSeat.executeQuery(findMaxSeat);
//			int returnint = 1;
//			while(rs.next()) {
//				if(rs.getString(1) == airlineID && rs.getInt(2) == flightID) {
//					returnint = rs.getInt(3) + 1;
//					break;
//				}
//			}
//			return returnint;
//		}catch (Exception e) {
//			throw e;
//		}
//	}
	
	//Naveenan Yogeswaran: Adjusted this method
    public int getNextSeatNumber(String airlineID, int flightID, String flightClass) throws Exception {
   	 	try {
   	 		//String findMaxSeat = "SELECT max(seatID) AS seat FROM Flight_Ticket WHERE airlineID = \"UA\" AND flightID = 666 AND class = \"FIRST CLASS\"";
   	 		String findMaxSeat = "SELECT max(seatID) AS seat FROM Flight_Ticket WHERE airlineID = \"" + airlineID + "\" AND flightID = " + flightID + " AND class = \"" + flightClass + "\"";
   	 		PreparedStatement getCurrSeat = dbConnection.prepareStatement(findMaxSeat);
   	 		ResultSet rs = getCurrSeat.executeQuery();
   	 		rs.next();
   	 		return rs.getInt("seat") + 1;
   	 	}catch (Exception e) {
   	 		throw e;
   	 	}
    }

/* Sales Report */
	public double getSalesReport(Date startDate, Date endDate) throws Exception {
		try {
			double report = 0.0;
			
			Timestamp reportStart = new Timestamp(startDate.getTime());
			Timestamp reportEnd = new Timestamp(endDate.getTime());
			
			String query = "SELECT bookingFee FROM Ticket WHERE purchaseDateTime >= ? AND purchaseDateTime <= ?";
			PreparedStatement select = dbConnection.prepareStatement(query);
			select.setTimestamp(1, reportStart);
			select.setTimestamp(2, reportEnd);

			ResultSet rs = select.executeQuery();
			
			while(rs.next()) {
				report = report + rs.getDouble(1);
			}
			rs.close();
			select.close();
			
			return report;
		}catch (Exception e) {
			throw e;
		}
	}
	
	public double getSalesReport(Date startDate, Date endDate, String whereCondition) throws Exception {
		try {
			double report = 0.0;
			
			Timestamp reportStart = new Timestamp(startDate.getTime());
			Timestamp reportEnd = new Timestamp(endDate.getTime());
			
			String query = "SELECT bookingFee FROM Ticket WHERE purchaseDateTime >= ? AND purchaseDateTime <= ? AND " + whereCondition;
			PreparedStatement select = dbConnection.prepareStatement(query);
			select.setTimestamp(1, reportStart);
			select.setTimestamp(2, reportEnd);

			ResultSet rs = select.executeQuery();
			
			while(rs.next()) {
				report = report + rs.getDouble(1);
			}
			rs.close();
			select.close();
			
			return report;
		}catch (Exception e) {
			throw e;
		}
	}
	
	//Added by Jonathan
	public Double getRevenueFromFlight(String flightID, String airlineID) throws Exception {
		try {
			String query = "SELECT t.ticketPrice FROM Ticket t, Flight_Ticket ft WHERE t.ticketID = ft.ticketID AND flightID = \"" + flightID + "\" AND airlineID = \"" + airlineID + "\"";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			double revenue = 0;
			
			while(rs.next()) {
				revenue = revenue + rs.getDouble(1);
			}
			
			return revenue;
		}catch (Exception e) {
			throw e;
		}	
	}
	
	//Added by Jonathan
	public Double getRevenueFromAirline(String airlineID) throws Exception {
		try {
			String query = "SELECT t.ticketPrice FROM Ticket t, Flight_Ticket ft WHERE t.ticketID = ft.ticketID AND airlineID = \"" + airlineID + "\"";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			double revenue = 0;
			
			while(rs.next()) {
				revenue = revenue + rs.getDouble(1);
			}
			
			return revenue;
		}catch (Exception e) {
			throw e;
		}	
	}
	
	//Added by Jonathan
	public Double getRevenueFromCustomer(String customer) throws Exception {
		try {
			String query = "SELECT ticketPrice FROM Ticket WHERE accountID = \"" + customer + "\"";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			double revenue = 0;
			
			while(rs.next()) {
				revenue = revenue + rs.getDouble(1);
			}
			
			return revenue;
		}catch (Exception e) {
			throw e;
		}
	}

	//Added by Jonathan
	public ResultSet getMostRevCust() throws Exception {
		try {
			String query = "SELECT c.accountID, MAX(sum) FROM (SELECT accountID, SUM(ticketPrice) AS sum FROM Ticket GROUP BY accountID) maxAccount JOIN Customer c on maxAccount.accountID = c.AccountID";
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
			
		}catch (Exception e) {
			throw e;
		}
	}	
	
	//Added by Jonathan
	public ResultSet getMostActiveFlights(int limit) throws Exception {
		try {
			String query = "SELECT flightID, airlineID, num FROM (SELECT flightID, airlineID, COUNT(*) as num FROM Flight_Ticket ft GROUP BY flightID, airlineID) c ORDER BY num desc LIMIT " + limit;
			PreparedStatement select = dbConnection.prepareStatement(query);
			ResultSet rs = select.executeQuery();
			
			return rs;
			
		}catch (Exception e) {
			throw e;
		}
	}
	
	//Naveenan Yogeswaran: Created this method
    public int getCapacity(String airlineID, int flightID, String flightClass) throws Exception{
    	String seats;
    	if(flightClass.equals("FIRST")) {
    		seats = "firstSeats";
    	}
    	else if(flightClass.equals("BUSINESS")) {
    		seats = "buisnessSeats";
    	}
    	else {
    		seats = "economySeats";
    	}
    	try {
    		String query = "SELECT * "
    				+ "FROM Aircraft "
    				+ "INNER JOIN Flight "
    				+ "ON Aircraft.aircraftID = Flight.aircraftID "
    				+ "WHERE Flight.flightID = " + flightID + " AND Flight.airlineID = \"" + airlineID + "\"";
    		PreparedStatement aircraft = dbConnection.prepareStatement(query);
    		ResultSet rs = aircraft.executeQuery();
    		rs.next();
    		return rs.getInt(seats);
   	 	}catch(Exception e) {
   	 		throw e;
   	 	}
    }

	
	public boolean isUser(String user) throws Exception {
		try {
			ResultSet rs = this.selectCustomer();
			while(rs.next() != false) {
				if(rs.getString(1).equals(user)) {
					//rs.close();
					return true;
				}
				else {
					System.out.println(rs.getString(1) + " vs " + user);
					System.out.println("Nope isUser");
				}
			}
			rs.close();
			return false;
		}catch (Exception e){
			throw e;
		}
	}
	
	public boolean isCustomerRepresentative(String user) throws Exception{
		try {
			ResultSet rs = this.selectEmployee();
			while(rs.next() != false) {
				if(rs.getString(1).equals(user) && rs.getBoolean(2) == false) {
					rs.close();
					return true;
				}
				else {
					System.out.println(rs.getString(1) + " vs " + user);
					System.out.println("Nope isCustomerrep");
				}
			}
			rs.close();
			return false;
		}catch (Exception e){
			throw e;
		}
	}
	
	public boolean isAdmin(String user) throws Exception{
		try {
			ResultSet rs = this.selectEmployee();
			while(rs.next() != false) {
				if(rs.getString(1).equals(user) && rs.getBoolean(2) == true) {
					rs.close();
					return true;
				}
				else {
					System.out.println(rs.getString(1) + " vs " + user);
					System.out.println("Nope isCustomerrep");
				}
			}
			rs.close();
			return false;
		}catch (Exception e){
			throw e;
		}
	}
	
	//Naveenan Yogeswaran: Created this method
	public  ResultSet getWaitlist(String airlineID, int flightID, String flightClass) throws Exception{
   	 try {
   		 int capacity = getCapacity(airlineID, flightID, flightClass);
   		 String query = "SELECT * "
   					 + "FROM Ticket, Flight_Ticket "
   					 + "WHERE Flight_Ticket.ticketID = Ticket.ticketID "
   					 + "AND Flight_Ticket.flightID = " + flightID
   					 + " AND Flight_Ticket.airlineID = \"" + airlineID + "\" "
   					 + "AND Flight_Ticket.class = \"" + flightClass + "\" "
   					 + "AND Flight_Ticket.seatID > " + capacity;
   		 PreparedStatement list = dbConnection.prepareStatement(query);
   		 ResultSet rs = list.executeQuery();
   		 return rs;
   	 }catch(Exception e) {
   		 e.printStackTrace();
   		 throw e;
   	 }
	}

	
}
