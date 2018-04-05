package com.test01;

import java.util.*;

public class Main {
	
	public static void main(String[] args) {
		TestService test = new TestService();
		Scanner sc = new Scanner(System.in);
		boolean run = true;
		try {
		while(run){
			System.out.println("1.출력 2.입력 3.삭제 0. 종료");
			System.out.println("선택(1~2)?");
			int input = sc.nextInt();
			if(input == 0)run=false;
			switch(input) {
			case 1: test.list();break;
			case 2: test.add(sc);break;
			case 3: test.remove(sc);break;
			}
		}
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		sc.close();
		System.out.println("프로그램 종료...");
	}
	
}
