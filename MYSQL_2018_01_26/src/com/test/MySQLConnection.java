package com.test;

import java.sql.*;

public class MySQLConnection {

	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://211.63.89.95:3306/moon?useSSL=false";


	private static final String USER = "moon";
	private static final String PASS = "1234";
	
	private static Connection conn;
	
	
	public static Connection connect() throws ClassNotFoundException, SQLException {
		
		Class.forName(JDBC_DRIVER);
		
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		return conn;
	}
	
	
	public static void close() throws SQLException {
		if (conn != null) {
			conn.close();
		}
	}
}
