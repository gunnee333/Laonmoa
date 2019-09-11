package com.laonmoa.member.VO;

public class WishlistVO {
	private int num;	//PK번호 => 자동증가
	private String id;	//아이디
	private int fno;	//행사번호
	private int level;	//분류레벨
	
	public WishlistVO() {
		super();
	}

	public WishlistVO(int num, String id, int fno, int level) {
		super();
		this.num = num;
		this.id = id;
		this.fno = fno;
		this.level = level;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
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

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "WishlistVO [num=" + num + ", id=" + id + ", fno=" + fno + ", level=" + level + "]";
	}
	
	
}
