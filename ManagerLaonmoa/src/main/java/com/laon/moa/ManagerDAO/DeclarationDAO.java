package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import com.laon.moa.VO.WarVO;

public interface DeclarationDAO {
	// 목록 보기
	public List<WarVO> DecList(Map<String, Object> map) throws Exception;

	// 신고리스트 갯수세기
	public int warListCnt(Map<String, Object> map);

	// 상세보기
	public WarVO DecDetail(int wnum) throws Exception;

	// 접수
	public int DecUpdate(int wnum) throws Exception;
	
	// 신고당한 회원 신고횟수 가져오기
	public int warCnt(String warid);
	
	// 신고횟수 3 이상일 때 블랙회원으로 바꿔주기
	public void blackMemberChange(String warid);

	// 기각
	public int DecDelete(int wnum) throws Exception;
	
	//미처리신고 갯수
	public int waralarm();

}
