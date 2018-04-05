package com.test;

import java.util.*;

public class ScheduleService {

	private ScheduleDAO dao = new ScheduleDAO();
	
	//일정 입력 메소드
	public void scheduleAdd(Scanner sc) {

		System.out.println("-----------------------------");
		System.out.println("일정 관리 v2.0 > 1. 일정 입력");
		System.out.println("-----------------------------");
		System.out.print("날짜/시간(yyyy-MM-dd/HH)?");
		String datetime = sc.nextLine();
		System.out.print("내용(200자 이내)?");
		String content_ = sc.nextLine();
		
		Schedule s = new Schedule(datetime, content_);
		dao.scheduleAdd(s);
		System.out.println("1건의 일정이 입력되었습니다.");
		
	}
	
	//일정 검색 및 출력 메소드
	public void scheduleList(Scanner sc) {
		
		boolean run = true;
		while (run) {
			System.out.println("-------------------------------------");
			System.out.println("일정 관리 v2.0 > 2. 일정 검색 및 출력");
			System.out.println("------------------------------------------------------------------");
			System.out.println("1.오늘  2.특정일  3.특정월  4.특정단어포함  5.전체  6.월별일정건수");
			System.out.println("------------------------------------------------------------------");
			System.out.print("선택(1~6, 0 quit)?");

			int m = sc.nextInt();
			sc.nextLine();

			switch (m) {
			case 0:	run = false; break;
			case 1:	this.scheduleList(sc, "today"); break;
			case 2:	this.scheduleList(sc, "day"); break;
			case 3:	this.scheduleList(sc, "month"); break;
			case 4:	this.scheduleList(sc, "content_"); break;
			case 5:	this.scheduleList(sc, "all"); break;
			case 6:	this.countList(); break;
			}

		}
		
	}
	
	private void scheduleList(Scanner sc, String key) {
		
		String temp = "";
		String value = "";
		switch (key) {
		case "today":
			temp = "오늘 일정";
			break;
		case "day":
			temp = "특정 일(YYYY-MM-DD)";
			System.out.printf("%s?", temp);
			value = sc.nextLine();
			break;
		case "month":
			temp = "특정 월(YYYY-MM)";
			System.out.printf("%s?", temp);
			value = sc.nextLine();
			break;
		case "content_":
			temp = "특정 단어";
			System.out.printf("%s?", temp);
			value = sc.nextLine();
			break;
		case "all":
			temp = "전체";
			break;
		}
		
		List<Schedule> list = dao.scheduleList(key, value);
		
		System.out.println("--------------------------------------------------------");
		System.out.printf("일정 관리 v2.0 > 2. 일정 검색 및 출력 > %s%n", temp);
		System.out.println("--------------------------------------------------------");
		System.out.printf("총: %d건%n", list.size());

		if (list.size() > 0) {
			//검색 결과가 존재하는 경우
			System.out.println("---------------------------------");
			for (Schedule s : list) {
				System.out.println(s);
			}
		} else {
			//검색 결과가 존재하지 않는 경우
			System.out.println("결과가 없습니다.");
		}		
	}
	
	private void countList() {

		List<Schedule> list = dao.countList();
		
		System.out.println("------------------------------------------------------");
		System.out.println("일정 관리 v2.0 > 2. 일정 검색 및 출력 > 월별 일정 건수");
		System.out.println("------------------------------------------------------");
		System.out.printf("총: %d건%n", list.size());

		if (list.size() > 0) {
			System.out.println("---------------------------------");
			for (Schedule s : list) {
				System.out.printf("%s - %s%n", s.getDatetime(), s.getCount_());
			}
		} else {
			System.out.println("검색 결과가 없습니다.");
		}

	}
}
