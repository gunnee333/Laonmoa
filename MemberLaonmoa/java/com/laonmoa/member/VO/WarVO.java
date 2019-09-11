package com.laonmoa.member.VO;

import java.sql.Date;

public class WarVO {
	private int wnum;	//신고내역번호 => 자동증가
	private String warid;	//신고당한 아이디
	private String whoid;	//신고한 아이디
	private int level;	//분류레벨
	private int bnum;	//게시글번호
	private int rnum;	//댓글번호
	private int process;	//처리여부 => 0 미처리, 1 처리
	private String wcontent;	//신고내용
	private Date wdate;	//신고일
	
	public WarVO() {
		super();
	}

	public WarVO(int wnum, String warid, String whoid, int level, int bnum, int rnum, int process, String wcontent,
			Date wdate) {
		super();
		this.wnum = wnum;
		this.warid = warid;
		this.whoid = whoid;
		this.level = level;
		this.bnum = bnum;
		this.rnum = rnum;
		this.process = process;
		this.wcontent = wcontent;
		this.wdate = wdate;
	}

	public int getWnum() {
		return wnum;
	}

	public void setWnum(int wnum) {
		this.wnum = wnum;
	}

	public String getWarid() {
		return warid;
	}

	public void setWarid(String warid) {
		this.warid = warid;
	}

	public String getWhoid() {
		return whoid;
	}

	public void setWhoid(String whoid) {
		this.whoid = whoid;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getProcess() {
		return process;
	}

	public void setProcess(int process) {
		this.process = process;
	}

	public String getWcontent() {
		return wcontent;
	}

	public void setWcontent(String wcontent) {
		this.wcontent = wcontent;
	}

	public Date getWdate() {
		return wdate;
	}

	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "WarVO [wnum=" + wnum + ", warid=" + warid + ", whoid=" + whoid + ", level=" + level + ", bnum=" + bnum
				+ ", rnum=" + rnum + ", process=" + process + ", wcontent=" + wcontent + ", wdate=" + wdate + "]";
	}
	
	

}
