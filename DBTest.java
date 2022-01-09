package databas;

import java.sql.*;
import java.util.Scanner;

public class DBTest {
	public static void listInst(String instrumentS) {
		//String instrumentS = "violin";


		Scanner input = new Scanner(System.in);
		//System.out.println("Vilket instrument vill du söka efter?");
		//instrumentS = input.next();
		String sql =
				"SELECT instrumentID, tillverkare, pris " +
				"FROM instrument" +
				" WHERE instrumentID NOT IN " +
				" (SELECT instrumentID " +
				" FROM instrumenthyra " +
				" WHERE (lanetid > 0) )  " +
				" AND (instrumenttyp = '" + instrumentS +"');";


		try{
			//Ändra andra "root" till användarens lösenord.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","root"); 

			Statement stmt  = con.createStatement();
			ResultSet rs    = stmt.executeQuery(sql);
			System.out.println("instrumentID \t tillverkare \t\t pris");
	            while (rs.next()) {
	                System.out.println(rs.getString("instrumentID")
	                		+ " \t\t " + rs.getString("tillverkare")
	                		+ " \t\t " + rs.getString("pris"));

	            }

			con.close();
		}catch(Exception e){ System.out.println(e);}
		System.out.println("\n");
		input.close();
	}

	public static void rentInst(String instID) {

		Scanner input = new Scanner(System.in);
		System.out.println("Person nummer för den hyrande eleven:");
		String personnummer = "201407062431";
		//personnummer = input.next();
		System.out.println(personnummer);
		System.out.println("Ange instrumentID för det instrument du vill hyra:");
		//instID = "2";
		//instID = input.next();
		System.out.println(instID);
		System.out.println("Ange dagens datum i formated YYYY-MM-DD:");
		
		// Byt datum varje gång programmet körs
		String datum = "2021-01-09";
		//datum = input.next();
		System.out.println(datum);

		String sql =
				"INSERT INTO instrumenthyra (personnummer, instrumentID, datum, lanetid) "
				+ "VALUES ('" + personnummer + "'," + instID +  ", '" + datum + "',1095)";

		String check = "SELECT personnummer, COUNT(*) AS antal "
				+ "FROM instrumenthyra "
				+ "WHERE lanetid != '0' "
				+ "GROUP BY personnummer;";

		try{
			//Ändra andra "root" till användarens lösenord.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","root");

			Statement stmt  = con.createStatement();

			ResultSet rs    = stmt.executeQuery(check);
			rs.next();
			boolean res = true;
			int antal = Integer.parseInt(rs.getString("antal"));
			String persnummer = rs.getString("personnummer");


			if (antal < 2 && persnummer.equals(personnummer)) {
				   res = stmt.execute(sql);
			} else {
				System.out.println("för många hyrda instrument");
			}
			con.close();

			if (res) {
				System.out.println("ingen ändring gjordes");
			}
		}catch(Exception e){ System.out.println(e);}
		System.out.println("\n");
		input.close();
	}



	public static void termRentInst(String instID) {
		//String instID = "2";
		String persnummer = "201407062431";
		//Byt datum varje gång programmet körs
		String datum = "2021-01-09";

		Scanner input = new Scanner(System.in);
		System.out.println("Ange det lånade instrumentets ID: ");
		//instID = input.next();
		System.out.println(instID);
		System.out.println("Ange personnummret på eleven som hyrde instrumentet: ");
		//persnummer = input.next();
		System.out.println(persnummer);
		System.out.println("Ange datumet lånet påbörjades: ");
		//datum = input.next();
		System.out.println(datum);

		String sql =
				"UPDATE instrumenthyra " +
				" SET lanetid = 0 " +
				" WHERE (instrumentID = " + instID + ") AND (personnummer="+ persnummer +
						") AND (datum = '" + datum + "');";

		
		try{
			//Ändra andra "root" till användarens lösenord.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/mydb?characterEncoding=latin1","root","root");

			Statement stmt  = con.createStatement();
			boolean rs    = stmt.execute(sql);

			con.close();
			if (rs) {
				System.out.println("ingen ändring gjordes");
			}
		}catch(Exception e){ System.out.println(e);}
		System.out.println("\n");
		input.close();
	}

	public static void main(String[] args) {
		System.out.println("Hyra violin:");
		listInst("violin");
		rentInst("2");
		System.out.println("Finns den kvar att hyra?");
		listInst("violin");
		System.out.println("Hyra slagverk:");
		listInst("slagwerk");
		rentInst("3");
		System.out.println("Lämna tillbaka instrument:");
		termRentInst("2");
		termRentInst("3");
		System.out.println("Finns instrumenten i lager igen?");
		listInst("slagwerk");
		listInst("violin");
	}
}