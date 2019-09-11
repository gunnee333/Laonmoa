package com.laonmoa.member.MemberService;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.laonmoa.member.MemberDAO.SearchDAO;
import com.laonmoa.member.VO.SearchVO;

@Service
@Repository 
public class SearchServiceImpl implements SearchService {

	private static final Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);
	@Autowired
	private SearchDAO search;

	// 검색 게시글 수 카운트
	@Override
	public int searchCount(Map<String, Object> map) throws Exception {
		return search.searchCount(map);
	}
	
	//검색 리스트
	@Override
	public List<SearchVO> SearchList(Map<String, Object> map) throws Exception {
		return search.searchList(map);
	}

	//검색 결과 <최신순>
	@Override
	public List<SearchVO> New(Map<String, Object> map) throws Exception {
		return search.New(map);
	}

}
