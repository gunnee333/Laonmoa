package com.laon.moa.ManagerDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.laon.moa.ManagerController.MemberController;
import com.laon.moa.VO.MemberVO;

@Repository
public class MemberInfoDAOImpl implements MemberInfoDAO {
	@Inject
	private SqlSession sql;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberInfoDAOImpl.class);
	
	//관리자 인원 카운트
	@Override
	public int AdminCnt() throws Exception {
		return sql.selectOne("Member.admincnt");
	}

	// 관리자보기 리스트
	@Override
	public List<MemberVO> ManagerList(Map map) {
		return sql.selectList("Member.adminlist",map);
	}

	//일반회원 카운트
	@Override
	public int membercnt() {
		return sql.selectOne("Member.membercnt");
	}
	
	//일반회원 리스트
	@Override
	public List<MemberVO> MemberList(Map map) {
	 return sql.selectList("Member.memberlist",map);
	}

	// 회원 상세보기
	@Override
	public MemberVO MemberDetail(Map map) {
		logger.info("상세뷰DAO ="+map.toString());
		return sql.selectOne("Member.memberdetail", map);
	}
	
	//이메일 체크
	@Override
	public int emailcheck(String email) {
		return sql.selectOne("Member.emailcheck", email);
	}

	// 회원수정
	@Override
	public int MemberUpdate(Map map) {
		return sql.update("Member.update", map);
	}

	// 회원삭제
	@Override
	public int MemberDelete(MemberVO id) {
		return sql.update("Member.delete", id);
	}
	
	//일반회원 검색 카운트
	@Override
	public int Searchcnt(Map<String,Object> map) {
		return sql.selectOne("Member.searchcnt",map);
	}
	
	//일반회원 검색
	@Override
	public List<MemberVO> Search(Map<String, Object> map) {
		return sql.selectList("Member.search",map);
	}
	
	//블랙리스트 카운트
	@Override
	public int blackmembercnt() {
		return sql.selectOne("Member.blackmembercnt");
	}

	//블랙리스트
	@Override
	public List<MemberVO> blackMemberList(Map map) {
		return sql.selectList("Member.blackmemberlist", map);
	}
	
	//블랙리스트 검색카운트
	@Override
	public int blacksearchcnt(Map<String,Object> map) {
		return sql.selectOne("Member.blacksearchcnt",map);
	}

	//블랙리스트 검색
	@Override
	public List<MemberVO> blacksearch(Map map) {
		return sql.selectList("Member.blacksearch", map);
	}

	//로그인
	@Override
	public String login(Map<String, String> map) {
		String id = sql.selectOne("Member.login", map);
		return id;
	}

	//회원 비밀번호 수정
	@Override
	public int Repass(Map map) {
		return sql.update("Member.repass",map);
	}
	
	// 사용중인 회원리스트 수
	@Override
	public int uselistCnt(Map<String, Object> map) {
		return sql.selectOne("Member.uselistCnt", map);
	}

	// 사용중인 회원리스트
	@Override
	public List<MemberVO> uselist(Map<String, Object> map) {
		return sql.selectList("Member.uselist", map);
	}
}
