package com.test;

import java.util.*;

//콘솔 액션 클래스
public class EmployeesService {

	
	// 직원관리 v.20.0 > 2.기초정보관리
	 private EmployeesDAO employeesDAO = new EmployeesDAO();
	
	 public void menu_2(Scanner sc) {
	  boolean run = true;

	  while (run) {
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("기초정보관리 >");
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("1.지역 관리 2.부서 관리 3.직위 관리 0.나가기");
	   System.out.println("---------------------------------------------------------------");
	   System.out.print("선택 > ");

	   int sn = sc.nextInt();
	   sc.nextLine();

	   switch (sn) {
	   case 0:run = false;break;
	   case 1:this.menu_21(sc);break;
	   case 2:this.menu_22(sc);break;
	   case 3:this.menu_23(sc);break;
			}
		}
	}

	 public void menu_21(Scanner sc) {
	  boolean run = true;

	  while (run) {
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("기초정보관리 > 지역 관리");
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("1.지역 입력 2.지역 출력 3.지역 삭제 0.나가기");
	   System.out.println("---------------------------------------------------------------");
	   System.out.print("선택 > ");

	   int sn = sc.nextInt();
	   sc.nextLine();

	   switch (sn) {

	   case 0:run = false;break;
	   case 1:this.menu_211(sc);break;
	   case 2:this.menu_212();break;
	   case 3:this.menu_213(sc);
			}
		}
	}

	 public void menu_211(Scanner sc) {

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("기초정보관리 > 지역 출력 > 지역 입력");
	  System.out.println("---------------------------------------------------------------");

	  // 지역 리스트 출력

	  this.menu_212();

	  System.out.print("지역 이름 입력> ");
	  String reg_name = sc.nextLine();
	  int result = this.employeesDAO.regionAdd(reg_name);
		if (result == 0) {
			System.out.println("지역 정보 입력 실패");
		} else {
			System.out.println("지역 정보 입력 완료");
		}

	}

	 public void menu_212() {

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("기초정보관리 > 지역 출력 > 지역 출력");
	  System.out.println("---------------------------------------------------------------");

	  List<Employees> regionList = this.employeesDAO.regionList();

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("지역번호 / 지역명");
	  System.out.println("---------------------------------------------------------------");
	  for (Employees employees : regionList) {
	   String deleteCheck;
	   if (employees.getDeleteCheck() == 0) {
	    deleteCheck = "Y";
	   } else {
	    deleteCheck = "N";
	   }

			System.out.printf("%s / %s / %s%n", employees.getReg_id(), employees.getReg_name(), deleteCheck);
		}
		System.out.println("---------------------------------------------------------------");
	}

	 public void menu_213(Scanner sc) {

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("기초정보관리 > 지역관리 > 지역 삭제");
	  System.out.println("---------------------------------------------------------------");

	  // 지역 리스트 출력

	  this.menu_212();

	  System.out.print("삭제할 지역 번호 입력> ");

	  String reg_id = sc.nextLine();
	  
	  System.out.printf("[%s]를 정말로 삭제하시겠습니까?(Y/N)", reg_id);

	  String select = sc.nextLine();
	  if (select.equalsIgnoreCase("Y")) {

	   int result = this.employeesDAO.regionDelete(reg_id);

	   if (result == 0) {
	    System.out.println("지역 정보 삭제가 실패 했습니다.");
	   } else {
	    System.out.println("지역 정보 삭제가 완료 되었습니다..");
	   }
	  } else if (select.equalsIgnoreCase("N")) {
	   System.out.println("지역 삭제를 취소했습니다.");
	  }

	 }

	 public void menu_22(Scanner sc) {
	  boolean run = true;

	  while (run) {
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("기초 정보 관리 > 부서 관리 ");
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("1.부서 입력 2.부서 출력 3.부서 삭제 0.나가기");
	   System.out.println("---------------------------------------------------------------");
	   System.out.print("선택 > ");

	   int sn = sc.nextInt();
	   sc.nextLine();

	   switch (sn) {

	   case 0:run = false;break;
	   case 1:this.menu_221(sc);break;
	   case 2:this.menu_222();break;
	   case 3:this.menu_223(sc);
			}
		}
	}

	 public void menu_221(Scanner sc) {

	  this.menu_222();

	  System.out.print("부서 이름 입력> ");

	  String dept_name = sc.nextLine();

	  int result = this.employeesDAO.deptAdd(dept_name);

	  if (result == 0) {
	   System.out.println("지역 정보 입력 실패");
	  } else {
	   System.out.println("지역 정보 입력 완료");
	  }

	 }

	 public void menu_222() {

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("기초 정보 관리 > 부서 관리 > 부서 출력");
	  System.out.println("---------------------------------------------------------------");

	  List<Employees> deptList = this.employeesDAO.deptList();

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("부서번호 / 부서명 / 삭제 가능 여부 ");
	  System.out.println("---------------------------------------------------------------");

	  for (Employees employees : deptList) {

	   String deleteCheck;
	   if (employees.getDeleteCheck() == 0) {
	    deleteCheck = "Y";
	   } else {
	    deleteCheck = "N";
	   }

	   System.out.printf("%s / %s / %s%n", employees.getDept_id(), employees.getDept_name(), deleteCheck);

	  }
	  System.out.println("---------------------------------------------------------------");

	 }

	 public void menu_223(Scanner sc) {

	  this.menu_222();

	  System.out.print("삭제할 부서 번호 입력> ");

	  String dept_id = sc.nextLine();

	  System.out.printf("[%s]를 정말로 삭제하시겠습니까?(Y/N)", dept_id);

	  String select = sc.nextLine();

	  if (select.equalsIgnoreCase("Y")) {
	   int result = this.employeesDAO.deptDelete(dept_id);
		if (result == 0) {
				System.out.println("부서 정보 삭제가 실패 했습니다.");
			} else {
				System.out.println("부서 정보 삭제가 완료 되었습니다.");
			}
		}else if (select.equalsIgnoreCase("N")) {
			System.out.println("부서 삭제를 취소했습니다.");
		}

	}

	 public void menu_23(Scanner sc) {
	  boolean run = true;

	  while (run) {
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("기초 정보 관리 > 직위 관리 ");
	   System.out.println("---------------------------------------------------------------");
	   System.out.println("1.직위 입력 2.직위 출력 3.직위 삭제 0.나가기");
	   System.out.println("---------------------------------------------------------------");
	   System.out.print("선택 > ");

	   int sn = sc.nextInt();
	   sc.nextLine();

	   switch (sn) {

	   case 0:run = false;break;
	   case 1:this.menu_231(sc);break;
	   case 2:this.menu_232();break;
	   case 3:this.menu_233(sc);break;
			}
		}
	}

	 public void menu_231(Scanner sc) {

	  this.menu_232();

	  System.out.print("직위 이름 입력> ");

	  String job_title = sc.nextLine();

	  int result = this.employeesDAO.jobAdd(job_title);
		if (result == 0) {
			System.out.println("직위 정보 입력 실패");
		} else {
			System.out.println("직위 정보 입력 완료");
		}
	 }

	 public void menu_232() {

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("기초 정보 관리 > 직위 관리 > 직위 출력");
	  System.out.println("---------------------------------------------------------------");

	  List<Employees> jobList = this.employeesDAO.jobList();

	  System.out.println("---------------------------------------------------------------");
	  System.out.println("직위 번호 / 직위명 / 삭제 가능 여부 ");
	  System.out.println("---------------------------------------------------------------");

	  for (Employees employees : jobList) {

	   String deleteCheck;
			if (employees.getDeleteCheck() == 0) {
				deleteCheck = "Y";
			} else {
				deleteCheck = "N";
			}

	   System.out.printf("%s / %s / %s%n", employees.getJob_id(), employees.getJob_title(), deleteCheck);

	  }
	  System.out.println("---------------------------------------------------------------");

	 }

	 public void menu_233(Scanner sc) {

	  this.menu_232();

	  System.out.print("삭제할 직위 번호 입력> ");
	  String job_id = sc.nextLine();

	  System.out.printf("[%s]를 정말로 삭제하시겠습니까?(Y/N)", job_id);

	  String select = sc.nextLine();
	  if (select.equalsIgnoreCase("Y")) {
	   int result = this.employeesDAO.jobDelete(job_id);
			if (result == 0) {
				System.out.println("직위 정보 삭제가 실패 했습니다.");
			} else {
				System.out.println("직위 정보 삭제가 완료 되었습니다.");
			}
		} else if (select.equalsIgnoreCase("N")) {
			System.out.println("직위 정보 삭제를 취소했습니다.");
		}

	 }
}
