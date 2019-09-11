package com.laonmoa.member.VO;

import java.util.Date;

public class ReviewBoardVO {
	private int bnum;	//게시글번호	=> 자동증가
	private String id;	//작성자 아이디
	private int level;	//분류레벨
	private int fno;	//행사번호
	private String title;	//게시글제목
	private String content;	//게시글내용
	private int hit;	//조회수
	private Date date;	//작성일
	private int del;	//삭제여부 => 0 게시중, 1사용중
	private String image;	//이미지주소
	private int flevel; //축제 레벨
	private String fname; //축제 이름
	
	public ReviewBoardVO() {
		
	}
	
	public ReviewBoardVO(int bnum, String id, int level, int fno, String title, String content, int hit, Date date,
			int del, String image, int flevel, String fname) {
		this.bnum = bnum;
		this.id = id;
		this.level = level;
		this.fno = fno;
		this.title = title;
		this.content = content;
		this.hit = hit;
		this.date = date;
		this.del = del;
		this.image = image;
		this.flevel = flevel;
		this.fname = fname;
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
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getFlevel() {
		return flevel;
	}
	public void setFlevel(int flevel) {
		this.flevel = flevel;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	
	@Override
	public String toString() {
		return "ReviewBoardVO [bnum=" + bnum + ", id=" + id + ", level=" + level + ", fno=" + fno + ", title=" + title
				+ ", content=" + content + ", hit=" + hit + ", date=" + date + ", del=" + del + ", image=" + image
				+ ", flevel=" + flevel + ", fname=" + fname + "]";
	}
	
	
}
