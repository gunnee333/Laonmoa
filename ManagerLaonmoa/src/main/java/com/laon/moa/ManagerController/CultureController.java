package com.laon.moa.ManagerController;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import com.laon.moa.ManagerDAO.CultureDAO;
import com.laon.moa.ManagerService.CultureService;
import com.laon.moa.VO.BoardVO;
import com.laon.moa.VO.InfoVO;
import com.laon.moa.VO.MemberVO;
import com.laon.moa.VO.PageMaker;
import com.laon.moa.VO.ReplyVO;
import com.laon.moa.VO.WarVO;

@Controller
@RequestMapping(value="/admin")
public class CultureController {
	private static final Logger logger = LoggerFactory.getLogger(CultureController.class);
	private String saveName=null;

	@Inject
	CultureService service;
	@Inject
	CultureDAO dao;
	//문화정보 전체 보여주기
	@RequestMapping(value="/cultureList", method=RequestMethod.GET)
	public ModelAndView cultureList(HttpServletRequest request) {
		PageMaker pagemaker = new PageMaker();
		ModelAndView mav = new ModelAndView();
		List<InfoVO> list =new ArrayList<>();
		System.out.println(request.getParameter("value"));
		int count = service.countInfo(0);
		page(request,pagemaker,count);
		list = service.CultureList(pagemaker.getPagenum()*10,pagemaker.getContentnum());

		mav.addObject("list", list);
		mav.addObject("page", pagemaker);


		mav.setViewName("culture/cultureList");
		return mav;
	}
	//문화 추가 
	@RequestMapping(value="/cultureInsert",method=RequestMethod.GET)
	public ModelAndView cultureInsertpage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("culture/cultureInsert");
		return mav;
	}

	//문화 추가 
	@RequestMapping(value="/cultureInsert",method=RequestMethod.POST)
	public ModelAndView cultureInsert(HttpServletRequest request,@RequestParam("file1") MultipartFile file) throws UnsupportedEncodingException {
		PageMaker pagemaker = new PageMaker();
		System.out.println("Controller 들어가나연!!!!!");	
		request.setCharacterEncoding("UTF-8");
		System.out.println("---------------"+file);
		ModelAndView mav = new ModelAndView();
		System.out.println(request.getParameter("filenull"));
		try {
			if (request.getParameter("filenull").equals("in")) {
				file = null;
			}
			System.out.println(file);
			service.CultureInsert(request,file);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		List<InfoVO> list;
		int count =service.countInfo(0);
		page(request,pagemaker,count);
		list = service.CultureList(pagemaker.getPagenum()*10,pagemaker.getContentnum());
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("culture/cultureList");
		return mav;
	}


	@RequestMapping(value = "/cultureupdate", method = RequestMethod.POST)
	public ModelAndView cultureupdate(HttpServletRequest request,@RequestParam("fno") int Fno) throws Exception {
		System.out.println("수정 컨트롤러 진입");
		
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		System.out.println("---------------"+request.getParameter("fname"));
		System.out.println("---------------"+request.getParameter("fno"));
		System.out.println("---------------"+request.getParameter("ftype"));
		System.out.println("--------- ------"+request.getParameter("sdate"));
		System.out.println("---------------"+request.getParameter("edate"));
		System.out.println("---------------"+request.getParameter("location_1"));
		System.out.println("---------------"+request.getParameter("location_2"));
		System.out.println("---------------"+request.getParameter("fcontent"));	
		System.out.println("---------------"+request.getParameter("user_photo"));	
		System.out.println(request.getParameter("filenull"));
		try {
			if (request.getParameter("filenull").equals("null")) {
				saveName = null;
				System.out.println("11"+saveName);
			}
			System.out.println(saveName);
			service.CultureUpdate(request,saveName);

		} catch (Exception e) {
			// TODO: handle exception
		}

		InfoVO infovo =null;
		infovo = service.CultureDetail(Fno);
		mav.addObject("infovo", infovo); 
		mav.setViewName("culture/cultureDetail");
		return mav;
	}

	//절대 경로
	private static final String UPLOAD_PATH = "D:/YMW/Laonmoa/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ManagerLaonmoa/resources/image";
	private static final String UPLOAD_PATH1 = "D:/YMW/Laonmoa/Laonmoa/MemberLaonmoa/src/main/webapp/resources/image";
	
	//이미지 수정
	@RequestMapping(value = "/ThumbNail", method=RequestMethod.POST)
	@ResponseBody
	public String ThumbNail(@RequestParam("file") MultipartFile[] files) throws Exception {
		String fileName = "";
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
			CopyFile(file.getAbsolutePath(),saveName,extension);
			url = "/resources/image/"+saveName;
		}
		return url;
	}// end of ThumbNail
	
	//이미지 복사
	public void CopyFile(String FilePath,String saveName, String extension) throws IOException {
	//위에서 경로+새로운이름으로 생성한 file의 절대위치로 저장한 이미지 찾아옴
		BufferedImage srcImg = ImageIO.read(new File(FilePath));
		File file = new File(UPLOAD_PATH1,saveName);
		ImageIO.write(srcImg,extension, file);
	}
	
		
	//축제리스트만 보여주기
	@RequestMapping(value="/festival",method=RequestMethod.GET)
	public ModelAndView FestivalVeiw(HttpServletRequest request) {
		System.out.println("축제별 리스트");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<InfoVO> list;
		int count = service.countInfo(7);
		System.out.println(count);
		page(request,pagemaker,count);
		list = service.festival(pagemaker.getPagenum()*10,pagemaker.getContentnum());
		mav.addObject("list",list);
		mav.addObject("page", pagemaker);
		mav.setViewName("culture/cultureList");
		return mav;
	}
	//연극리스트만 보여주기
	@RequestMapping(value="/drama",method=RequestMethod.GET)
	public ModelAndView dramaVeiw(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<InfoVO> list;
		
		int count = service.countInfo(8);
		page(request,pagemaker,count);
		list = service.drama(pagemaker.getPagenum()*10,pagemaker.getContentnum());
		mav.addObject("list",list);
		mav.addObject("page", pagemaker);
		mav.setViewName("culture/cultureList");
		return mav;
	}

	//뮤지컬리스트만 보여주기
	@RequestMapping(value="/musical",method=RequestMethod.GET)
	public ModelAndView musicalVeiw(HttpServletRequest request) {
		System.out.println("뮤지컬 리스트");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		List<InfoVO> list;
		list = service.musical(pagemaker.getPagenum()*10,pagemaker.getContentnum());
		int count = service.countInfo(9);
		page(request,pagemaker,count);
		mav.addObject("list",list);
		mav.addObject("page", pagemaker);
		mav.setViewName("culture/cultureList");
		return mav;
	}

	//전시회리스트만 보여주기
	@RequestMapping(value="/show",method=RequestMethod.GET)
	public ModelAndView show(HttpServletRequest request) {
		System.out.println("전시회 리스트");
		PageMaker pagemaker = new PageMaker();
		ModelAndView mav = new ModelAndView();
		List<InfoVO> list;
		list = service.show(pagemaker.getPagenum()*10,pagemaker.getContentnum());
		int count = service.countInfo(10);
		page(request,pagemaker,count);
		mav.addObject("list",list);
		mav.addObject("page", pagemaker);
		mav.setViewName("culture/cultureList"); 
		return mav;
	}

	//문화정보 상세보기
	@RequestMapping(value = "/cultureDetail", method = RequestMethod.GET)
	public ModelAndView warView(@RequestParam("fno") int Fno ) throws Exception {
		ModelAndView mav = new ModelAndView();
		InfoVO infovo =null;
		infovo = service.CultureDetail(Fno);
		mav.addObject("infovo", infovo); 
		mav.setViewName("culture/cultureDetail");
		return mav;
	}

	//문화 삭제
	@RequestMapping(value = "/culturedelete", method = RequestMethod.GET)
	public ModelAndView culturedelete(HttpServletRequest request,@RequestParam("fno") int Fno ) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		service.CultureDelete(Fno);
		List<InfoVO> list;
		int count = service.countInfo(0);
		page(request,pagemaker,count);
		list = service.CultureList(pagemaker.getPagenum()*10,pagemaker.getContentnum());
		mav.addObject("list", list);
		mav.addObject("page", pagemaker);
		mav.setViewName("culture/cultureList");
		return mav;
	}

	//페이징 bean에 저장
	public PageMaker page(HttpServletRequest request,PageMaker pagemaker,int count) {
		String pagenum = request.getParameter("pagenum");
		String contentnum = request.getParameter("contentnum");
		System.out.println("카운트카운트카운트"+count);
		System.out.println(pagenum);
		System.out.println(contentnum);
		int cpagenum = Integer.parseInt(pagenum);
		//int ccontentnum = Integer.parseInt(contentnum);
		pagemaker.setTotalcount(count);
		pagemaker.setPagenum(cpagenum-1);
		pagemaker.setCurrentblock(cpagenum);
		//pagemaker.setContentnum(ccontentnum);
		
		pagemaker.setLastblock(pagemaker.getTotalcount());
		pagemaker.prevnext(cpagenum);
		pagemaker.setStartpage(pagemaker.getCurrentblock());
		pagemaker.setEndpage(pagemaker.getLastblock(), pagemaker.getCurrentblock());
		return pagemaker;
			
	}
	//이미지 삭제
	@RequestMapping(value = "/imagedelete", method = RequestMethod.GET)
	public ModelAndView imagedelete(@RequestParam("fno") int Fno ) throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println(" 이미지 삭제 !!!"+Fno);
		service.imageDelete(Fno);
		InfoVO infovo =null;
		infovo = service.CultureDetail(Fno);
		mav.addObject("infovo", infovo); 
		mav.setViewName("culture/cultureDetail");
		return mav;
	}



	// 검색
	@RequestMapping(value = "/cultureSearch", method = { RequestMethod.GET, RequestMethod.POST })
	public String cultureSearch(HttpServletRequest request,@RequestParam("pagenum") int pagenum,@RequestParam("contentnum") int contentnum,
			Model model,HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		PageMaker pagemaker = new PageMaker();
		Map<Object, Object> map = new HashMap<Object, Object>();
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		int count ; 
		//파라미터값 (name값으로 받아옴)
		System.out.println(request.getParameter("type"));
		System.out.println(request.getParameter("value"));
		System.out.println("검색카운트"+service.locationcount(value));
		map.put("type", type);
		if (type.equals("location")) {
			count = service.locationcount(value);
			page(request,pagemaker,count);
			map.put("value", value + "%");
		} else if(type.equals("culturename")){
			count = service.culturenamecount(value);
			page(request,pagemaker,count);
			map.put("value", value);
		}
		map.put("pagenum", pagemaker.getPagenum() * 10);
		map.put("contentnum", pagemaker.getContentnum());
		List<InfoVO> list = service.CultureSearch(map);
		model.addAttribute("list", list);
		model.addAttribute("page",pagemaker);
		System.out.println(list.toString());
		return "culture/cultureList";
	}

}
