package com.laon.moa.ManagerService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.laon.moa.ManagerController.MemberController;
import com.laon.moa.ManagerDAO.MemberInfoDAO;
import com.laon.moa.VO.MemberVO;

@Service
public class MemberInfoServiceImpl implements MemberInfoService {
	@Inject
	private MemberInfoDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberInfoServiceImpl.class);
	
	//관리자 인원 카운트
	@Override
	public int AdminCnt() throws Exception {
		return dao.AdminCnt();
	}

	// 괸리자 리스트
	@Override
	public List<MemberVO> ManagerList(int pagenum,int contentnum) {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
		return dao.ManagerList(map);
	}
	
	//일반회원 카운트
	@Override
	public int membercnt() {
		return dao.membercnt();
	}

	//일반 회원 리스트
	@Override
	public List<MemberVO> MemberList(int pagenum,int contentnum,String max) {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum);
		map.put("max", max);
		return dao.MemberList(map);
	}
    
	// 회원 상세보기
	@Override
	public MemberVO MemberDetail(String id,String level) {
		Map<String,Object> map = new HashMap<>();
		map.put("id", id);
		map.put("level", level);
		logger.info("서비스 = "+map.toString());
		return dao.MemberDetail(map);
	}
	
	//이메일 체크
	@Override
	public int emailcheck(String email) {
		return dao.emailcheck(email);
	}

	// 회원 정보수정
	@Override
	public int MemberUpdate(Map map) {
		return dao.MemberUpdate(map);
	}

	// 회원 삭제
	@Override
	public int MemberDelete(MemberVO id) {
		return dao.MemberDelete(id);
	}
	
	//일반회원 검색카운트
	@Override
	public int Searchcnt(String keyword,String searchmember) {
		Map<String,Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("searchmember", searchmember);
		return dao.Searchcnt(map);
	}
	
	//일반회원 검색
	@Override
	public List<MemberVO> Search(int pagenum, int contentnum, String keyword, String searchmember, String max) {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum );
		map.put("keyword", keyword);
		map.put("searchmember", searchmember);
		map.put("max", max);
		return dao.Search(map);
	}

	//로그인
	public String login(String id, String password) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		return dao.login(map);
	}

	//블랙리스트 카운트
	@Override
	public int blackmembercnt() {
		return dao.blackmembercnt();
	}

	//블랙리스트 회원
	@Override
	public List<MemberVO> blackMemberList(int pagenum, int contentnum, String max) {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum",pagenum);
		map.put("contentnum",contentnum);
		map.put("max",max);
		return dao.blackMemberList(map);
	}
	
	//블랙리스트 검색카운트
	@Override
	public int blacksearchcnt(String keyword, String searchmember) {
		Map<String,Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("searchmember", searchmember);
		return dao.blacksearchcnt(map);
	}

	//블랙리스트 검색
	@Override
	public List<MemberVO> blacksearch(int pagenum, int contentnum, String keyword, String searchmember, String max) {
		Map<String,Object> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum", contentnum);
		map.put("keyword", keyword);
		map.put("searchmember", searchmember);
		map.put("max", max);
		return dao.blacksearch(map);
	}


	//회원비밀번호 수정
	@Override
	public int Repass(String id,String password) {
		Map<String,Object> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);
		logger.info(map.toString());
		return dao.Repass(map);
	}
	
	// 사용중인 회원리스트 수
	@Override
	public int uselistCnt(Map<String, Object> map) {
		return dao.uselistCnt(map);
	}
	
	//사용중인 회원리스트
	@Override
	public List<MemberVO> uselist(Map<String, Object> map) {
		return dao.uselist(map);
	}
}
