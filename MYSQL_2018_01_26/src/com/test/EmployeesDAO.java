package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class EmployeesDAO {

	// 지역 정보 출력 메소드 -> 삭제 가능 여부 포함
	 public List<Employees> regionList() {
	  List<Employees> result = new ArrayList<Employees>();

	  String sql = "SELECT reg_id, reg_name,(SELECT COUNT(*) FROM employees WHERE reg_id = r.reg_id) AS deleteCheck FROM regions r ORDER BY reg_id";

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();
	   pstmt = conn.prepareStatement(sql);

	   ResultSet rs = pstmt.executeQuery();

	   while (rs.next()) {
	    String reg_id = rs.getString("reg_id");
	    String reg_name = rs.getString("reg_name");
	    int deleteCheck = rs.getInt("deleteCheck");

	    Employees e = new Employees();

	    e.setReg_id(reg_id);
	    e.setReg_name(reg_name);
	    e.setDeleteCheck(deleteCheck);

	    result.add(e);

	   }
	   rs.close();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;

	 }

	 public int regionAdd(String reg_name) {
	  int result = 0;

	  String sql = "INSERT INTO regions (reg_id, reg_name) VALUES ( (SELECT CONCAT('REG',LPAD(IFNULL(SUBSTR(MAX(reg_id),4), 0) + 1, 2, 0)) AS newRegId FROM regions r), ?)";

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();

	   pstmt = conn.prepareStatement(sql);

	   pstmt.setString(1, reg_name);

	   result = pstmt.executeUpdate();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;
	 }

	 // 지역 정보 삭제 메소드
	 public int regionDelete(String reg_id) {
	  int result = 0;

	  String sql = "DELETE FROM regions WHERE reg_id =?";
	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();

	   pstmt = conn.prepareStatement(sql);

	   pstmt.setString(1, reg_id);

	   result = pstmt.executeUpdate();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;
	 }

	 public List<Employees> deptList() {
	  List<Employees> result = new ArrayList<Employees>();

	  String sql = "SELECT dept_id, dept_name,(SELECT COUNT(*) FROM employees WHERE dept_id = d.dept_id) AS deleteCheck FROM departments d ORDER BY dept_id";

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();
	   pstmt = conn.prepareStatement(sql);

	   ResultSet rs = pstmt.executeQuery();

	   while (rs.next()) {
	    String dept_id = rs.getString("dept_id");
	    String dept_name = rs.getString("dept_name");
	    int deleteCheck = rs.getInt("deleteCheck");

	    Employees e = new Employees();

	    e.setDept_id(dept_id);
	    e.setDept_name(dept_name);
	    e.setDeleteCheck(deleteCheck);

	    result.add(e);

	   }
	   rs.close();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;

	 }

	 public int deptAdd(String dept_name) {
	  int result = 0;

	  String sql = "INSERT INTO departments (dept_id, dept_name) VALUES ( (SELECT CONCAT('DEPT',LPAD(IFNULL(SUBSTR(MAX(dept_id),5), 0) + 1, 2, 0)) AS newDeptId FROM departments d), ?)";

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();

	   pstmt = conn.prepareStatement(sql);

	   pstmt.setString(1, dept_name);

	   result = pstmt.executeUpdate();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;
	 }

	 // 지역 정보 삭제 메소드
	 public int deptDelete(String dept_id) {
	  int result = 0;

	  String sql = "DELETE FROM departments WHERE dept_id =?";
	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();

	   pstmt = conn.prepareStatement(sql);

	   pstmt.setString(1, dept_id);

	   result = pstmt.executeUpdate();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;
	 }

	 public List<Employees> jobList() {
	  List<Employees> result = new ArrayList<Employees>();

	  String sql = "SELECT job_id, job_title, (SELECT COUNT(*) FROM employees WHERE job_id = j.job_id) AS deleteCheck FROM jobs j ORDER BY job_id";

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();
	   pstmt = conn.prepareStatement(sql);

	   ResultSet rs = pstmt.executeQuery();

	   while (rs.next()) {
	    String job_id = rs.getString("job_id");
	    String job_title = rs.getString("job_title");
	    int deleteCheck = rs.getInt("deleteCheck");

	    Employees e = new Employees();

	    e.setJob_id(job_id);
	    e.setJob_title(job_title);
	    e.setDeleteCheck(deleteCheck);

	    result.add(e);

	   }
	   rs.close();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;

	 }

	 public int jobAdd(String job_title) {
	  int result = 0;
	  String sql = "INSERT INTO jobs (job_id, job_title) VALUES ( (SELECT CONCAT('JOB',LPAD(IFNULL(SUBSTR(MAX(job_id),4), 0) + 1, 2, 0)) AS newJobId FROM jobs j), ?)";

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();

	   pstmt = conn.prepareStatement(sql);

	   pstmt.setString(1, job_title);

	   result = pstmt.executeUpdate();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;
	 }

	 // 지역 정보 삭제 메소드
	 public int jobDelete(String job_id) {
	  int result = 0;

	  String sql = "DELETE FROM jobs WHERE job_id =?";
	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	   conn = MySQLConnection.connect();

	   pstmt = conn.prepareStatement(sql);

	   pstmt.setString(1, job_id);

	   result = pstmt.executeUpdate();

	  } catch (SQLException se) {
	   se.printStackTrace();
	  } catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   try {
	    if (pstmt != null)
	     pstmt.close();
	   } catch (SQLException se) {
	   }
	   try {
	    MySQLConnection.close();
	   } catch (SQLException se) {
	    se.printStackTrace();
	   }
	  }

	  return result;
	 }

}
