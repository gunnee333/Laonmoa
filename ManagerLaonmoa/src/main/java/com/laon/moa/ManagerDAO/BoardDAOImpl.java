package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.ReplyVO;
import com.laon.moa.VO.ReviewBoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession session;

	@Inject
	private static String ns = "BoardMapper";
	
//--------------------------------------자유게시판----------------------------------
	
	// 자유게시판 글갯수
	@Override
	public int freeBoardCount(Map<String, Object> map) throws Exception {
		System.out.println("MAP1 :: " + map.toString());
		return session.selectOne(ns + ".freeBoardCount", map);
	}

	// 자유게시판 목록/페이징
	@Override
	public List<BoardVO> freeBoardList(Map<String, Object> map) throws Exception {
		System.out.println("MAP2 :: " + map.toString());
		return session.selectList(ns + ".freeBoardList", map);
	}


	// 자유게시판 글쓰기
	@Override
	public int BoardInsert(BoardVO vo) throws Exception {
		session.insert(ns + ".BoardInsert", vo);
		int bnum = vo.getBnum();
		return bnum;
	}

	// 자유게시판 상세보기
	@Override
	public BoardVO BoardDetail(int bnum) throws Exception {
		return session.selectOne(ns + ".BoardDetail", bnum);
	}

	// 자유게시판 수정하기
	@Override
	public void BoardChange(BoardVO vo) throws Exception {
		session.update(ns + ".BoardChange", vo);
	}

	// 자유게시판 삭제하기
	@Override
	public void BoardDelete(int bnum) throws Exception {
		session.update(ns + ".BoardDelete", bnum);
	}

	// 게시중/삭제 구분하기
	@Override
	public List<BoardVO> listDel(int del) {
		return session.selectList(ns + ".listDel", del);
	}
	
	//자유게시판 검색
	@Override
	public List<BoardVO> freeBoardsearch(Map map) throws Exception {
		return session.selectList(ns + ".freeSearch",map);
	}

	//자유게시판 검색 카운트
	@Override
	public int freeBoardSearchcnt(Map map) throws Exception {
		System.out.println("DAO"+map.toString());
		return session.selectOne(ns + ".freeSearchcnt",map);
	}
	
//--------------------------------------리뷰게시판----------------------------------
	
	// 리뷰게시판 글갯수
	@Override
	public int reviewBoardCount(Map<String, Object> map) throws Exception {
		return session.selectOne(ns + ".reviewBoardCount", map);
	}

	// 리뷰게시판 목록/페이징
	@Override
	public List<BoardVO> reviewBoardList(Map<String, Object> map) throws Exception {
		
		return session.selectList(ns + ".reviewBoardList", map);
	}

	// 리뷰게시판 글쓰기
	@Override
	public int reviewInsert(Map<String, Object> map) throws Exception {
		session.insert("BoardMapper.reviewInsert", map);
		int bnum = (int) map.get("bnum");
		return bnum;
	}
	
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	@Override
	public int popupCultureCnt(Map<String, Object> map) {
		return session.selectOne("BoardMapper.popupCultureCnt", map);
	};
	
	// 축제찾는 팝업 리스트
	@Override
	public List<InfoVO> popupCulture(Map<String, Object> map){
		return session.selectList("BoardMapper.popupCulture", map);
	}

	// 리뷰 상세보기
	@Override
	public ReviewBoardVO reviewDetail(int bnum) throws Exception {
		return session.selectOne(ns + ".reviewDetail", bnum);
	}

	// 리뷰게시판 수정하기
	@Override
	public void reviewChange(BoardVO vo) throws Exception {
		session.update(ns + ".reviewChange", vo);
	}

	// 리뷰게시판 삭제하기
	@Override
	public void reviewDelete(int bnum) throws Exception {
		session.update(ns + ".reviewDelete", bnum);
	}

	// 게시중/삭제 구분하기
	@Override
	public List<BoardVO> reviewListDel(int del) {
		return session.selectList(ns + ".reviewListDel", del);
	}
	
	//리뷰게시판 검색
	@Override
	public List<ReviewBoardVO> reviewBoardsearch(Map map) throws Exception {
		System.out.println("리뷰게시판 검색  = "+map.toString());
		return session.selectList(ns + ".reviewSearch",map);
	}

	//리뷰게시판 검색 카운트
	@Override
	public int reviewBoardSearchcnt(Map map) throws Exception {
		System.out.println("DAO"+map.toString());
		return session.selectOne(ns + ".reviewSearchcnt",map);
	}

	//--------------------------------------공지게시판----------------------------------

	// 공지게시판 글갯수
	@Override
	public int noticeCount(Map<String, Object> map) throws Exception {
		return session.selectOne(ns + ".noticeCount", map);
	}

	// 공지게시판 페이징/리스트
	@Override
	public List<BoardVO> noticeList(Map<String, Object> map) throws Exception {
		return session.selectList(ns + ".noticeList", map);
	}

	// 공지사항 글쓰기
	@Override
	public int NoticeInsert(BoardVO vo) throws Exception {
		session.insert(ns + ".NoticeInsert", vo);
		int bnum = vo.getBnum();
		return bnum;
	}

	// 공지사항 수정하기
	@Override
	public void NoticeChange(BoardVO vo) throws Exception {
		session.update(ns + ".NoticeChange", vo);
	}

	// 공지사항 상세보기
	@Override
	public BoardVO NoticeDetail(int bnum) throws Exception {
		return session.selectOne(ns + ".NoticeDetail", bnum);
	}

	// 공지사항 삭제하기
	@Override
	public void NoticeDelete(int bnum) throws Exception {
		session.update(ns + ".reviewDelete", bnum);
	}

	// 게시중/삭제 구분하기
	@Override
	public List<BoardVO> NoticeListDel(int del) throws Exception {
		return session.selectList(ns + ".NoticeListDel", del);
	}
	
	// 공지게시판 검색 카운트
	@Override
	public int noticeSearchcnt(Map map) throws Exception {
		System.out.println("DAO"+map.toString());
		return session.selectOne(ns + ".noticeSearchcnt",map);
	}

	// 공지게시판 검색
	@Override
	public List<BoardVO> noticeSearch(Map map) throws Exception {
		return session.selectList(ns + ".noticeSearch",map);
	}

	// ----------------------------------------------------리플 구간---------------------------------------------------------
	// 댓글 리스트
	@Override
	public List<ReplyVO> replyList(Map<String, Object> map) {
		return session.selectList("Reply.replylist", map);
	}
	
	// 댓글 리스트 갯수
	public int replyListCnt(Map<String,Object> map){
		System.out.println(map.toString());
		return session.selectOne("Reply.replyListCnt", map);
	}

	// 댓글 상세보기
	@Override
	public List<ReplyVO> ReplyDetail(int bnum) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("dao : " + bnum);
		return session.selectList("Reply.selectOne", bnum);
	}
	
	// 댓글불러오기
	@Override
	public ReplyVO replyDetailOne(int rnum) {
		return session.selectOne("Reply.replyDetailOne", rnum);
	}

	// 리플 삭제처리 del 을 1로 바꾸는 구간
	@Override
	public void ReplyUpdate(int rnum) throws Exception {
		int check = 0;
		try {
			session.update("Reply.update", rnum);
			check = 1;
		} catch (Exception e) {
		}
		if (check == 1) {
			session.update("Reply.update", rnum);
		}
	}

	// 댓글 검색
	@Override
	public List<ReplyVO> ReplySearch(Map<String, String> map) {
		return session.selectList("Reply.search", map);
	}

	// 페이징
	public List<ReplyVO> listPage(Map map) {
		return session.selectList("Reply.listPage", map);
	}

	// 리플 의 총갯수
	@Override
	public int Replycount() {
		return session.selectOne("Reply.count");
	}

	@Override
	public void ReplyDelete(int rnum) throws Exception {
		int check = 0;
		try {
			session.update("Reply.delete", rnum);
			check = 1;
		} catch (Exception e) {
		}
		if (check == 1) {
			session.update("Reply.delete", rnum);
		}

	}

}
