package members_20180118;

import java.util.*;
import java.time.LocalDate;

public class MemberService {
	
	MemberDAO dao = new MemberDAO();
	
	//-> 여러개의 항목을 모두 가지고 있다.
	//-> 주의) mid 컬럼(PK)의 값은 외부에서 전달 받지 않고, 자동 증가 할 수 있도록 한다.
	//회원번호, 이름, 전화번호, 이메일, 등록일, 부서번호, 부서명
	public void memberAdd(Scanner sc) {
		System.out.print("이름:");
		String name_ = sc.next();
		System.out.print("전화번호:");
		String phone = sc.next();
		System.out.print("이메일:");
		String email = sc.next();
		System.out.print("등록일:");
		String regDate = sc.next();
		System.out.println(deptList());
		System.out.print("부서번호:");
		String dept_id = sc.next();
		
		int result = dao.memberAdd(new Member(name_, phone, email, LocalDate.parse(regDate), dept_id));
		if(result!=0) {
			System.out.printf("%d개의 행이 삽입되었습니다.\n", result);
		}else {
			System.out.println("삽입 중에 오류가 발생했습니다.");
		}
		
	}
	public String memberList() {
		StringBuilder sb = new StringBuilder();

		System.out.println("--------------------------------");
		System.out.printf("총:%d명%n",dao.memberList().size());
		System.out.println("--------------------------------");
		
		for(Member m : dao.memberList()) {
			sb.append(String.format("%s%n", m));
		}
		sb.append("--------------------------------");
		return sb.toString();

	}
	
	private String deptList() {
		String result = dao.deptList().toString();
		return result;
	}
	
}
