package com.test;

//STEP 1. Import required packages
import java.sql.*;
import java.time.*;

public class Sample05 {

	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	static final String DB_URL = "jdbc:oracle:thin:@211.63.89.68:1521:xe";

	// Database credentials
	static final String USER = "test01";
	static final String PASS = "1234";

	public static void main(String[] args) {

		// 문제) insa 테이블의 전체 자료(num, name, ...., sudang)를 읽어와서 콘솔 화면에 출력하는 프로그램 작성.
		String sql = "SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi,basicpay, sudang FROM insa";

		Connection conn = null;
		Statement stmt = null;
		try {
			// STEP 2: Register JDBC driver
			Class.forName(JDBC_DRIVER);

			// STEP 3: Open a connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			// STEP 4: Execute a query
			System.out.println("Creating statement...");
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			// STEP 5: Extract data from result set
			while (rs.next()) {
				// Retrieve by column name

				//PK 제약을 가진 컬럼은 NULL 값이 존재하지 못한다.
				int num = rs.getInt("num");
				
				String name = rs.getString("name");
				String ssn = rs.getString("ssn");
				
				//주의) 날짜 자료형은 getDate() 메소드 사용
				LocalDate ibsaDate = rs.getDate("ibsaDate").toLocalDate();
				
				String tel = rs.getString("tel");
				String city = rs.getString("city");
				String buseo = rs.getString("buseo");
				String jikwi = rs.getString("jikwi");
				
				//주의) null 값인 경우 자동으로 0 반환
				int basicPay = rs.getInt("basicPay");
				//주의) null 값인 경우 자동으로 0 반환
				int sudang = rs.getInt("sudang");

				System.out.printf(
						"num:%s name:%s ssn:%s ibsaDate:%s tel:%s city:%s buseo:%s jikwi:%s basicPay:%d sudang:%s %n",
						num, name, ssn, ibsaDate, tel, city, buseo, jikwi, basicPay, sudang);

			}
			// STEP 6: Clean-up environment
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		} finally {
			// finally block used to close resources
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			} // nothing we can do
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			} // end finally try
		} // end try
		System.out.println("Goodbye!");

	}

}
