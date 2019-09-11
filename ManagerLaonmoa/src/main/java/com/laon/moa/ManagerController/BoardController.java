package com.laon.moa.ManagerController;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
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

import com.laon.moa.ManagerService.BoardService;
import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.MemberVO;
import com.laon.moa.VO.PageMaker;
import com.laon.moa.VO.ReviewBoardVO;

@Controller
@RequestMapping(value = "/admin")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Inject
	BoardService service;
	
//----------------------------------------------자유게시판--------------------------------------------------
	
	// 자유게시판 목록/페이징
	@RequestMapping(value = "/board/freeBoardList", method = RequestMethod.GET)
	public ModelAndView freeBoardList(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();

		int del = Integer.parseInt((String) request.getParameter("del"));
		int pagenum = Integer.parseInt((String) request.getParameter("num"));

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("del", del);
		map.put("level", 3);

		int cpagenum = pagenum;

		int totalcount = service.freeBoardCount(map);

		pagemaker.setTotalcount(totalcount); // 전체 게시글 개수를 가져옴
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객체에 저장
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.

		List<BoardVO> list = new ArrayList<>();
		map.put("pagenum", pagemaker.getPagenum() * 10);
		map.put("contentnum", pagemaker.getContentnum());
		list = service.freeBoardList(map);

		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("totalcount", totalcount);
		mav.setViewName("board/freeBoardList");

		return mav;
	}
	
	// 자유게시판 검색
	@RequestMapping(value = "/board/freeBoardSearch", method = RequestMethod.GET)
	public ModelAndView freeBoardSearch(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<BoardVO> list = null;
		String keyword = request.getParameter("keyword");
		String search = request.getParameter("search");
		String pagenum = request.getParameter("num");
		if(pagenum == null) {
			pagenum = "1";
		}
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.freeBoardSearchcnt(keyword, search)); // 전체 게시글 개수를 가져옴
		
		System.out.println("keyword:::::::::"+keyword);
		
		//검색결과가 존재할 때
		if(pagemaker.getTotalcount() > 0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			list = service.freeBoardsearch(pagemaker.getPagenum() * pagemaker.getContentnum(),
					pagemaker.getContentnum(), keyword, search);
			mav.addObject("cnt", list.size()+1);
		}
		//검색 결과가 없을 때
		else{
			pagemaker.init();
		}
		
		System.out.println("keyword:::::::::"+keyword);
		
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("board/freeBoardList");
		return mav;
	}

	// 자유게시판 글쓰기
	@RequestMapping(value = "/board/freeBoardInsert", method = RequestMethod.GET)
	public String getInsert() throws Exception {
		return "/board/freeBoardInsert";
	}

	// 자유게시판 글쓰기
	@RequestMapping(value = "/board/freeBoardInsert", method = RequestMethod.POST)
	public String postInsert(BoardVO vo) throws Exception {
		int bnum = service.BoardInsert(vo);
		return "redirect:/admin/board/freeBoardDetail?bnum=" + bnum;
	}

	// 자유게시판 상세보기
	@RequestMapping(value = "/board/freeBoardDetail", method = { RequestMethod.GET, RequestMethod.POST })
	public String getDetail(@RequestParam("bnum") int bnum, Model model) throws Exception {
		BoardVO view = null;
		view = service.BoardDetail(bnum);
		model.addAttribute("view", view);
		return "/board/freeBoardDetail";
	}

	// 자유게시판 수정하기
	@RequestMapping(value = "/board/freeBoardChange", method = RequestMethod.GET)
	public String getChange(@RequestParam("bnum") int bnum, Model model) throws Exception {
		BoardVO view = null;
		view = service.BoardDetail(bnum);
		model.addAttribute("view", view);
		return "/board/freeBoardChange";
	}

	// 자유게시판 수정하기
	@RequestMapping(value = "/board/freeBoardChange", method = RequestMethod.POST)
	public String postChange(BoardVO vo) throws Exception {
		service.BoardChange(vo);
		return "redirect:/admin/board/freeBoardDetail?bnum=" + vo.getBnum();
	}

	// 자유게시판 삭제하기
	@RequestMapping(value = "/board/freeBoardDelete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bnum") int bnum, Model model) throws Exception {
		BoardVO view = null;
		view = service.BoardDetail(bnum);
		model.addAttribute("view", view);
		return "/board/freeBoardDelete";
	}

	// 자유게시판 삭제하기
	@RequestMapping(value = "/board/freeBoardDelete", method = RequestMethod.POST)
	public String postDelete(@RequestParam("bnum") int bnum) throws Exception {
		service.BoardDelete(bnum);
		return "redirect:/admin/board/freeBoardList?del=-1&num=1";
	}


//----------------------------------------------리뷰게시판--------------------------------------------------

	// 리뷰게시판 목록/페이징
	@RequestMapping(value = "/board/reviewBoardList", method = RequestMethod.GET)
	public ModelAndView reviewBoardList(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();

		int del = Integer.parseInt((String) request.getParameter("del"));
		int pagenum = Integer.parseInt((String) request.getParameter("num"));
		String fname = request.getParameter("fname");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("del", del);
		map.put("level", 4);
		map.put("fname", fname);

		int cpagenum = pagenum;

		int totalcount = service.reviewBoardCount(map);

		pagemaker.setTotalcount(totalcount); // 전체 게시글 개수를 가져옴
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.

		List<BoardVO> list = new ArrayList<>();
		map.put("pagenum", pagemaker.getPagenum() * 10);
		map.put("contentnum", pagemaker.getContentnum());
		list = service.reviewBoardList(map);

		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("totalcount", totalcount);
		mav.setViewName("board/reviewBoardList");

		return mav;
	}

	// 리뷰게시판 글쓰기
	@RequestMapping(value = "/board/reviewBoardInsert", method = RequestMethod.GET)
	public String getReviewInsert() throws Exception {
		return "/board/reviewBoardInsert";
	}

	// 리뷰게시판 글쓰기
	@RequestMapping(value = "/board/reviewBoardInsert", method = RequestMethod.POST)
	public String postReviewInsert(BoardVO vo, HttpServletRequest request) throws Exception {
		// int bnum = service.reviewInsert(vo);
		Map<String, Object> map = new HashMap<>();
		map.put("title", request.getParameter("title"));
		map.put("content", request.getParameter("content"));
		map.put("id", request.getParameter("id"));
		System.out.println("들어왔다면 map = "+map.toString());
		int bnum = service.reviewInsert(map);
		// redirect를 사용하면 그 jsp페이지에서 컨트롤러로 재요청
		System.out.println("bnum = " + bnum);
		return "redirect:/admin/board/reviewBoardDetail?bnum=" + bnum;
	}

	// 리뷰게시판 문화정보찾기 팝업
	@RequestMapping(value = "/board/searchCulture", method = RequestMethod.GET)
	public ModelAndView searchCulture(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("board/searchCulture");
		List<InfoVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pagemaker = new PageMaker();
		String pagenumStr = request.getParameter("pagenum");
		int pagenum;
		String typeStr = request.getParameter("type");
		logger.info("typeStr = " + typeStr);
		String value = request.getParameter("value");
		logger.info("value = " + value);

		// 페이지번호 받아오기
		if (pagenumStr == null) {
			pagenumStr = "1";
		}
		pagenum = Integer.parseInt(pagenumStr);

		// type 날아오지 않을 때 null 문자열로 변경
		if (typeStr == null) {
			typeStr = "-1";
		}
		int type = Integer.parseInt(typeStr);
		// 검색값 날아오지 않았을 때 null 문자열로 변경
		if (value == null) {
			value = "!null";
		}

		map.put("type", type);
		map.put("value", value);
		/* System.out.println("MAP ::: " + map.toString()); */

		// 페이징처리 -기본 10개씩 보여주는걸로 설정되어 있음.
		// 조건에 맞는 게시글의 수가 0이 아닐 때, 페이징처리 및 리스트 mav에 담아줌
		int totalcount = service.popupCultureCnt(map);
		System.out.println("검색게시글 총 갯수 = " + totalcount);
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
		mav.setViewName("board/searchCulture");
		return mav;
	}

	// 리뷰게시판 상세보기
	@RequestMapping(value = "/board/reviewBoardDetail", method = { RequestMethod.GET, RequestMethod.POST })
	public String getReviewDetail(@RequestParam("bnum") int bnum, Model model) throws Exception {
		ReviewBoardVO detail = null;
		detail = service.reviewDetail(bnum);
		System.out.println("VO ::::  " + detail.toString());
		model.addAttribute("detail", detail);
		return "/board/reviewBoardDetail";
	}

	// 리뷰게시판 수정하기
	@RequestMapping(value = "/board/reviewBoardChange", method = RequestMethod.GET)
	public String getReviewChange(@RequestParam("bnum") int bnum, Model model) throws Exception {
		ReviewBoardVO view = null;
		view = service.reviewDetail(bnum);
		model.addAttribute("view", view);

		System.out.println("BNUM:::::::::::::::::::::::::::::::::::::::::::::::::" + bnum);

		return "/board/reviewBoardChange";
	}

	// 리뷰게시판 수정하기	
	@RequestMapping(value = "/board/reviewBoardChange", method = RequestMethod.POST)
	public String postReviewChange(BoardVO vo) throws Exception {
		service.reviewChange(vo);
		return "redirect:/admin/board/reviewBoardDetail?bnum=" + vo.getBnum();
	}

	// 리뷰게시판 삭제하기
	@RequestMapping(value = "/board/reviewBoardDelete", method = RequestMethod.GET)
	public String getReviewDelete(@RequestParam("bnum") int bnum, Model model) throws Exception {
		ReviewBoardVO view = null;
		view = service.reviewDetail(bnum);
		model.addAttribute("view", view);
		return "/board/reviewBoardDelete";
	}

	// 리뷰게시판 삭제하기
	@RequestMapping(value = "/board/reviewBoardDelete", method = RequestMethod.POST)
	public String postReviewDelete(@RequestParam("bnum") int bnum) throws Exception {
		service.reviewDelete(bnum);
		// service.BoardDelete(bnum, num);
		return "redirect:/admin/board/reviewBoardList?del=-1&num=1";
	}

	// 절대경로
	private static final String UPLOAD_PATH = "D:/LGH/Laonmoa/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ManagerLaonmoa/resources/image";
 
	// 리뷰게시판 파일업로드
	@RequestMapping(value = "/imageupload", method = RequestMethod.POST)
	@ResponseBody
	public String imageresize(@RequestParam("uploadFile") MultipartFile[] files) throws Exception {
		String fileName = "";
		String saveName = "";
		String url = "";
		for (int i = 0; i < files.length; i++) {
			fileName = files[i].getOriginalFilename(); // 업로드 할 이미지 이름 가져오기
			System.out.println("불러온 파일 이름 = " + fileName);
			UUID uuid = UUID.randomUUID(); // 랜덤 아이디 생성
			System.out.println("생성한 랜덤 아이디 = " + uuid);
			String extension = fileName.substring(fileName.lastIndexOf(".") + 1); // .기준 뒷글자 자르기 ex)jpg
			System.out.println("extension = " + extension);
			saveName = uuid + "_." + extension; // 랜덤 아이디와 jpg합쳐서 새로운 이름 만들어주기
			System.out.println("폴더에 저장할 파일 이름 = " + saveName);
			File file = new File(UPLOAD_PATH, saveName); // file이라는 새로운 객체를 만들면서 경로와 새로운 이름 지정
			files[i].transferTo(file); // 폴더에 저장
			System.out.println("sdfsdfdsfdsfs111");
			Tika tika = new Tika();
			System.out.println("sdfsdfdsfdsfs222");
			String mimeType = tika.detect(file);
			System.out.println("sdfsdfdsfdsfs333");
			System.out.println("mimeType = " + mimeType);
			if (mimeType.startsWith("image")) {
				url = "/resources/image/" + saveName;
			} else {
				url = "noimage";
				file.delete();
			}
		}
		System.out.println(url);
		return url;
	}
	
	// 리뷰게시판 검색
	@RequestMapping(value = "/board/reviewBoardSearch", method = RequestMethod.GET)
	public ModelAndView reviewSearch(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<ReviewBoardVO> list = null;
		String keyword = request.getParameter("keyword");
		String search = request.getParameter("search");
		String pagenum = request.getParameter("num");
		if(pagenum == null) {
			pagenum = "1";
		}
		int cpagenum = Integer.parseInt(pagenum);
		pagemaker.setTotalcount(service.reviewBoardSearchcnt(keyword, search)); // 전체 게시글 개수를 가져옴
		
		System.out.println("keyword:::::::::"+keyword);
		
		//검색결과가 존재할 때
		if(pagemaker.getTotalcount() > 0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			list = service.reviewBoardsearch(pagemaker.getPagenum() * pagemaker.getContentnum(),
					pagemaker.getContentnum(), keyword, search);
			mav.addObject("cnt", list.size()+1);
		}
		//검색 결과가 없을 때
		else{
			pagemaker.init();
		}
		
		System.out.println("keyword:::::::::"+keyword);
		
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("board/reviewBoardList");
		return mav;
	}


// -----------------------------------------공지게시판-------------------------------------------------------

	// 공지게시판 목록/페이징
	@RequestMapping(value = "/board/noticeList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView NoticeList(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<BoardVO> list = new ArrayList<>();
		List<BoardVO> adminlist = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();

		int del = Integer.parseInt((String) request.getParameter("del"));
		int pagenum = Integer.parseInt((String) request.getParameter("num"));
		String levelStr = request.getParameter("level");

		if (levelStr == null) {
			levelStr = "-1";
		}

		int level = Integer.parseInt(levelStr);

		map.put("level", level);
		map.put("del", del);

		int cpagenum = pagenum;
		int totalcount = service.noticeCount(map);

		pagemaker.setTotalcount(totalcount); // 전체 게시글 개수를 가져옴
		pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
		pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
		pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.

		map.put("pagenum", pagemaker.getPagenum() * 10);
		map.put("contentnum", pagemaker.getContentnum());
		list = service.noticeList(map);

		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.addObject("totalcount", totalcount);
		mav.setViewName("board/noticeList");
		return mav;
	}
	
	// 공지게시판 검색
		@RequestMapping(value = "/board/noticeSearch", method = RequestMethod.GET)
		public ModelAndView noticesearch(HttpServletRequest request) throws Exception {
			request.setCharacterEncoding("UTF-8");
			ModelAndView mav = new ModelAndView();
			PageMaker pagemaker = new PageMaker();
			List<BoardVO> list = null;
			String keyword = request.getParameter("keyword");
			String search = request.getParameter("search");
			String pagenum = request.getParameter("num");
			String levelStr = request.getParameter("level");

			if (levelStr == null) {
				levelStr = "-1";
			}
			if(pagenum == null) {
				pagenum = "1";
			}
			if(search == null) {
				search = "null";
			}
			int cpagenum = Integer.parseInt(pagenum);
			int level = Integer.parseInt(levelStr);
			pagemaker.setTotalcount(service.noticeSearchcnt(keyword, search, level)); // 전체 게시글 개수를 가져옴
			
			System.out.println("keyword:::::::::"+keyword);
			System.out.println("pagemaker.getTotalcount() :: " + pagemaker.getTotalcount());
			//검색결과가 존재할 때
			if(pagemaker.getTotalcount() > 0) {
				pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
				pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
				pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
				pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
				pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
				pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
				list = service.noticeSearch(pagemaker.getPagenum() * pagemaker.getContentnum(),
						pagemaker.getContentnum(), keyword, search, level);
				mav.addObject("cnt", list.size()+1);
			}
			//검색 결과가 없을 때
			else{
				pagemaker.init();
			}
			
			System.out.println("keyword:::::::::"+keyword);
			
			mav.addObject("list", list);
			mav.addObject("page", pagemaker);
			mav.setViewName("board/noticeList");
			
			return mav;
		}

	// 공지게시판 글쓰기
	@RequestMapping(value = "/board/noticeInsert", method = RequestMethod.GET)
	public String getNoticeInsert() throws Exception {
		return "/board/noticeInsert";
	}

	// 공지게시판 글쓰기
	@RequestMapping(value = "/board/noticeInsert", method = RequestMethod.POST)
	public String postNoticeInsert(BoardVO vo, HttpServletRequest request) throws Exception {
		int bnum = service.NoticeInsert(vo);
		String levelStr = request.getParameter("level");
		if (levelStr == null) {
			levelStr = "-1";
		}
		int level = Integer.parseInt(levelStr);
		return "redirect:/admin/board/noticeDetail?bnum=" + bnum;
	}

	// 공지게시판 상세보기
	@RequestMapping(value = "/board/noticeDetail", method = { RequestMethod.GET, RequestMethod.POST })
	public String getNoticeDetail(@RequestParam("bnum") int bnum, Model model, HttpServletRequest request) throws Exception {
		BoardVO view = null;
		view = service.NoticeDetail(bnum);
		model.addAttribute("view", view);
		return "/board/noticeDetail";
	}

	// 공지게시판 수정하기
	@RequestMapping(value = "/board/noticeChange", method = RequestMethod.GET)
	public String getNoticeChange(@RequestParam("bnum") int bnum, Model model) throws Exception {
		BoardVO view = null;
		view = service.NoticeDetail(bnum);
		model.addAttribute("view", view);
		return "/board/noticeChange";
	}

	// 공지게시판 수정하기
	@RequestMapping(value = "/board/noticeChange", method = RequestMethod.POST)
	public String postNoticeChange(BoardVO vo) throws Exception {
		service.NoticeChange(vo);
		System.out.println("hello=====================================");
		return "redirect:/admin/board/noticeDetail?bnum=" + vo.getBnum();
	}

	// 공지게시판 삭제하기
	@RequestMapping(value = "/board/noticeDelete", method = RequestMethod.GET)
	public String getNoticeDelete(@RequestParam("bnum") int bnum, Model model) throws Exception {
		BoardVO view = null;
		view = service.NoticeDetail(bnum);
		model.addAttribute("view", view);
		return "/board/noticeDelete";
	}

	// 공지게시판 삭제하기
	@RequestMapping(value = "/board/noticeDelete", method = RequestMethod.POST)
	public String postNoticeDelete(@RequestParam("bnum") int bnum) throws Exception {
		service.NoticeDelete(bnum);
		return "redirect:/admin/board/noticeList?del=-1&num=1";
	}

}
