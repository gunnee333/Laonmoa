package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.ReviewBoardVO;

@Repository
public class CultureDAOImpl implements CultureDAO{
	private static final Logger logger = LoggerFactory.getLogger(CultureDAOImpl.class);
	@Inject
	private SqlSession session;
	
	@Override
	public List<InfoVO> festivalList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("level 추가"+map.toString());
		return session.selectList("Info.festivallist",map);
	}
	@Override
	public String festvalCount(int level) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.festivalcount",level);
	}
	//날짜  
	@Override
	public List<InfoVO> date(Map<String,Object> map) {
		// TODO Auto-generated method stub
		System.out.println("dao!!!!"+map.toString());
		return session.selectList("Info.date",map);
	}
	@Override
	public List<InfoVO> Newest(Map<String,Object> map) {
		// TODO Auto-generated method stub
		System.out.println("최신순 dao "+map.toString());
		return session.selectList("Info.Newest",map);
	}
	// 페이징을 위한 내꺼모아 카운팅
	@Override
	public int mymoaCnt(Map<String, Object> map) {
		System.out.println(map.toString());
		return session.selectOne("Info.mymoaCnt", map);
	}
	
	// 내꺼모아 리스트 가져오기
	@Override
	public List<InfoVO> mymoa(Map<String, Object> map){
		return session.selectList("Info.mymoa", map);
	}
	@Override
	public InfoVO Detail(int fno) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.Detail",fno);
	}
	
	  @Override 
	  public int Wishlistinsert(Map<String, Object> map) { 
	
		  return session.insert("Info.wishinsert",map);
	 }
	@Override
	public int Wishcheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.wishcheck",map);
	}
	@Override
	public int Wishdelete(Map<String, Object> map)throws Exception {
		// TODO Auto-generated method stub
		System.out.println(map.toString()+"DAO");
		return session.delete("Info.wishdelete",map);
	}
	@Override
	public int countlove(int fno) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.countlove",fno);
	}
	@Override
	public int checklove(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.checklove",map);
	}
	@Override
	public int insertlove(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.insert("Info.insertlove",map);
	}
	@Override
	public int deletelove(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.delete("Info.deletelove",map);
	}
	// 축제찾는 팝업의 페이징을 위한 갯수세기
	@Override
	public int popupCultureCnt(Map<String, Object> map) {
		return session.selectOne("Info.popupCultureCnt", map);
	};
	
	// 축제찾는 팝업 리스트
	@Override
	public List<InfoVO> popupCulture(Map<String, Object> map){
		return session.selectList("Info.popupCulture", map);
	}
	
	@Override
	public List<InfoVO> orderlove(Map<String,Object>map) {
		// TODO Auto-generated method stub
		return session.selectList("Info.orderlove",map);
	}
	@Override
	public String culturedatecount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne("Info.culturedatecount",map);
	}
	@Override
	public List<InfoVO> locationlist(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("Info.locationselect",map);
	}
	@Override
	public String locationcount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.locationcount",map);
	}
	
	// 비로그인시 인기 축제보여주기
	@Override
	public List<InfoVO> bestCultureList(){
		return session.selectList("Info.bestCultureList");
	}
	
	// 로그인시 지역 인기 축제 보여주기
	@Override
	public List<InfoVO> locationBestCultureList(String id){
		return session.selectList("Info.locationBestCultureList", id);
	}
	@Override
	public List<ReviewBoardVO> DetailReview(int fno) {
		// TODO Auto-generated method stub
		return session.selectList("Info.DetailReview",fno);
	}
	/*
	 * @Override public List<InfoVO> tag(Map<String, Object> map) { // TODO
	 * Auto-generated method stub return session.selectList("Info.tag", map); }
	 */
	@Override
	public List<InfoVO> startfestival(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("Info.startfestival",map);
	}
	@Override
	public String startfestivalcount(int level) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.startfestivalcount",level);
	}
	@Override
	public List<InfoVO> schedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("Info.schedule",map);
	}
	@Override
	public String schedulecount(int level) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.schedulecount",level);
	}
	@Override
	public List<InfoVO> endfestival(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("Info.endfestival",map);
	}
	@Override
	public String endfestivalcount(int level) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.endfestivalcount",level);
	}
	
	
	
}
