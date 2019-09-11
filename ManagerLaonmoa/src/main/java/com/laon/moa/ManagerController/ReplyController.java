package com.laon.moa.ManagerController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.laon.moa.ManagerService.BoardService;
import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.MessageVO;
import com.laon.moa.VO.PageMaker;
import com.laon.moa.VO.ReplyVO;

@Controller
@RequestMapping(value = "/admin")
public class ReplyController {
	@Inject
	BoardService service;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// 리플 상세보기
	@RequestMapping(value = "/replyView", method = RequestMethod.GET)
	public ModelAndView replyView(@RequestParam("level") int level, @RequestParam("bnum") int bnum) throws Exception {
		ModelAndView mav = new ModelAndView("board/replyView");

		System.out.println("잘되라 제발");
		System.out.println("---------------------------");
		System.out.println(bnum);
		List<ReplyVO> replyDetail = null;
		BoardVO boardDetail = null;
		replyDetail = service.ReplyDetail(bnum);
		boardDetail = service.BoardDetail(bnum);
		mav.addObject("replyDetail", replyDetail);
		mav.addObject("boardDetail", boardDetail);
		return mav;

	}

	// 리플 삭제 접수
	@RequestMapping(value = "/replyCom", method = { RequestMethod.GET, RequestMethod.POST })
	public String replyCom(@RequestParam("rnum") int rnum) throws Exception {
		logger.info("reply rnum : " + rnum);
		service.ReplyUpdate(rnum);
		return "/board/replyView";
	}

	// 삭제처리 기각
	@RequestMapping(value = "/replyCencle", method = { RequestMethod.GET, RequestMethod.POST })
	public String replyDelete(@RequestParam("rnum") int rnum) throws Exception {
		System.out.println("삭제처리 기각가각!!"+ rnum);
		service.ReplyDelete(rnum);
		return "/board/replyView";
	}

	
//				//최신순 선택조건으로 보기
//				@RequestMapping(value="/noteread", method = { RequestMethod.GET, RequestMethod.POST })
//				public ModelAndView ifread(HttpServletRequest request) throws Exception {
//					request.setCharacterEncoding("UTF-8");
//					ModelAndView mav = new ModelAndView("message/noteList");
//					int ifread = Integer.parseInt(request.getParameter("ifread"));
//					List<MessageVO> list = null;
//					list = service.listRead(ifread);
//					mav.addObject("list", list);
//					return mav;
//				}
	/*
	 * // 조건 검색
	 * 
	 * @RequestMapping(value = "/replysearch", method = { RequestMethod.GET,
	 * RequestMethod.POST }) public ModelAndView notesearch(HttpServletRequest
	 * request) throws Exception { request.setCharacterEncoding("UTF-8");
	 * ModelAndView mav = new ModelAndView("board/replyList"); Map<String, String>
	 * map = new HashMap<>(); // 파라미터값받아서 map에 넣어줌 (name값으로 받아옴) String type =
	 * request.getParameter("type"); String value = request.getParameter("value");
	 * System.out.println("type=" + type); System.out.println("value=" + value);
	 * map.put("type", type);
	 * 
	 * if (type.equals("rcontent")) { map.put("value", "%" + value + "%"); } else {
	 * map.put("value", value); } List<ReplyVO> list = service.ReplySearch(map);
	 * mav.addObject("list", list); return mav; }
	 */

	// 페이징 처리하기!!
	@RequestMapping(value = "/replyList", method = RequestMethod.GET)
	public ModelAndView replyList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<ReplyVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		String pagenum = request.getParameter("num");
		if(pagenum == null) {
			pagenum = "1";
		}
		int cpagenum = Integer.parseInt(pagenum);
		
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		if(type == null) {
			type = "!null";
		}
		
		map.put("type", type);
		map.put("value", value);
		
		pagemaker.setTotalcount(service.replyListCnt(map)); // 전체 게시글 개수
		if(pagemaker.getTotalcount() > 0) {
			pagemaker.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객채에 저장
			pagemaker.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번째인지 현재페이지 번호를 통해서 지정한다.
			pagemaker.setLastblock(pagemaker.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
			pagemaker.prevnext(cpagenum); // 현재 페이지 번호로 화살표를 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지 블록 번호로 정한다.
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록으로 정한다.
			
			map.put("pagenum", pagemaker.getPagenum() * pagemaker.getContentnum());
			map.put("contentnum", pagemaker.getContentnum());
			list = service.replyList(map);
		}
		else {
			pagemaker.init();
		}
		System.out.println(pagemaker.toString());
		
		mav.addObject("page", pagemaker);
		mav.addObject("list", list);
		mav.setViewName("board/replyList");
		
		return mav;
	}

}
