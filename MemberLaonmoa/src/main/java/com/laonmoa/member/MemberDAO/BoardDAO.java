package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReplyVO;
import com.laonmoa.member.VO.ReviewBoardVO;
import com.laonmoa.member.VO.ReviewListVO;

public interface BoardDAO {

	// 메인페이지에 보여줄 베스트 리뷰리스트
	public List<ReviewListVO> bestReviewList(int reviewCnt);

	// 자유게시판 게시글 수
	public int freeBoardcount() throws Exception;

	// 자유게시판 리스트(공지사항, 1페이지만)
	public List<BoardVO> adminList() throws Exception;

	// 자유게시판 리스트(회원 글)
	public List<BoardVO> freeBoardList(Map<String, Object> map) throws Exception;

	// 자유게시판 상세보기
	public BoardVO freeBoardDetail(int bnum) throws Exception;

	// 조회수 증가
	public int freehitup(Map<String, Object> map) throws Exception;

	// 자유게시판 글 쓰기
	public int freeBoardInsert(Map<String, Object> map) throws Exception;

	// 자유게시판 글 삭제
	public int freeBoardDelete(Map<String, Object> map) throws Exception;

	// 자유게시판 글 수정 페이지 들어가기
	public BoardVO freeBoardUpdatein(int bnum) throws Exception;

	// 자유게시판 글 수정
	public int freeBoardUpdate(Map<String, Object> map) throws Exception;

	// 자유게시판 검색 카운트
	public int freeBoardSearchcnt(Map<String, String> map) throws Exception;

	// 자유게시판 검색
	public List<BoardVO> freeBoardsearch(Map<String, Object> map) throws Exception;

	// 자유게시판 댓글 리스트
	public List<ReplyVO> freeBoardReply(int bnum) throws Exception;

	// 자유게시판 댓글 삭제
	public int freeReplyDelete(int rnum) throws Exception;

	// 자유게시판 댓글 수정
	public int freeReplyUpdate(Map<String, Object> map) throws Exception;

	// 자유게시판 댓글 쓰기
	public int freeReplyInsert(Map<String, Object> map) throws Exception;

//----------------------------------------리뷰 게시판----------------------------------------------

	// 리뷰게시판 게시글 수
	public int reviewBoardCount(Map<String,Object> map) throws Exception;

	// 리뷰게시판 리스트(공지사항)
	public List<BoardVO> reviewadminList() throws Exception;

	// 리뷰게시판 리스트(회원 글)
	public List<ReviewBoardVO> reviewBoardList(Map<String, Object> map) throws Exception;

	// 리뷰게시판 글 쓰기
	public int reviewBoardInsert(Map<String, Object> map) throws Exception;
	
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	public int popupCultureCnt(Map<String, Object> map);

	// 축제찾는 팝업 리스트
	public List<InfoVO> popupCulture(Map<String, Object> map);
	
	// 리뷰게시판 공지사항 상세보기
	public ReviewBoardVO reviewadmindetail(int bnum)throws Exception;

	// 리뷰게시판 상세보기
	public ReviewBoardVO reviewBoardDetail(int bnum) throws Exception;

	// 조회수 증가
	public int reviewhitup(Map<String, Object> map) throws Exception;

	// 리뷰게시판 글 수정 페이지 들어가기
	public BoardVO reviewBoardUpdatein(int bnum) throws Exception;

	// 리뷰게시판 글 수정
	public int reviewBoardUpdate(Map<String, Object> map) throws Exception;

	// 리뷰게시판 글 삭제
	public int reviewBoardDelete(Map<String, Object> map) throws Exception;

	// 리뷰게시판 검색 카운트
	public int reviewBoardSearchcnt(Map<String, String> map) throws Exception;

	// 리뷰게시판 검색
	public List<ReviewBoardVO> reviewBoardsearch(Map<String, Object> map) throws Exception;

	// 리뷰게시판 댓글 리스트
	public List<ReplyVO> reviewBoardReply(int bnum) throws Exception;

	// 리뷰게시판 댓글 삭제
	public int reviewReplyDelete(int rnum) throws Exception;

	// 리뷰게시판 댓글 수정
	public int reviewReplyUpdate(Map<String, Object> map) throws Exception;

	// 리뷰게시판 댓글 쓰기
	public int reviewReplyInsert(Map<String, Object> map) throws Exception;
	
	// 블랙리스트회원
	public int blacklist(String id) throws Exception;

	// ----------------------------------------신고----------------------------------------------

	// 게시글 신고 넣기
	public int B_warning(Map<String, Object> map) throws Exception;

	// 댓글 신고 넣기
	public int R_warning(Map<String, Object> map) throws Exception;

	// 게시글 신고 불러오기
	public BoardVO boardWar(Map<String, Object> map) throws Exception;

	// 댓글 신고 불러오기
	public ReplyVO replyWar(Map<String, Object> map) throws Exception;
}
