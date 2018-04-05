package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

public class EmployeesDAO {

	//직원 정보 정렬 출력 메소드
	//-> 전체 출력시 사번, 이름 등 기준으로 정렬 지원
	public List<Employees>list(String key){
		List<Employees> result = new ArrayList<Employees>();
		
		/*
		 SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, (basicpay+extrapay) AS pay
		 FROM employees e 
		 INNER JOIN jobs j ON e.job_id = j.job_id
		 INNER JOIN departments d ON e.dept_id = d.dept_id
		 INNER JOIN regions r ON e.reg_id = r.reg_id 
		 ORDER BY "";
		 */
		
		String sql = "SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, pay FROM employeesView";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);
			switch(key) {
			case "eid":
				sql += " ORDER BY eid";
				break;
			case "name_":
				sql += " ORDER BY name_";
				break;
			case "dept_name": 
				sql += " ORDER BY dept_name";
				break;
			case "job_title":
				sql += " ORDER BY job_title";
				break;
			case "reg_name":
				sql += " ORDER BY reg_name";
				break;
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
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
				Employees e = new Employees();
				
				e.setEid(eid);
				e.setName_(name_);
				e.setSsn(ssn);
				e.setHiredate(hiredate);
				e.setPhone(phone);
				e.setReg_name(reg_name);
				e.setDept_name(dept_name);
				e.setJob_title(job_title);
				e.setBasicpay(basicpay);
				e.setExtrapay(extrapay);
				
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
	//직원 정보 검색 출력 메소드
	//-> 사번, 이름 등 기준으로 검색하고 사번 정렬된 상태로 출력
	public List<Employees>list(String key, String value){
		List<Employees> result = new ArrayList<Employees>();
		
		/*
		 SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, (basicpay+extrapay) AS pay
 		 FROM employees e 
		 INNER JOIN jobs j ON e.job_id = j.job_id
		 INNER JOIN departments d ON e.dept_id = d.dept_id
		 INNER JOIN regions r ON e.reg_id = r.reg_id 
		 ORDER BY "";
		 */
		
		String sql = "SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, pay FROM employeesView WHERE = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, value);
			switch(key) {
			case "eid":
				sql += " ORDER BY eid";
				break;
			case "name_":
				sql += " ORDER BY name_";
				break;
			case "dept_name": 
				sql += " ORDER BY dept_name";
				break;
			case "job_title":
				sql += " ORDER BY job_title";
				break;
			case "reg_name":
				sql += " ORDER BY reg_name";
				break;
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
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
				Employees e = new Employees();
				
				e.setEid(eid);
				e.setName_(name_);
				e.setSsn(ssn);
				e.setHiredate(hiredate);
				e.setPhone(phone);
				e.setReg_name(reg_name);
				e.setDept_name(dept_name);
				e.setJob_title(job_title);
				e.setBasicpay(basicpay);
				e.setExtrapay(extrapay);
				
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
	
	//직원 정보 입력 메소드
	public int add(Employees emp) {
		int result = 0;
			
		String sql = "INSERT INTO employees (eid, name_, ssn, hiredate, phone, reg_id, dept_id, job_id) VALUES ((SELECT CONCAT('E',LPAD(IFNULL(SUBSTR(MAX(eid),4), 0) + 1, 2, 0)) AS newEid FROM employees e), ?, ?, ?, ?, ?, ?, ?)";
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, emp.getName_());
			pstmt.setString(2, emp.getSsn());
			pstmt.setString(3, emp.getHiredate().toString());
			pstmt.setString(4, emp.getPhone());
			pstmt.setString(5, emp.getReg_id());
			pstmt.setString(6, emp.getDept_id());
			pstmt.setString(7, emp.getJob_id());
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
	
	//직원 정보 삭제 메소드
	
	//지역 정보 출력 메소드 -> 삭제 가능 여부 포함
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

	 public int remove(String eid) {
		 int result = 0;
		 String sql = "DELETE FROM employees WHERE eid = ?";

		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  try {
		   conn = MySQLConnection.connect();

		   pstmt = conn.prepareStatement(sql);

		   pstmt.setString(1, eid);

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
