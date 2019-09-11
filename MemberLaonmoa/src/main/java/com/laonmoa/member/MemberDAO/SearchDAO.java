package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.SearchVO;

public interface SearchDAO  {
	
	//검색 게시글 수
	public int searchCount(Map<String, Object> map) throws Exception;
	
	//검색 게시글 리스트
	public List<SearchVO> searchList(Map<String,Object> map) throws Exception;

	//검색 결과 <정렬>
	List<SearchVO> New(Map<String, Object> map) throws Exception;
	
}
