package com.laonmoa.member.MemberService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.laonmoa.member.MemberDAO.CultureDAO;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReviewBoardVO;

@Service
public class CultureServiceImpl implements CultureService{
	private static final Logger logger = LoggerFactory.getLogger(CultureServiceImpl.class);
	
	@Inject
	private CultureDAO dao;

	@Override
	public List<InfoVO> festivalList(int pagenum, int contentnum,int level,int month, int year) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum",pagenum );
		map.put("contentnum", contentnum);
		map.put("level", level);
		map.put("month", month);
		map.put("year", year);
		return dao.festivalList(map);
	}

	@Override
	public String festivalCount(int level) {
		// TODO Auto-generated method stub
		return dao.festvalCount(level);
	}

	@Override
	public List<InfoVO> date(int month,int level,HttpServletResponse response,int pagenum, int contentnum, int year) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("month",month);
		map.put("level", level);
		map.put("year", year);
		map.put("pagenum",pagenum );
		map.put("contentnum", contentnum);
		System.out.println("들어온 달은 ~~"+month);
		  return dao.date(map);
		
	}

	@Override
	public List<InfoVO> Newest(int pagenum, int contentnum,int level) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum",pagenum );
		map.put("contentnum", contentnum);
		map.put("level", level);
		return dao.Newest(map);
	}
	// 페이징을 위한 내꺼모아 카운팅
	@Override
	public int mymoaCnt(Map<String, Object> map) {
		return dao.mymoaCnt(map);
	}
	
	// 내꺼모아 리스트 가져오기
	@Override
	public List<InfoVO> mymoa(Map<String, Object> map){
		return dao.mymoa(map);
	}

	@Override
	public InfoVO Detail(int fno) {
		// TODO Auto-generated method stub
		return dao.Detail(fno);
	}
	//찜목록 삽입
	@Override
	public int Wishlistinsert(String id,int fno) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("fno", fno);
		return dao.Wishlistinsert(map);
	}

	@Override
	public int Wishcheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.Wishcheck(map);
	}

	@Override
	public int Wishdelete(String id , int fno)throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("fno", fno);
		return dao.Wishdelete(map);
	}

	@Override
	public int countlove(int fno) {
		// TODO Auto-generated method stub
		System.out.println("countlove"+fno);
		return dao.countlove(fno);
	}

	@Override
	public int checklove(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.checklove(map);
	}

	@Override
	public int insertlove(String id, int fno) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("fno", fno);
		return dao.insertlove(map);
	}

	@Override
	public int deletelove(String id, int fno) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("fno",fno);
		return dao.deletelove(map);
	}

	// 축제찾는 팝업의 페이징을 위한 갯수세기
	@Override
	public int popupCultureCnt(Map<String, Object> map) {
		return dao.popupCultureCnt(map);
	}
	
	// 축제찾는 팝업 리스트
	@Override
	public List<InfoVO> popupCulture(Map<String, Object> map){
		return dao.popupCulture(map);
	}



	@Override
	public List<InfoVO> orderlove(int pagenum, int contentnum,int level) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
		map.put("level", level);
		System.out.println("dao +++"+map.toString());
		return dao.orderlove(map);
	}

	@Override
	public String culturedatecount(int level, int month, int year) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("level", level);
		map.put("month", month);
		map.put("year", year);
		System.out.println("날짜 서비스 맴 체크"+map.toString());
		return dao.culturedatecount(map);
	}

	@Override
	public List<InfoVO> locationlist(String value, int level,int pagenum, int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("value", value);
		map.put("level", level);
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
 		return dao.locationlist(map);
	}

	@Override
	public String locationcount(String value, int level) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("value", value);
		map.put("level", level);
 		return dao.locationcount(map);
	}
	// 비로그인시 인기 축제보여주기
	@Override
	public List<InfoVO> bestCultureList(){
		return dao.bestCultureList();
	}
	
	// 로그인시 지역 인기 축제 보여주기
	@Override
	public List<InfoVO> locationBestCultureList(String id){
		return dao.locationBestCultureList(id);
	}

	@Override
	public List<ReviewBoardVO> DetailReview(int fno) {
		// TODO Auto-generated method stub
		System.out.println("축제상세 리뷰 리스트 " + fno);
		return dao.DetailReview(fno);
	}

	@Override
	public List<InfoVO> startfestival(int level,int pagenum,int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("level", level);
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
		System.out.println("진행중 service"+map);
		return dao.startfestival(map);
	}

	@Override
	public String startfestivalcount(int level) {
		// TODO Auto-generated method stub
		return dao.startfestivalcount(level);
	}

	@Override
	public List<InfoVO> schedule(int level, int pagenum, int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("level", level);
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
		System.out.println("예정 service"+map);
		return dao.schedule(map);
	}

	@Override
	public String schedulecount(int level) {
		// TODO Auto-generated method stub
		return dao.schedulecount(level);
	}

	@Override
	public List<InfoVO> endfestival(int level, int pagenum, int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("level", level);
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
		System.out.println("마감 service"+map);
		return dao.endfestival(map);
	}

	@Override
	public String endfestivalcount(int level) {
		// TODO Auto-generated method stub
		return dao.endfestivalcount(level);
	}

	/*
	 * @Override public List<InfoVO> tag(String value, int month, int level, int
	 * pagenum, int contentnum) { // TODO Auto-generated method stub
	 * Map<String,Object>map = new HashMap<String, Object>(); map.put("value",
	 * value); map.put("month", month); map.put("level",level); map.put("pagenum",
	 * pagenum); map.put("contentnum", contentnum);
	 * System.out.println("service tag "+ map); return dao.tag(map); }
	 */
}
