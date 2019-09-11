package com.laon.moa.VO;

public class LevelVO {
	private int level;	//분류레벨	=>자동증가
	private String levelcode;	//분류타입(member...)
	private String leveltype;	//분류레벨값
	public LevelVO() {
		super();
	}
	
	public LevelVO(int level, String levelcode, String leveltype) {
		super();
		this.level = level;
		this.levelcode = levelcode;
		this.leveltype = leveltype;
	}

	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getLeveltype() {
		return leveltype;
	}
	public void setLeveltype(String leveltype) {
		this.leveltype = leveltype;
	}

	public String getLevelcode() {
		return levelcode;
	}

	public void setLevelcode(String levelcode) {
		this.levelcode = levelcode;
	}

	@Override
	public String toString() {
		return "LevelVO [level=" + level + ", levelcode=" + levelcode + ", leveltype=" + leveltype + "]";
	}
	
}
