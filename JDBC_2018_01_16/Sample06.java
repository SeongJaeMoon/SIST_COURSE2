package com.test;

import java.sql.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

public class Sample06 {
	
	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	static final String DB_URL = "jdbc:oracle:thin:@211.63.89.68:1521:xe";

	// Database credentials
	static final String USER = "test01";
	static final String PASS = "1234";

	public static void main(String[] args) {

		// 문제) employees, departments, jobs, regions 테이블을 (INNER)조인한 후 전체 출력하는 프로그램 작성.
		String sql = "SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, (basicpay + extrapay) pay FROM employees e, regions r, departments d, jobs j WHERE e.reg_id = r.reg_id AND e.dept_id = d.dept_id AND e.job_id = j.job_id";

		//주의) 날짜 패턴 지정시 대소문자 구분
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd"); 

		/*
		 * 출력예) 
		 * 1001 홍길동 771212-1022432 98/10/11 011-2356-4528 서울 기획부 부장 2610000 200000 2810000 
		 * 1002 이순신 801007-1544236 00/11/29 010-4758-6532 경기 총무부 사원 1320000 200000 1520000 
		 * 1003 이순애 770922-2312547 99/02/25 010-4231-1236 인천 개발부 부장 2550000 160000 2710000 
		 * ...
		 */

		Connection conn = null;
		Statement stmt = null;
		try {
			// STEP 2: Register JDBC driver
			Class.forName(JDBC_DRIVER);

			// STEP 3: Open a connection
			System.out.println("Connecting to a selected database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Connected database successfully...");

			// STEP 4: Execute a query
			System.out.println("Creating statement...");
			stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			
			// STEP 5: Extract data from result set
			while (rs.next()) {
				// Retrieve by column name
				String eid = rs.getString("eid");
				String name_ = rs.getString("name_");
				String ssn = rs.getString("ssn");
				LocalDate hiredate = rs.getDate("hiredate").toLocalDate();
				String phone = rs.getString("phone");
				String reg_name = rs.getString("reg_name");
				String dept_name = rs.getString("dept_name");
				String job_title = rs.getString("job_title");
				int basicpay = rs.getInt("basicpay");
				int extrapay = rs.getInt("extrapay");
				int pay = rs.getInt("pay");

				// Display values
				System.out.printf("%s %s %s %s %s %s %s %s %,d %,d %,d%n",
						eid, name_, ssn
						, hiredate.format(formatter)
						, phone, reg_name, dept_name, job_title, basicpay, extrapay, pay);
			}
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
					conn.close();
			} catch (SQLException se) {
			} // do nothing
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
