package com.laonmoa.member.VO;

import java.util.Date;

public class MemberVO {
	private String id;	//아이디
	private int level;	//분류레벨
	private String password;	//비밀번호
	private String name;	//이름
	private String email;	//이메일
	private String tel;	//전화번호
	private String address_1;	//주소
	private String address_2;	//상세주소
	private String zipcode;	//우편번호
	private int age;	//생년월일
	private int secession;	//탈퇴여부  => 0 사용중, 1 탈퇴
	private int warcnt;	//경고횟수
	private Date lastLoginTime;	//마지막으로 로그인한 날짜
	
	public MemberVO() {
		super();
	}
	
	public MemberVO(String id, int level, String password, String name, String email, String tel, String address_1,
			String address_2, String zipcode, int age, int secession, int warcnt, Date lastLoginTime) {
		super();
		this.id = id;
		this.level = level;
		this.password = password;
		this.name = name;
		this.email = email;
		this.tel = tel;
		this.address_1 = address_1;
		this.address_2 = address_2;
		this.zipcode = zipcode;
		this.age = age;
		this.secession = secession;
		this.warcnt = warcnt;
		this.lastLoginTime = lastLoginTime;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getAddress_1() {
		return address_1;
	}

	public void setAddress_1(String address_1) {
		this.address_1 = address_1;
	}

	public String getAddress_2() {
		return address_2;
	}

	public void setAddress_2(String address_2) {
		this.address_2 = address_2;
	}

	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getSecession() {
		return secession;
	}
	public void setSecession(int secession) {
		this.secession = secession;
	}
	public int getWarcnt() {
		return warcnt;
	}
	public void setWarcnt(int warcnt) {
		this.warcnt = warcnt;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", level=" + level + ", password=" + password + ", name=" + name + ", email="
				+ email + ", tel=" + tel + ", address_1=" + address_1 + ", address_2=" + address_2 + ", zipcode="
				+ zipcode + ", age=" + age + ", secession=" + secession + ", warcnt=" + warcnt + ", lastLoginTime="
				+ lastLoginTime + "]";
	}
	
	
}
