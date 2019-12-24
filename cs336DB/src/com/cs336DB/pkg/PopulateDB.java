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

public class PopulateDB {
	private static boolean isTrue = true;
	private static boolean isFalse = false;
	
	public static void main(String[] args) {
			
		try {
			DBConnection db = new DBConnection();	
//			db.addUser("Sally", "password", "Sally", "Sanchez");
//			db.addUser("Billy", "password", "Billy", "Iranoutoflastnames");
//			
//			db.addUser("Alex", "password", "Alexis", "Gagagigo" );
//			db.addEmployee("Alex2", "password", isTrue, "Alexander", "SmityWerbermanjensen");
//			db.addEmployee("Alex3", "password", isFalse, "Alex", "Moreno");
//			
//			db.insertAirline("UA");
//			db.insertAirline("BB");
//			db.insertAirline("BO");
//			db.insertAircraft("UA", 1492, "BOEING MAX 8", 20,100,800);
//			db.insertAircraft("BB", 1111, "RAT WITH WINGS", 15, 300, 700);
//			db.insertAircraft("BO", 2222, "FAT BOI", 10, 200, 1000);
			db.insertAircraft("UA", 111, "Ratt Pack boi", 2, 0, 0);
//			
//			db.insertAirport("LAX", "LOS ANGELES");
//			db.insertAirport("TOR", "TORONTO");
//			db.insertAirport("JFK", "NEW YORK");
//			db.insertAirport("DIS", "DisneyLand");
//			db.insertAirline_Airport("UA", "LAX");
//			db.insertAirline_Airport("BB", "JFK");
//			db.insertAirline_Airport("BO", "LAX");
			Date departure = createDate(2020,1, 15, 13, 30, 00);
//			
			Date arrival = createDate(2020,1,15,20,30,00);
//			Date depart1 = createDate(2020,1,12,8,30,00);
//			Date depart2 = createDate(2020,1,13,14,00,00);
//			Date depart3 = createDate(2020,1,14,12,20,00);
//			Date depart4 = createDate(2020,1,16,11,50,00);
//			Date depart5 = createDate(2020,1,17,16,40,00);
//			Date depart6 = createDate(2020,1,18,17,10,00);
//			Date depart7 = createDate(2020,1,19,00,00,00);
//			
//			Date arrive1 = createDate(2020,1,12,13,30,00);
//			Date arrive2 = createDate(2020,1,13,19,40,00);
//			Date arrive3 = createDate(2020,1,14,17,25,00);
//			Date arrive4 = createDate(2020,1,16,16,10,00);
//			Date arrive5 = createDate(2020,1,17,21,00,00);
//			Date arrive6 = createDate(2020,1,18,22,18,00);
//			Date arrive7 = createDate(2020,1,19,22,19,30);
//			
//			db.insertFlight("UA", 666, 1492,isTrue,"LAX", departure, "JFK", arrival);
//			db.insertFlight("UA", 667, 1492,isTrue,"LAX", depart1, "JFK", arrive1);
//			db.insertFlight("UA", 668, 1492,isTrue,"LAX", depart2, "JFK", arrive2);
//			db.insertFlight("UA", 669, 1492,isTrue,"LAX", depart3, "JFK", arrive3);
//			db.insertFlight("UA", 610, 1492,isTrue,"LAX", depart4, "JFK", arrive4);
//			db.insertFlight("UA", 611, 1492,isTrue,"LAX", depart5, "JFK", arrive5);
//			db.insertFlight("UA", 612, 1492,isTrue,"LAX", depart6, "JFK", arrive6);
//			db.insertFlight("UA", 613, 1492,isTrue,"LAX", depart7, "JFK", arrive7);
//			
//			db.insertFlight("BB", 666, 1111,isTrue,"JFK", departure, "LAX", arrival);
//			db.insertFlight("BB", 667, 1111,isTrue, "JFK", depart1, "LAX", arrive1);
//			db.insertFlight("BB", 668, 1111,isTrue,"JFK", depart2, "LAX", arrive2);
//			db.insertFlight("BB", 669, 1111,isTrue,"JFK", depart3, "LAX", arrive3);
//			db.insertFlight("BB", 610, 1111,isTrue,"JFK", depart4, "LAX", arrive4);
//			db.insertFlight("BB", 611, 1111,isTrue,"JFK", depart5, "LAX", arrive5);
//			db.insertFlight("BB", 612, 1111,isTrue,"JFK", depart6, "LAX", arrive6);
//			db.insertFlight("BB", 613, 1111,isTrue,"JFK", depart7, "LAX", arrive7);
			db.insertFlight("UA", 614, 111, isTrue, "JFK", departure, "LAX", arrival);
//			
//			db.insertFlight_Days("UA", 666, "TUESDAY");
//			db.insertTicket(00001, "Sally", 150.00, 15.00, 97.00, isTrue, departure, "FISH" );
//			
//			int seat = db.getNextSeatNumber("UA", 666, "FIRST CLASS");
//			db.insertFlight_Ticket(00001,"UA",666, 10, "FIRST CLASS");
//			System.out.println("hellO!");
			/* tested each resultset individually */
//			ResultSet rs = db.selectFlight();
//			ResultSet rs = db.selectFlightOrderBy("flightID", isTrue);
//			/* if inputting a date, check the database to see what format string the date should be to compare to */
//			ResultSet rs = db.selectFlightWhere("flightID" , "666");
//			ResultSet rs = db.selectFlightWhereOrderBy("flightID", "667","airlineID" , isTrue);
//			ResultSet rs = db.selectFlightFlexible(departure, arrival);
//			ResultSet rs = db.selectFlightFlexibleOrderBy(departure, arrival, "flightID", true);
//			ResultSet rs = db.selectFlightFlexibleWhere(departure, arrival, "flightID", "669");
//			ResultSet rs = db.selectFlightFlexibleWhereOrderBy(departure, arrival, "flightID", "610", "airlineID", false);
//			while(rs.next()) {
//				//String airlineID, int flightID, int aircraftID, boolean isDomestic, String departureAirport, Date departureDateTime, String arrivalAirport, Date arrivalDateTime
//				// for some reason does not recognise isDomestic as a column name....
//				System.out.println(rs.getString("airlineID") + "\t" + rs.getInt("flightID") + "\t" + rs.getInt("aircraftID") + "\t" + rs.getBoolean("isDomestic") + "\t" + rs.getString("departureAirport") + "\t" + rs.getTimestamp("departureDateTime") + "\t" + rs.getString("arrivalAirport") + "\t" + rs.getTimestamp("arrivalDateTime") + "\n");
//			}
//			rs.close();
//			db.insertFlight_Price("UA", 666, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 667, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 668, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 669, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 610, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 611, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 612, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("UA", 613, 500.0, 200.0, 50.0);
//			
//			db.insertFlight_Price("BB", 666, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 667, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 668, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 669, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 610, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 611, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 612, 500.0, 200.0, 50.0);
//			db.insertFlight_Price("BB", 613, 500.0, 200.0, 50.0);
			db.insertFlight_Price("UA", 614, 300.0, 150.0, 1.0);
			
			db.closeConnection();
//			
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("HELP!");
		}
		
	}
	
	public static Date createDate(int year, int month, int day, int hour, int minute, int second) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month, day, hour, minute, second);
		Date r = calendar.getTime();
		return r;
	}

}
