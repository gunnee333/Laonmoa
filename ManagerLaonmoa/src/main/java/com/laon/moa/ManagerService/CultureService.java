package com.laon.moa.ManagerService;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.laon.moa.VO.InfoVO;

public interface CultureService {
	//문화 정보 상세보기
	public InfoVO CultureDetail(int Fno);

	//문화 정보 수정
	public int CultureUpdate(HttpServletRequest request,String saveName) throws ParseException;

	//문화정보 등록
	public int CultureInsert(HttpServletRequest request,MultipartFile multipartFile) throws ParseException;

	//문화정보 삭제
	public int CultureDelete(int Fno);

	//문화정보리스트
	public List<InfoVO> CultureList(int pagenum,int contentnum);

	//축제별 정보 리스트
	public List<InfoVO> festival(int pagenum,int contentnum);
	
	//연극별 리스트
	public List<InfoVO> drama(int pagenum,int contentnum);
	
	//뮤지컬별 리스트
	public List<InfoVO> musical(int pagenum,int contentnum);
	
	//전시회별 리스트
	public List<InfoVO> show(int pagenum,int contentnum);
	
	// 검색
	public List<InfoVO> CultureSearch(Map<Object, Object> map) throws Exception;
	
	//이미지 삭제
	public int imageDelete(int Fno);
	
	//전체 문화정보 구하기
	public int countInfo(int level);

	//지역 검색시 카운트
	public int locationcount(String value);
	
	//문화 이름 검색시 카운트
	public int culturenamecount(String value);
}
