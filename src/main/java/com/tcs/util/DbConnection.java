package com.tcs.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;



public class DbConnection {

		private static final String URL = "jdbc:mysql://localhost:3306/hms";
		private static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
		private static final String USERNAME = "root";
		private static final String PASSWORD = "!9492234713@";

		public static Connection getConnection() {
			Connection con = null;
			
			try {
				Class.forName(DRIVER_NAME);
				con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}catch(SQLException e) {
				e.printStackTrace();
			}
			
			return con;
		}

		public static void closeConnection(Connection con) {
			if(con!=null) {
				try {
					con.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			
		}

		public static void closeStatement(PreparedStatement ps) {
			// TODO Auto-generated method stub
			if(ps!=null) {
				try {
					ps.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}

