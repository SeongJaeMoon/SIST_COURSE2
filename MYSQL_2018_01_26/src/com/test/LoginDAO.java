package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO {

	//로그인 검증 메소드
	public Login login(String id_, String pw_) {
		Login result = null;
		
		//로그인 확인 절차 진행
		//성공하면 Login 객체 반환 id_, grade 정보 저장
		//실패하면 NULL 반환
		
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  String sql = "SELECT id_, pw_, grade FROM login WHERE id_= ? AND pw_ = ?";
		  try {
		   conn = MySQLConnection.connect();
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, id_);
		   pstmt.setString(2, pw_);
		   ResultSet rs = pstmt.executeQuery(); 
		   
		   while (rs.next()) {
			   String id = rs.getString("id_");
			   String pw = rs.getString("pw_");
			   int grade = rs.getInt("grade");
			   if(id_.equals(id)&&pw_.equals(pw)) {
				   result = new Login(id_, pw_, grade);
			   }
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
}
