package com.test01;

import java.util.*;

public class TestService {

	TestDAO dao = new TestDAO();
	
	//출력 액션 메소드
	public void list() {
		List<Test>temp = dao.list();
		StringBuilder sb = new StringBuilder();
		for(Test t : temp) {
			sb.append(String.format("%s%n", t.toString()));
		}
		sb.insert(0, String.format("아이디 나이 성 이름%n"));
		System.out.println(sb.toString());
	}
	
	//입력 액션 메소드
	public void add(Scanner sc) {
		System.out.println("나이를 입력해주세요.");
		int age_ = sc.nextInt();
		sc.nextLine();
		System.out.println("성을 입력해주세요.");
		String first_ = sc.next();
		System.out.println("이름을 입력해주세요. ");
		String last_ = sc.next();
		if(dao.add(new Test(0, age_, first_, last_)) == 0)
		{
			System.out.println("데이터 저장 중, 오류가 발생하였습니다.");
		} else {
			System.out.println("사용자 정보가 등록되었습니다.");
		}
	}
	
	public void remove(Scanner sc) {
		System.out.println("삭제할 id를 입력해주세용");
		int id_ = sc.nextInt();
		int result = dao.remove(id_);
		if(result!=0) {
			System.out.printf("%d 행의 삭제가 정상적으로 완료되었습니다.%n", result);
		}else {
			System.out.println("삭제가 정상적으로 이루어지지 않았습니다.");
		}
	}
}
