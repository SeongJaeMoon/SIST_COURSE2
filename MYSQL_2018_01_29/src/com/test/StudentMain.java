package com.test;

import java.util.Scanner;

public class StudentMain {

	public void main(Scanner sc, String id_) {
		boolean run = true;
		while(run) {

		System.out.println("-----------------------------");
		System.out.printf("직원관리v2.0 (사용자:%s)%n", id_);
		System.out.println("-----------------------------");
		System.out.println("수강생 전용 화면입니다.");
		System.out.println("-----------------------------");
		System.out.print("선택(1~2, 0 quit)?");
		
		int num = sc.nextInt();
		sc.nextLine();

		switch (num) {
		case 0: run = false; break;	
		case 1: break;
		case 2: break;
		
			}
		}
	System.out.println("로그아웃 되었습니다.");
	}
}
