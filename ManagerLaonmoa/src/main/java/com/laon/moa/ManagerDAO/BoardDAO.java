package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.ReplyVO;
import com.laon.moa.VO.ReviewBoardVO;

public interface BoardDAO {
	
//----------------------------------------자유게시판-----------------------------------------------
	
	// 자유게시판 글갯수
	public int freeBoardCount(Map<String, Object> map) throws Exception;
		
	// 자유게시판 목록/페이징
	public List<BoardVO> freeBoardList(Map<String,Object> map) throws Exception;

	// 자유게시판 글쓰기
	public int BoardInsert(BoardVO vo) throws Exception;

	// 자유게시판 상세보기
	public BoardVO BoardDetail(int bnum) throws Exception;

	// 자유게시판 수정하기
	public void BoardChange(BoardVO vo) throws Exception;

	// 자유게시판 삭제하기
	public void BoardDelete(int bnum) throws Exception;

	// 게시중/삭제 구분하기
	public List<BoardVO> listDel(int del);
	
	// 자유게시판 검색 카운트
	public int freeBoardSearchcnt(Map<String, String> map) throws Exception;

	// 자유게시판 검색
	public List<BoardVO> freeBoardsearch(Map<String, Object> map) throws Exception;
	
	
	
//----------------------------------------리뷰게시판-----------------------------------------------

	// 리뷰게시판 글갯수
	public int reviewBoardCount(Map<String, Object> map) throws Exception;
			
	// 리뷰게시판 목록/페이징
	public List<BoardVO> reviewBoardList(Map<String,Object> map) throws Exception;
	
	// 리뷰게시판 글쓰기
	public int reviewInsert(Map<String, Object> map) throws Exception;
	
	// 축제찾는 팝업 축제 갯수
	public int popupCultureCnt(Map<String, Object> map);

	// 축제찾는 팝업 목록
	public List<InfoVO> popupCulture(Map<String, Object> map);

	// 리뷰게시판 상세보기
	public ReviewBoardVO reviewDetail(int bnum) throws Exception;

	// 리뷰게시판 수정하기
	public void reviewChange(BoardVO vo) throws Exception;

	// 리뷰게시판 삭제하기
	public void reviewDelete(int bnum) throws Exception;

	// 게시중/삭제 구분하기
	public List<BoardVO> reviewListDel(int del) throws Exception;
	
	// 리뷰게시판 검색 카운트
	public int reviewBoardSearchcnt(Map<String, String> map) throws Exception;

	// 리뷰게시판 검색
	public List<ReviewBoardVO> reviewBoardsearch(Map<String, Object> map) throws Exception;
	

	// -------------------------------------------공지게시판---------------------------------------------

	// 공지게시판 글갯수
	public int noticeCount(Map<String, Object> map) throws Exception;
		
	// 공지게시판 목록/페이징
	public List<BoardVO> noticeList(Map<String, Object> map) throws Exception;

	// 공지사항 글쓰기
	public int NoticeInsert(BoardVO vo) throws Exception;

	// 공지사항 수정하기
	public void NoticeChange(BoardVO vo) throws Exception;

	// 공지사항 삭제하기
	public void NoticeDelete(int del) throws Exception;

	// 공지사항 상세보기
	public BoardVO NoticeDetail(int bnum) throws Exception;

	// 게시중/삭제 구분하기 
	public List<BoardVO> NoticeListDel(int del) throws Exception;
	
	// 공지게시판 검색 카운트
	public int noticeSearchcnt(Map<String, Object> map) throws Exception;

	// 공지게시판 검색
	public List<BoardVO> noticeSearch(Map<String, Object> map) throws Exception;
	

//-------------------------------------------------리플 구간---------------------------------------------------------
	
	//댓글 리스트
	public List<ReplyVO> replyList(Map<String, Object> map);
	
	// 댓글 리스트 갯수
	public int replyListCnt(Map<String,Object> map);
	
	//댓글 상세보기
	public List<ReplyVO> ReplyDetail(int bnum) throws Exception;
	
	// 댓글불러오기
	public ReplyVO replyDetailOne(int rnum);
	
	//댓글 삭제
	public void ReplyUpdate(int rnum)throws Exception;

	//댓글 검색
	public List<ReplyVO> ReplySearch(Map<String, String>map);

	// 전체 인원 조회
	public int Replycount();

	//페이징철휘
	public List<ReplyVO> listPage(Map map);
	
	//댓글 삭제 기각
	public void ReplyDelete(int rnum)throws Exception;
//		int count() throws Exception;


}
