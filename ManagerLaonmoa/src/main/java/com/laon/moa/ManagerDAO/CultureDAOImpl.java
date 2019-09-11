package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.WarVO;

@Repository
public class CultureDAOImpl implements CultureDAO{
	
	@Inject
	private SqlSession session;

	//문화정보 상세보기
	@Override
	public InfoVO CultureDetail(int Fno) {
		return session.selectOne("Info.selectOne",Fno);
	}

	//문화정보 수정
	@Override
	public int CultureUpdate(Map<Object, Object> map) {
		System.out.println("문화정보수정 출력 DAO");
		System.out.println("문화수정11111 " + map.toString());
		return session.update("Info.cultureupdate", map) ;
	}

	//문화정보 추가
	@Override
	public int CultureInsert(Map<Object, Object> map) {
		System.out.println("dao들어가나연");
		System.out.println("map : "+map);
		return session.insert("Info.cultureInsert",map);
	}

	//문화정보 삭제
	@Override
	public int CultureDelete(int fno) {
		System.out.println(fno);
		return session.delete("Info.culturedelete",fno);
	}

	@Override
	public List<InfoVO> CultureList(Map map) {
		return session.selectList("Info.infolist",map);
	}

	@Override
	public List<InfoVO> festival(Map<String,Integer> map) {
		return session.selectList("Info.festivalList",map);
	}

	@Override
	public List<InfoVO> drama(Map<String,Integer> map) {
		return session.selectList("Info.dramaList",map);
	}

	@Override
	public List<InfoVO> musical(Map<String,Integer> map) {
		return session.selectList("Info.musicalList",map);
	}

	@Override
	public List<InfoVO> show(Map<String,Integer> map) {
		return session.selectList("Info.showList",map);
	}

	@Override
	public Map<String, Object> getByteImage() {
		return session.selectOne("Info.getByteImage");
	}

	@Override
	public List<InfoVO> CultureSearch(Map<Object, Object> map) throws Exception {
		System.out.println("dao진입 "+map);
		return session.selectList("Info.search", map);
	}

	@Override
	public int imageDelete(int fno) {
		return session.update("Info.image", fno);
	}

	//문화정보 카운트 
	@Override
	public int countinfo(Map<Object,Object>  map) {
		System.out.println("Dao카운트"+map.toString());
		return session.selectOne("Info.countinfo",map);
	}

	@Override
	public int locationcount(String value) {
		// TODO Auto-generated method stub
		System.out.println("지역 카운트 "+value);
		return session.selectOne("Info.locationcount",value);
	}

	@Override
	public int culturenamecount(String value) {
		// TODO Auto-generated method stub
		return session.selectOne("Info.culturenamecount",value);
	}
	


	
}
