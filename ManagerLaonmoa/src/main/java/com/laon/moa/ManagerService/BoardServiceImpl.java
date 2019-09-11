package com.laon.moa.ManagerService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.laon.moa.ManagerDAO.BoardDAO;
import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.ReplyVO;
import com.laon.moa.VO.ReviewBoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO board;

//--------------------------------------자유 게시판---------------------------------------------------

	// 자유게시판 게시글 갯수
	@Override
	public int freeBoardCount(Map<String, Object> map) throws Exception {
		return board.freeBoardCount(map);
	}

	// 자유게시판 목록/페이징
	@Override
	public List<BoardVO> freeBoardList(Map<String, Object> map) throws Exception {
		return board.freeBoardList(map);
	}
	
	// 자유게시판 글쓰기
	@Override
	public int BoardInsert(BoardVO vo) throws Exception {
		int bnum = board.BoardInsert(vo);
		System.out.println(bnum);
		return bnum;
	}

	// 자유게시판 상세보기
	@Override
	public BoardVO BoardDetail(int bnum) throws Exception {
		return board.BoardDetail(bnum);
	}

	// 자유게시판 수정하기
	@Override
	public void BoardChange(BoardVO vo) throws Exception {
		board.BoardChange(vo);
	}

	// 자유게시판 삭제하기
	@Override
	public void BoardDelete(int bnum) throws Exception {
		board.BoardDelete(bnum);
	}

	// 게시중/삭제 구분하기
	@Override
	public List<BoardVO> listDel(int del) {
		return board.listDel(del);
	}
	
	//자유게시판 검색
	@Override
	public List<BoardVO> freeBoardsearch(int pagenum,int contentnum,String keyword, String search) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("pagenum",pagenum);
		map.put("contentnum",contentnum);
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

	// ---------------------------------리뷰게시판-------------------------------------------------

	// 리뷰게시판 글갯수
	@Override
	public int reviewBoardCount(Map<String, Object> map) throws Exception {
		return board.reviewBoardCount(map);
	}

	// 리뷰게시판 목록/페이징
	@Override
	public List<BoardVO> reviewBoardList(Map<String, Object> map) throws Exception {
		return board.reviewBoardList(map);
	}
	
	// 리뷰게시판 글쓰기
	@Override
	public int reviewInsert(Map<String, Object> map) throws Exception {
		return board.reviewInsert(map);
	}

	// 축제찾는 팝업 축제 갯수
	@Override
	public int popupCultureCnt(Map<String, Object> map) {
		return board.popupCultureCnt(map);
	}
	
	// 축제찾는 팝업 목록/페이징
	@Override
	public List<InfoVO> popupCulture(Map<String, Object> map){
		return board.popupCulture(map);
	}
	
	// 리뷰게시판 상세보기
	@Override
	public ReviewBoardVO reviewDetail(int bnum) throws Exception {
		return board.reviewDetail(bnum);
	}
	
	// 리뷰게시판 수정하기
	@Override
	public void reviewChange(BoardVO vo) throws Exception {
		board.reviewChange(vo);
	}

	// 리뷰게시판 삭제하기
	@Override
	public void reviewDelete(int bnum) throws Exception {
		board.reviewDelete(bnum);
	}

	// 게시중/삭제 구분하기
	@Override
	public List<BoardVO> reviewListDel(int del) throws Exception {
		return board.reviewListDel(del);
	}
	
	//리뷰게시판 검색 카운트
	@Override
	public int reviewBoardSearchcnt(String keyword,String search) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("keyword",keyword);
		map.put("search",search);
		return board.reviewBoardSearchcnt(map);
	}

	//리뷰게시판 검색
	@Override
	public List<ReviewBoardVO> reviewBoardsearch(int pagenum,int contentnum,String keyword, String search) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("pagenum",pagenum);
		map.put("contentnum",contentnum);
		System.out.println("리뷰게시판 검색 서비스 = "+map.toString());
		return board.reviewBoardsearch(map);
	}


//------------------------------------------공지게시판-----------------------------------------------

	// 공지게시판 글갯수
	@Override
	public int noticeCount(Map<String, Object> map) throws Exception {
		return board.noticeCount(map);
	}

	// 공지게시판 목록/페이징
	@Override
	public List<BoardVO> noticeList(Map<String, Object> map) throws Exception {
		return board.noticeList(map);
	}

	// 공지사항 글쓰기
	@Override
	public int NoticeInsert(BoardVO vo) throws Exception {
		int bnum = board.NoticeInsert(vo);
		return bnum;
	}

	// 공지게시판 상세보기
	@Override
	public BoardVO NoticeDetail(int bnum) throws Exception {
		return board.NoticeDetail(bnum);
	}

	// 공지게시판 수정하기
	@Override
	public void NoticeChange(BoardVO vo) throws Exception {
		board.reviewChange(vo);
	}

	// 공지게시판 삭제하기
	@Override
	public void NoticeDelete(int bnum) throws Exception {
		board.reviewDelete(bnum);
	}
	
	// 게시중/삭제 구분하기
	@Override
	public List<BoardVO> noticeListDel(int del) throws Exception {
		return board.reviewListDel(del);
	}

	//공지게시판 검색 카운트
	@Override
	public int noticeSearchcnt(String keyword,String search, int level) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("keyword",keyword);
		map.put("search",search);
		map.put("level",level);
		return board.noticeSearchcnt(map);
	}
	
	//공지게시판 검색
	@Override
	public List<BoardVO> noticeSearch(int pagenum,int contentnum,String keyword, String search, int level) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("pagenum",pagenum);
		map.put("contentnum",contentnum);
		map.put("level",level);
		return board.noticeSearch(map);
	}


	// ------------------------------------------------리플구간-----------------------------------------------------------
	
	@Override
	public List<ReplyVO> replyList(Map<String,Object> map) {
		return board.replyList(map);
	}
	

	// 댓글 리스트 갯수
	@Override
	public int replyListCnt(Map<String,Object> map){
		return board.replyListCnt(map);
	}

	@Override
	public List<ReplyVO> ReplyDetail(int bnum) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service : " + bnum);
		return board.ReplyDetail(bnum);
	}
	
	// 댓글불러오기
	@Override
	public ReplyVO replyDetailOne(int rnum) {
		return board.replyDetailOne(rnum);
	}

	// 댓글 접수
	@Override
	public void ReplyUpdate(int rnum) throws Exception {
		board.ReplyUpdate(rnum);
	}

	@Override
	public List<ReplyVO> ReplySearch(Map<String, String> map) {
		// TODO Auto-generated method stub
		return board.ReplySearch(map);
	}

	@Override
	public void ReplyDelete(int rnum) throws Exception {
		board.ReplyDelete(rnum);

	}

	@Override
	public List<ReplyVO> listPage(int displayPost, int postNum) {
		Map<String, Integer> map = new HashMap<>();
		map.put("displayPost", displayPost);
		map.put("postNum", postNum);
		return board.listPage(map);
	}

	@Override
	public int Replycount() {
		return board.Replycount();
	}


}
