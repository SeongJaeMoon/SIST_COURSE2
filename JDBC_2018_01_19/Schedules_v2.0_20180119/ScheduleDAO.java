package com.test;

import java.util.*;
import java.sql.*;

public class ScheduleDAO {
	
	//검색 및 출력 액션 메소드
	public List<Schedule> scheduleList(String key, String value) {
		List<Schedule> result = new ArrayList<Schedule>();
		

		//검색 기준에 따른 검색 액션 코드 작성.
		//->오늘 일정, 특정 일, 특정 월, 특정 단어, 전체
		//->switch 구문 사용
		String sql = "SELECT sid_, TO_CHAR(datetime, 'YYYY-MM-DD/HH24') datetime, content_ FROM schedules";
		
		//검색 기준에 따른 WHERE 구문 추가
		//주의) 식별자는 PreparedStatement 클래스의 바인딩 대상이 아니므로 문자열로만 처리 가능.
		//주의) 쿼리문 앞에 공백 문자 삽입
		switch (key) {
		case "today":
			sql += " WHERE TO_CHAR(datetime, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
			break;
		case "day":
			sql += " WHERE TO_CHAR(datetime, 'YYYY-MM-DD') = ?";
			break;
		case "month":
			sql += " WHERE TO_CHAR(datetime, 'YYYY-MM') = ?";
			break;
		case "content_":
			sql += " WHERE INSTR(content_, ?) > 0";
			break;
		case "all":
			//전체 출력인 경우 WHERE 구문이 없는 상태이다.
			break;
		}
		sql += " ORDER BY datetime";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			
			//검색 기준에 따른 검색값 바인딩 추가
			switch (key) {
			case "today":
				//외부 데이터 바인딩 없는 상태
				break;
			case "day":
			case "month":
			case "content_":
				pstmt.setString(1, value);
				break;
			case "all":
				//외부 데이터 바인딩 없는 상태
				break;
			}
			
			ResultSet rs = pstmt.executeQuery();
			
			//주의) 검색 결과가 존재하는 경우만 반복문 실행 가능 -> 채워진 컬렉션 반환
			//주의) 검색 결과가 없는 경우 빈 컬렉션 반환
			while (rs.next()) {
				
				int sid_ = rs.getInt("sid_");
				String datetime = rs.getString("datetime");
				String content_ = rs.getString("content_");
				
				Schedule s = new Schedule(sid_, datetime, content_);
				result.add(s);
				
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
				DBConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		
		return result;
	}
	
	//입력 액션 메소드
	public int scheduleAdd(Schedule s) {
		int result = 0;
		
		String sql = "INSERT INTO schedules (sid_, datetime, content_) VALUES ((SELECT NVL(MAX(sid_),0) + 1 FROM schedules), TO_DATE(?, 'YYYY-MM-DD/HH24'), ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, s.getDatetime());
			pstmt.setString(2, s.getContent_());
			
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
				DBConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}		
		
		return result;
	}
	

	//월별 건수 출력 메소드
	public List<Schedule> countList() {
		List<Schedule> result = new ArrayList<Schedule>();

		
		String sql = "SELECT TO_CHAR(datetime, 'YYYY-MM') datetime, COUNT(*) count_ FROM schedules GROUP BY TO_CHAR(datetime, 'YYYY-MM') ORDER BY datetime";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				String datetime = rs.getString("datetime");
				int count_ = rs.getInt("count_");
				
				Schedule s = new Schedule(datetime, count_);
				result.add(s);
				
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
				DBConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		
		
		return result;
	}
	
}
