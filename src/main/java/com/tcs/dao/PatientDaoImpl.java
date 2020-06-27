package com.tcs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tcs.util.DbConnection;

public class PatientDaoImpl extends PatientDao{

	@Override
	public boolean validateLogin(String username, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DbConnection.getConnection();
			ps = con.prepareStatement("SELECT username, password from users where username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			while(rs.next()) {
				String usr = rs.getString("username");
				String pwd = rs.getString("password");
				if(username != null && password != null) {
					if(username.equals(usr) && password.equals(pwd)) {
						return true;
					} else {
						return false;
					}
				}
				return false;
			}
		} catch(SQLException e) {
			System.out.println(e.getErrorCode()+" "+e.getMessage());
		} finally {
			System.out.println("Login Attempted");
		}
		return false;
	}
}
