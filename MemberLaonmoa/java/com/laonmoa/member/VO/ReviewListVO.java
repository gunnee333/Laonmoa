package com.laonmoa.member.VO;

import java.util.Date;

public class ReviewListVO {
	private int bnum;	//게시글번호	=> 자동증가
	private String id;	//작성자 아이디
	private int fno;	//행사번호
	private String title;	//게시글제목
	private String content;	//게시글내용
	private String fname;	//행사이름
	private String image;	//이미지주소
	private int level;	// 축제종류
	private Date sdate;	//행사시작일
	private Date edate;	//행사종료일
	
	public ReviewListVO() {
		super();
	}

	public ReviewListVO(int bnum, String id, int fno, String title, String content, String fname, String image, int level, Date sdate, Date edate) {
		super();
		this.bnum = bnum;
		this.id = id;
		this.fno = fno;
		this.title = title;
		this.content = content;
		this.fname = fname;
		this.image = image;
		this.level = level;
		this.sdate = sdate;
		this.edate = edate;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
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

	@Override
	public String toString() {
		return "ReviewListVO [bnum=" + bnum + ", id=" + id + ", fno=" + fno + ", title=" + title + ", content="
				+ content + ", fname=" + fname + ", image=" + image + ", level=" + level + ", sdate=" + sdate
				+ ", edate=" + edate + "]";
	}
	
}
