package com.tcs.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DbConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/hms";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "!9492234713@";
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			if(con == null) {
				System.out.println("Connection to Database Failed");
			}
			return con;
		}catch(SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}

