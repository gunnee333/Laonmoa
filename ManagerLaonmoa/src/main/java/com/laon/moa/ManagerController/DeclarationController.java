package com.laon.moa.ManagerController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.laon.moa.ManagerService.BoardService;
import com.laon.moa.ManagerService.DeclarationService;
import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.PageMaker;
import com.laon.moa.VO.ReplyVO;
import com.laon.moa.VO.WarVO;

@Controller
@RequestMapping(value = "/admin")
public class DeclarationController {
	private static final Logger logger = LoggerFactory.getLogger(DeclarationController.class);
	@Inject
	DeclarationService service;
	@Inject
	BoardService boardService;

	// 신고내역 전체리스트
	@RequestMapping(value = "/warList", method = { RequestMethod.GET, RequestMethod.POST } )
	public ModelAndView warList(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView("declaration/warList");
		List<WarVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pagemaker = new PageMaker();
		
		// 페이지넘버 받아오기
		String pagenumStr = request.getParameter("pagenum");
		if(pagenumStr == null) {
			pagenumStr = "1";
		}
		int pagenum = Integer.parseInt(pagenumStr);
		
		// 검색조건 받아오기
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		if(type == null) {
			type = "null";
		}
		
		// 게시판타입(level) 받아오기
		String levelStr = request.getParameter("level");
		if(levelStr == null) {
			levelStr = "-1";
		}
		int level = Integer.parseInt(levelStr);
		
		// 처리여부 받아오기
		String processStr = request.getParameter("process");
		if(processStr == null) {
			processStr = "-1";
		}
		int process = Integer.parseInt(processStr);
		
		map.put("pagenum", pagenum);	// 페이지번호
		map.put("type", type);	// 검색타입
		map.put("value", value);	// 검색값
		map.put("level", level);	// 게시판타입
		map.put("process", process);	// 처리여부
		
		int totalcount = service.warListCnt(map);
		if(totalcount > 0) {
			pagemaker.setTotalcount(totalcount); // 전체 쪽지갯수 가져옴
			pagemaker.setPagenum(pagenum - 1); // 처음 보여줄 페이지번호 -1
			pagemaker.setCurrentblock(pagenum); // 페이지블록 (1~5 / 6~10)
			pagemaker.setLastblock(pagemaker.getTotalcount());// 마지막 블록 설정
			pagemaker.prevnext(pagenum); // 페이지번호로 화살표 나타낼지 결정
			pagemaker.setStartpage(pagemaker.getCurrentblock()); // 시작페이지를 페이지블록번호로 결정
			pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
			// 마지막 페이지를 마지막페이지 블록과 현재 페이지 블록으로 정함
			map.put("pagenum", pagemaker.getPagenum()*pagemaker.getContentnum());
			map.put("contentnum", pagemaker.getContentnum());
			
			list = service.DecList(map);
		} else {
			// 조건에 맞는 게시글이 없는 경우 pagemaker 초기화
			pagemaker.init();
		}
		
		
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		return mav;
	}

	// 신고내역 상세보기
	@RequestMapping(value = "/warView", method = RequestMethod.GET)
	public ModelAndView warView(@RequestParam("wnum") int wnum) throws Exception {
		ModelAndView mav = new ModelAndView("declaration/warView");

		WarVO warDetail = null;
		BoardVO boardDetail = null;
		ReplyVO replyDetail = null;

		warDetail = service.DecDetail(wnum);
		
		int level = warDetail.getLevel();

		// 신고당한 글이 게시글이면 boardList에 List 넣어주고, 댓글이면 replyList 에 List 넣어줌
		if (level == 3 || level == 4) { // 게시글일경우
			boardDetail = boardService.BoardDetail(warDetail.getBnum());
		} else if (level == 5 || level == 6) {
			replyDetail = boardService.replyDetailOne(warDetail.getRnum());
		} else {
			System.out.println("이럴리가 없어");
		}
		mav.addObject("warDetail", warDetail);
		mav.addObject("boardDetail", boardDetail);
		mav.addObject("replyDetail", replyDetail);

		return mav;
	}

	// 신고내역 접수
	@RequestMapping(value = "/warRec", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int warRec(@RequestParam("wnum") int wnum, @RequestParam("warid") String warid, HttpServletResponse response) throws Exception {
		int success = 0;
		success= service.DecUpdate(wnum);
		if(success > 0) {
			service.warCntUp(warid);
		}
		return success;
	}

	// 신고내역 기각
	@RequestMapping(value = "/warDis", method = { RequestMethod.GET, RequestMethod.POST })
	public String warDis(@RequestParam("wnum") int wnum) throws Exception {
		int success = 0;
		success = service.DecDelete(wnum);
		if(success > 0) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
		}
		return "redirect:/admin/warList";
	}
	
	@RequestMapping(value="/waralarm", method = RequestMethod.POST)
	@ResponseBody
	public int waralarm() {
		int warCnt = 0;
		warCnt = service.waralarm();
		
		return warCnt;
	}
	
}
