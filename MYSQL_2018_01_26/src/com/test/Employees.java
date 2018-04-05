package com.test;

import java.time.LocalDate;

public class Employees {

	private String reg_id, reg_name, dept_id, dept_name, job_id, job_title;

	 // 삭제 가능ㅇ 여부 확인용 필드
	 private int deleteCheck;
	 
	 public Employees() {
	 
	 }


	 public String getReg_id() {
	  return reg_id;
	 }

	 public void setReg_id(String reg_id) {
	  this.reg_id = reg_id;
	 }

	 public String getReg_name() {
	  return reg_name;
	 }

	 public void setReg_name(String reg_name) {
	  this.reg_name = reg_name;
	 }

	 public int getDeleteCheck() {
	  return deleteCheck;
	 }

	 public void setDeleteCheck(int deleteCheck) {
	  this.deleteCheck = deleteCheck;
	 }


	 public String getDept_id() {
	  return dept_id;
	 }


	 public void setDept_id(String dept_id) {
	  this.dept_id = dept_id;
	 }


	 public String getDept_name() {
	  return dept_name;
	 }


	 public void setDept_name(String dept_name) {
	  this.dept_name = dept_name;
	 }


	 public String getJob_id() {
	  return job_id;
	 }


	 public void setJob_id(String job_id) {
	  this.job_id = job_id;
	 }


	 public String getJob_title() {
	  return job_title;
	 }


	 public void setJob_title(String job_title) {
	  this.job_title = job_title;
	 }
	
}
