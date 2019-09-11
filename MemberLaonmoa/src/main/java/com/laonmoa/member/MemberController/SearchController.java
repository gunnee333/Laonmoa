package com.laonmoa.member.MemberController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.laonmoa.member.MemberService.SearchService;
import com.laonmoa.member.VO.PageMaker;
import com.laonmoa.member.VO.SearchVO;

@Controller
@RequestMapping(value = "/main")
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	@Inject
	SearchService service;

	// 검색 글 리스트으로 이동
	@RequestMapping(value = "/searchMain", method = RequestMethod.GET)
	public ModelAndView searchMain(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		Map<String, Object> map = new HashMap<String, Object>();
		List<SearchVO> list = null;

		String pagenum = request.getParameter("pagenum");
		String keyword = request.getParameter("keyword"); // 검색 값
		String type = request.getParameter("type"); // 검색 축제 종류
		int ftype = -1;
		String city = request.getParameter("city"); // 검색 도시
		String month = request.getParameter("month"); // 검색 날자
		String sort = request.getParameter("sort"); // 정렬기준 - 최신
		
		System.out.println("Keyword :::::" + keyword);
		System.out.println("month :::::" + month);

		if (pagenum == null) {
			pagenum = "1";
		}
		if (keyword == null || keyword.equals("")) {
			keyword = "$$";
		}
		if (type == null) {
			type = "search_allF";
		}
		if (city == null) {
			city = "전체";
		}
		if (month == null) {
			month = "all";
		}
		if (sort == null) {
			sort = "sort";
		}
		
		if (type.equals("search_allF")) {
			ftype = -1;
		} else if (type.equals("search_festival")) {	//축제
			ftype = 7;
		} else if (type.equals("search_play")) {	// 연극
			ftype = 8;
		} else if (type.equals("search_musical")) {	//뮤지컬
			ftype = 9;
		} else if (type.equals("search_exhibition")) {	//전시회
			ftype = 10;
		}

		int cpagenum = Integer.parseInt(pagenum);

		map.put("keyword", keyword); // 검색 값
		map.put("ftype", ftype); // 축제 타입
		map.put("city", city); // 도시
		map.put("month", month); // 날짜
		map.put("year", 2019); // 년도
		map.put("sort", sort);	//정렬기준 - 최신
		
//		map.put("id", id);	
//		map.put("fno", fno);	

		int totalcount = service.searchCount(map);
		
		if(totalcount != 0) {
			pagemaker.setTotalcount(totalcount); // 게시글 개수를 가져옴
			
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객체에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
			
			
			map.put("pagenum", pagemaker.getPagenum() * pagemaker.getContentnum());
			map.put("contentnum", pagemaker.getContentnum());
			list = service.SearchList(map);
		} else {
			pagemaker.init();
		}

		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("totalcount", totalcount);
		mav.setViewName("main/searchMain");
		return mav;
	}
}
