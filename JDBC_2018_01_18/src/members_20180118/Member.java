package members_20180118;

import java.time.LocalDate;
import java.util.*;
import java.time.LocalDate;

public class Member {

	//회원번호, 이름, 전화번호, 이메일, 등록일, 부서번호, 부서명
	private String mem_id;
	private String name_;
	private String phone;
	private String email;
	private LocalDate regDate;
	private String dept_id;
	private String dept_name;
	
	public Member() {
		
	}
	
	public Member(String name_, String phone, String email, LocalDate regDate, String dept_id){
		this.name_ = name_;
		this.email = email;
		this.phone = phone;
		this.regDate = regDate;
		this.dept_id = dept_id;
	}
	
	public Member(String mem_id, String name_, String phone, String email, LocalDate regDate, String dept_name) {
		this.mem_id = mem_id;
		this.name_ = name_;
		this.email = email;
		this.phone = phone;
		this.regDate = regDate;
		this.dept_name = dept_name;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public LocalDate getregDate() {
		return regDate;
	}
	public void setregDate(LocalDate regDate) {
		this.regDate = regDate;
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
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return String.format("%s %s %s %s %s %s", this.mem_id, this.name_, this.phone, this.email, this.regDate, this.dept_name);
	}
}
