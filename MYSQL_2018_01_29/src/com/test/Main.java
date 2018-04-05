package com.test;

import java.util.*;

//콘솔 액션 클래스
public class Main {

	//메인 메뉴 (로그인 화면 구성)
	public static void main(String[] args) {
		
		//로그인 메뉴 구성
		//로그인 성공 여부에 따라서 등급에 따른 전용 메뉴로 이동		
		Scanner sc = new Scanner(System.in);
		LoginService service = new LoginService();
		
		boolean run = true;
		while(run) {
			
		System.out.println("---------------");
		System.out.println("직원관리v2.0");
		System.out.println("---------------");
		System.out.println("1.로그인 0.종료");
		 
		int num = sc.nextInt();
		sc.nextLine();
		
		if(num == 0) {
			break;
		}else if(num == 1){
			Login result = service.login(sc);
			if(result == null) {
				//로그인 실패
				System.out.println("로그인에 실패했습니다.");
			}else {
				//로그인 성공
				String id_ = result.getId_();
				int grade = result.getGrade();
				if(grade == 0) {
					//관리자 전용 메인 메뉴
					new EmployeesMain().main(sc, id_);
				}else if(grade == 1) {
					//강사 전용 메인 메뉴
					new InstructorMain().main(sc, id_);
				}else if(grade == 2) {
					//수강생 전용 메인 메뉴
					new StudentMain().main(sc, id_);
				}else {
					System.out.println("잘못된 등급 정보입니다.");
				}
			}
		}
		
		}
		System.out.println("프로그램 종료.");
		sc.close();
	}

}
