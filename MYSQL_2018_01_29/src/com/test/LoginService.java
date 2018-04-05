package com.test;

import java.util.*;
import java.sql.*;

//콘솔 액션 클래스
public class LoginService {
	 
	//아아디, 패스워드 입력 받고, 로그인 검증하는 메소드
	private LoginDAO dao = new LoginDAO();
	
	public Login login(Scanner sc) {
		Login result = null;
		//로그인 검증 절차 짅행
		//성공하면 "아이디/등급" 반환
		//실패하면 NULL 반환	
		System.out.print("아이디:");
		String id_ = sc.nextLine();
		System.out.print("비밀번호:");
		String pw_ = sc.nextLine();
		
		result = this.dao.login(id_, pw_); 
		
		return result;
	}
}
