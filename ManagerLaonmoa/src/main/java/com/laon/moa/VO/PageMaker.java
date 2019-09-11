package com.laon.moa.VO;

public class PageMaker {
	private int totalcount; // 전체 게시물 개수
	private int pagenum; // 현재 페이지 번호
	private int contentnum = 10; // 한 페이지에 보여줄 개수
	private int startpage = 1; // 현재 페이지블록의 시작 페이지
	private int endpage = 5; // 현재 페이지 블록의 마지막 페이지
	private boolean prev = false; // 이전 페이지로
	private boolean next; // 다음 페이지로
	private int currentblock; // 현재 페이지 블록
	private int lastblock; // 마지막 페이지 블록
	
	//앞뒤 페이지 버튼의 보이기 유무를 선택
	public void prevnext(int pagenum) { //페이지번호를 입력받아서 결정한다.
		if(pagenum>0 && pagenum<6) { 
			// 페이지 번호가 1~5라면 이전버튼 안보임
			setPrev(false);
		} else {
			// 페이지번호가 6 이상일 때 이전버튼 보임
			setPrev(true);
		}
		if(getLastblock() == getCurrentblock()) {
			// 현재의 블록과 마지막블록이 같다면 다음버튼 안보이기
			setNext(false);
		} else {
			// 현재 블록과 마지막블록이 다르다면 다음버튼 보이기
			setNext(true);
		}
	}
	
	//전체 페이지를 구하는 함수
	public int calcpage(int totalcount, int contentnum) {
		//전체 페이지 = 전체게시물 / 한 페이지에 표시할 게시물 개수
		// 125 / 10의 나머지 =  0.5 > 0 => 12+1 => 13페이지 필요
		int totalpage = totalcount / contentnum;
		if(totalcount%contentnum>0) {
			totalpage++;
		}
		return totalpage;
	}
	
	public int getTotalcount() {
		return totalcount;
	}
	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}
	public int getPagenum() {
		return pagenum;
	}
	public void setPagenum(int pagenum) {
		this.pagenum = pagenum;
	}
	public int getContentnum() {
		return contentnum;
	}
	public void setContentnum(int contentnum) {
		this.contentnum = contentnum;
	}
	public int getStartpage() {
		return startpage;
	}
	public void setStartpage(int currentblock) {
		//첫 페이지를 구하는 함수(페이지 5개씩 나눌 때)
		this.startpage = (currentblock*5)-4;
		//1 2 3 4 5
		//6 7 8 9 10
		//11 12 13 14 15
		// 페이지를 10개씩 보여줄 경우
		// this.startpage = (currentblock*10)-9;
	}
	public int getEndpage() {
		return endpage;
	}
	
	//마지막 블록일 때 보여주는 페이지번호를 구하는 함수
	// ex) << 11 12 13 처럼 마지막페이지가 13에서 끝날 수 있음
	public void setEndpage(int getlastblock,int getcurrentblock) {
		if (getlastblock == getcurrentblock) {
			//마지막 페이지 = 전체 페이지의 개수를 구하는 함수
			this.endpage = calcpage(getTotalcount(), getContentnum());
		}
		else { // 아니라면 스타트페이지의+4 (5개씩 보여주기 때문에)
			   // 10개씩 보여주는 경우였다면 +9
			this.endpage = getStartpage()+4;
		}
		
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getCurrentblock() {
		return currentblock;
	}
	public void setCurrentblock(int pagenum) {
		// 페이지 번호를 통해서 구한다
		// 페이지 번호 / 페이지 블록 안의 페이지 개수 
		// 1p 1 / 5 = > 0.2 int이기때문에 0이되고 +1 => 현재 페이지블록1
		// 3p 3 / 5 = > 0.6 => 0 + 1 => 현재 페이지 블록1
		// 8p 8 / 5 = > 1.6 => 1 + 1 => 현재 페이지 블록2
		this.currentblock = pagenum/5;
		if(pagenum%5>0) {
			this.currentblock++;
		}
	}
	public int getLastblock() {
		return lastblock;
	}
	public void setLastblock(int lastblock) {
		// 게시물 10개씩 한 페이지블록당 5개 페이지
		// 10 * 5 = 50
		// 마지막 페이지블록 = 125(전체글) / 50(한블록에 게시글) = 2.5
		// 125(전체글) % 50(한블록에 게시글) = 0.5>0이면 ++로 3페이지블록이 필요
		this.lastblock = totalcount / (5 * this.contentnum);
		if(totalcount %(5*this.contentnum)>0) {
			this.lastblock++;
		}
	}
	public void init() {
		startpage = 1;
		endpage = 1;
		contentnum = 0;
		prev = false;
		next = false;
		pagenum = 1;
		currentblock = 1;
		lastblock = 1;
	}

	@Override
	public String toString() {
		return "PageMaker [startpage=" + startpage + ", endpage=" + endpage + ", contentnum=" + contentnum + ", prev="
				+ prev + ", next=" + next + ", pagenum=" + pagenum + ", totalcount=" + totalcount + ", currentblock="
				+ currentblock + ", lastblock=" + lastblock + "]";
	}
	
}
