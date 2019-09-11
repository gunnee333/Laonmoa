package com.laon.moa.VO;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class ReplyVO {
	private int rnum;	//댓글번호 => 자동증가
	private int bnum;	//게시글번호
	private int level;	//분류레벨
	private String id;	//작성자 아이디
	private String rcontent;	//댓글내용
	private Date date;	//작성일
	private int del;	//삭제여부 => 0게시중, 1삭제
	
	public ReplyVO() {
		super();
	}

	public ReplyVO(int rnum, int level, String id, int bnum, String rcontent, Date date, int del) {
		super();
		this.rnum = rnum;
		this.level = level;
		this.id = id;
		this.bnum = bnum;
		this.rcontent = rcontent;
		this.date = date;
		this.del = del;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
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

	@Override
	public String toString() {
		return "RepleVO [rnum=" + rnum + ", level=" + level + ", id=" + id + ", bnum=" + bnum + ", rcontent=" + rcontent
				+ ", date=" + date + ", del=" + del + "]";
	}
	
}
