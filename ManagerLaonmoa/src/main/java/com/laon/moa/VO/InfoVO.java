package com.laon.moa.VO;

import java.util.Date;

public class InfoVO {
	private int fno;	//축제번호 => 자동증가
	private int level;	//분류레벨
	private String fname;	//행사이름
	private String sdate;	//행사시작일
	private String edate;	//행사종료일
	private String location_1;	//행사지역
	private String location_2;	//행사상세지역
	private String fcontent;	//행사내용
	private String image;	//이미지주소
	private String gps;	//위치정보
	private String kind;	//축제종류(유아용, 가족용....)
	private String tel;
	private String homepage;
	private String host;
	
	public String getTel() {
		return tel;
	}


	public void setTel(String tel) {
		this.tel = tel;
	}


	public String getHomepage() {
		return homepage;
	}


	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}


	public String getHost() {
		return host;
	}


	public void setHost(String host) {
		this.host = host;
	}


	public InfoVO() {
		super();
	}


	public InfoVO(int fno, int level, String fname, String sdate, String edate, String location_1, String location_2,
			String fcontent, String image, String gps, String kind) {
		super();
		this.fno = fno;
		this.level = level;
		this.fname = fname;
		this.sdate = sdate;
		this.edate = edate;
		this.location_1 = location_1;
		this.location_2 = location_2;
		this.fcontent = fcontent;
		this.image = image;
		this.gps = gps;
		this.kind = kind;
	}


	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}


	public String getLocation_1() {
		return location_1;
	}


	public void setLocation_1(String location_1) {
		this.location_1 = location_1;
	}


	public String getLocation_2() {
		return location_2;
	}


	public void setLocation_2(String location_2) {
		this.location_2 = location_2;
	}


	public String getFcontent() {
		return fcontent;
	}

	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getGps() {
		return gps;
	}

	public void setGps(String gps) {
		this.gps = gps;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}


	@Override
	public String toString() {
		return "InfoVO [fno=" + fno + ", level=" + level + ", fname=" + fname + ", sdate=" + sdate + ", edate=" + edate
				+ ", location_1=" + location_1 + ", location_2=" + location_2 + ", fcontent=" + fcontent + ", image="
				+ image + ", gps=" + gps + ", kind=" + kind + "]";
	}

	
	
}
