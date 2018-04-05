package com.test;

//자료형 클래스 선언
//->클래스명 지정시 테이블명과 동일하게 작성
public class Dept {

	//부서번호, 부서명
	//deptId, deptName
	
	//필드 구성
	private String deptId, deptName;
	
	//매개변수 있는 생성자 추가
	public Dept(String deptId, String deptName) {
		this.deptId = deptId;
		this.deptName = deptName;
	}
	
	//getter, setter 구성
	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	//toString() 메소드 오버라이딩
	@Override
	public String toString() {
		return String.format("%s %s", deptId, deptName);
	}
	
}
