package com.laonmoa.member.MemberService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.laonmoa.member.MemberDAO.BoardDAO;
import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReplyVO;
import com.laonmoa.member.VO.ReviewBoardVO;
import com.laonmoa.member.VO.ReviewListVO;

@Service
public class BoardServiceImpl implements BoardService{
	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	@Autowired
	private BoardDAO board;
	
	// 메인페이지에 보여줄 베스트 리뷰리스트
	public List<ReviewListVO> bestReviewList(int reviewCnt){
		return board.bestReviewList(reviewCnt);
	}
	
	//자유게시판 게시글 수 카운트
	@Override
	public int freeBoardcount()throws Exception {
		return board.freeBoardcount();
	}
	
	//자유게시판 리스트(공지사항,1페이지만)
	@Override
	public List<BoardVO> adminList() throws Exception {
		return board.adminList();
	}
	
	//자유게시판 리스트(회원용)
	@Override
	public List<BoardVO> freeBoardList(int pagenum, int contentnum, String hit) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum",pagenum );
		map.put("contentnum", contentnum);
		map.put("hit",hit);
		return board.freeBoardList(map);
	}

	//자유게시판 상세보기
	@Override
	public BoardVO freeBoardDetail(int bnum) throws Exception {
		return board.freeBoardDetail(bnum);
	}
	
	//자유게시판 조회수 증가
	@Override
	public int freehitup(int bnum,String id) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("bnum", bnum);
		map.put("id",id);
		return board.freehitup(map);
	}
	
	//자유게시판 글 쓰기
	@Override
	public int freeBoardInsert(HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("title", request.getParameter("title"));
		map.put("content", request.getParameter("content"));
		map.put("id", request.getParameter("id"));
		return board.freeBoardInsert(map);
	}

	//자유게시판 글 삭제
	@Override
	public int freeBoardDelete(String id, int bnum) throws Exception {
		Map<String , Object> map = new HashMap<>();
		map.put("id", id);
		map.put("bnum", bnum);
		return board.freeBoardDelete(map);
	}

	//자유게시판 수정페이지 들어가기
	@Override
	public BoardVO freeBoardUpdatein(int bnum) throws Exception {
		return board.freeBoardUpdatein(bnum);
	}

	//자유게시판 글 수정
	@Override
	public int freeBoardUpdate(int bnum, String title, String content) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("bnum",bnum);
		map.put("title", title);
		map.put("content", content);
		return board.freeBoardUpdate(map);
	}

	//자유게시판 검색
	@Override
	public List<BoardVO> freeBoardsearch(int pagenum,int contentnum,String keyword, String search,String hit) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("pagenum",pagenum);
		map.put("contentnum",contentnum);
		map.put("hit", hit);
		return board.freeBoardsearch(map);
	}

	//자유게시판 검색 카운트
	@Override
	public int freeBoardSearchcnt(String keyword,String search) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("keyword",keyword);
		map.put("search",search);
		return board.freeBoardSearchcnt(map);
	}

	//자유게시판 댓글 리스트
	@Override
	public List<ReplyVO> freeBoardReply(int bnum) throws Exception {
		return board.freeBoardReply(bnum);
	}

	//자유게시판 댓글삭제
	@Override
	public int freeReplyDelete(int rnum) throws Exception {
		return board.freeReplyDelete(rnum);
	}

	//자유게시판 댓글 수정
	@Override
	public int freeReplyUpdate(int rnum, String rcontent) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("rnum",rnum);
		map.put("rcontent",rcontent);
		return board.freeReplyUpdate(map);
	}

	//자유게시판 댓글 쓰기
	@Override
	public int freeReplyInsert(Map map) throws Exception {
		return board.freeReplyInsert(map);
	}

//----------------------------------------리뷰 게시판----------------------------------------------
	//리뷰게시판 게시글 수
	@Override
	public int reviewBoardCount(String eventkinds) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("eventkinds", eventkinds);
		return board.reviewBoardCount(map);
	}
	
	//리뷰게시판 공지리스트
	@Override
	public List<BoardVO> reviewadminList() throws Exception {
		return board.reviewadminList();
	}

	//리뷰게시판 게시글리스트
	@Override
	public List<ReviewBoardVO> reviewBoardList(int pagenum, int contentnum, String hit, String eventkinds) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum",pagenum );
		map.put("contentnum", contentnum);
		map.put("hit",hit);
		map.put("eventkinds", eventkinds);
		return board.reviewBoardList(map);
	}

	//리뷰게시판 글쓰기
	@Override
	public int reviewBoardInsert(Map map) throws Exception {
		return board.reviewBoardInsert(map);
	}
	
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	@Override
	public int popupCultureCnt(Map<String, Object> map) {
		return board.popupCultureCnt(map);
	}
	
	// 축제찾는 팝업 리스트
	@Override
	public List<InfoVO> popupCulture(Map<String, Object> map){
		return board.popupCulture(map);
	}
	
	//리뷰게시판 공지사항 상세보기
	@Override
	public ReviewBoardVO reviewadmindetail(int bnum) throws Exception {
		return board.reviewadmindetail(bnum);
	}
	
	//리뷰게시판 상세보기
	@Override
	public ReviewBoardVO reviewBoardDetail(int bnum) throws Exception {
		return board.reviewBoardDetail(bnum);
	}
	
	//리뷰게시판 조회수 
	@Override
	public int reviewhitup(int bnum,String id) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("bnum", bnum);
		map.put("id",id);
		return board.reviewhitup(map);
	}
	
	//리뷰게시판 수정페이지 들어가기
	@Override
	public BoardVO reviewBoardUpdatein(int bnum) throws Exception {
		return board.reviewBoardUpdatein(bnum);
	}
	
	//리뷰게시판 글 수정
	@Override
	public int reviewBoardUpdate(int bnum, String title, String content) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("bnum",bnum);
		map.put("title", title);
		map.put("content", content);
		return board.reviewBoardUpdate(map);
	}
	
	//리뷰게시판 글 삭제
	@Override
	public int reviewBoardDelete(String id, int bnum) throws Exception {
		Map<String , Object> map = new HashMap<>();
		map.put("id", id);
		map.put("bnum", bnum);
		return board.reviewBoardDelete(map);
	}
	
	//리뷰게시판 검색 카운트
	@Override
	public int reviewBoardSearchcnt(String keyword,String search,String eventkinds) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("keyword",keyword);
		map.put("search",search);
		map.put("eventkinds", eventkinds);
		return board.reviewBoardSearchcnt(map);
	}

	//리뷰게시판 검색
	@Override
	public List<ReviewBoardVO> reviewBoardsearch(int pagenum,int contentnum,String keyword, String search,String hit,String eventkinds) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("pagenum",pagenum);
		map.put("contentnum",contentnum);
		map.put("hit", hit);
		map.put("eventkinds",eventkinds);
		System.out.println("리뷰게시판 검색 서비스 = "+map.toString());
		return board.reviewBoardsearch(map);
	}
	
	//블랙리스트 회원
	@Override
	public int blacklist(String id) throws Exception {
		return board.blacklist(id);
	}
	
	//리뷰게시판 댓글 리스트
	@Override
	public List<ReplyVO> reviewBoardReply(int bnum) throws Exception {
		return board.reviewBoardReply(bnum);
	}

	//리뷰게시판 댓글삭제
	@Override
	public int reviewReplyDelete(int rnum) throws Exception {
		return board.reviewReplyDelete(rnum);
	}

	//리뷰게시판 댓글 수정
	@Override
	public int reviewReplyUpdate(int rnum, String rcontent) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("rnum",rnum);
		map.put("rcontent",rcontent);
		return board.reviewReplyUpdate(map);
	}

	//리뷰게시판 댓글 쓰기
	@Override
	public int reviewReplyInsert(Map map) throws Exception {
		return board.reviewReplyInsert(map);
	}
	
//----------------------------------------리뷰 게시판----------------------------------------------
	
	//게시글 신고 넣기
	@Override
	public int B_warning(Map<String,Object> map) throws Exception {
		return board.B_warning(map);
	}
	
	//댓글 신고 넣기
	@Override
	public int R_warning(Map<String,Object> map) throws Exception {
		return board.R_warning(map);
	}
	
	//게시글 신고
	public BoardVO boardWar(Map<String, Object> map) throws Exception {
		return board.boardWar(map);
	}
	
	//댓글신고
	public ReplyVO replyWar(Map<String, Object> map) throws Exception {
		return board.replyWar(map);
	}

	
}
