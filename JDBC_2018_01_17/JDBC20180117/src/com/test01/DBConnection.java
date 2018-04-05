package com.test01;

import java.sql.*;

public class DBConnection {

	private static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DB_URL = "jdbc:oracle:thin:@211.63.89.86:1521:xe";


	private static final String USER = "test_moon";
	private static final String PASS = "1234";
	
	private static Connection conn;
	
	//데이테베이스 커넥션 객체 생성 메소드
	public static Connection connect() throws ClassNotFoundException, SQLException {
		
		Class.forName(JDBC_DRIVER);
		
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		return conn;
	}
	
	//데이테베이스 커넥션 객체 소멸 메소드
	public static void close() throws SQLException {
		if (conn != null) {
			conn.close();
		}
	}
}
