package com.laon.moa;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.laon.moa.ManagerService.MemberInfoService;
import com.laon.moa.VO.MemberVO;
import com.laon.moa.VO.PageMaker;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	MemberInfoService memberService;
	@Inject
	MemberInfoService MemberInfoservice;

	// 메인페이지로 이동
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "/adminMain";
	}
	
	// 비로그인시 로그인페이지로 이동
	@RequestMapping(value = "/adminLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String adminLogin() {
		return "/adminLogin";
	}
	
	// 로그인하기
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int login(@RequestParam("id") String id, @RequestParam("password") String password, HttpSession session) {
		// 비밀번호 암호화
		String secPassword = Sha256.encrypt(password);
		System.out.println(secPassword);
		// 로그인 후 아이디 반환
		String id2 = memberService.login(id, secPassword);
		if(id2 == null || id2.equals("")) {	//로그인실패
			return 0;
		} else {	// 로그인성공
			session.setAttribute("id", id2);
			return 1;
		}
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/adminLogin";
	}

	// 아이디검색 창
	@RequestMapping(value = "/idfind", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView idfind(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("/popup/idfind");
		List<MemberVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pagemaker = new PageMaker();
		
		String pagenum = request.getParameter("pagenum");
		String value = request.getParameter("value");
		if(pagenum == null) {
			pagenum = "1";
		}
		int cpagenum = Integer.parseInt(pagenum);
		
		if(value == null) {
			value = "null!";
		}
		
		map.put("value", value);
		
		System.out.println("map" + map.toString());
		//페이징
		int totalcount = memberService.uselistCnt(map);
		if(totalcount > 0) {
			pagemaker.setTotalcount(totalcount);//관리자 전체인원 카운트
			pagemaker.setPagenum(cpagenum - 1); // DB에서 관리자를 불러올 때 0부터 카운트되기 때문에 -1을 해줌
			pagemaker.setCurrentblock(cpagenum); //페이지 번호를 통해서 현재 블록을 정함
			pagemaker.setLastblock(pagemaker.getTotalcount()); //전체 인원을 통해서 마지막 블록을 정해줌
			//마지막 블록 = 전체 인원 / 한 블록에 보여줄 인원(한 페이지에 보여줄 게시물* 블록 갯수)
			pagemaker.prevnext(cpagenum); //블록 이동버튼(화살표)를 보여줄지 안보여줄지 결정
			//첫 블록에서는 <<버튼(false),마지막 블록에서는 >>버튼(false)
			pagemaker.setStartpage(pagemaker.getCurrentblock()); //블록번호로 첫 페이지 결정
			System.out.println("시작 페이지 = "+pagemaker.getStartpage());
			//한 블록에 5개의 페이지가 존재하기 때문에 블록의 첫페이지는 (현재블록*5)-4
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			//마지막 페이지는 두가지의 경우가 있음
			//1. 다음 블록이 존재하는 경우의 마지막 페이지 => getStartpage()+4 (한 블록을 다섯페이지로 설정하였기때문)
			//2. 현재의 블록이 마지막 블록일 경우 =>전체 페이지 개수와 같음 => 전체인원 / 한페이지에서 보여줄 인원
			map.put("pagenum", pagemaker.getPagenum() * pagemaker.getContentnum());
			map.put("contentnum", pagemaker.getContentnum());
			
			list = memberService.uselist(map);
		} else {
			//게시글이 없을 시
			pagemaker.init();
		}
		
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		return mav;
	}
}
