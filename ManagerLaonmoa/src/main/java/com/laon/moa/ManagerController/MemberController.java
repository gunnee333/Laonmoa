package com.laon.moa.ManagerController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.Integer;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.laon.moa.Sha256;
import com.laon.moa.ManagerService.MemberInfoService;
import com.laon.moa.VO.MemberVO;
import com.laon.moa.VO.PageMaker;

@Controller
@RequestMapping(value = "/admin")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Inject
	MemberInfoService service;

	// 관리자 목록 보기
	@RequestMapping(value = "/adminList", method = RequestMethod.GET)
	public ModelAndView adminList(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<MemberVO> list = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		if (pagenum == null || pagenum == "") {
			pagenum = "1";
		}
			int cpagenum = Integer.parseInt(pagenum);
			System.out.println("cpagenum = " + cpagenum);
			pagemaker.setTotalcount(service.AdminCnt());// 관리자 전체인원 카운트
			if(pagemaker.getTotalcount()>0) {
			pagemaker.setPagenum(cpagenum - 1); // DB에서 관리자를 불러올 때 0부터 카운트되기 때문에 -1을 해줌
			pagemaker.setCurrentblock(cpagenum); // 페이지 번호를 통해서 현재 블록을 정함
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 전체 인원을 통해서 마지막 블록을 정해줌
			// 마지막 블록 = 전체 인원 / 한 블록에 보여줄 인원(한 페이지에 보여줄 게시물* 블록 갯수)
			pagemaker.prevnext(cpagenum); // 블록 이동버튼(화살표)를 보여줄지 안보여줄지 결정
			// 첫 블록에서는 <<버튼(false),마지막 블록에서는 >>버튼(false)
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 블록번호로 첫 페이지 결정
			System.out.println("시작 페이지 = " + pagemaker.getStartpage());
			// 한 블록에 5개의 페이지가 존재하기 때문에 블록의 첫페이지는 (현재블록*5)-4
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지는 두가지의 경우가 있음
			// 1. 다음 블록이 존재하는 경우의 마지막 페이지 => getStartpage()+4 (한 블록을 다섯페이지로 설정하였기때문)
			// 2. 현재의 블록이 마지막 블록일 경우 =>전체 페이지 개수와 같음 => 전체인원 / 한페이지에서 보여줄 인원
			list = service.ManagerList(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum());
			}
		else {
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("member/adminList");
		return mav;
	}

	// 일반회원 목록
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public ModelAndView memberlist(HttpServletRequest request) {
		PageMaker pagemaker = new PageMaker();
		ModelAndView mav = new ModelAndView();
		List<MemberVO> list = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		String max = request.getParameter("max");
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.membercnt()); // 전체 게시글 개수
		if(pagemaker.getTotalcount() > 0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
			list = service.MemberList(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum(), max);
			logger.info(list.toString());
		}
		else {
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("member/memberList");
		return mav;
	}

	/*
	 * ModelAndView mav = new ModelAndView(); List<MemberVO> list = null;
	 * 
	 * // 전체 회원 인원 카운트 26명 int count = service.membercount();
	 * 
	 * // 한 페이지에 보여줄 게시물(본인이 선택) int postNum = 20;
	 * 
	 * // 총 인원 / 한 페이지에 보여줄 인원 = 하단 페이징 갯수 // Math.ceil은 소수점 무조건 올림 // 현재 일반회원26명 /
	 * 20은 1.3이기때문에 2페이지 필요 int pageNum = (int)Math.ceil((double)count/(double)20);
	 * 
	 * // 선택한 페이지 번호 (확인용 페이지 번호) // int selectNum = 1;
	 * 
	 * // 출력할 게시물 첫번 째 번호 계산 => query문 limit기능때문에 필요함 // 첫번째 페이지 => (1(num) - 1) *
	 * 20(한 페이지에 출력할 갯수) = 0 => 0번째부터 20개, 0~19 // 두번째 페이지 => (2(num) - 1) * 20 = 20
	 * => 20번째부터 20개 출력, 20~39 if(num==0) { num=1; } int displayPost = (num - 1) *
	 * 20;
	 * 
	 * list = service.listPage(displayPost, postNum, max); mav.addObject("num",num);
	 * mav.addObject("list", list); mav.addObject("pageNum",pageNum);
	 * mav.addObject("max", max); mav.setViewName("member/memberList"); return mav;
	 */

	// 일반회원 상세보기
	@RequestMapping(value = "/memberView", method = RequestMethod.GET)
	public ModelAndView memberView(@RequestParam("id") String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String level = request.getParameter("level");
		logger.info(id);
		logger.info("상세보기컨트롤러 level = " + level);
		MemberVO info = service.MemberDetail(id, level);
		mav.addObject("detail", info);
		mav.setViewName("member/memberView");
		return mav;
	}

	// 회원 탈퇴
	@RequestMapping(value = "/recmemberView", method = { RequestMethod.POST, RequestMethod.GET })
	public String memberDelete(MemberVO id) {
		service.MemberDelete(id);
		return "member/memberView";
	}

	// 일반회원 정보수정 페이지로 이동
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public ModelAndView memberUpdate(@RequestParam("id") String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String level = request.getParameter("level");
		MemberVO info = service.MemberDetail(id, level);
		mav.addObject("info", info);
		mav.setViewName("member/memberUpdate");
		return mav;
	}

	// 일반회원 비밀번호 변경페이지로 이동
	@RequestMapping(value = "/memberPasschange", method = RequestMethod.GET)
	public String memberPasschange() {

		return "/popup/memberPasschange";
	}

	// 일반회원 비밀번호 변경
	@RequestMapping(value = "/memberPasschange", method = RequestMethod.POST)
	public ModelAndView rememberPasschange(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		logger.info("비밀번호 변경");
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String secPassword = Sha256.encrypt(password);
		System.out.println(secPassword);
		logger.info("비밀번호 변경 id = " + id + " , password = " + password);
		int result = service.Repass(id, secPassword);
		mav.addObject("result", result);
		mav.setViewName("popup/memberPasschange");
		return mav;
	}

	// 일반회원 정보수정
	@RequestMapping(value = "/memberUpdater", method = RequestMethod.GET)
	public ModelAndView memberUpdater(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		logger.info("회원정보수정 Controller");
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String age = request.getParameter("age");
		String address_1 = request.getParameter("address_1");
		String address_2 = request.getParameter("address_2");
		String zipcode = request.getParameter("zipcode");
		String level = request.getParameter("level");
		String secession = request.getParameter("secession");
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		map.put("tel", tel);
		map.put("age", age);
		map.put("address_1", address_1);
		map.put("address_2", address_2);
		map.put("zipcode", zipcode);
		logger.info("tel = "+tel);
		map.put("level", level);
		map.put("secession", secession);
		int result = service.MemberUpdate(map);
		mav.addObject("result", result);
		mav.setViewName("member/memberUpdate");
		return mav;
	}
	
	// 일반회원 이메일 체크
	@RequestMapping(value="/emailcheck",method=RequestMethod.POST)
	@ResponseBody
	public int emailcheck(@RequestParam("email")String email) {
		logger.info("email = "+email);
		int result = service.emailcheck(email);
		//중복값이 있을 때 => 사용 불가능
		if(result > 0) {
			result = 1;
		}
		//중복값이 없을 때 => 사용 가능
		else {
			result = 0;
		}
		return result;
	}

	// 일반회원 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("html/text;charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<MemberVO> list = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		logger.info("pagenum = " + pagenum);
		String keyword = request.getParameter("keyword");
		String searchmember = request.getParameter("searchmember");
		String max = request.getParameter("max");
		int cpagenum = Integer.parseInt(pagenum);		
		pagemaker.setTotalcount(service.Searchcnt(keyword, searchmember)); // 전체 게시글 개수
		if(pagemaker.getTotalcount()>0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
			list = service.Search(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum(), keyword,
					searchmember, max);
		}
		else {
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("member/memberList");
		return mav;
	}

	// 블랙리스트 목록보기
	@RequestMapping(value = "/blackList", method = RequestMethod.GET)
	public ModelAndView blackmemberlist(HttpServletRequest request) {
		PageMaker pagemaker = new PageMaker();
		ModelAndView mav = new ModelAndView();
		List<MemberVO> list = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		String max = request.getParameter("max");
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.blackmembercnt()); // 전체 게시글 개수
		if(pagemaker.getTotalcount()>0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
			
			list = service.blackMemberList(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum(),
					max);
		}
		else {
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("member/blackList");
		return mav;
	}

	// 블랙리스트회원 검색
	@RequestMapping(value = "/blacksearch", method = RequestMethod.GET)
	public ModelAndView blacksearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("html/text;charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<MemberVO> list = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		logger.info("pagenum = " + pagenum);
		String keyword = request.getParameter("keyword");
		String searchmember = request.getParameter("searchmember");
		String max = request.getParameter("max");
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.blacksearchcnt(keyword, searchmember)); // 전체 게시글 개수
		if(pagemaker.getTotalcount()>0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
			list = service.blacksearch(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum(),
					keyword, searchmember, max);
		}
		else {
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("member/blackList");
		return mav;
	}

	// 상세보기 뒤로가기
	@RequestMapping(value = "/viewCencel", method = RequestMethod.GET)
	public ModelAndView viewCencel(int pagenum) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pagenum", pagenum);
		mav.setViewName("member/memberList");
		return mav;
	}

}
