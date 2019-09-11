package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReviewBoardVO;

public interface CultureDAO {
	//축제 리스트 보여주기
	List<InfoVO> festivalList(Map<String,Object> map);
	//축제 상세 리뷰리스트 
	List<ReviewBoardVO> DetailReview(int fno);
	//축제 리스트 카운트 
	String festvalCount(int level);
	//7월 
	List<InfoVO> date(Map<String,Object> map);
	//최신순
	List<InfoVO>Newest(Map<String,Object> map);
	//상세보기 
	InfoVO Detail(int fno);
	// 페이징을 위한 내꺼모아 카운팅
	public int mymoaCnt(Map<String, Object> map);
	// 내꺼모아 리스트 가져오기
	public List<InfoVO> mymoa(Map<String, Object> map);
	// 찜목록 추가
	public int Wishlistinsert(Map<String, Object> map); 
	//찜목록 확인
	public int Wishcheck(Map<String,Object> map);
	//찜목록 취소
	public int Wishdelete(Map<String,Object> map)throws Exception;
	
	//좋아요 카운트
	public int countlove(int fno);

	//좋아요 체크
	public int checklove(Map<String,Object> map);

	//좋아요 
	public int insertlove(Map<String,Object>map);

	//좋아요 취소
	public int deletelove(Map<String,Object>map);

	// 축제찾는 팝업의 페이징을 위한 갯수세기
	public int popupCultureCnt(Map<String, Object> map);

	// 축제찾는 팝업 리스트
	public List<InfoVO> popupCulture(Map<String, Object> map);
	
	//축제 개수
    public String culturedatecount(Map<String,Object>map)throws Exception;
    //좋아요 순
    public List<InfoVO> orderlove(Map<String, Object>map);
    
    //지역별 
    public List<InfoVO> locationlist(Map<String,Object>map);
    
    //지역별 카운트
    public String locationcount(Map<String,Object>map);
	
    //태그 
    //public List<InfoVO> tag (Map<String,Object>map);
    // 비로그인시 인기 축제보여주기
	public List<InfoVO> bestCultureList();
	
	// 로그인시 지역 인기 축제 보여주기
	public List<InfoVO> locationBestCultureList(String id);
	
	//진형여부
	public List<InfoVO> startfestival(Map<String,Object> map); 
	
	//진행여부 카운트
	public String startfestivalcount(int level);
	
	//예정여부
	public List<InfoVO> schedule(Map<String,Object> map); 
		
	//예정여부 카운트
	public String schedulecount(int level);
	
	//마감여부
	public List<InfoVO> endfestival(Map<String,Object> map); 
		
	//마감여부 카운트
	public String endfestivalcount(int level);
}
