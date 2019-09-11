package com.laonmoa.member.MemberService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReviewBoardVO;

public interface CultureService {
	//축제 리스트 보여주기
	List<InfoVO> festivalList(int pagenum, int contentnum,int level,int month, int year);

	//축제상세 리뷰게시판 리스트
	List<ReviewBoardVO> DetailReview(int fno);
	
	//축제 카운트
	String festivalCount(int level);

	//날짜 조회
	List<InfoVO> date(int month,int level,HttpServletResponse response,int pagenum, int contentnum, int year) throws Exception;

	//최신순
	List<InfoVO> Newest(int pagenum, int contentnum,int level);
	//상세보기
	InfoVO Detail(int fno);
	// 페이징을 위한 내꺼모아 카운팅
	public int mymoaCnt(Map<String, Object> map);

	// 내꺼모아 리스트 가져오기
	public List<InfoVO> mymoa(Map<String, Object> map);
	
	//찜목록 삽입
	public int Wishlistinsert(String id,int fno);
	
	//찜목록 확인
	public int Wishcheck(Map<String, Object>map);
	
	//찜목록 취소
	public int Wishdelete(String id,int fno)throws Exception;
	
	//좋아요 카운트
	public int countlove(int fno);
	
	//좋아요 확인
	public int checklove(Map<String,Object>map);
	
	//좋아요 
	public int insertlove(String id,int fno);
	
	//좋아요 취소
	public int deletelove(String id ,int fno);
	
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	public int popupCultureCnt(Map<String, Object> map);
	
	// 축제찾는 팝업 리스트
	public List<InfoVO> popupCulture(Map<String, Object> map);
	
	//날짜별 카운트
	public String culturedatecount(int level,int month, int year)throws Exception;
	
	//좋아요 순
	public List<InfoVO> orderlove(int pagenum, int contentnum,int level);
	
    //지역별 
    public List<InfoVO> locationlist(String value, int level,int pagenum, int contentnum);
    
    //지역별 카운트
    public String locationcount(String value, int level);
    
    //태그 
   // public List<InfoVO> tag(String value,int month, int level,int pagenum, int contentnum);
	// 비로그인시 인기 축제보여주기
	public List<InfoVO> bestCultureList();
	
	// 로그인시 지역 인기 축제 보여주기
	public List<InfoVO> locationBestCultureList(String id);
	
	//진형여부
	public List<InfoVO> startfestival(int level,int pagenum,int contentnum); 
	
	//진행여부 카운트
	public String startfestivalcount(int level);
	
	//예정여부
	public List<InfoVO> schedule(int level,int pagenum,int contentnum); 
			
	//예정여부 카운트
	public String schedulecount(int level);

	//마감여부
	public List<InfoVO> endfestival(int level,int pagenum,int contentnum); 
				
	//마감여부 카운트
	public String endfestivalcount(int level);

}
