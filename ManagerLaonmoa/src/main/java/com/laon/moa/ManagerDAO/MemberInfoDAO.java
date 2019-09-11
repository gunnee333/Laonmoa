package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import com.laon.moa.VO.MemberVO;

public interface MemberInfoDAO {
	//관리자 인원 카운트
	public int AdminCnt() throws Exception;
	
	// 관리자 회원 리스트
	public List<MemberVO> ManagerList(Map map);
	
	// 일반회원 카운트
	public int membercnt();

	// 일반회원 리스트 보기
	public List<MemberVO> MemberList(Map map);
	
	// 회원비밀번호 수정
	public int Repass(Map map);
	
	// 이메일 체크
	public int emailcheck(String email);

	// 회원 정보 수정
	public int MemberUpdate(Map map);

	// 회원 삭제
	public int MemberDelete(MemberVO id);

	// 회원 상세보기
	public MemberVO MemberDetail(Map map);
	
	// 회원 검색 카운트
	public int Searchcnt(Map<String,Object> map);
	
	// 일반회원 검색
	public List<MemberVO> Search(Map<String,Object> map);

	// 블랙회원 카운트
	public int blackmembercnt();

	// 블랙회원 리스트 보기
	public List<MemberVO> blackMemberList(Map map);
	
	// 블랙회원 검색카운트
	public int blacksearchcnt(Map<String,Object> map);
	
	// 블랙회원 검색
	public List<MemberVO> blacksearch(Map map);
	
	//로그인
	public String login(Map<String, String> map);
	
	// 사용중인 회원리스트 수
	public int uselistCnt(Map<String, Object> map);
	
	// 사용중인 회원리스트
	public List<MemberVO> uselist(Map<String, Object> map);
}
