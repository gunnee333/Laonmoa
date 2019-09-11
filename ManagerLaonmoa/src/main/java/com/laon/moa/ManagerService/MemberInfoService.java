package com.laon.moa.ManagerService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;

import com.laon.moa.VO.MemberVO;

public interface MemberInfoService {
	// 관리자 인원 카운트
	public int AdminCnt() throws Exception;
	
	// 관리자 회원 리스트
	public List<MemberVO> ManagerList(int pagenum,int contentnum);
	
	// 일반회원 카운트
	public int membercnt();

	// 회원 리스트
	public List<MemberVO> MemberList(int pagenum,int contentnum,String max);

	// 회원 비밀번호 수정
	public int Repass(String id, String password);
	
	// 이메일 체크
	public int emailcheck(String email);

	// 회원 정보 수정
	public int MemberUpdate(Map map);

	// 회원 삭제
	public int MemberDelete(MemberVO id);

	// 회원 상세보기
	public MemberVO MemberDetail(String id,String level);
	
	// 일반회원 검색 카운트
	public int Searchcnt(String keyword,String searchmember);
	
	// 일반회원 검색
	public List<MemberVO> Search(int pagenum, int contentnum, String keyword, String searchmember, String max);

	// 블랙회원 카운트
	public int blackmembercnt();

	// 블랙회원 리스트 보기
	public List<MemberVO> blackMemberList(int pagenum, int contentnum, String max);
	
	// 블랙회원 검색카운트
	public int blacksearchcnt(String keyword,String searchmember);
	
	// 블랙회원 검색
	public List<MemberVO> blacksearch(int pagenum,int contentnum,String keyword,String searchmember, String max);
	
	//로그인
	public String login(String id, String password);
	
	// 사용중인 회원리스트 수
	public int uselistCnt(Map<String, Object> map);
	
	// 사용중인 회원리스트
	public List<MemberVO> uselist(Map<String, Object> map);
}
