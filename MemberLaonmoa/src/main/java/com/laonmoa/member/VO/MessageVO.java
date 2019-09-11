package com.laonmoa.member.VO;

import java.util.Date;

public class MessageVO {
	private int mnum;	//메시지번호 => 자동증가
	private String sendid;	//보낸사람 아이디
	private String recid;	//받는사람 아이디
	private String mtitle;	//메시지제목
	private String mcontent;	//메시지내용
	private Date date;	//작성일
	private int ifread;	//열람여부 => 0 미열람, 1열람
	
	public MessageVO() {
		super();
	}
	public MessageVO(int mnum, String sendid, String recid, String mtitle, String mcontent, Date date, int ifread) {
		super();
		this.mnum = mnum;
		this.sendid = sendid;
		this.recid = recid;
		this.mtitle = mtitle;
		this.mcontent = mcontent;
		this.date = date;
		this.ifread = ifread;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public String getSendid() {
		return sendid;
	}
	public void setSendid(String sendid) {
		this.sendid = sendid;
	}
	public String getRecid() {
		return recid;
	}
	public void setRecid(String recid) {
		this.recid = recid;
	}
	public String getMtitle() {
		return mtitle;
	}
	public void setMtitle(String mtitle) {
		this.mtitle = mtitle;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getIfread() {
		return ifread;
	}
	public void setIfread(int ifread) {
		this.ifread = ifread;
	}
	@Override
	public String toString() {
		return "MessageVO [mnum=" + mnum + ", sendid=" + sendid + ", recid=" + recid + ", mtitle=" + mtitle
				+ ", mcontent=" + mcontent + ", date=" + date + ", ifread=" + ifread + "]";
	}
	
	
}
