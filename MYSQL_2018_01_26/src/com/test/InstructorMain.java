package com.test;

import java.util.Scanner;

public class InstructorMain {

	 public void main(Scanner sc, String id_) {

	  LoginService ls = new LoginService();
	  
	  boolean run = true;
	  
	  while (run) {
	   System.out.println("---------------------------------------------------------------");
	   System.out.printf("직원관리v2.0 (강사:%s)%n", id_);
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("강사 전용 화면입니다.");
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("1.아직메뉴없음 0.종료");
	   System.out.print("선택 > ");

	   int sn = sc.nextInt();
	   sc.nextLine();
	   switch (sn) {
	   case 0:run = false;break;
	   case 1:break;
	   case 2:break;
			}
		}
		System.out.println("로그아웃 되었습니다.");
	}
}