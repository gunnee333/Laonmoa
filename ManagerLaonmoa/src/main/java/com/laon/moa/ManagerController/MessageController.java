package com.laon.moa.ManagerController;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;

import com.laon.moa.ManagerService.MessageService;
import com.laon.moa.VO.MessageVO;
import com.laon.moa.VO.PageMaker;
import com.mysql.cj.Session;

@Controller
@RequestMapping(value = "/admin")
public class MessageController {
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Inject
	MessageService service;
	
	//전체리스트불러오기
	@RequestMapping(value = {"/noteList", "/mynoteList"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView noteList(HttpServletRequest request, HttpSession session) {
		logger.info("noteList controller");
		
		ModelAndView mav = new ModelAndView("message/noteList");
		List<MessageVO> list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pagemaker = new PageMaker();
		
		// 페이지 번호 받아오기
		String pagenumStr = request.getParameter("pagenum");
		if(pagenumStr == null) {
			pagenumStr = "1";
		}
		int pagenum = Integer.parseInt(pagenumStr);
		
		// 검색타입/값 받아오기
		String type = request.getParameter("type");
		if(type == null) {
			type = "null";
		}
		String value = request.getParameter("value");
		
		String ifreadStr = request.getParameter("ifread");
		if(ifreadStr == null) {
			ifreadStr = "-1";
		}
		int ifread = Integer.parseInt(ifreadStr);
		
		// URL로 전체쪽지인지 내쪽지함인지 구분
		UrlPathHelper urlPathHelper = new UrlPathHelper();
		String originalURL = urlPathHelper.getOriginatingRequestUri(request);
		System.out.print("OriginalURL ==>" + originalURL  );

		String id = "!";
		if(originalURL.equals("/admin/mynoteList")) {
			id = (String) session.getAttribute("id");
			if(id == null) {
				id = "!";
			}
		}
		
		map.put("pagenum", pagenum);	// 페이지번호
		map.put("type", type);	// 검색타입
		map.put("value", value);	// 검색값
		map.put("ifread", ifread);	// 처리여부
		map.put("id", id);	// 아이디 담기
		
		int totalcount = service.messageListCnt(map);
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
			
			list = service.messageList(map);
		} else {
			// 조건에 맞는 게시글이 없는 경우 pagemaker 초기화
			pagemaker.init();
		}
		
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		return mav;
	}
	
	//메시지 상세보기
	@RequestMapping(value="/noteView", method= { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView noteView(@RequestParam("mnum") int mnum, HttpSession session) {
		ModelAndView mav = new ModelAndView("message/noteView");
		MessageVO vo = new MessageVO();
		String id = (String)session.getAttribute("id");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("mnum", mnum);
		vo = service.messageDetail(map);
		mav.addObject("list", vo);
		
		return mav;
	}
	
	//메시지삭제
	@RequestMapping(value="/delete", method= { RequestMethod.GET, RequestMethod.POST })
	public String delete(@RequestParam("mnum") int mnum) {
		System.out.println("controller");
		service.messageDelete(mnum);
		return "redirect:/admin/noteList";
	}
	
	//열람/미열람 선택조건으로 보기
	@RequestMapping(value="/noteread", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView ifread(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView("message/noteList");
		int ifread = Integer.parseInt(request.getParameter("ifread"));
		List<MessageVO> list = null;
		list = service.listRead(ifread);
		mav.addObject("list", list);
		return mav;
	}
	
	//메시지 검색
	@RequestMapping(value="/notesearch", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView notesearch(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView("message/noteList");
		Map<String, String> map = new HashMap<>();
		//파라미터값받아서 map에 넣어줌 (name값으로 받아옴)
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		map.put("type", type);
		
		if (type.equals("mtitle")) {
			map.put("value", "%" + value + "%");
		} else {
			map.put("value", value);
		}
		List<MessageVO> list = service.messageSearch(map);
		mav.addObject("list", list);
		
		return mav;
	}
	
	//쪽지보내기 페이지로 이동
	@RequestMapping(value="noteSend", method = { RequestMethod.GET, RequestMethod.POST })
	public String noteSend() {
		return "message/noteSend";
	}
	
	//메시지보내기
	@RequestMapping(value="/insert", method = { RequestMethod.GET, RequestMethod.POST })
	public String insert(HttpServletRequest request, HttpSession session) throws Exception {
		request.setCharacterEncoding("UTF-8");
		MessageVO vo = new MessageVO();
		//파라미터값 vo에 넣어주기
		vo.setSendid((String) session.getAttribute("id"));
		vo.setRecid(request.getParameter("recid"));
		vo.setMtitle(request.getParameter("mtitle"));
		vo.setMcontent(request.getParameter("mcontent"));
		//메시지 DB에 저장 후 PK(자동증가)값 가져오기
		int mnum = service.messageInsert(vo);
		System.out.println("mnum::::::: " + mnum);
		
		return "redirect:/admin/noteView?mnum=" + mnum;
	}
	
	// 안읽은 쪽지 갯수
	@RequestMapping(value="/notealarm", method = RequestMethod.POST)
	@ResponseBody
	public int notealarm(HttpSession session) {
		int alarmCnt = 0;
		String id = (String) session.getAttribute("id");
		alarmCnt = service.alarmCnt(id);
		
		return alarmCnt;
	}

}
