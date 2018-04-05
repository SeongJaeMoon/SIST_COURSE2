package com.test01;

//자료형 클래스 선언
//->클래스명 지정시 테이블명과 동일하게 작성
public class Test {
	
	//데이터베이스 입력, 출력 액션에서 사용한 모든 식별자(특히 별칭 사용한 경우)를 멤버로 구성해야 한다. 
	
	private int id_, age_;
	private String first_, last_;
	
	public Test() {
		
	}
	
	public Test(int age_, String first_, String last_) {
		this.age_ = age_;
		this.first_ = first_;
		this.last_ = last_;
	}
	
	public Test(int id_, int age_, String first_, String last_){
		this.id_ = id_;
		this.age_ = age_;
		this.first_ = first_;
		this.last_ = last_;
	}
	
	public int getId_() {
		return id_;
	}
	public void setId_(int id_) {
		this.id_ = id_;
	}
	public int getAge_() {
		return age_;
	}
	public void setAge_(int age_) {
		this.age_ = age_;
	}
	public String getFirst_() {
		return first_;
	}
	public void setFirst_(String first_) {
		this.first_ = first_;
	}
	public String getLast_() {
		return last_;
	}
	public void setLast_(String last_) {
		this.last_ = last_;
	}
	@Override
	public String toString() {
		return String.format("%d %d %s %s", this.id_, this.age_, this.first_, this.last_); 
	}
}
