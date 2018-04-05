package com.test;

import java.util.*;

//콘솔 액션 클래스(관리자 전용)
public class EmployeesMain {

	public void main(Scanner sc, String id_) {

		  EmployeesService es = new EmployeesService();

		  boolean run = true;

		  while (run) {
		   System.out.println("---------------------------------------------------------------");
		   System.out.printf("직원관리v2.0 (관리지ㅣ:%s)%n", id_);
		   System.out.println("---------------------------------------------------------------");
		   System.out.println("1.직원관리 2.기초정보 관리 0.종료");
		   System.out.print("선택 > ");

		   int sn = sc.nextInt();
		   sc.nextLine();

		   switch (sn) {
		   case 0:run = false;break;
		   case 1:break;
		   case 2:es.menu_2(sc);break;
			}
		}
		System.out.println("로그아웃 되었습니다.");
	}
}
