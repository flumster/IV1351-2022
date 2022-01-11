package databas;

import java.sql.*; 
import java.util.Scanner;


public class Test {
	
	public static void listInst() {
		String instrumentS = "violin";
		
		
		Scanner scannerIn = new Scanner(System.in);
		System.out.println("Vilket instrument vill du söka efter?");
		instrumentS = scannerIn.next();
		String sql = 
				"SELECT instrumentID, tillverkare, pris " +
				"FROM instrument" +
				" WHERE instrumentID NOT IN " +
				" (SELECT instrumentID " +
				" FROM instrumenthyra " +
				" WHERE (lanetid > 0) )  " +
				" AND (instrumenttyp = '" + instrumentS +"');";
		
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(  
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","Admin");  
			
			Statement stmt  = con.createStatement();
			ResultSet rs    = stmt.executeQuery(sql);
			System.out.println("instrumentID \t tillverkare \t\t pris");
	            while (rs.next()) {
	                System.out.println(rs.getString("instrumentID")
	                		+ " \t\t " + rs.getString("tillverkare")
	                		+ " \t\t " + rs.getString("pris"));
	                    
	            }
			
			
			
			
			con.close();  
			scannerIn.close();
		}catch(Exception e){ System.out.println(e);}
		System.out.println("\n");
	}
	
	public static void rentInst() {
		
		Scanner scannerIn = new Scanner(System.in);
		System.out.println("Person nummer för den hyrande eleven:");
		String personnummer = "201407062431";
		personnummer = scannerIn.next();
		System.out.println("Ange instrumentID för det instrument du vill hyra:");
		String instID = "2";

		instID = scannerIn.next();
		System.out.println("Ange dagens datum i formated YYYY-MM-DD:");
		String datum = "2021-01-09";
		
		datum = scannerIn.next();
		System.out.println("Ange dagens datum i formated YYYY-MM-DD:");
		String lanetid = "365";
		
		lanetid = scannerIn.next();
		
		if (Integer.parseInt(lanetid) > 365) {
			while (Integer.parseInt(lanetid) > 365) {
				System.out.println("För lång lånetid, var snäll ange nummer mellan 0-365 dagar:");
				lanetid = scannerIn.next();
			}
		}
		
		String sql = 
				"INSERT INTO instrumenthyra (personnummer, instrumentID, datum, lanetid) "
				+ "VALUES ('" + personnummer + "'," + instID +  ", '" + datum + "'," + lanetid + ")";
		
		String check = "SELECT COALESCE( (SELECT COUNT(*) "
				+ "FROM instrumenthyra "
				+ "WHERE lanetid != '0' AND personnummer = "+ personnummer + " "
				+ "), 0) AS antal;";
		
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(  
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","Admin");  
			
			Statement stmt  = con.createStatement();
			
			ResultSet rs    = stmt.executeQuery(check);
			rs.next();
			boolean res = true;
			int antal = (rs.getInt("antal"));
			System.out.println(antal);
			if (antal < 2) {
				   res = stmt.execute(sql);
			} else {
				System.out.println("för många hyrda instrument");
			}
			con.close();  
			scannerIn.close();
			if (res) {
				System.out.println("ingen ändring gjordes");
			}
		}catch(Exception e){ System.out.println(e);}
		System.out.println("\n");
	}
	
	
	
	public static void termRentInst() {
		String instID= "2";
		String persnummer = "201407062431";
		String datum = "2021-01-02";
		
		Scanner scannerIn = new Scanner(System.in);
		System.out.println("Ange instrument IDet på lånade instrumentet: ");
		
		instID = scannerIn.next();
		System.out.println("Ange person nummret på eleven som hyrde instrumentet: ");
		
		persnummer = scannerIn.next();
		System.out.println("Ange datumet lånet påbörjades: ");
		
		datum = scannerIn.next();
		
		String sql = 
				"UPDATE instrumenthyra " +
				" SET lanetid = 0 " + 
				" WHERE (instrumentID = " + instID + ") AND (personnummer="+ persnummer + 
						") AND (datum = '" + datum + "');";
		
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(  
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","Admin");  
			
			Statement stmt  = con.createStatement();
			boolean rs    = stmt.execute(sql);

			con.close();  
			scannerIn.close();
			if (rs) {
				System.out.println("ingen ändring gjordes");
			}
		}catch(Exception e){ System.out.println(e);}
		System.out.println("\n");
	}
	
	public static void main(String[] args) {
		listInst();
		rentInst();
		listInst();
		termRentInst();
		listInst();
	}

}
