package members_20180118;


import java.util.*;

public class Main {

	public static void main(String[] args) {
		MemberService service = new MemberService();
		Scanner sc = new Scanner(System.in);
		try {
			while(true){
				System.out.println("1.출력 2.입력 3.삭제 0.종료");
				int input = sc.nextInt();
				if(input == 0)break;
				switch(input){
				case 1: System.out.println(service.memberList());break;
				case 2: service.memberAdd(sc);break;
				}
				
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		sc.close();
		System.out.println("시스템 종료...");
	}
}
