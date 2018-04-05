package com.test;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;
import java.util.regex.Pattern;

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
	 /*
	  1.사번정렬  2.이름정렬  3.지역정렬  4.부서정렬  5.직위정렬
	  선택(1~5, 0 quit)?0
	  */
	 
	 public void menu_1(Scanner sc) {
		 boolean run = true;
		 while(run) {
		 System.out.println("1.직원입력  2.직원전체출력  3.직원검색  4.직원삭제");
		 System.out.print("선택(1~3, 0 quit)?");
		 int in = sc.nextInt();
		 sc.nextLine();
		 switch(in) {
		 case 0: run = false;break;
		 case 1: this.menu_11(sc);break;
		 case 2: this.menu_12(sc);break;
		 case 3: this.menu_13(sc);break;
		 case 4: this.menu_14(sc);break; 
		 	}
		 }
	 }
	 
	 private void menu_12(Scanner sc) {
		 System.out.println("1.사번정렬  2.이름정렬  3.지역정렬  4.부서정렬  5.직위정렬");
		 System.out.print("선택(1~5, 0 quit)?");
		 int in = sc.nextInt();
		 sc.nextLine();
		 switch(in) {
		 case 1: this.menu_123();break;
		 case 2: this.menu_124();break;
		 case 3: this.menu_125();break;
		 case 4: this.menu_126();break;
		 case 5: this.menu_127();break;
		 }
	 }
	 
	 private void menu_123() {
		 this.employeesLIst("eid");
	 }
	 
	 private void menu_124() {
		 this.employeesLIst("name_");
	 }
	 
	 private void menu_125() {
		 this.employeesLIst("reg_name");
	 }
	 
	 private void menu_126() {
		 this.employeesLIst("dept_name");
	 }
	 
	 private void menu_127() {
		 this.employeesLIst("job_title");
	 }
	 
	 private void menu_13(Scanner sc) {
		 boolean run = true;
		 while(run) {
		 System.out.println("1.사번 검색 2.이름 검색 3.지역 검색 4.부서 검색 5.직업 검색");
		 System.out.print("선택(1~5, 0 quit)?");
		 int in = sc.nextInt();
		 sc.nextLine();
		 switch(in) {
		 case 0: run = false;break;
		 case 1: this.menu_131(sc);break;
		 case 2: this.menu_132(sc);break;
		 case 3: this.menu_133(sc);break;
		 case 4: this.menu_134(sc);break;
		 case 5: this.menu_135(sc);break;
		 	}
		 }
	 }
	 private int menu_131(Scanner sc) {
		 int result = 0;
		 System.out.print("검색할 사번 입력 >");
		 String value = sc.nextLine();
		 List<Employees>list = this.employeesDAO.list("eid", value);
		 StringBuilder sb = new StringBuilder();
		 for(Employees e : list) {
			 sb.append(String.format("%s%n", e.toString()));
		 }
		 if(list.size()==0) {
			 System.out.println("검색 결과가 없습니다.");
		 }else {
			 System.out.println(sb.toString());
		 }
		 result = list.size();
		 return result;		 
	 }
	
	 private int menu_132(Scanner sc) {
		 int result = 0;
		 System.out.print("검색할 이름 입력 >");
		 String value = sc.nextLine();
		 List<Employees>list = this.employeesDAO.list("name_", value);
		 StringBuilder sb = new StringBuilder();
		 for(Employees e : list) {
			 sb.append(String.format("%s%n", e.toString()));
		 }
		 if(list.size()==0) {
			 System.out.println("검색 결과가 없습니다.");
		 }else {
			 System.out.println(sb.toString());
		 }
		 result = list.size();
		 return result;		 
	 }
	 
	 private int menu_133(Scanner sc) {
		 int result = 0;
		 System.out.print("검색할 지역 입력 >");
		 String value = sc.nextLine();
		 List<Employees>list = this.employeesDAO.list("reg_name", value);
		 StringBuilder sb = new StringBuilder();
		 for(Employees e : list) {
			 sb.append(String.format("%s%n", e.toString()));
		 }
		 if(list.size()==0) {
			 System.out.println("검색 결과가 없습니다.");
		 }else {
			 System.out.println(sb.toString());
		 }
		 result = list.size();
		 return result;		 
	 }
	 
	 private int menu_134(Scanner sc) {
		 int result = 0;
		 System.out.print("검색할 부서 입력 >");
		 String value = sc.nextLine();
		 List<Employees>list = this.employeesDAO.list("dept_name", value);
		 StringBuilder sb = new StringBuilder();
		 for(Employees e : list) {
			 sb.append(String.format("%s%n", e.toString()));
		 }
		 if(list.size()==0) {
			 System.out.println("검색 결과가 없습니다.");
		 }else {
			 System.out.println(sb.toString());
		 }
		 result = list.size();
		 return result;		 
	 }
	 
	 private int menu_135(Scanner sc) {
		 int result = 0;
		 System.out.print("검색할 직업 입력 >");
		 String value = sc.nextLine();
		 List<Employees>list = this.employeesDAO.list("job_title", value);
		 StringBuilder sb = new StringBuilder();
		 for(Employees e : list) {
			 sb.append(String.format("%s%n", e.toString()));
		 }
		 if(list.size()==0) {
			 System.out.println("검색 결과가 없습니다.");
		 }else {
			 System.out.println(sb.toString());
		 }
		 result = list.size();
		 return result;		 
	 }
	 
	 
	 private void menu_14(Scanner sc) {
		 System.out.println("삭제할 회원의 사번을 입력해주세요.");
		 this.menu_141(sc);
	 }
	 
	 private void menu_141(Scanner sc) {
		 int result = this.menu_131(sc);
		 int temp = 0;
		 if(result > 0) {
			 System.out.print("삭제할 사번:");
			 String eid = sc.nextLine();
			 temp = this.employeesDAO.remove(eid);
		 }
		 if(temp != 0) {
			 System.out.printf("%d개의 행이 정상적으로 값이 삭제되었습니다.",temp);
		 }else if(temp==0) {
			 System.out.println("정상적으로 값이 삭제되지 않았습니다.");
		 }
	 }
	 private void menu_11(Scanner sc) {
		  // 이름, 주민번호, ... 등의 항목을 콘솔 입력 받는다.
		  // 주의) 지역, 부서, 직위는 번호 입력을 받기 전에 번호의 범위를 출력한다. FK 지정
		  // 주의) 입력시 특정 패턴을 벗어나거나, 입력 범위를 벗어나는 경우 예외처리
		  System.out.println("**입력 항목에서 0 입력시 입력 취소됨.");

		  System.out.print("이름?");
		  String name_ = sc.nextLine();
		  // 입력 중단
		  if (name_.equals("0")) {
		   // 메소드 액션 진행에 대한 중단
		   return;
		  }

		  System.out.print("주민등록번호(YYMMDD-NNNNNNN))?");
		  String ssn = sc.nextLine();
		  if (ssn.equals("0")) {
		   return;
		  }

		  String date = "";
		  LocalDate hiredate = null;
		  while (true) {
		   System.out.print("입사일(YYYY-MM-DD))?");
		   date = sc.nextLine();
		   if (date.equals("0")) {
		    return;
		   }
		   try {
		    hiredate = LocalDate.parse(date);
		    break;
		   } catch (Exception e) {
		    System.out.println("날짜 형식이 틀렸습니다.");
		   }
		  }

		  System.out.print("전화번호(010-XXXX-XXXX))?");
		  String phone = sc.nextLine();
		  if (phone.equals("0")) {
		   return;
		  }

		  // 지역번호 확인
		  List<Employees> regionList = this.employeesDAO.regionList();
		  System.out.println("지역번호 | 지역명");
		  System.out.println("-----------------");
		  for (Employees e : regionList) {
		   System.out.printf(" %s  |  %s  %n", e.getReg_id(), e.getReg_name());
		  }
		  // 지역번호 범위를 벗어나는 경우 확인하는 과정
		  String reg_id = "";
		  while (true) {
		   System.out.print("지역번호?");
		   reg_id = sc.nextLine();
		   if (reg_id.equals("0")) {
		    return;
		   }
		   // 범위 검사 진행 -> 결과에 따라서 반복문 탈출
		   // 주의) Employees 클래스에서 toString() 메소드 오버라이딩 추가 필요
		   // "[객체1, 객체2, ...]"
		   // "[REG01/null/null/Reg02/...]"
		   boolean result = regionList.toString().contains(reg_id);
		   if (result && reg_id.length()==5) {
		    break;
		   } else {
		    System.out.println("잘못된 범위의 값입니다.");
		   }
		  }

		  // 부서번호 확인
		  List<Employees> departmentList = this.employeesDAO.deptList();
		  System.out.println("부서번호 | 부서명");
		  System.out.println("-----------------");
		  for (Employees e : departmentList) {
		   System.out.printf(" %s  |  %s  %n", e.getDept_id(), e.getDept_name());
		  }
		  // 부서번호 범위를 벗어나는 경우 확인하는 과정
		  String dept_id = "";
		  while (true) {
		   System.out.print("부서번호?");
		   dept_id = sc.nextLine();
		   if (dept_id.equals("0")) {
		    return;
		   }
		   boolean result = departmentList.toString().contains(dept_id);
		   if (result && dept_id.length()==6) {
		    break;
		   } else {
		    System.out.println("잘못된 범위의 값입니다.");
		   }
		  }
		  // 직위번호 확인
		  List<Employees> jobList = this.employeesDAO.jobList();
		  System.out.println("직위번호 | 직위명");
		  System.out.println("-----------------");
		  for (Employees e : jobList) {
		   System.out.printf(" %s  |  %s  %n", e.getJob_id(), e.getJob_title());
		  }
		  String job_id = "";
		  while (true) {
		   System.out.print("직위번호?");
		   job_id = sc.nextLine();
		   if (job_id.equals("0")) {
		    return;
		   }
		   boolean result = jobList.toString().contains(job_id);
		   if (result && job_id.length()==5) {
		    break;
		   } else {
		    System.out.println("잘못된 범위의 값입니다.");
		   }
		  }

		  System.out.print("기본급?");
		  int basicpay = sc.nextInt();
		  sc.nextLine();
		  if (basicpay == 0) {
		   return;
		  }

		  System.out.print("수당?");
		  int extrapay = sc.nextInt();
		  sc.nextLine();
		  if (extrapay == 0) {
		   return;
		  }

		  Employees e = new Employees();
		  e.setName_(name_);
		  e.setSsn(ssn);
		  e.setHiredate(hiredate);
		  e.setPhone(phone);
		  e.setReg_id(reg_id);
		  e.setDept_id(dept_id);
		  e.setJob_id(job_id);
		  e.setBasicpay(basicpay);
		  e.setExtrapay(extrapay);

		  this.employeesDAO.add(e);
		  System.out.println("1개의 행이 입력되었습니다.");
	 }
	 
	 private void employeesLIst(String key) {
		 //정렬 지원되는 전체 출력 액션
		 StringBuilder sb = new StringBuilder();
		 List<Employees>list = this.employeesDAO.list(key);
		 sb.append("----------------------------------------");
		 sb.append("사번 이름   주민번호       입사일     전화번호 	    지역명 부서명   직위명 기본급    수당    급여");
		 sb.append("----------------------------------------");
		 sb.append(String.format("전체 인원: %d명", list.size()));
		 for(Employees e : list) {
			 sb.append(String.format("%s%n", e.toString()));
		 }
		System.out.println(sb.toString()); 
	 }
	 
	 private boolean hireDateExceptionCheck(String hireDate) {
			boolean isOK = false;
			try {
				LocalDate.parse(hireDate, DateTimeFormatter.ISO_LOCAL_DATE);
			} catch (DateTimeParseException e) {
				isOK = true;
			}
			return isOK;
		}
	 
	 private boolean phonePatternExceptionCheck(String phone) {
				//전화번호 패턴 (010-1234-5678)
			String temp = "(\\d{3}).*(\\d{4}).*(\\d{4})";
			Boolean bool = Pattern.matches(temp, phone);
			return bool;
	 }
}
