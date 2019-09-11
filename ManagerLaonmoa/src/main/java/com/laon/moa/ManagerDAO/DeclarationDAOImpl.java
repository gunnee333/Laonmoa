package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.laon.moa.VO.WarVO;

@Repository
public class DeclarationDAOImpl implements DeclarationDAO{
	private static final Logger logger = LoggerFactory.getLogger(DeclarationDAOImpl.class);
	@Inject
	private SqlSession session;
	
	private static String namespace = "War";
	
	//신고내역 전체리스트
	@Override
	public List<WarVO> DecList(Map<String, Object> map) throws Exception {
		logger.info("war.dao");
		return session.selectList(namespace + ".list", map);
	}
	
	// 신고리스트 갯수세기
	public int warListCnt(Map<String, Object> map) {
		return session.selectOne(namespace + ".warListCnt", map);
	}
	
	//신고내역 상세보기
	@Override
	public WarVO DecDetail(int wnum) throws Exception {
		return session.selectOne(namespace + ".selectOne", wnum);
	}
	
	//신고접수
	@Override
	public int DecUpdate(int wnum) throws Exception {
		return session.update(namespace + ".update", wnum);
	}
	
	// 신고당한 회원 신고횟수 늘려주고 신고횟수 가져오기
	@Override
	public int warCnt(String warid) {
		session.selectOne(namespace + ".warcntUpdate", warid);
		return session.selectOne(namespace + ".selectWarCnt", warid);
	}
	
	// 신고횟수 3 이상일 때 블랙회원으로 바꿔주기
	@Override
	public void blackMemberChange(String warid) {
		session.selectOne(namespace + ".blackMemberChange", warid);
	}

	//신고기각
	@Override
	public int DecDelete(int wnum) throws Exception {
		return session.delete(namespace + ".delete", wnum);
	}

	//미처리신고 갯수
	@Override
	public int waralarm() {
		return session.selectOne(namespace + ".waralarm");
	}

}
