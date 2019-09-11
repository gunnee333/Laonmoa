package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.laonmoa.member.VO.SearchVO;

@Repository
public class SearchDAOImpl implements SearchDAO {
	private static final Logger logger = LoggerFactory.getLogger(SearchDAOImpl.class);
	@Inject
	private SqlSession session;

	//검색 게시글 수
	@Override
	public int searchCount(Map<String, Object> map) throws Exception {
		return session.selectOne("Search.searchCount", map); 
	}

	//검색 게시글 리스트
	@Override
	public List<SearchVO> searchList(Map map) throws Exception {
		System.out.println(map.toString());
		return session.selectList("Search.searchList", map);
	}

	//검색 결과 <정렬>
	@Override
	public List<SearchVO> New(Map map) throws Exception {
		return session.selectList("Search.New");
	}


}
