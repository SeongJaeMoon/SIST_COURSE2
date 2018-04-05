package com.test;

//자료형 클래스 
public class Login {
	
	private String id_, pw_;
	private int grade;
	
	public Login() {
		
	}
	public Login(String id_, String pw_, int grade) {
		this.id_ = id_;
		this.pw_ = pw_;
		this.grade = grade;
	}
	
	public String getId_() {
		return id_;
	}
	public void setId_(String id_) {
		this.id_ = id_;
	}
	public String getPw_() {
		return pw_;
	}
	public void setPw_(String pw_) {
		this.pw_ = pw_;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	} 
	
}
