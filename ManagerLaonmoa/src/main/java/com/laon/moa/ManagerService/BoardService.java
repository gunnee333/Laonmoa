package com.laon.moa.ManagerService;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.ReplyVO;
import com.laon.moa.VO.ReviewBoardVO;

@Service
public interface BoardService {
	
//---------------------------------------자유게시판---------------------------------------------
	
	// 자유게시판 목록/페이징
	public int freeBoardCount(Map<String, Object> map) throws Exception;

	// 자유게시판 목록/페이징
	public List<BoardVO> freeBoardList(Map<String, Object> map) throws Exception;

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
	public int freeBoardSearchcnt(String keyword, String search) throws Exception;
	
	// 자유게시판 검색
	public List<BoardVO> freeBoardsearch(@RequestParam("pagenum") int pagenum,
	@RequestParam("contentnum") int contentnum, String keyword, String search) throws Exception;

//---------------------------------------리뷰게시판---------------------------------------------

	// 리뷰게시판 글갯수
	public int reviewBoardCount(Map<String, Object> map) throws Exception;

	// 리뷰게시판 목록/페이징
	public List<BoardVO> reviewBoardList(Map<String, Object> map) throws Exception;
	
	// 리뷰게시판 글쓰기
	public int reviewInsert(Map<String, Object> map) throws Exception;
	
	// 축제찾는 팝업 축제 글갯수
	public int popupCultureCnt(Map<String, Object> map);
	
	// 축제찾는 팝업 목록/페이징
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
	public int reviewBoardSearchcnt(String keyword, String search) throws Exception;

	// 리뷰게시판 검색
	public List<ReviewBoardVO> reviewBoardsearch(@RequestParam("pagenum") int pagenum,
		@RequestParam("contentnum") int contentnum, String keyword, String search) throws Exception;

//--------------------------------------------공지---------------------------------------------------

	// 공지게시판 글갯수
	public int noticeCount(Map<String, Object> map) throws Exception;

	// 공지게시판 목록/페이징
	public List<BoardVO> noticeList(Map<String, Object> map) throws Exception;

	// 공지게시판 글쓰기
	public int NoticeInsert(BoardVO vo) throws Exception;

	// 공지게시판 상세보기
	public BoardVO NoticeDetail(int bnum) throws Exception;

	// 공지게시판 수정하기
	public void NoticeChange(BoardVO vo) throws Exception;

	// 공지게시판 삭제하기
	public void NoticeDelete(int bnum) throws Exception;

	// 게시중/삭제 구분하기
	public List<BoardVO> noticeListDel(int del) throws Exception;
	
	// 공지게시판 검색 카운트
	public int noticeSearchcnt(String keyword, String search, int level) throws Exception;
	
	// 공지게시판 검색
	public List<BoardVO> noticeSearch(int pagenum, int contentnum, String keyword, String search, int level) throws Exception;
	

// ------------------------------------------------리플구간-----------------------------------------------------------
	
	// 댓글 리스트
	public List<ReplyVO> replyList(Map<String, Object> map);

	// 댓글 리스트 갯수
	public int replyListCnt(Map<String, Object> map);
	
	// 댓글 상세보기
	public List<ReplyVO> ReplyDetail(int bnum) throws Exception;
	
	// 댓글불러오기
	public ReplyVO replyDetailOne(int rnum);
	
	// 댓글 접수
	public void ReplyUpdate(int rnum) throws Exception;

	// 댓글 삭제 취소
	public void ReplyDelete(int rnum) throws Exception;

	// 댓글 검색 //
	public List<ReplyVO> ReplySearch(Map<String, String> map);

	// 리플 페이징
	public List<ReplyVO> listPage(int displayPost, int postNum);

	// 전체리플 조회
	public int Replycount();

}
