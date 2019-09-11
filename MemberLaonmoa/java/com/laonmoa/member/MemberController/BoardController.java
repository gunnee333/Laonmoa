package com.laonmoa.member.MemberController;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tika.Tika;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.laonmoa.member.MemberService.BoardService;
import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.InfoVO;
import com.laonmoa.member.VO.PageMaker;
import com.laonmoa.member.VO.ReplyVO;
import com.laonmoa.member.VO.ReviewBoardVO;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Inject
	BoardService service;

	// 자유게시판 메인으로 이동
	@RequestMapping(value = "/freeBoardMain", method = RequestMethod.GET)
	public ModelAndView freeBoardMain(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<BoardVO> list = new ArrayList<>();
		List<BoardVO> adminlist = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		String hit = request.getParameter("hit"); // 조회수정렬 처리용 변수
		if (hit == null) {
			hit = "null";
		}
		//1페이지라면 공지사항 불러오기
		if (pagenum.equals("1")) {
			adminlist = service.adminList();
			mav.addObject("adminlist", adminlist);
		}
		pagemaker.setTotalcount(service.freeBoardcount()); // 전체 게시글 개수를 가져옴
		System.out.println("자유게시판 게시글 수 = "+service.freeBoardcount());
		//게시글이 존재할 때
		if(pagemaker.getTotalcount() > 0) {
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
			list = service.freeBoardList(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum(),
					hit);
		}
		//회원용 게시글이 없을 때
		else {
			//공지사항은 있는경우
			if(!adminlist.isEmpty()) {
				pagemaker.init();
			}
			//공지사항까지 없는경우
			else {
				pagemaker.init();
			}
		}
		if (hit.equals("null")) {
			hit = "조회 수";
		} else if (hit.equals("hitdesc")) {
			hit = "많은 순";
		} else {
			hit = "적은 순";
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("hit", hit);
		mav.setViewName("board/freeBoardMain");
		return mav;
	}

	// 자유게시판 상세보기
	@RequestMapping(value = "/freeBoardDetail", method =  RequestMethod.GET )
	public ModelAndView freeBoardDetail(@RequestParam("bnum") int bnum, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		BoardVO detail;
		Cookie[] cookies = request.getCookies();
		// 비교하기 위해 새로운 쿠키
		Cookie viewCookie = null;
		// 쿠키가 있을 경우
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + bnum과 일치하는 쿠키를 viewCookie에 넣어줌
				if (cookies[i].getName().equals("cookie" + bnum)) {
					System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
		// 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
		if (viewCookie == null) {
			System.out.println("cookie 없음");
			// 쿠키 생성(이름, 값)
			Cookie newCookie = new Cookie("cookie" + bnum, "|" + bnum + "|");
			// 쿠키 추가
			response.addCookie(newCookie);
			// 쿠키를 추가 시키고 조회수 증가시킴

			// 자신의 게시글은 조회수 올리지 못하도록하게끔 id값 비교
			String id = (String) session.getAttribute("id");

			// 게시글id와 로그인 id가 다르면 조회수를 증가해야하는데
			// 비로그인상태(null)인 경우에는 비교값 대상자체가 없기 때문에 조회수 증가가 되지않으므로 "!"로 치환
			if (id == null) {
				id = "!";
			}
			// 조회수 증가
			int result = service.freehitup(bnum, id);
			if (result > 0) {
				System.out.println("조회수 증가");
			} else {
				System.out.println("조회수 증가 에러");
			}
		}
		// viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
		else {
			System.out.println("cookie 있음");
			// 쿠키 값 받아옴.
			String value = viewCookie.getValue();
			System.out.println("cookie 값 : " + value);
		}
		detail = service.freeBoardDetail(bnum);
		// 받아온 값 넘겨주기(상세보기)
		if (detail != null) {
			System.out.println("System - 해당 상세 리뷰페이지로 넘어감");
			mav.addObject("detail", detail);
			mav.setViewName("board/freeBoardDetail");
			return mav;
		} else {
			// 에러 페이지 설정
			mav.setViewName("error/error");
			return mav;
		}

	}

	// 자유게시판 글쓰기로 이동
	@RequestMapping(value = "/freeBoardInsert", method = RequestMethod.GET)
	public String freeBoardInsert() {
		return "board/freeBoardInsert";
	}

	// 자유게시판 글 쓰기
	@RequestMapping(value = "/freeBoardInsert", method = RequestMethod.POST)
	public String freeBoardInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		int result = service.freeBoardInsert(request);
		// redirect를 사용하면 그 jsp페이지에서 컨트롤러로 재요청
		return "redirect:freeBoardDetail?bnum=" + result + "&pagenum=1";
	}

	// 자유게시판 글 삭제
	@RequestMapping(value = "/freeDelete", method = RequestMethod.GET)
	public void freeDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		service.freeBoardDelete(id, bnum);
	}

	// 자유게시판 수정으로 이동
	@RequestMapping(value = "/freeBoardUpdate", method = RequestMethod.GET)
	public ModelAndView freeBoardUpdate(@RequestParam("bnum") int bnum) throws Exception {
		ModelAndView mav = new ModelAndView();
		BoardVO list;
		list = service.freeBoardUpdatein(bnum);
		mav.addObject("list", list);
		mav.setViewName("board/freeBoardUpdate");
		return mav;
	}

	// 자유게시판 글 수정
	@RequestMapping(value = "/freeBoardUpdate", method = RequestMethod.POST)
	public ModelAndView freeBoardUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		String num = request.getParameter("bnum");
		if (num == null) {
			num = "-1";
		}
		int bnum = Integer.parseInt(num);
		// int bnum = Integer.parseInt(request.getParameter("bnum"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int result = service.freeBoardUpdate(bnum, title, content);
		if (result > 0) {
			System.out.println("글 수정 성공");
		} else {
			System.out.println("글 수정 실패");
		}
		mav.setViewName("redirect:freeBoardDetail?bnum=" + bnum + "&pagenum=1");
		return mav;
	}

	// 자유게시판 검색
	@RequestMapping(value = "/freeBoardSearch", method = RequestMethod.GET)
	public ModelAndView freeBoardSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("html/text;charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<BoardVO> list = null;
		String keyword = request.getParameter("keyword");
		String search = request.getParameter("search");
		String pagenum = request.getParameter("pagenum");
		String hit = request.getParameter("hit");
		System.out.println("hit는?" + hit);
		if (hit == null) {
			hit = "null";
		}
		if (pagenum == null) {
			pagenum = "1";
		}
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.freeBoardSearchcnt(keyword, search)); // 전체 게시글 개수를 가져옴
		//검색결과가 존재할 때
		if(pagemaker.getTotalcount() > 0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			list = service.freeBoardsearch(pagemaker.getPagenum() * pagemaker.getContentnum(),
					pagemaker.getContentnum(), keyword, search, hit);
			mav.addObject("cnt", list.size()+1);
		}
		//검색 결과가 없을 때
		else{
			pagemaker.init();
		}
		if (hit.equals("null")) {
			hit = "조회 수";
		} else if (hit.equals("hitdesc")) {
			hit = "많은 순";
		} else {
			hit = "적은 순";
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("hit", hit);
		mav.setViewName("board/freeBoardMain");
		return mav;
	}

	// 자유게시판 댓글 삭제
	@RequestMapping(value = "/freeReplyDelete", method = RequestMethod.POST)
	@ResponseBody
	public int freeReplyDelete(HttpServletRequest request) throws Exception {
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		int result = service.freeReplyDelete(rnum);
		if (result > 0) {// 성공했을 경우
			result = rnum;
		} else {
			result = 0;
		}
		return result;
	}

	// 자유게시판 댓글 수정
	@RequestMapping(value = "/freeReplyUpdate", produces = "application/json; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public int freeReplyUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		String rcontent = request.getParameter("rcontent");
		int result = service.freeReplyUpdate(rnum, rcontent);
		if (result > 0) {
			result = 1;
		}
		return result;
	}

	// 자유게시판 댓글 쓰기
	@RequestMapping(value = "/freeReplyInsert", produces = "application/json; charset=utf8", method = RequestMethod.GET)
	@ResponseBody
	public int freeReplyInsert(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		String id = (String) session.getAttribute("id");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String rcontent = request.getParameter("rcontent");
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("bnum", bnum);
		map.put("rcontent", rcontent);
		int result = service.freeReplyInsert(map);
		if (result > 0) {
			result = 1;
		}

		return result;
	}

	// 자유게시판 댓글 불러오기
	@RequestMapping(value = "/replyList", produces = "application/json; charset=utf8", method = RequestMethod.GET)
	@ResponseBody
	public List<ReplyVO> replyList(@RequestParam("bnum") int bnum, HttpServletResponse response) throws Exception {
		List<ReplyVO> reply = null;
		System.out.println("bnum = " + bnum);
		reply = service.freeBoardReply(bnum);
		return reply;

	}

	// -------------------------------리뷰게시판---------------------------------

	// 리뷰게시판 메인으로 이동
	@RequestMapping(value = "/reviewBoardMain", method = RequestMethod.GET)
	public ModelAndView reviewBoardMain(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<ReviewBoardVO> list = new ArrayList<>();
		List<BoardVO> adminlist = new ArrayList<>();
		String pagenum = request.getParameter("pagenum");
		int cpagenum = Integer.parseInt(pagenum);
		String hit = request.getParameter("hit"); // 조회수 처리용 변수
		if (hit == null || hit == "") {
			hit = "null";
		}
		String eventkinds = request.getParameter("eventkinds");
		System.out.println("받아온 eventkinds = "+eventkinds);
		if (eventkinds == null || eventkinds == "") {
			eventkinds = "nullkind";
		}
		//페이지 번호 없을 시 1페이지로 간주
		if(pagenum == null) {
			pagenum = "1";
		}
		//1페이지라면 공지사항 보여주기
		if (pagenum.equals("1")) {
			adminlist = service.reviewadminList();
			mav.addObject("adminlist", adminlist);
		}
		pagemaker.setTotalcount(service.reviewBoardCount(eventkinds)); // 전체 게시글 개수를 가져옴
		//게시물이 존재할 때
		if(pagemaker.getTotalcount() > 0) {
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
			list = service.reviewBoardList(pagemaker.getPagenum() * pagemaker.getContentnum(), pagemaker.getContentnum(),
					hit,eventkinds);
		}
		//게시글이 없는경우
		else {
			//공지사항은 있을 때
			if(!adminlist.isEmpty()) {
				pagemaker.init();
			}
			//공지사항도 없을 때
			else {
				pagemaker.init();
			}
		}
		//댓글 갯수 보여주기
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("hit", hit);
		mav.addObject("eventkinds", eventkinds);
		mav.addObject("hevent", eventkinds);
		mav.setViewName("board/reviewBoardMain");
		return mav;
	}

	// 리뷰게시판 글쓰기로 이동
	@RequestMapping(value = "/reviewBoardInsert", method = RequestMethod.GET)
	public ModelAndView reviewBoardInsert() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/reviewBoardInsert");
		return mav;
	}

	

	// 리뷰게시판 글 쓰기
	@RequestMapping(value = "/reviewBoardInsert", method = RequestMethod.POST)
	public String reviewBoardInsert(HttpServletRequest request,HttpServletResponse response, Model model) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Map<String, Object> map = new HashMap<>();
		map.put("title", request.getParameter("title"));
		map.put("content", request.getParameter("content"));
		map.put("id", request.getParameter("id"));
		logger.info("글쓰기의 fno = "+request.getParameter("fno"));
		String fno = request.getParameter("fno");
		String level = request.getParameter("level");
		logger.info("글쓰기의 level = "+level);
		if(fno == "") {
			fno = "0";
		}
		map.put("fno", fno);
		int result = service.reviewBoardInsert(map);
		// redirect를 사용하면 그 jsp페이지에서 컨트롤러로 재요청
		System.out.println("result = " + result);
		if(level.equals("1")) {
			return "redirect:reviewadminDetail?bnum=" + result + "&pagenum=1";
		}
		else {
			return "redirect:reviewBoardDetail?bnum=" + result + "&pagenum=1";
		}
	}
	
	// 리뷰게시판 문화정보찾기 팝업
		@RequestMapping(value = "/searchCulture", method = RequestMethod.GET)
		public ModelAndView searchCulture(HttpServletRequest request) {
			ModelAndView mav = new ModelAndView("popup/searchCulture");
			List<InfoVO> list = null;
			Map<String, Object> map = new HashMap<String, Object>();
			PageMaker pagemaker = new PageMaker();
			String pagenumStr = request.getParameter("pagenum");
			int pagenum;
			String typeStr = request.getParameter("type");
			logger.info("typeStr = "+typeStr);
			String value = request.getParameter("value");
			logger.info("value = "+value);
			
			// 페이지번호 받아오기
			if(pagenumStr == null) {
				pagenumStr = "1";
			}
			pagenum = Integer.parseInt(pagenumStr);
			
			// type 날아오지 않을 때 null 문자열로 변경
			if(typeStr == null) {
				typeStr = "-1";
			}
			int type = Integer.parseInt(typeStr);
			// 검색값 날아오지 않았을 때 null 문자열로 변경
			if(value == null) {
				value = "!null";
			}
			
			map.put("type", type);
			map.put("value", value);
			
			// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
			// 조건에 맞는 게시글의 수가 0이 아닐 때, 페이징처리 및 리스트 mav에 담아줌
			int totalcount = service.popupCultureCnt(map);
			System.out.println("검색게시글 총 갯수 = "+totalcount);
			if(totalcount > 0) {
				pagemaker.setTotalcount(totalcount); // 전체 쪽지갯수 가져옴
				pagemaker.setContentnum(15);
				pagemaker.setPagenum(pagenum - 1); // 처음 보여줄 페이지번호 -1
				pagemaker.setCurrentblock(pagenum); // 페이지블록 (1~5 / 6~10)
				pagemaker.setLastblock(pagemaker.getTotalcount());// 마지막 블록 설정
				pagemaker.prevnext(pagenum); // 페이지번호로 화살표 나타낼지 결정
				pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지블록번호로 결정
				pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
				// 마지막 페이지를 마지막페이지 블록과 현재 페이지 블록으로 정함
				map.put("pagenum", pagemaker.getPagenum()*pagemaker.getContentnum());
				map.put("contentnum", pagemaker.getContentnum());
				list = service.popupCulture(map);
			} else {
				// 조건에 맞는 게시글이 없는 경우 pagemaker 초기화
				pagemaker.init();
			}
			
			mav.addObject("list", list);
			mav.addObject("page", pagemaker);
			mav.setViewName("popup/searchCulture");
			return mav;
		}
	
	//절대경로
	private static final String UPLOAD_PATH = "http://hoohee0331.cdn3.cafe24.com/resource";
	//리뷰게시판 파일업로드
	@RequestMapping(value="/imageupload",method=RequestMethod.POST)
	@ResponseBody
	public String imageresize(@RequestParam("uploadFile") MultipartFile[] files)throws Exception{
		String fileName = "";
		String saveName = "";
		String url = "";
		for (int i = 0; i < files.length; i++) {
			fileName = files[i].getOriginalFilename(); // 업로드 할 이미지 이름 가져오기
			System.out.println("불러온 파일 이름 = " + fileName);
			UUID uuid = UUID.randomUUID(); // 랜덤 아이디 생성
			System.out.println("생성한 랜덤 아이디 = "+uuid);
			String extension = fileName.substring(fileName.lastIndexOf(".") + 1); // .기준 뒷글자 자르기 ex)jpg
			System.out.println("extension = " + extension);
			saveName = uuid + "_." + extension; // 랜덤 아이디와 jpg합쳐서 새로운 이름 만들어주기
			System.out.println("폴더에 저장할 파일 이름 = " + saveName);
			File file = new File(UPLOAD_PATH, saveName); // file이라는 새로운 객체를 만들면서 경로와 새로운 이름 지정
			files[i].transferTo(file); // 폴더에 저장
			Tika tika = new Tika();
			String mimeType = tika.detect(file);
			System.out.println("mimeType = "+mimeType);
			if(mimeType.startsWith("image")) {
				url = "http://hoohee0331.cdn3.cafe24.com/resource/"+saveName;
			}
			else {
				url = "noimage";
				file.delete();
			}
		}
		return url;
	}
	
	// 리뷰게시판 공지사항 상세보기
	@RequestMapping(value="reviewadminDetail",method = RequestMethod.GET)
	public ModelAndView reviewadminDetail(@RequestParam("bnum")int bnum,HttpServletRequest request,
			HttpServletResponse response,HttpSession session)throws Exception {
		ModelAndView mav = new ModelAndView();
		ReviewBoardVO detail;
		Cookie[] cookies = request.getCookies();
		// 비교하기 위해 새로운 쿠키
		Cookie viewCookie = null;
		// 쿠키가 있을 경우
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + bnum과 일치하는 쿠키를 viewCookie에 넣어줌
				if (cookies[i].getName().equals("cookie" + bnum)) {
					System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
		// 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
		if (viewCookie == null) {
			System.out.println("cookie 없음");
			// 쿠키 생성(이름, 값)
			Cookie newCookie = new Cookie("cookie" + bnum, "|" + bnum + "|");
			// 쿠키 추가
			response.addCookie(newCookie);
			// 쿠키를 추가 시키고 조회수 증가시킴

			// 자신의 게시글은 조회수 올리지 못하도록하게끔 id값 비교
			String id = (String) session.getAttribute("id");

			// 게시글id와 로그인 id가 다르면 조회수를 증가해야하는데
			// 비로그인상태(null)인 경우에는 비교값 대상자체가 없기 때문에 조회수 증가가 되지않으므로 "!"로 치환
			if (id == null) {
				id = "!";
			}
			// 조회수 증가
			int result = service.reviewhitup(bnum, id);
			if (result > 0) {
				System.out.println("조회수 증가");
			} else {
				System.out.println("조회수 증가 에러");
			}
		}
		// viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
		else {
			System.out.println("cookie 있음");
			// 쿠키 값 받아옴.
			String value = viewCookie.getValue();
			System.out.println("cookie 값 : " + value);
		}
		detail = service.reviewadmindetail(bnum);
		logger.info(detail.toString());
			
		// 받아온 값 넘겨주기(상세보기)
		if (detail != null) {
			System.out.println("System - 해당 상세 리뷰페이지로 넘어감");
			mav.addObject("detail", detail);
			mav.setViewName("board/reviewBoardDetail");
			return mav;
		} else {
			// 에러 페이지 설정
			mav.setViewName("error/error");
			return mav;
		}
	}

	// 리뷰게시판 상세보기
	@RequestMapping(value = "/reviewBoardDetail", method = { RequestMethod.GET })
	public ModelAndView reviewBoardDetail(@RequestParam("bnum") int bnum, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		ReviewBoardVO detail;
		Cookie[] cookies = request.getCookies();
		// 비교하기 위해 새로운 쿠키
		Cookie viewCookie = null;
		// 쿠키가 있을 경우
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + bnum과 일치하는 쿠키를 viewCookie에 넣어줌
				if (cookies[i].getName().equals("cookie" + bnum)) {
					System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
		// 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
		if (viewCookie == null) {
			System.out.println("cookie 없음");
			// 쿠키 생성(이름, 값)
			Cookie newCookie = new Cookie("cookie" + bnum, "|" + bnum + "|");
			// 쿠키 추가
			response.addCookie(newCookie);
			// 쿠키를 추가 시키고 조회수 증가시킴

			// 자신의 게시글은 조회수 올리지 못하도록하게끔 id값 비교
			String id = (String) session.getAttribute("id");

			// 게시글id와 로그인 id가 다르면 조회수를 증가해야하는데
			// 비로그인상태(null)인 경우에는 비교값 대상자체가 없기 때문에 조회수 증가가 되지않으므로 "!"로 치환
			if (id == null) {
				id = "!";
			}
			// 조회수 증가
			int result = service.reviewhitup(bnum, id);
			if (result > 0) {
				System.out.println("조회수 증가");
			} else {
				System.out.println("조회수 증가 에러");
			}
		}
		// viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
		else {
			System.out.println("cookie 있음");
			// 쿠키 값 받아옴.
			String value = viewCookie.getValue();
			System.out.println("cookie 값 : " + value);
		}
		detail = service.reviewBoardDetail(bnum);
			
		// 받아온 값 넘겨주기(상세보기)
		if (detail != null) {
			System.out.println("System - 해당 상세 리뷰페이지로 넘어감");
			mav.addObject("detail", detail);
			mav.setViewName("board/reviewBoardDetail");
			return mav;
		} else {
			// 에러 페이지 설정
			mav.setViewName("error/error");
			return mav;
		}

	}

	// 리뷰게시판 수정으로 이동
	@RequestMapping(value = "/reviewBoardUpdate", method = RequestMethod.GET)
	public ModelAndView reviewBoardUpdate(@RequestParam("bnum") int bnum) throws Exception {
		ModelAndView mav = new ModelAndView();
		BoardVO list;
		list = service.reviewBoardUpdatein(bnum);
		mav.addObject("list", list);
		mav.setViewName("board/reviewBoardUpdate");
		return mav;
	}

	// 리뷰게시판 글 수정
	@RequestMapping(value = "/reviewBoardUpdate", method = RequestMethod.POST)
	public ModelAndView reviewBoardUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		String num = request.getParameter("bnum");
		if (num == null) {
			num = "-1";
		}
		int bnum = Integer.parseInt(num);
		// int bnum = Integer.parseInt(request.getParameter("bnum"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int result = service.reviewBoardUpdate(bnum, title, content);
		if (result > 0) {
			System.out.println("글 수정 성공");
		} else {
			System.out.println("글 수정 실패");
		}
		mav.setViewName("redirect:reviewBoardDetail?bnum=" + bnum + "&pagenum=1");
		return mav;
	}

	// 리뷰게시판 글 삭제
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.GET)
	public void reviewDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		service.reviewBoardDelete(id, bnum);
	}

	// 리뷰게시판 검색
	@RequestMapping(value = "/reviewBoardSearch", method = RequestMethod.GET)
	public ModelAndView reviewBoardSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("html/text;charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<ReviewBoardVO> list = null;
		String keyword = request.getParameter("keyword");
		String search = request.getParameter("search");
		String pagenum = request.getParameter("pagenum");
		System.out.println("검색 pagenum = "+pagenum);
		String hit = request.getParameter("hit");
		String eventkinds = request.getParameter("eventkinds");
		//검색용 변수
		String hevent = request.getParameter("hevent");
		if(hevent == null || hevent == "") {
			hevent = "kindnull";
		}
		if (hit == null || hit == "") {
			hit = "null";
		}
		if (eventkinds == null || eventkinds == "") {
			eventkinds = hevent;
		}
		if (pagenum == null) {
			pagenum = "1";
		}
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.reviewBoardSearchcnt(keyword, search , eventkinds)); // 전체 게시글 개수를 가져옴
		System.out.println("pagemaker.gettotal = "+pagemaker.getTotalcount());
		//검색 결과가 있을 때
		if(pagemaker.getTotalcount() > 0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			list = service.reviewBoardsearch(pagemaker.getPagenum() * pagemaker.getContentnum(),
					pagemaker.getContentnum(), keyword, search, hit, eventkinds);
			System.out.println("첫 페이지 = "+pagemaker.getPagenum() * pagemaker.getContentnum());
			System.out.println("어디까지 = "+pagemaker.getContentnum());
			
		}
		//검색 결과가 없을 때
		else{
			pagemaker.init();
		}
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("hit", hit);
		mav.addObject("eventkinds", eventkinds);
		mav.setViewName("board/reviewBoardMain");
		return mav;
	}

	// 리뷰게시판 댓글 불러오기
	@RequestMapping(value = "/reviewreplyList", produces = "application/json; charset=utf8", method = RequestMethod.GET)
	@ResponseBody
	public List<ReplyVO> reviewreplyList(@RequestParam("bnum") int bnum, HttpServletResponse response)
			throws Exception {
		List<ReplyVO> reply = null;
		System.out.println("bnum = " + bnum);
		reply = service.reviewBoardReply(bnum);
		logger.info(reply.toString());
		return reply;

	}

	// 리뷰게시판 댓글 삭제
	@RequestMapping(value = "/reviewReplyDelete", method = RequestMethod.POST)
	@ResponseBody
	public int reviewReplyDelete(HttpServletRequest request) throws Exception {
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		int result = service.reviewReplyDelete(rnum);
		if (result > 0) {// 성공했을 경우
			result = rnum;
		} else {
			result = 0;
		}
		return result;
	}

	// 리뷰게시판 댓글 수정
	@RequestMapping(value = "/reviewReplyUpdate", produces = "application/json; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public int reviewReplyUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		String rcontent = request.getParameter("rcontent");
		int result = service.reviewReplyUpdate(rnum, rcontent);
		if (result > 0) {
			result = 1;
		}
		return result;
	}

	// 리뷰게시판 댓글 쓰기
	@RequestMapping(value = "/reviewReplyInsert", produces = "application/json; charset=utf8", method = RequestMethod.GET)
	@ResponseBody
	public int reviewReplyInsert(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		String id = (String) session.getAttribute("id");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String rcontent = request.getParameter("rcontent");
		List<ReplyVO> list = null;
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("bnum", bnum);
		map.put("rcontent", rcontent);
		int result = service.reviewReplyInsert(map);
		if (result > 0) {
			result = 1;
		}

		return result;
	}
	
	//블랙리스트 글쓰기 제한
	@RequestMapping(value="/blacklist", method=RequestMethod.GET)
	@ResponseBody
	public int blacklist(@RequestParam("id")String id) throws Exception {
		int level = service.blacklist(id);
		return level;
	}
	
//----------------------------------신고--------------------------------------
	
	//신고하기
	@RequestMapping(value = "/warning", method = RequestMethod.GET)
	public ModelAndView warning(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView("popup/warning");
		Map<String, Object> map = new HashMap<>();
		
		String levelStr = request.getParameter("level");
		String numStr = request.getParameter("num");
		String whoid = (String)session.getAttribute("id");
		BoardVO boardvo = null;
		ReplyVO replyvo = null;
		
		if(levelStr == null) {
			levelStr = "-1";
		} if(numStr == null) {
			numStr = "-1";
		}
		
		System.out.println("levelStr:::::::::::" + levelStr);
		System.out.println("numStr:::::::::::::" + numStr);
		
		int level = Integer.parseInt(levelStr);
		int num = Integer.parseInt(numStr);
		
		map.put("level", level);
		map.put("num", num);
		
		if(level == 3 || level == 4) {
			//num 이 bnum
			boardvo = service.boardWar(map);
			// 신고자 아이디/ 게시글제목 받아오기
			mav.addObject("warid", boardvo.getId());
			mav.addObject("title", boardvo.getTitle());
		} else if(level == 5 || level == 6) {
			//num 이 rnum
			replyvo = service.replyWar(map);
			// 신고자 아이디/ 댓글내용 받아오기
			mav.addObject("warid", replyvo.getId());
			mav.addObject("title", replyvo.getRcontent());
		}
		
		map.put("level", level);
		map.put("whoid", whoid);
		
		return mav;
	}

	@RequestMapping(value = "/war", method = RequestMethod.GET)
	@ResponseBody
	public int war(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<>();
		String whoid = (String)session.getAttribute("id");
		String warid = request.getParameter("warid");
		String search = request.getParameter("search");
		String levelStr = request.getParameter("level");
		String numStr = request.getParameter("num");
		String wcontent = request.getParameter("wcontent");
		
		int data = -1;
		
		if(levelStr == null) {
			levelStr = "-1";
		}
		int level = Integer.parseInt(levelStr);
		if(numStr == null) {
			numStr = "-1";
		}
		int num = Integer.parseInt(numStr);
		
		map.put("warid", warid);
		map.put("whoid", whoid);
		map.put("level", level);
		map.put("num", num);
		map.put("wcontent", "["+search+"]" + wcontent);
		
//		System.out.println("search:::::::::::::"+search);
		System.out.println("num:::::::::::::"+num);
//		System.out.println("whoid:::::" + whoid);
		
		if(level == 3 || level == 4) {
			data = service.B_warning(map);
		} else if(level == 5 || level == 6) {
			data = service.R_warning(map);
		}
		
		return data;
	}

}
