package com.laonmoa.member.MemberController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;

import com.laonmoa.member.MemberService.CultureService;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.PageMaker;
import com.laonmoa.member.VO.ReviewBoardVO;

@Controller
@RequestMapping(value = "/culture")
public class CultureController {
	private static final Logger logger = LoggerFactory.getLogger(CultureController.class);
	@Inject
	CultureService service;
	
	// 축제모아 페이지로 이동
	@RequestMapping(value = "/festivalList", method = RequestMethod.GET)
	public ModelAndView festivalList(HttpServletRequest request, @RequestParam("level") int level) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<InfoVO> list = new ArrayList<>();
		PageMaker pagemaker = new PageMaker();
		String count;
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		int month = Integer.parseInt(request.getParameter("month"));
		System.out.println("컨트롤러 실행 몇월인가" + month);
		int allcount = Integer.parseInt(service.festivalCount(level));
		String value = request.getParameter("value");
		if (!value.equals(null)) {
			count = service.locationcount(value, level);
			pagemaker.setTotalcount(Integer.parseInt(service.locationcount(value, level))); 
			System.out.println("vlaue 값 들어오나"+value);
		}
		if (month != 0) {
			count = service.culturedatecount(level, month, year);
			pagemaker.setTotalcount(Integer.parseInt(count)); // 전체 게시글 개수를 가져옴
			System.out.println("0이 아닐때 " + count);
		} else {
			pagemaker.setTotalcount(allcount); // 전체 게시글 개수를 가져옴
			count = service.festivalCount(level);
			System.out.println("0일떄 출력" + count);
		}
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		// select count(id) from laonmoa.member where level = 11
		// sql에 limit함수에서 첫게시물을 0으로 쓰기 때문에 -1하여 저장
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		// pagemaker.setContentnum(10); // 한 페이지에 몇개씩 보여줄지 지정
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		// this.currentblock = pagenum/5; 페이지 번호 / 보여줄 페이지의 갯수
		// if(pagenum%5>0) { 1 % 5 = > 0.2 => 0.2는 0보다 크기 때문에 현재 페이지블록은 1.2가 되지만 int라서
		// 소수점 탈락
		// this.currentblock++; //즉 현재페이지 블록은 1페이지 블록이 된다 (1,2,3,4,5)
		// }
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
		/*
		 * if(pagenum.equals("1")) { List<BoardVO> adminlist = new ArrayList<>();
		 * adminlist = service.adminList(); mav.addObject("adminlist", adminlist); }
		 */
		System.out.println("level+++" + level);
		list = service.festivalList(pagemaker.getPagenum() * 10, pagemaker.getContentnum(), level, month, year);
		mav.addObject("page", pagemaker);
		mav.addObject("list", list);
		mav.addObject("count", count);
		mav.setViewName("culture/festivalList");
		return mav;
	}
	// 월별 데이터 불러오기
	@RequestMapping(value = "/datepage", method = RequestMethod.GET)
	public ModelAndView datepage(@RequestParam("month") int month, @RequestParam("level") int level,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		ModelAndView mav = new ModelAndView();
		System.out.println("date 컨트롤러 진입");
		System.out.println(request.getParameter("pagenum"));
		List<InfoVO> list = null;
		System.out.println("month = " + month);
		PageMaker pagemaker = new PageMaker();
		int allcount = Integer.parseInt(service.culturedatecount(level, month, year));
		pagemaker.setTotalcount(allcount); // 전체 게시글 개수를 가져옴
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		// pagemaker.setContentnum(10); // 한 페이지에 몇개씩 보여줄지 지정
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		// this.currentblock = pagenum/5; 페이지 번호 / 보여줄 페이지의 갯수
		// if(pagenum%5>0) { 1 % 5 = > 0.2 => 0.2는 0보다 크기 때문에 현재 페이지블록은 1.2가 되지만 int라서
		// 소수점 탈락
		// this.currentblock++; //즉 현재페이지 블록은 1페이지 블록이 된다 (1,2,3,4,5)
		// }
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
		/*
		 * if(pagenum.equals("1")) { List<BoardVO> adminlist = new ArrayList<>();
		 * adminlist = service.adminList(); mav.addObject("adminlist", adminlist); }
		 */
		System.out.println("level+++" + level);
		list = service.date(month, level, response, pagemaker.getPagenum() * 10, pagemaker.getContentnum(), year);
		String count = service.culturedatecount(level, month, year);
		mav.addObject("page", pagemaker);
		mav.addObject("list", list);
		mav.addObject("count", count);
		mav.setViewName("culture/festivalList");
		return mav;
	}

	// 월별 데이터 불러오기 
	@RequestMapping(value = "/date", method = { RequestMethod.GET, RequestMethod.POST })
	public String date(@RequestParam("month") int month, @RequestParam("level") int level, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		System.out.println("date 컨트롤러 진입");
		System.out.println(request.getParameter("pagenum"));
		List<InfoVO> list = null;
		System.out.println("month = " + month);
		PageMaker pagemaker = new PageMaker();
		int allcount = Integer.parseInt(service.culturedatecount(level, month, year));
		pagemaker.setTotalcount(allcount); // 전체 게시글 개수를 가져옴
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		System.out.println("level+++" + level);
		list = service.date(month, level, response, pagemaker.getPagenum() * 10, pagemaker.getContentnum(), year);
		String count = service.culturedatecount(level, month, year);
		model.addAttribute("page", pagemaker);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		System.out.println("페이지처리" + pagemaker);
		System.out.println("ddfsdfa" + list.toString());
		return "culture/festivalList";
	}

	@RequestMapping(value = "/location", method = { RequestMethod.GET, RequestMethod.POST })
	public String location(@RequestParam("value") String value, @RequestParam("level") int level,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println("date 컨트롤러 진입");
		System.out.println(request.getParameter("pagenum"));
		PageMaker pagemaker = new PageMaker();
		String count = service.locationcount(value, level);
		pagemaker.setTotalcount(Integer.parseInt(service.locationcount(value, level))); 
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		List<InfoVO> list = null;
		list = service.locationlist(value, level,pagemaker.getPagenum() * 10, pagemaker.getContentnum());
		model.addAttribute("page", pagemaker);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		return "culture/festivalList";
	}

	/*
	 * @RequestMapping(value = "/tag", method = { RequestMethod.GET,
	 * RequestMethod.POST }) public String tag(@RequestParam("value") String
	 * value, @RequestParam("level") int level, HttpServletRequest request,
	 * HttpServletResponse response, Model model) throws Exception { ModelAndView
	 * mav = new ModelAndView(); System.out.println("date 컨트롤러 진입"); PageMaker
	 * pagemaker = new PageMaker(); String count = service.locationcount(value,
	 * level); pagemaker.setTotalcount(Integer.parseInt(service.locationcount(value,
	 * level))); String pagenum = request.getParameter("pagenum"); int cpagenum =
	 * Integer.parseInt(pagenum); pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지
	 * 객채에 저장 pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서
	 * 지정한다. pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글
	 * 수를 통해서 정한다. pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
	 * pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로
	 * 정한다. pagemaker.setEndpage(pagemaker.getLastblock(),
	 * pagemaker.getCurrentblock()); List<InfoVO> list = null; list =
	 * service.locationlist(value, level,pagemaker.getPagenum() * 10,
	 * pagemaker.getContentnum()); model.addAttribute("page", pagemaker);
	 * model.addAttribute("list", list); model.addAttribute("count", count); return
	 * "culture/festivalList"; }
	 */
	
	@RequestMapping(value = "/Newest", method = RequestMethod.GET)
	public ModelAndView Newest(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<InfoVO> list = new ArrayList<>();
		PageMaker pagemaker = new PageMaker();
		int level = Integer.parseInt(request.getParameter("level"));
		int allcount = Integer.parseInt(service.festivalCount(level));
		pagemaker.setTotalcount(allcount); // 전체 게시글 개수를 가져옴
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		if (pagenum == null) {
			pagenum = "1";
		}
		// sql에 limit함수에서 첫게시물을 0으로 쓰기 때문에 -1하여 저장
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		// pagemaker.setContentnum(10); // 한 페이지에 몇개씩 보여줄지 지정
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		// this.currentblock = pagenum/5; 페이지 번호 / 보여줄 페이지의 갯수
		// if(pagenum%5>0) { 1 % 5 = > 0.2 => 0.2는 0보다 크기 때문에 현재 페이지블록은 1.2가 되지만 int라서
		// 소수점 탈락
		// this.currentblock++; //즉 현재페이지 블록은 1페이지 블록이 된다 (1,2,3,4,5)
		// }
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
		/*
		 * if(pagenum.equals("1")) { List<BoardVO> adminlist = new ArrayList<>();
		 * adminlist = service.adminList(); mav.addObject("adminlist", adminlist); }
		 */

		String count = service.festivalCount(level);
		list = service.Newest(pagemaker.getPagenum() * 10, pagemaker.getContentnum(), level);
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("count", count);
		mav.setViewName("culture/festivalList");
		return mav;
	}

	// 공연모아 페이지로 이동
	@RequestMapping(value = "/showList", method = RequestMethod.GET)
	public String showList() {
		return "culture/showList";
	}

	// 내꺼모아 페이지로 이동
	@RequestMapping(value = "/mymoamain", method = RequestMethod.GET)
	public ModelAndView mymoamain(@RequestParam("level") int level, @RequestParam("pagenum") int pagenum,
			HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("culture/mymoamain");
		List<InfoVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pagemaker = new PageMaker();

		// 축제타입 선택했는지 확인
		String flevelStr = request.getParameter("flevel");
		String korType = "";
		if (flevelStr == null) {
			flevelStr = "-1";
		}
		// select 기본값을 위한 축제타입한글
		int flevel = Integer.parseInt(flevelStr);
		if (flevel == -1) {
			korType = "전체";
		} else if (flevel == 7) {
			korType = "축제";
		} else if (flevel == 8) {
			korType = "연극";
		} else if (flevel == 9) {
			korType = "뮤지컬";
		} else if (flevel == 10) {
			korType = "전시회";
		}
		map.put("level", level); // 찜하기/좋아요 구분하기 위한 level
		map.put("flevel", flevel); // 축제타입 구분하기 위한 level

		// 세션아이디받기
		String id = (String) session.getAttribute("id");

		if (id == null) { // 비 로그인시 빈 리스트 보내기
			pagemaker.init();
		} else {
			map.put("id", id);

			// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
			// 조건에 맞는 게시글의 수가 0이 아닐 때, 페이징처리 및 리스트 mav에 담아줌
			int totalcount = service.mymoaCnt(map);
			if (totalcount > 0) {
				pagemaker.setTotalcount(totalcount); // 전체 쪽지갯수 가져옴
				pagemaker.setPagenum(pagenum - 1); // 처음 보여줄 페이지번호 -1
				pagemaker.setCurrentblock(pagenum); // 페이지블록 (1~5 / 6~10)
				pagemaker.setLastblock(pagemaker.getTotalcount());// 마지막 블록 설정
				pagemaker.prevnext(pagenum); // 페이지번호로 화살표 나타낼지 결정
				pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지블록번호로 결정
				pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
				// 마지막 페이지를 마지막페이지 블록과 현재 페이지 블록으로 정함

				map.put("pagenum", pagemaker.getPagenum() * pagemaker.getContentnum());
				map.put("contentnum", pagemaker.getContentnum());
				list = service.mymoa(map);
			} else {
				// 조건에 맞는 게시글이 없는 경우 pagemaker 초기화
				pagemaker.init();
			}
		}

		mav.addObject("list", list);
		mav.addObject("korType", korType); // option selected 를 위한 boardType
		mav.addObject("level", level); // 찜하기 or 좋아요
		mav.addObject("page", pagemaker);
		return mav;
	}

	// 상세페이지로 이동
	@RequestMapping(value = "/cultureDetailView", method = RequestMethod.GET)
	public ModelAndView cultureDetailView(@RequestParam("fno") int fno, HttpServletRequest request,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<ReviewBoardVO> Reviewlist = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
		String id = (String) session.getAttribute("id");
		InfoVO info = service.Detail(fno);
		Reviewlist = service.DetailReview(fno);
		map.put("id", id);
		map.put("fno", fno);
		
		int wishcheck = service.Wishcheck(map);
		int countlove = service.countlove(fno);
		int checklove = service.checklove(map);
		
		mav.addObject("countlove", countlove);
		mav.addObject("checklove", checklove);
		mav.addObject("check", wishcheck);
		mav.addObject("info", info);
		mav.addObject("Reviewlist",Reviewlist);
		mav.setViewName("culture/cultureDetailView");
		return mav;
	}

	@RequestMapping(value = "/Wishdelete", method = RequestMethod.POST)
	@ResponseBody
	public int wishdelete(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		System.out.println("찜목록 !!!" + id);
		int fno = Integer.parseInt(request.getParameter("fno"));
		int wishdelete = service.Wishdelete(id, fno);
		if (wishdelete == 1) {
			return 1;
		} else {
			return 0;
		}
	}

	@RequestMapping(value = "/Wishlistinsert", method = RequestMethod.POST)
	@ResponseBody
	public int Wishlistinsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		int fno = Integer.parseInt(request.getParameter("fno"));
		int wishinsert = service.Wishlistinsert(id, fno);
		System.out.println(fno + id + "!!!!!!!!!!!!!!!!!!");
		if (wishinsert == 1) {
			return 1;
		} else {
			return 0;
		}
	}

	@RequestMapping(value = "/insertlove", method = RequestMethod.POST)
	@ResponseBody
	public int insertlove(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		int fno = Integer.parseInt(request.getParameter("fno"));
		int insertlove = service.insertlove(id, fno);
		if (insertlove == 1) {
			return 1;
		} else {
			return 0;
		}
	}

	@RequestMapping(value = "/deletelove", method = RequestMethod.POST)
	@ResponseBody
	public int deletelove(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		int fno = Integer.parseInt(request.getParameter("fno"));
		int deletelove = service.deletelove(id, fno);
		if (deletelove == 1) {
			return 1;
		} else {
			return 0;
		}
	}

	// 문화정보찾기 팝업
	@RequestMapping(value = "/searchCulture", method = RequestMethod.GET)
	public ModelAndView searchCulture(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("popup/searchCulture");
		List<InfoVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pagemaker = new PageMaker();

		String pagenumStr = request.getParameter("pagenum");
		int pagenum;
		String typeStr = request.getParameter("type");
		int type = -1;
		String value = request.getParameter("value");

		// 페이지번호 받아오기
		if (pagenumStr == null) {
			pagenumStr = "1";
		}
		pagenum = Integer.parseInt(pagenumStr);

		// type 날아오지 않을 때 null 문자열로 변경
		if (typeStr == null) {
			typeStr = "-1";
		}
		type = Integer.parseInt(typeStr);

		// 검색값 날아오지 않았을 때 null 문자열로 변경
		if (value == null) {
			value = "!null";
		}

		map.put("type", type);
		map.put("value", value);

		// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
		// 조건에 맞는 게시글의 수가 0이 아닐 때, 페이징처리 및 리스트 mav에 담아줌
		int totalcount = service.popupCultureCnt(map);
		if (totalcount > 0) {
			pagemaker.setTotalcount(totalcount); // 전체 쪽지갯수 가져옴
			pagemaker.setPagenum(pagenum - 1); // 처음 보여줄 페이지번호 -1
			pagemaker.setCurrentblock(pagenum); // 페이지블록 (1~5 / 6~10)
			pagemaker.setLastblock(pagemaker.getTotalcount());// 마지막 블록 설정
			pagemaker.prevnext(pagenum); // 페이지번호로 화살표 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지블록번호로 결정
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막페이지 블록과 현재 페이지 블록으로 정함

			map.put("pagenum", pagemaker.getPagenum() * pagemaker.getContentnum());
			map.put("contentnum", pagemaker.getContentnum());
			list = service.popupCulture(map);
		} else {
			// 조건에 맞는 게시글이 없는 경우 pagemaker 초기화
			pagemaker.init();
		}

		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		return mav;
	}

	@RequestMapping(value = "/orderlove", method = RequestMethod.GET)
	public ModelAndView orderlove(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<InfoVO> list = new ArrayList<>();
		PageMaker pagemaker = new PageMaker();
		int level = Integer.parseInt(request.getParameter("level"));
		int allcount = Integer.parseInt(service.festivalCount(level));
		pagemaker.setTotalcount(allcount); // 전체 게시글 개수를 가져옴
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		if (pagenum == null) {
			pagenum = "1";
		}
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		String count = service.festivalCount(level);
		list = service.orderlove(pagemaker.getPagenum() * 10, pagemaker.getContentnum(), level);
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("count", count);
		mav.setViewName("culture/festivalList");
		return mav;
	}
	
		// 진행여부
		@RequestMapping(value = "/startfestival", method = RequestMethod.GET)
		public ModelAndView startfestival(@RequestParam("level") int level, HttpServletRequest request) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<InfoVO> list = new ArrayList<>();
			PageMaker pagemaker = new PageMaker();
			String count = service.startfestivalcount(level);
			System.out.println(count);
			pagemaker.setTotalcount(Integer.parseInt(service.startfestivalcount(level))); // 전체 게시글 개수를 가져옴
			String pagenum = request.getParameter("pagenum");
			int cpagenum = Integer.parseInt(pagenum);
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			System.out.println("level+++" + level);
		
			list = service.startfestival(level,pagemaker.getPagenum() * 10, pagemaker.getContentnum());
			mav.addObject("page", pagemaker);
			mav.addObject("count",count);
			mav.addObject("list", list);
		
			mav.setViewName("culture/festivalList");
			return mav;
		}
		// 예정여부
		@RequestMapping(value = "/schedule", method = RequestMethod.GET)
		public ModelAndView schedule(@RequestParam("level") int level, HttpServletRequest request) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<InfoVO> list = new ArrayList<>();
			PageMaker pagemaker = new PageMaker();
			String count = service.schedulecount(level);
			System.out.println(count);
			pagemaker.setTotalcount(Integer.parseInt(service.schedulecount(level))); // 전체 게시글 개수를 가져옴
			String pagenum = request.getParameter("pagenum");
			int cpagenum = Integer.parseInt(pagenum);
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			System.out.println("level+++" + level);

			list = service.schedule(level,pagemaker.getPagenum() * 10, pagemaker.getContentnum());
			mav.addObject("page", pagemaker);
			mav.addObject("count",count);
			mav.addObject("list", list);

			mav.setViewName("culture/festivalList");
			return mav;
		}
		
		// 예정여부
		@RequestMapping(value = "/endfestival", method = RequestMethod.GET)
		public ModelAndView endfestival(@RequestParam("level") int level, HttpServletRequest request) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<InfoVO> list = new ArrayList<>();
			PageMaker pagemaker = new PageMaker();
			String count = service.endfestivalcount(level);
			System.out.println(count);
			pagemaker.setTotalcount(Integer.parseInt(service.endfestivalcount(level))); // 전체 게시글 개수를 가져옴
			String pagenum = request.getParameter("pagenum");
			int cpagenum = Integer.parseInt(pagenum);
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			System.out.println("level+++" + level);
			list = service.endfestival(level,pagemaker.getPagenum() * 10, pagemaker.getContentnum());
			mav.addObject("page", pagemaker);
			mav.addObject("count",count);
			mav.addObject("list", list);
			mav.setViewName("culture/festivalList");
			return mav;
		}
}
