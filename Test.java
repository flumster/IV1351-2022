package databas;


import java.sql.*; 
import java.util.Scanner;


public class Test {
	
	public static void main(String[] args) throws SQLException {
		
		
String instrumentS = "violin";
		
		
		Scanner scannerIn = new Scanner(System.in);
		System.out.println("Vilket instrument vill du söka efter?");
		//instrumentS = scannerIn.next();
		System.out.println("Person nummer för den hyrande eleven:");
		String personnummer = "201407062431";
		//personnummer = scannerIn.next();
		System.out.println("Ange instrumentID för det instrument du vill hyra:");
		String instID = "2";
		//instID = scannerIn.next();
		System.out.println("Ange dagens datum i formated YYYY-MM-DD:");
		String datum = "2021-01-09";
		//datum = scannerIn.next();
		System.out.println("Ange dagens datum i formated YYYY-MM-DD:");
		String lanetid = "365";
		//lanetid = scannerIn.next();
		
		String sql = 
				"SELECT instrumentID, tillverkare, pris " +
				"FROM instrument" +
				" WHERE instrumentID NOT IN " +
				" (SELECT instrumentID " +
				" FROM instrumenthyra " +
				" WHERE (lanetid > 0) )  " +
				" AND (instrumenttyp = '" + instrumentS +"');";
		
		String rentSQL = 
				"INSERT INTO instrumenthyra (personnummer, instrumentID, datum, lanetid) "
				+ "VALUES ('" + personnummer + "'," + instID +  ", '" + datum + "'," + lanetid + ")";
		
		String rentCHECK = "SELECT COALESCE( (SELECT COUNT(*) "
				+ "FROM instrumenthyra "
				+ "WHERE lanetid != '0' AND personnummer = "+ personnummer + " "
				+ "), 0) AS antal;";
		
		String termSQL = 
				"UPDATE instrumenthyra " +
				" SET lanetid = 0 " + 
				" WHERE (instrumentID = " + instID + ") AND (personnummer="+ personnummer + 
						") AND (datum = '" + datum + "');";

		
		Connection con = null;
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			con=DriverManager.getConnection(  
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","root");  
			
			Statement stmt  = con.createStatement();
			con.setAutoCommit(false);
			
			
			ResultSet rs    = stmt.executeQuery(sql);
			System.out.println("instrumentID \t tillverkare \t\t pris");
	            while (rs.next()) {
	                System.out.println(rs.getString("instrumentID")
	                		+ " \t\t " + rs.getString("tillverkare")
	                		+ " \t\t " + rs.getString("pris"));
	            }
			
	            rs    = stmt.executeQuery(rentCHECK);
				rs.next();
				boolean res = true;
				int antal = (rs.getInt("antal"));
				System.out.println(antal);
				if (antal < 2) {
					   res = stmt.execute(rentSQL);
				} else {
					System.out.println("för många hyrda instrument");
				}
				if (res) {
					System.out.println("ingen ändring gjordes");
				}
				
				rs    = stmt.executeQuery(sql);
				System.out.println("instrumentID \t tillverkare \t\t pris");
		            while (rs.next()) {
		                System.out.println(rs.getString("instrumentID")
		                		+ " \t\t " + rs.getString("tillverkare")
		                		+ " \t\t " + rs.getString("pris"));
		            }
		            
		            
					boolean resu    = stmt.execute(termSQL);
					if (resu) {
						System.out.println("ingen ändring gjordes");
					}
		            
					rs    = stmt.executeQuery(sql);
					System.out.println("instrumentID \t tillverkare \t\t pris");
			            while (rs.next()) {
			                System.out.println(rs.getString("instrumentID")
			                		+ " \t\t " + rs.getString("tillverkare")
			                		+ " \t\t " + rs.getString("pris"));
			            }    
		            
			con.commit();
			con.close();  
			scannerIn.close();
		}catch(Exception e){ System.out.println(e); con.rollback();}
		System.out.println("\n");

	}

}
