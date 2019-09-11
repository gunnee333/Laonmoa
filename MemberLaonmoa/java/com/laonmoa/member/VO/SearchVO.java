package com.laonmoa.member.VO;

import java.util.Date;

public class SearchVO {
	
	private int level;	//�з�����
	private int fno;	//����ȣ
	private String fname;
	private String image;	//�̹����ּ�
	private Date sdate;
	private Date edate;
	private String fcontent;
	private String location_1;
	private int count;

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public SearchVO() {
		super();
	}
	
	public SearchVO(int level, int fno, String fname, String image, Date sdate, Date edate, String fcontent,
			String location_1, int count) {
		super();
		this.level = level;
		this.fno = fno;
		this.fname = fname;
		this.image = image;
		this.sdate = sdate;
		this.edate = edate;
		this.fcontent = fcontent;
		this.location_1 = location_1;
		this.count = count;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getSdate() {
		return sdate;
	}

	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}

	public Date getEdate() {
		return edate;
	}

	public void setEdate(Date edate) {
		this.edate = edate;
	}

	public String getFcontent() {
		return fcontent;
	}

	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}

	public String getLocation_1() {
		return location_1;
	}

	public void setLocation_1(String location_1) {
		this.location_1 = location_1;
	}

	@Override
	public String toString() {
		return "SearchVO [level=" + level + ", fno=" + fno + ", fname=" + fname + ", image=" + image + ", sdate="
				+ sdate + ", edate=" + edate + ", fcontent=" + fcontent + ", location_1=" + location_1 + ", count="
				+ count + "]";
	}


	
	
	
}
