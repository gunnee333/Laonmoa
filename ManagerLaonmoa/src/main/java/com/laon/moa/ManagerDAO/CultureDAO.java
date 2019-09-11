package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.WarVO;

public interface CultureDAO {
	//문화 정보 상세보기
	public InfoVO CultureDetail(int Fno);
	
	//문화 정보 수정
	public int CultureUpdate(Map<Object, Object> map);
	
	//문화정보 등록
	public int CultureInsert(Map<Object, Object> map);
	
	//문화정보 삭제
	public int CultureDelete(int fno);
	
	//문화정보리스트
	public List<InfoVO> CultureList(Map map);
	
	//축제별 리스트
	public List<InfoVO> festival(Map<String,Integer>  map);
	
	//연극별 리스트
	public List<InfoVO> drama(Map<String,Integer> map);
	//뮤지컬별 리스트
	public List<InfoVO> musical(Map<String,Integer> map);
	//전시회별 리스트
	public List<InfoVO> show(Map<String,Integer> map);

	//문화 사진 출력
	public Map<String, Object> getByteImage();
	
	// 검색
	public List<InfoVO> CultureSearch(Map<Object, Object> map) throws Exception;
	
	//이미지 삭제
	public int imageDelete(int fno);
	
	//전체 문화 정보 구하기
	public int countinfo(Map<Object,Object>  map);
	
	//지역 검색시 카운트
	public int locationcount(String value);
	
	//문화 이름 검색시 카운트
	public int culturenamecount(String value);
}
