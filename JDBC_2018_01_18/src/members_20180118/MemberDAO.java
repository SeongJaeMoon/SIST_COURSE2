package members_20180118;

import java.util.*;
import java.sql.*;
import java.time.LocalDate;


public class MemberDAO {
		
	public List<Member> memberList(){
		List<Member> result = new ArrayList<Member>();
		/*
		 CREATE OR REPLACE VIEW membersView 
		 AS
		 SELECT mem_id, name_, phone, email, regDate, d.dept_name
		 FROM members m, department d
		 WHERE m.dept_id = d.dept_id;  
		 */
		
		
		String sql = "SELECT mem_id, name_, phone, email, regDate, dept_name FROM membersView";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBConnection.connect();
			stmt = conn.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String mem_id = rs.getString("mem_id");
				String name_ = rs.getString("name_");
				String phone = rs.getString("email");
				String email = rs.getString("email");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				String dept_name = rs.getString("dept_name");
				
				result.add(new Member(mem_id, name_, phone, email, regDate, dept_name));
			}
			rs.close();
			stmt.close();
		}catch(Exception e) {
			
		}finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {

			}
			try {
				DBConnection.close();
			}catch(Exception e) {
				
			}
		}
		return result;
	}
	
	public int memberAdd(Member m) {
		int result = 0;
		String sql = "INSERT INTO members(mem_id, name_, phone, email, regDate, dept_id) VALUES((SELECT NVL(LPAD(SUBSTR(MAX(mem_id), 2, 3)+1, 3, 'M0'), 'M01') FROM members),? ,? ,?, ?, ?)";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBConnection.connect();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, m.getName_());
			stmt.setString(2, m.getPhone());
			stmt.setString(3, m.getEmail());
			stmt.setString(4, m.getregDate().toString());
			stmt.setString(5, m.getDept_id());
			
			result = stmt.executeUpdate();	
		
			stmt.close();
		}catch(Exception e) {
			
		}finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {

			}
			try {
				DBConnection.close();
			}catch(Exception e) {
				
			}
		}
		return result;
	}
	
	public Map<String, String> deptList(){
		Map<String, String> result = new HashMap<String, String>();
		String sql = "SELECT dept_id, dept_name FROM department";
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = DBConnection.connect();
			stmt = conn.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String dept_id = rs.getString("dept_id");
				String dept_name = rs.getString("dept_name");
				result.put(dept_id, dept_name);
			}
			rs.close();
			stmt.close();
		}catch(Exception e) {
			
		}finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {

			}
			try {
				DBConnection.close();
			}catch(Exception e) {
				
			}
		}
		return result;
	}
}
