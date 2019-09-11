package com.laonmoa.member.MemberService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReplyVO;
import com.laonmoa.member.VO.ReviewBoardVO;
import com.laonmoa.member.VO.ReviewListVO;

public interface BoardService {

	// 메인페이지에 보여줄 베스트 리뷰리스트
	public List<ReviewListVO> bestReviewList(int reviewCnt);

	// 자유게시판 게시글 수
	public int freeBoardcount() throws Exception;

	// 자유게시판 리스트(공지사항, 1페이지만)
	public List<BoardVO> adminList() throws Exception;

	// 자유게시판 리스트(회원용)
	public List<BoardVO> freeBoardList(@RequestParam("pagenum") int pagenum, @RequestParam("contentnum") int contentnum,
			String hit) throws Exception;

	// 자유게시판 상세보기
	public BoardVO freeBoardDetail(int bnum) throws Exception;

	// 자유게시판 상세보기 조회수 증가
	public int freehitup(int bnum, String id) throws Exception;

	// 자유게시판 글 쓰기
	public int freeBoardInsert(HttpServletRequest request) throws Exception;

	// 자유게시판 글 삭제
	public int freeBoardDelete(String id, int bnum) throws Exception;

	// 자유게시판 글 수정 페이지 들어가기
	public BoardVO freeBoardUpdatein(int bnum) throws Exception;

	// 자유게시판 글 수정
	public int freeBoardUpdate(int bnum, String title, String content) throws Exception;

	// 자유게시판 검색 카운트
	public int freeBoardSearchcnt(String keyword, String search) throws Exception;

	// 자유게시판 검색
	public List<BoardVO> freeBoardsearch(@RequestParam("pagenum") int pagenum,
	@RequestParam("contentnum") int contentnum, String keyword, String search, String hit) throws Exception;

	// 자유게시판 댓글 리스트
	public List<ReplyVO> freeBoardReply(int bnum) throws Exception;

	// 자유게시판 댓글 삭제
	public int freeReplyDelete(int rnum) throws Exception;

	// 자유게시판 댓글 수정
	public int freeReplyUpdate(int rnum, String rcontent) throws Exception;

	// 자유게시판 댓글 쓰기
	public int freeReplyInsert(Map map) throws Exception;

//----------------------------------------리뷰 게시판----------------------------------------------

	// 리뷰게시판 게시글 수
	public int reviewBoardCount(String eventkinds) throws Exception;

	// 리뷰게시판 리스트(공지사항)
	public List<BoardVO> reviewadminList() throws Exception;

	// 리뷰게시판 리스트(회원 글)
	public List<ReviewBoardVO> reviewBoardList(int pagenum, int contentnum, String hit, String eventkinds) throws Exception;

	// 리뷰게시판 글 쓰기
	public int reviewBoardInsert(Map map) throws Exception;
	
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	public int popupCultureCnt(Map<String, Object> map);
	
	// 축제찾는 팝업 리스트
	public List<InfoVO> popupCulture(Map<String, Object> map);
	
	// 리뷰게시판 공지사항 상세보기
	public ReviewBoardVO reviewadmindetail(int bnum)throws Exception;

	// 리뷰게시판 상세보기
	public ReviewBoardVO reviewBoardDetail(int bnum) throws Exception;

	// 리뷰게시판 상세보기 조회수 증가
	public int reviewhitup(int bnum, String id) throws Exception;

	// 리뷰게시판 글 수정 페이지 들어가기
	public BoardVO reviewBoardUpdatein(int bnum) throws Exception;

	// 리뷰게시판 글 수정
	public int reviewBoardUpdate(int bnum, String title, String content) throws Exception;

	// 리뷰게시판 글 삭제
	public int reviewBoardDelete(String id, int bnum) throws Exception;

	// 리뷰게시판 검색 카운트
	public int reviewBoardSearchcnt(String keyword, String search, String eventkinds) throws Exception;

	// 리뷰게시판 검색
	public List<ReviewBoardVO> reviewBoardsearch(@RequestParam("pagenum") int pagenum,
			@RequestParam("contentnum") int contentnum, String keyword, String search, String hit, String eventkinds) throws Exception;

	// 리뷰게시판 댓글 리스트
	public List<ReplyVO> reviewBoardReply(int bnum) throws Exception;

	// 리뷰게시판 댓글 삭제
	public int reviewReplyDelete(int rnum) throws Exception;

	// 리뷰게시판 댓글 수정
	public int reviewReplyUpdate(int rnum, String rcontent) throws Exception;

	// 리뷰게시판 댓글 쓰기
	public int reviewReplyInsert(Map map) throws Exception;
	
	// 블랙리스트회원
	public int blacklist(String id) throws Exception;

// ----------------------------------신고--------------------------------------

	// 게시글 신고 넣기
	public int B_warning(Map<String, Object> map) throws Exception;

	// 댓글 신고 넣기
	public int R_warning(Map<String, Object> map) throws Exception;

	// 게시글 신고
	public BoardVO boardWar(Map<String, Object> map) throws Exception;

	// 댓글신고
	public ReplyVO replyWar(Map<String, Object> map) throws Exception;

}
