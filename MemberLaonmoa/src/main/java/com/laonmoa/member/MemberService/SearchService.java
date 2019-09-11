package com.laonmoa.member.MemberService;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.SearchVO;

public interface SearchService {

	//검색 게시글 수
	public int searchCount(Map<String, Object> map) throws Exception;
	
	//검색 리스트
	public List<SearchVO> SearchList(Map<String, Object> map) throws Exception;

	//검색 결과 <정렬>
	public List<SearchVO> New(Map<String, Object> map) throws Exception;


}
