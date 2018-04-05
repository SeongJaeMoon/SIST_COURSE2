package com.test;

import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		ScheduleService service = new ScheduleService();

		// 메인 메뉴 액션
		boolean run = true;
		while (run) {
			System.out.println("--------------");
			System.out.println("일정 관리 v2.0");
			System.out.println("----------------------------------");
			System.out.println("1. 일정 입력  2. 일정 검색 및 출력");
			System.out.println("----------------------------------");
			System.out.print("선택(1~2, 0 quit)?");

			int m = sc.nextInt();
			sc.nextLine();

			switch (m) {
			case 0:	run = false; break;
			case 1:	service.scheduleAdd(sc); break;
			case 2:	service.scheduleList(sc); break;
			}

		}

		sc.close();
		System.out.println("프로그램 종료");
	}

}
