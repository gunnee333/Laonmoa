package com.laonmoa.member.MemberDAO;


import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReplyVO;
import com.laonmoa.member.VO.ReviewBoardVO;
import com.laonmoa.member.VO.ReviewListVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImpl.class);
	@Inject
	private SqlSession session;
	
	// 메인페이지에 보여줄 베스트 리뷰리스트
	public List<ReviewListVO> bestReviewList(int reviewCnt){
		return session.selectList("Board.bestReviewList", reviewCnt);
	}
	
	//자유게시판 게시글 수
	@Override
	public int freeBoardcount()throws Exception {
		return session.selectOne("Board.freecount");
	}
	
	// 자유게시판 리스트(공지사항,1페이지만)
	@Override
	public List<BoardVO> adminList() throws Exception {
		return session.selectList("Board.freeBoardAdminList");
	}
	
	//자유게시판 리스트(회원 글)
	@Override
	public List<BoardVO> freeBoardList(Map map) throws Exception {
		return session.selectList("Board.freeBoardList", map);
	}
	
	//자유게시판 상세보기
	@Override
	public BoardVO freeBoardDetail(int bnum) throws Exception {
		return session.selectOne("Board.freeBoardDetail", bnum);
	}
	
	//자유게시글 조회수 증가
	@Override
	public int freehitup(Map map) throws Exception {
		return session.update("Board.freehitup", map);
	}

	//자유게시판 글 쓰기
	@Override
	public int freeBoardInsert(Map map) throws Exception {
		session.insert("Board.freeBoardInsert",map);
		int bnum = (int) map.get("bnum");
		return bnum;
	}
	
	//자유게시판 글 삭제
	@Override
	public int freeBoardDelete(Map map) throws Exception {
		return session.update("Board.freeBoardDelete",map);
	}

	//자유게시판 수정페이지 들어가기
	@Override
	public BoardVO freeBoardUpdatein(int bnum) throws Exception {
		return session.selectOne("Board.freeBoardUpdatein",bnum);
	}

	//자유게시판 글 수정
	@Override
	public int freeBoardUpdate(Map map) throws Exception {
		return session.update("Board.freeBoardUpdate", map);
	}

	//자유게시판 검색
	@Override
	public List<BoardVO> freeBoardsearch(Map map) throws Exception {
		return session.selectList("Board.freeSearch",map);
	}

	//자유게시판 검색 카운트
	@Override
	public int freeBoardSearchcnt(Map map) throws Exception {
		System.out.println("DAO"+map.toString());
		return session.selectOne("Board.freeSearchcnt",map);
	}


	//자유게시판 댓글리스트
	@Override
	public List<ReplyVO> freeBoardReply(int bnum) throws Exception {
		return session.selectList("Reply.freeBoardReply",bnum);
	}

	//자유게시판 댓글 삭제
	@Override
	public int freeReplyDelete(int rnum) throws Exception {
		return session.update("Reply.freeReplyDelete", rnum);
	}

	//자유게시판 댓글 수정
	@Override
	public int freeReplyUpdate(Map map) throws Exception {
		return session.update("Reply.freeReplyUpdate", map);
	}

	//자유게시판 댓글 쓰기
	@Override
	public int freeReplyInsert(Map map) throws Exception {
		return session.insert("Reply.freeReplyInsert", map);
	}
	
//----------------------------------------리뷰게시판-------------------------------------------

	//리뷰게시판 게시글 카운트(회원만)
	@Override
	public int reviewBoardCount(Map<String,Object> map) throws Exception {
		return session.selectOne("Board.reviewcount",map);
	}

	//리뷰게시판 회원글리스트
	@Override
	public List<BoardVO> reviewadminList() throws Exception {
		return session.selectList("Board.reviewBoardAdminList");
	}

	//리뷰게시판 회원글 리스트
	@Override
	public List<ReviewBoardVO> reviewBoardList(Map<String, Object> map) throws Exception {
		return session.selectList("Board.reviewBoardList", map);
	}

	//리뷰게시판 글쓰기
	@Override
	public int reviewBoardInsert(Map<String, Object> map) throws Exception {
		session.insert("Board.reviewBoardInsert", map);
		int bnum = (int) map.get("bnum");
		return bnum;
	}
	
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	@Override
	public int popupCultureCnt(Map<String, Object> map) {
		return session.selectOne("Board.popupCultureCnt", map);
	};
	
	// 축제찾는 팝업 리스트
	@Override
	public List<InfoVO> popupCulture(Map<String, Object> map){
		return session.selectList("Board.popupCulture", map);
	}
	
	@Override
	public ReviewBoardVO reviewadmindetail(int bnum) throws Exception {
		return session.selectOne("Board.reviewadmindetail",bnum);
	}
	
	//리뷰게시판 상세보기
	@Override
	public ReviewBoardVO reviewBoardDetail(int bnum) throws Exception {
		return session.selectOne("Board.reviewBoardDetail", bnum);
	}
	
	//리뷰게시글 조회수 증가
	@Override
	public int reviewhitup(Map map) throws Exception {
		return session.update("Board.reviewhitup", map);
	}
	
	//리뷰게시판 수정페이지 들어가기
	@Override
	public BoardVO reviewBoardUpdatein(int bnum) throws Exception {
		return session.selectOne("Board.reviewBoardUpdatein",bnum);
	}
	//리뷰게시판 글 수정
	@Override
	public int reviewBoardUpdate(Map map) throws Exception {
		return session.update("Board.reviewBoardUpdate", map);
	}
	
	//리뷰게시판 글 삭제
	@Override
	public int reviewBoardDelete(Map map) throws Exception {
		return session.update("Board.reviewBoardDelete",map);
	}
	
	//리뷰게시판 검색
	@Override
	public List<ReviewBoardVO> reviewBoardsearch(Map map) throws Exception {
		System.out.println("리뷰게시판 검색  = "+map.toString());
		return session.selectList("Board.reviewSearch",map);
	}

	//리뷰게시판 검색 카운트
	@Override
	public int reviewBoardSearchcnt(Map map) throws Exception {
		System.out.println("DAO"+map.toString());
		return session.selectOne("Board.reviewSearchcnt",map);
	}
	
	//블랙리스트 회원
	@Override
	public int blacklist(String id) throws Exception {
		return session.selectOne("Board.blacklist", id);
	}
	
	
//----------------------------------댓글------------------------------------------
	
	//리뷰게시판 댓글리스트
	@Override
	public List<ReplyVO> reviewBoardReply(int bnum) throws Exception {
		return session.selectList("Reply.reviewBoardReply",bnum);
	}

	//리뷰게시판 댓글 삭제
	@Override
	public int reviewReplyDelete(int rnum) throws Exception {
		return session.update("Reply.reviewReplyDelete", rnum);
	}

	//리뷰게시판 댓글 수정
	@Override
	public int reviewReplyUpdate(Map map) throws Exception {
		return session.update("Reply.reviewReplyUpdate", map);
	}

	//리뷰게시판 댓글 쓰기
	@Override
	public int reviewReplyInsert(Map map) throws Exception {
		System.out.println(map.toString());
		return session.insert("Reply.reviewReplyInsert", map);
	}
	
	//----------------------------------------신고 게시판----------------------------------------------
	
	//게시글 신고 넣기
	@Override
	public int B_warning(Map<String, Object> map) throws Exception {
		return session.insert("Board.B_warning", map);
	}
	
	//댓글 신고 넣기
	@Override
	public int R_warning(Map<String, Object> map) throws Exception {
		return session.insert("Board.R_warning", map);
	}
	
	//게시글 신고
	public BoardVO boardWar(Map<String, Object> map) throws Exception {
		return session.selectOne("Board.boardWar", map);
	}
	
	//댓글신고
	public ReplyVO replyWar(Map<String, Object> map) throws Exception {
		return session.selectOne("Board.replyWar", map);
	}

}
