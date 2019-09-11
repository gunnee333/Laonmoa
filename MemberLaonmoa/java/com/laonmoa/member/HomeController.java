package com.laonmoa.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.laonmoa.member.MemberService.BoardService;
import com.laonmoa.member.MemberService.CultureService;
import com.laonmoa.member.MemberService.MemberInfoService;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.MemberVO;
import com.laonmoa.member.VO.ReviewListVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MemberInfoService memberService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private CultureService cultureService;

	// 메인으로 이동
	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView main(HttpSession session) {
		logger.info("Welcome main!");
		ModelAndView mav = new ModelAndView("main/main");
		List<InfoVO> bestCultureList = null;
		List<ReviewListVO> bestReviewList = null;

		// 축제정보 띄워주기
		String id = (String) session.getAttribute("id");
		if (id == null) {
			// 비로그인시 인기축제리스트 가져오기
			bestCultureList = cultureService.bestCultureList();
		} else {
			// 로그인시 회원주소 위주의 인기축제리스트 가져오기
			bestCultureList = cultureService.locationBestCultureList(id);
			if (bestCultureList.size() == 0) {
				bestCultureList = cultureService.bestCultureList();
			}
		}

		// 베스트 리뷰 가져오기
		int reviewCnt = 3; // 가져올 게시글 갯수
		bestReviewList = boardService.bestReviewList(reviewCnt);

		mav.addObject("bestCultureList", bestCultureList);
		mav.addObject("bestReviewList", bestReviewList);

		return mav;
	}

	// 로그인페이지로 이동
	@RequestMapping(value = "/loginpage", method = RequestMethod.GET)
	public ModelAndView main2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login/loginForm");
		return mav;
	}

	// 로그인 후 메인페이지로 이동
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public String login(HttpServletRequest request, HttpSession session) throws Exception {
		// 파라미터값 받기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String level = request.getParameter("level");
		
		System.out.println("비밀번호 :: " + password);
		String secPassword = Sha256.encrypt(password);
		System.out.println("비밀번호암호화 :: " + secPassword);
		MemberVO vo = memberService.login(id, secPassword, level);
		String login = "";

		if (vo == null) { // 로그인실패
			login = "fail";
		} else { // 세션부여
			session.setAttribute("id", vo.getId());
			session.setAttribute("name", vo.getName());
			login = "success";
		}
		return login;
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// '우리는' 탭으로 이동
	@RequestMapping(value="/laonmoa", method = RequestMethod.GET)
	public String laonmoa() {
		return "main/laonmoa";
	}
	
	// 안읽은 쪽지갯수
	@RequestMapping(value="/noteCnt", method = RequestMethod.POST)
	@ResponseBody
	public int noteCnt(HttpSession session) {
		int result = 0;
		String id = (String) session.getAttribute("id");
		if(id != null) {
			result = memberService.noteCnt(id);
		}
		System.out.println("result :: " + result);
		return result;
	}
}
