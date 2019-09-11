package com.laon.moa.ManagerService;

import java.io.FileOutputStream;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.laon.moa.ManagerDAO.CultureDAO;
import com.laon.moa.VO.InfoVO;


@Service
public class CultureServiceImpl implements CultureService{

	@Inject
	private CultureDAO dao;
	@Override
	public InfoVO CultureDetail(int Fno) {
		// TODO Auto-generated method stub
		return dao.CultureDetail(Fno);
	}
	// 리눅스 기준으로 파일 경로를 작성 ( 루트 경로인 /으로 시작한다. )
	// 윈도우라면 workspace의 드라이브를 파악하여 JVM이 알아서 처리해준다.
	// 따라서 workspace가 C드라이브에 있다면 C드라이브에 upload 폴더를 생성해 놓아야 한다.
	//private static final String SAVE_PATH = "D:/KHS/KHS/laonmoa/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ManagerLaonmoa/resources/image";
	//private static final String MemberSAVE_PATH = "D:/KHS/KHS/laonmoa/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/MemberLaonmoa/resources/image";
	//private static final String MemberSAVE_PATH = "C:/Users/vip/git/Laonmoa/MemberLaonmoa/src/main/webapp/resources/image";
	private static final String SAVE_PATH = "http://hoohee0331.cdn3.cafe24.com/resource";
	
	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName,HttpServletRequest request) {
		String fileName = "";
		Calendar calendar = Calendar.getInstance();
		fileName += request.getParameter("sdate");
		fileName += request.getParameter("edate");
		fileName += request.getParameter("level");
		fileName += request.getParameter("location_2");	
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += extName;
		return fileName;
	}
	// 파일을 실제로 write 하는 메서드
	private boolean writeFile(MultipartFile multipartFile, String saveFileName)
			throws IOException{
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		//FileOutputStream Memberfos = new FileOutputStream(MemberSAVE_PATH + "/" + saveFileName);
		//Memberfos.write(data);
		fos.write(data);
		//Memberfos.close();
		fos.close();
		return result;
	}

	//문화정보 수정
	@Override
	public int CultureUpdate(HttpServletRequest request,String saveName) throws ParseException {
		// TODO Auto-generated method stub
		System.out.println("정보수정 서비스 진입");
		String saveFileName = null;
		Map<Object,Object> map = new HashMap<Object,Object>();
		// String -> Date 형변환
		System.out.println("서비스 에러 !!!!1");
		String sdateStr = request.getParameter("sdate");
		String edateStr = request.getParameter("edate");
		System.out.println("정보수정 서비스 진입3");
		/*
		 * SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 * 
		 * java.util.Date sdate_Date = transFormat.parse(sdateStr); java.util.Date
		 * edate_Date = transFormat.parse(edateStr); Date sdate = new
		 * java.sql.Date(sdate_Date.getTime()); Date edate = new
		 * java.sql.Date(edate_Date.getTime());
		 */
		 
		System.out.println(" 에러 !!!!2");
		map.put("fno", Integer.parseInt(request.getParameter("fno")));
		map.put("level", Integer.parseInt(request.getParameter("level")));
		map.put("fname", request.getParameter("fname"));
		map.put("sdate", sdateStr);
		map.put("edate", edateStr);
		map.put("location_1", request.getParameter("location_1"));
		map.put("location_2", request.getParameter("location_2"));
		map.put("fcontent", request.getParameter("fcontent"));
		map.put("gps", request.getParameter("order_start_lat")+","+request.getParameter("order_start_lon"));
		map.put("kind", request.getParameter("kind")); 
		map.put("tel",request.getParameter("tel"));
		map.put("homepage",request.getParameter("homepage")); 
		map.put("host",request.getParameter("host"));
		if (saveName !=null) {
			map.put("image", saveName);		
		}
		System.out.println("service"+map);
		return dao.CultureUpdate(map);
	}


	//문화정보 추가
	@Override
	public int CultureInsert(HttpServletRequest request,MultipartFile multipartFile) throws ParseException {
		InfoVO infovo = new InfoVO();
		
		Map<Object,Object>map = new HashMap<Object, Object>();
		System.out.println("여기13");
		System.out.println(multipartFile);
		if (multipartFile != null) {
			String originFilename = multipartFile.getOriginalFilename();
			String extName
			= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			String saveFileName = genSaveFileName(extName,request);
			System.out.println("문화추가 !!!"+saveFileName);
			map.put("image", saveFileName);
			try {
				writeFile(multipartFile, saveFileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// String -> Date 형변환
		String sdateStr = request.getParameter("sdate");
		String edateStr = request.getParameter("edate");
		System.out.println("sdateStr : " + sdateStr);
		System.out.println("edateStr : " + edateStr);
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date sdate_Date = transFormat.parse(sdateStr);
		java.util.Date edate_Date = transFormat.parse(sdateStr);
		Date sdate = new java.sql.Date(sdate_Date.getTime());
		Date edate = new java.sql.Date(edate_Date.getTime());


		map.put("level", Integer.parseInt(request.getParameter("level")));
		map.put("fname", request.getParameter("fname"));
		map.put("sdate", sdate);
		map.put("edate", edate);
		map.put("location_1", request.getParameter("location_1"));
		map.put("location_2", request.getParameter("location_2"));
		map.put("fcontent", request.getParameter("content"));
		map.put("gps", request.getParameter("order_start_lat")+","+request.getParameter("order_start_lon"));
		map.put("kind", request.getParameter("kind"));
		map.put("tel", request.getParameter("tel"));
		map.put("homepage", request.getParameter("homepage"));
		map.put("host", request.getParameter("host"));
		
		System.out.println("service들어가나연"+map);
		return dao.CultureInsert(map);
	}



	@Override
	public List<InfoVO> CultureList(@RequestParam("pagenum") int pagenum,@RequestParam("contentnum") int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Integer> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum);
		return dao.CultureList(map);
	}

	@Override
	public List<InfoVO> festival(@RequestParam("pagenum") int pagenum,@RequestParam("contentnum") int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Integer> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum);
		System.out.println(map.toString());
		return dao.festival(map);
	}

	@Override
	public List<InfoVO> drama(@RequestParam("pagenum") int pagenum,@RequestParam("contentnum") int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Integer> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum);
		System.out.println(map.toString());
		return dao.drama(map);
	}

	@Override
	public List<InfoVO> musical(@RequestParam("pagenum") int pagenum,@RequestParam("contentnum") int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Integer> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum);
		System.out.println(map.toString());
		return dao.musical(map);
	}

	@Override
	public List<InfoVO> show(@RequestParam("pagenum") int pagenum,@RequestParam("contentnum") int contentnum) {
		// TODO Auto-generated method stub
		Map<String,Integer> map = new HashMap<>();
		map.put("pagenum", pagenum);
		map.put("contentnum",contentnum);
		System.out.println(map.toString());
		return dao.show(map);
	}

	@Override
	public int CultureDelete(int Fno) {
		// TODO Auto-generated method stub
		System.out.println("service Fno"+Fno);
		return dao.CultureDelete(Fno);
	}

	//검색
	@Override
	public List<InfoVO> CultureSearch(Map<Object, Object> map) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("서비스 진입"+map);
		return dao.CultureSearch(map);
	}

	//이미지 삭제
	@Override
	public int imageDelete(int Fno) {
		// TODO Auto-generated method stub
		return dao.imageDelete(Fno);
	}
	@Override
	public int countInfo(int level) {
		// TODO Auto-generated method stub
		Map<Object,Object> map = new HashMap<Object,Object>();
		map.put("level", level);
		return dao.countinfo(map);
	}
	@Override
	public int locationcount(String value) {
		// TODO Auto-generated method stub
		return dao.locationcount(value); 
	}
	@Override
	public int culturenamecount(String value) {
		// TODO Auto-generated method stub
		return dao.culturenamecount(value);
	}
	
	

}
