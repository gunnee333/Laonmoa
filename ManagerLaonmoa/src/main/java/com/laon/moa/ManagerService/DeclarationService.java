package com.laon.moa.ManagerService;

import java.util.List;
import java.util.Map;

import com.laon.moa.VO.WarVO;

public interface DeclarationService {
	// 목록 보기
	public List<WarVO> DecList(Map<String, Object> map) throws Exception;
	
	// 신고리스트 갯수세기
	public int warListCnt(Map<String, Object> map);

	// 상세보기
	public WarVO DecDetail(int wnum) throws Exception;

	// 접수
	public int DecUpdate(int wnum) throws Exception;
	
	// 신고횟수 3회 이상시 블랙회원으로 변경
	public void warCntUp(String warid);

	// 기각
	public int DecDelete(int wnum) throws Exception;
	
	//미처리신고 갯수
	public int waralarm();

}
