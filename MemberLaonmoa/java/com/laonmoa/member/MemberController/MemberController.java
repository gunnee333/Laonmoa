package com.laonmoa.member.MemberController;

import java.util.HashMap;

import java.util.List;
import java.util.Map;
import java.util.Random;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.laonmoa.member.Sha256;
import com.laonmoa.member.MemberService.MemberInfoService;
import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.MemberVO;
import com.laonmoa.member.VO.MessageVO;
import com.laonmoa.member.VO.PageMaker;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	MemberInfoService service;
//메일 인증 번호 생성
	@RequestMapping(value = "/emailsend", method = RequestMethod.GET)
	@ResponseBody
	public String emailsend(HttpServletRequest request) throws Exception {
		logger.info("이메일 인증 번호 생성기");
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();

		System.out.println("emailsend" + request.getParameter("email"));
		String email = request.getParameter("email");
		service.regist(email, AuthenticationKey);
		return AuthenticationKey;
	}
//패스워드 인증번호 생성
	@RequestMapping(value = "/newPassword", method = RequestMethod.GET)
	@ResponseBody
	public String newPassword(HttpServletRequest request, Map<String, String> map) throws Exception {
		logger.info("비밀번호 인증 번호 생성기");
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}

		String AuthenticationKey = temp.toString();
		String secAuthenticationKey = Sha256.encrypt(AuthenticationKey);

		System.out.println("newPassword" + request.getParameter("email"));
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		logger.info(temp.toString());
		map.put("password", secAuthenticationKey);
		map.put("email", email);
		map.put("id", id);

		service.regist(email, AuthenticationKey);
		service.newPassword(map);

		return AuthenticationKey;
	}


	// 비밀번호 이메일 인증 코드 검증
	@RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(MemberVO user, Model model, RedirectAttributes rttr) throws Exception {
		logger.info("이메일 인증 코드 검증");
		System.out.println("cont get user" + user);
		MemberVO vo = new MemberVO();
		vo = service.userAuth(user);
		if (vo == null) {
			rttr.addFlashAttribute("msg", "비정상적인 접근 입니다. 다시 인증해 주세요");
			return "redirect:/";
		}
		// System.out.println("usercontroller vo =" +vo);
		model.addAttribute("login", vo);
		return "/user/emailConfirm";
	}

	// name 중복 체크 컨트롤러
	@RequestMapping(value = "/telCheck", method = RequestMethod.GET)
	@ResponseBody
	public int telCheck(@RequestParam("tel") String tel) {
		logger.info("중복 체크");
		System.out.println("번호 체크!!!!!!!!!!!!");
		int Telcheck = service.TelCheck(tel);
		System.out.println(Telcheck);
		if (Telcheck == 1) {
			System.out.println("번호 있음");
			return 1;
		} else {
			return 0;
		}
	}

	// id찾기
	@RequestMapping(value = "/findingId", method = RequestMethod.GET)
	@ResponseBody
	public String findingId(HttpServletRequest request) {
		logger.info("id찾기");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		String Findingid = service.FindingId(name, tel);
		return Findingid;
	}

	// 비번찾기(일치하는 정보인지 확인용)
	@RequestMapping(value = "/findingPassword", method = RequestMethod.GET)
	@ResponseBody
	public String findingPassword(HttpServletRequest request) {
		logger.info("비번찾기");
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String findingPassword = service.findingPassword(id, email);
		if (findingPassword == null) { // 아이디나 이메일이 틀렸을 경우
			findingPassword = "1";
		} else { // 아이디 이메일 일치하는경우
			findingPassword = "2";
		}
		logger.info("name = " + findingPassword);
		return findingPassword;
	}

	// name 중복 체크 컨트롤러
	@RequestMapping(value = "/nameCheck", method = RequestMethod.GET)
	@ResponseBody
	public int nameCheck(@RequestParam("name") String name) {
		System.out.println("이름을 체크!!!!!!!!!!!!" + name);
		int Namecheck = service.NameCheck(name);
		System.out.println("Controller ::: " + Namecheck);
		return Namecheck;
	}

	// id 중복 체크 컨트롤러
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		System.out.println("아이디체크!!!!!!!!!!!!");
		int Idcheck = service.IdCheck(id);
		System.out.println(Idcheck);
		if (Idcheck == 1) {
			System.out.println("아이디 있음");
			return 1;
		} else {
			return 0;
		}
	}

	// email 중복 체크 컨트롤러
	@RequestMapping(value = "/emailCheck", method = RequestMethod.GET)
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {
		System.out.println("이메일체크!!!!!!!!!!!!");
		int Emailcheck = service.EmailCheck(email);
		System.out.println(Emailcheck);
		if (Emailcheck == 1) {
			System.out.println("이메일 있음");
			return 1;
		} else {
			return 0;
		}
	}

//	// 회원가입
//	@RequestMapping(value = "/join", method = RequestMethod.GET)
//	public String join(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("id", request.getParameter("id"));
//		map.put("password", request.getParameter("password"));
//		map.put("name", request.getParameter("name"));
//		map.put("tel", request.getParameter("tel"));
//		map.put("email", request.getParameter("email"));
//		map.put("zipcode", request.getParameter("zipcode"));
//		map.put("address_1", request.getParameter("address_1"));
//		map.put("address_2", request.getParameter("address_2"));
//		System.out.println("ㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱ"+map);
//		// service.join(map);
//		return "login/loginForm";
//	}
//	
	//회원가입시 인증 메일전송
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String RegisterPost(HttpServletRequest request, MemberVO user, Model model, RedirectAttributes rttr) throws Exception {
		user.setEmail(request.getParameter("email"));
		logger.info("email :::: " + request.getParameter("email"));
		System.out.println("map :: " + user);
		System.out.println("regesterPost 진입 ");
		// 비밀번호 암호화
		String password = user.getPassword();
		String secPassword = Sha256.encrypt(password);
		user.setPassword(secPassword);

		service.join(user);
		rttr.addFlashAttribute("msg", "가입시 사용한 이메일로 인증해주세요");

		return "redirect:/";
	}

//	//회원가입
//	@RequestMapping(value = "/join", method = RequestMethod.POST)
//	public String join(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("id", request.getParameter("id"));
//		map.put("password",request.getParameter("password") );
//		map.put("name",request.getParameter("name") );
//		map.put("tel",request.getParameter("tel") );
//		map.put("email",request.getParameter("email") );
//		map.put("zipcode",request.getParameter("zipcode") );
//		map.put("address_1",request.getParameter("address_1") );
//		map.put("address_2",request.getParameter("address_2") );
//		service.join(map);
//		return "login/loginForm"; 
//	}

	// 회원가입 페이지로 이동
	@RequestMapping(value = "/joinpage", method = RequestMethod.GET)
	public String joinpage() {
		return "login/joinForm";
	}

	// 아이디/비밀번호찾기 페이지로 이동
	@RequestMapping(value = "/findIdPw", method = RequestMethod.GET)
	public String findIdPw() {
		return "login/findIdPw";
	}

	// 내정보 페이지로 이동
	@RequestMapping(value = "/mypage/myinfo", method = RequestMethod.GET)
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView("login/mypage");
		MemberVO vo = service.mypage((String) session.getAttribute("id"));
		mav.addObject("vo", vo);
		return mav;
	}

	// 내정보 수정
	@RequestMapping(value = "/mypage/myinfoUpdate", method = RequestMethod.GET)
	public String myinfoUpdate(MemberVO vo, HttpSession session) {
		// 정보수정에서 넘어온 아이디와 세션 아이디 일치시에 수정실행
		if (vo.getId().equals((String) session.getAttribute("id"))) {
			service.update(vo);
		}
		return "redirect:myinfo";
	}

	// 회원탈퇴
	@RequestMapping(value = "/mypage/memberout", method = RequestMethod.GET)
	@ResponseBody
	public String memberout(@RequestParam("id") String id, @RequestParam("password") String password,
			HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		// 탈퇴하려는 아이디가 세션아이디와 동일할 때 수행
		if (id.equals((String) session.getAttribute("id"))) {
			map.put("id", id);
			map.put("password", password);
			int success = service.memberout(map);
			if (success >= 1) {
				session.invalidate();
				return "1"; // 탈퇴 성공
			} else {
				return "0"; // 아이디와 패스워드 불일치
			}
		}
		return "-1"; // 탈퇴하려는 아이디가 세션아이디와 다름
	}

	// 쪽지메인페이지로 이동
	@RequestMapping(value = "/mypage/mynote", method = { RequestMethod.GET, RequestMethod.POST })
	public String mynote(HttpServletRequest request) {
		return "login/mynote";
	}

	// 내 리뷰페이지로 이동
	@RequestMapping(value = "/mypage/myReview", method = RequestMethod.GET)
	public ModelAndView myReview(@RequestParam("pagenum") int pagenum, HttpServletRequest request,
			HttpSession session) {
		ModelAndView mav = new ModelAndView("login/myReview");
		List<BoardVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();

		// 내가 쓴 글만 보기 위한 세션아이디 받아오기
		String id = (String) session.getAttribute("id");

		// boardType 이 Param 으로 날아오지 않았을 때 모든 게시판 글보기
		String boardType = request.getParameter("boardType");
		String korboardType = ""; // select 에 기본으로 출력하기 위한 한글게시판타입
		if (boardType == null) {
			boardType = "all";
		}

		// 게시글 타입에 따라 검색할 level 값 변경해주기
		int level = 0;
		if (boardType.equals("all")) {
			level = 0;
			korboardType = "전체";
		} else if (boardType.equals("freeboard")) {
			level = 3;
			korboardType = "자유게시판";
		} else if (boardType.equals("reviewboard")) {
			level = 4;
			korboardType = "리뷰게시판";
		}

		// 검색조건 체크
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		if (type == null) {
			type = "null";
		}

		map.put("id", id);
		map.put("level", level);
		map.put("boardType", boardType);
		map.put("type", type);
		map.put("value", value);

		// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
		PageMaker pagemaker = new PageMaker();
		// 조건에 맞는 게시글의 수가 0이 아닐 때, 페이징처리 및 리스트 mav에 담아줌
		int totalcount = service.myBoardCount(map);
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

			list = service.myBoard(map);
		} else {
			// 조건에 맞는 게시글이 없는 경우 pagemaker 초기화
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("boardType", boardType); // option selected 를 위한 boardType
		mav.addObject("korboardType", korboardType); // option selected 를 위한 boardType
		mav.addObject("page", pagemaker);
		return mav;
	}

	// 비밀번호 팝업
	@RequestMapping(value = "/mypage/changePw", method = RequestMethod.GET)
	public String openchangePW() {
		return "popup/changePw";
	}

	// 비밀번호 수정
	@RequestMapping(value = "/mypage/changePw", method = RequestMethod.POST)
	@ResponseBody
	public String changePw(@RequestParam("id") String id, @RequestParam("password") String password,
			@RequestParam("newpassword") String newpassword, HttpSession session) {
		// 비밀번호 암호화
		String secPassword = Sha256.encrypt(password);
		String secNewPassword = Sha256.encrypt(newpassword);

		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", secPassword);
		map.put("newpassword", secNewPassword);
		// 세션아이디와 비밀번호 수정할 아이디 같을 경우
		if (id.equals((String) session.getAttribute("id"))) {
			int success = service.changePw(map);
			if (success >= 1) {
				return "1"; // 변경성공
			} else {
				return "0"; // 변경실패
			}
		}
		return "-1"; // 세션아이디와 비밀번호수정아이디 다름
	}

	// 멤버찾는 팝업
	@RequestMapping(value = "/mypage/searchMember", method = RequestMethod.GET)
	public ModelAndView searchMember(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("popup/searchMember");
		List<MemberVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();

		// 검색타입&검색값 받아오기 => 검색타입&검색값이 없을 때 각각 "null" 문자열 넣어줌
		String type = request.getParameter("type");
		String korType = "";
		if (type == null) {
			type = "null";
		}
		String value = request.getParameter("value");

		// selected option 기본값 설정을 위한 한글검색타입
		if (type.equals("all") || type.equals("null")) {
			korType = "전체선택";
		} else if (type.equals("id")) {
			korType = "아이디";
		} else if (type.equals("name")) {
			korType = "이름";
		} else if (type.equals("email")) {
			korType = "이메일";
		}

		// 세션아이디 받아오기 (자신의 아이디는 제외하고 리스트보여주기 위함)
		String id = (String) session.getAttribute("id");
		if (id == null) {
			id = "sessionIDisNULL"; // 혹시라도 세션아이디가 없을 시 ! 넣어줘서 모든아이디 검색
		}

		// 페이지번호 받아오기 (넘어온 페이지번호 없을 시 1로 설정)
		String pagenumStr = request.getParameter("pagenum");
		if (pagenumStr == null) {
			pagenumStr = "1";
		}
		int pagenum = Integer.parseInt(pagenumStr);
		
		map.put("id", id);
		map.put("type", type);
		map.put("value", value);

		// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
		PageMaker pagemaker = new PageMaker();
		int totalcount = service.memberSearchCnt(map);
		// 보여줄 데이터의 갯수가 0이 아닐 경우
		if (totalcount > 0) {
			pagemaker.setTotalcount(totalcount); // 전체 쪽지갯수 가져옴
			pagemaker.setContentnum(8);// 한페이지에 8개씩 보여줌
			pagemaker.setPagenum(pagenum - 1); // 처음 보여줄 페이지번호 -1
			pagemaker.setCurrentblock(pagenum); // 페이지블록 (1~5 / 6~10)
			pagemaker.setLastblock(pagemaker.getTotalcount());// 마지막 블록 설정
			pagemaker.prevnext(pagenum); // 페이지번호로 화살표 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지블록번호로 결정
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막페이지 블록과 현재 페이지 블록으로 정함
			
			map.put("pagenum", pagemaker.getPagenum() * pagemaker.getContentnum());
			map.put("contentnum", pagemaker.getContentnum());
			
			list = service.searchMember(map);
		} else {
			// 보여줄 데이터가 없을 경우
			pagemaker.init();
		}

		mav.addObject("list", list);
		mav.addObject("type", type); // selected option 값을 위한 검색타입
		mav.addObject("korType", korType); // selected option 값을 위한 검색타입
		mav.addObject("value", value); // selected option 값을 위한 검색타입
		mav.addObject("page", pagemaker);
		return mav;
	}

	// 경고팝업
	@RequestMapping(value = "/mypage/warning", method = RequestMethod.GET)
	public String warning() {
		return "popup/warning";
	}

	// 쪽지함으로 이동
	@RequestMapping(value = "/mypage/noteList", method = RequestMethod.GET)
	public ModelAndView noteList(@RequestParam("pagenum") int pagenum, @RequestParam("num") int num,
			HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("login/noteList");
		List<MessageVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();

		// 열람여부조건
		String readType = request.getParameter("readType");
		String korreadType = null;
		int ifread = -1;
		if (readType == null) { // 열람여부조건 안날아왔을 때 모든데이터 출력
			readType = "all";
		}
		// select 에 출력할 한글열람여부
		if (readType.equals("all")) {
			korreadType = "열람여부";
		} else if (readType.equals("read")) {
			korreadType = "열람";
			ifread = 1;
		} else if (readType.equals("notread")) {
			korreadType = "미열람";
			ifread = 0;
		}

		// 검색조건 확인
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
		if (searchType == null || searchType.equals("")) {
			searchValue = "null"; // 검색하지 않았을 때, null 로 임의지정
		}

		// 세션아이디 받아오기
		String id = (String) session.getAttribute("id");

		// 서비스에 보내기 위한 map
		map.put("id", id);
		map.put("num", num);
		map.put("readType", readType);
		map.put("ifread", ifread);
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);

		// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
		PageMaker pagemaker = new PageMaker();
		int totalcount = service.notecount(map);
		// 보여줄 쪽지의 갯수가 0을 초과하는 경우 페이징처리
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
			list = service.noteList(map);
		} else {
			// 조건에 맞는 쪽지가 없는 경우 pagemaker 초기화
			pagemaker.init();
		}

		mav.addObject("list", list);
		mav.addObject("ifsend", num);
		mav.addObject("readType", readType); // select 에 열람여부기본값을 위함
		mav.addObject("korreadType", korreadType); // select 에 열람여부기본값을 위함
		mav.addObject("page", pagemaker);
		return mav;
	}

	// 쪽지보내기 페이지로 이동
	@RequestMapping(value = "/mypage/noteSend", method = RequestMethod.GET)
	public ModelAndView noteSend(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("login/noteSend");
		String recid = request.getParameter("recid");
		mav.addObject("recid", recid);
		return mav;
	}

	// 쪽지 보내기
	@RequestMapping(value = "/mypage/noteSend", method = RequestMethod.POST)
	public String noteSend(MessageVO vo, HttpSession session) {
		// recid, mtitle, mcontent 받아옴
		vo.setSendid((String) session.getAttribute("id"));
		System.out.println(vo.toString());
		service.noteSend(vo);
		System.out.println(vo.toString());
		return "redirect:/mypage/notedetail?mnum=" + vo.getMnum();
	}

	// 쪽지상세페이지로 이동
	@RequestMapping(value = "/mypage/notedetail", method = RequestMethod.GET)
	public ModelAndView notedetail(@RequestParam("mnum") int mnum, HttpSession session) {
		ModelAndView mav = new ModelAndView("login/notedetail");
		MessageVO vo = new MessageVO();
		vo = service.notedetail(mnum);
		String sessionid = (String) session.getAttribute("id");

		// 미열람쪽지를 받은사람이 읽었을 때 읽음으로 변경해줌
		if (vo.getIfread() == 0 && vo.getRecid().equals(sessionid)) {
			service.noteread(vo);
			vo.setIfread(1);
		}
		mav.addObject("list", vo);
		mav.addObject("sessionid", sessionid);
		return mav;
	}

	// 쪽지삭제
	@RequestMapping(value = "/mypage/notedelete", method = RequestMethod.POST)
	public void notedelete(@RequestParam("mnum") int mnum, @RequestParam("id") String id, HttpSession session,
			HttpServletResponse response) {
		String sessionid = (String) session.getAttribute("id");
		// 삭제하려는 글의 작성자와 세션아이디가 같을 때
		if (id.equals(sessionid)) {
			service.notedelete(mnum);
		}
	}

}
