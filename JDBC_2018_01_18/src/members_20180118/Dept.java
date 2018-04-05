package members_20180118;


public class Dept {

	//부서번호, 부서명
	
	private String dept_id;
	private String dept_name;
	
	public Dept() {
		
	}
	
	public Dept(String dept_id, String dept_name) {
		this.dept_id = dept_id;
		this.dept_name = dept_name;
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
	@Override
	public String toString() {
		return String.format("%s %s", this.dept_id, this.dept_name);
	}
	
}
