package com.test;

//자료형 클래스 선언
public class Schedule {
	
	// 자료형 클래스 선언시 멤버 구성은
	// 동일 자료, 동일 식별자 권장
	// ->데이터베이스 입력, 출력 액션에서 사용한 모든 식별자(특히 별칭 사용한 경우)를 멤버로 구성
	// ->테이블의 컬럼 구성시 사용한 컬럼명 및 자료형을 멤버로 구성
	// ->오라클에서 NUMBER 자료형인 경우 Java에서는 int, double 자료형
	// ->오라클에서 VARCHAR2, NVARCHAR2 자료형인 경우 Java에서는 String 자료형
	// ->오라클에서 DATE 자료형인 경우 Java에서는 Date, LocalDate 자료형
	
	//sid_, datetime, content_, count_
	private int sid_, count_;
	private String content_, datetime;

	public Schedule(String datetime, String content_) {
		this.datetime = datetime;
		this.content_ = content_;
	}

	public Schedule(int sid_, String datetime, String content_) {
		this.sid_ = sid_;
		this.datetime = datetime;
		this.content_ = content_;
	}

	public Schedule(String datetime, int count_) {
		this.datetime = datetime;
		this.count_ = count_;
	}

	public int getSid_() {
		return sid_;
	}

	public void setSid_(int sid_) {
		this.sid_ = sid_;
	}

	public int getCount_() {
		return count_;
	}

	public void setCount_(int count_) {
		this.count_ = count_;
	}

	public String getContent_() {
		return content_;
	}

	public void setContent_(String content_) {
		this.content_ = content_;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	@Override
	public String toString() {
		return String.format("%s %s %s", this.sid_, this.datetime, this.content_);
	}
	
}
