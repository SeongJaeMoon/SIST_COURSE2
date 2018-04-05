package com.test01;

import java.util.*;
import java.sql.*;
//자료 저장소(데이터베이스) 액션 전용 클래스
public class TestDAO {
	private Connection conn = null; 
	private PreparedStatement stmt = null;
	//출력
	//-> 반환 자료형을 컬렉션 객체로 지정
	
	public List<Test> list(){
		List<Test> result = new ArrayList<Test>();
		String sql = "SELECT id_, age_, first_, last_ FROM sample01 ORDER BY id_";
		try {
		conn = DBConnection.connect();
		stmt = conn.prepareStatement(sql);
		//외부데이터 바인딩 과정 추가
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			result.add(new Test(rs.getInt("id_"), rs.getInt("age_"), rs.getString("first_"),rs.getString("last_")));
		}
		rs.close();
		stmt.close();
		conn.close();
		}catch(Exception e) {
		
		}finally {
			try {
				if(stmt!=null) {
					stmt.close();
				}
			}catch(Exception e) {
				
			}
			try {
				DBConnection.close();
			}catch(Exception e) {
				
			}
		}
		
		
		return result;
	}
	
	//입력
	public int add(Test t) {
		int result = 0;
		String sql = "INSERT INTO sample01 (id_, age_, first_, last_) VALUES ((SELECT NVL(MAX(id_),0)+1 FROM sample01), ?, ?, ?)";
		try {
			conn = DBConnection.connect();
			stmt = conn.prepareStatement(sql);
			
			//물음표인덱스는 1부터 시작된다.
			
			stmt.setInt(1, t.getAge_());
			stmt.setString(2, t.getFirst_());
			stmt.setString(3,t.getLast_());
			
			result = stmt.executeUpdate();	
			
			conn.close();
			stmt.close();
			
		}catch(Exception e) {
			
		}finally {
			try {
				if(stmt!=null) {
					stmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch(Exception e) {
				
			}try {
				DBConnection.close();
			}catch(Exception e) {
				
			}
		}
		return result;
	}

	public int remove(int id_) {
		int result= 0;
		String sql = "DELETE FROM sample01 WHERE id_ = ?";
		try {
			conn = DBConnection.connect();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, id_);
			
			result = stmt.executeUpdate();	
				
			conn.close();
			stmt.close();
			
		}catch(Exception e) {
			
		}finally {
			try {
				if(stmt!=null) {
					stmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch(Exception e) {
				
			}try {
				DBConnection.close();
			}catch(Exception e) {
				
			}
		}
		return result;
	}
}
