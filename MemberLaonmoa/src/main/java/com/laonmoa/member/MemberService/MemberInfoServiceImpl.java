package com.laonmoa.member.MemberService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.laonmoa.member.MailHandler;
import com.laonmoa.member.TempKey;
import com.laonmoa.member.MemberDAO.MemberInfoDAO;
import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.MemberVO;
import com.laonmoa.member.VO.MessageVO;

@Service
public class MemberInfoServiceImpl implements MemberInfoService {
	private static final Logger logger = LoggerFactory.getLogger(MemberInfoServiceImpl.class);

	@Inject
	private MemberInfoDAO dao;

	@Inject
	private JavaMailSender mailSender;
//인증키 전송<메일 확인시 실제 보이는 인증 화면>
	@Override
	public void regist(String email, String AuthenticationKey) throws Exception {

//		System.out.println("서비스레지스");
//		System.out.println("service email" + email);
		// System.out.println(vo.toString());
		// String encPassword = Password(vo.getMemberPassword());
		// vo.setMemberPassword(encPassword);
		// System.out.println("암호화된 비밀번호 : "+user.getUserPassword());

		// dao.insertUser(vo);
		// System.out.println(vo);
		String key = new TempKey().getKey(50, false); // 인증키 생성

		// dao.createAuthKey(vo.getMemberEmail(),key); //인증키 db 저장

		// 메일 전송
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("라온모아 서비스");
		StringBuffer sb = new StringBuffer();
		//전송 메일의 본문 html
		sb.append("<html xmlns='http://www.w3.org/1999/xhtml' xmlns:v='urn:schemas-microsoft-com:vml' xmlns:o='urn:schemas-microsoft-com:office:office'>");

		sb.append("<head>");

		sb.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />");
		sb.append("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
		sb.append("<meta name='x-apple-disable-message-reformatting'>");
		sb.append("<meta http-equiv='X-UA-Compatible' content='IE=edge'>");

		sb.append("<title>고객센터</title>");
		sb.append("</head>");
		sb.append("<body class='clean-body' style='margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #f0f0f0'>");
		sb.append("<table class='nl-container' style='border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #f0f0f0;width:100%' cellpadding='0' cellspacing='0'>");
		sb.append("<tbody>");
		sb.append(" <tr style='vertical-align: top'>");
		sb.append("<td style='word-break: break-word;border-collapse: collapse !important;vertical-align: top'>");
		sb.append("<div class='email-row-container' style='padding: 50px 10px 0px;background-color: rgba(255,255,255,0)'>");
		sb.append("<div style='Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;' class='email-row'>");
		sb.append("<div style='border-collapse: collapse;display: table;width: 100%;background-color: #ffffff;'>");
		sb.append("<div style='left 25px no-repeat; border-top:1px solid #d7d7d7; border-bottom:1px solid #d7d7d7; padding:10px 10px 10px -6px;'>");

		sb.append("<p style='line-height:1.6em; color:#754c24;'>");
		sb.append("<div class='email-col email-col-100' style='max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;'>");
		sb.append("<div style='width: 100% !important;'>");
		sb.append("<div style='padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;'>");
		sb.append("<table id='u_content_image_1' class='u_content_image' style='font-family:'Montserrat',sans-serif;' role='presentation' cellpadding='0' cellspacing='0' width='100%' border='0'>");
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append(" <td style='overflow-wrap:break-word;word-break:break-word;padding:24px;font-family:'Montserrat',sans-serif;' align='left'>");
		sb.append("<table width='100%' cellpadding='0' cellspacing='0' border='0'>");
		sb.append("<tr>");
		sb.append("<td style='padding-right: 0px; padding-left: 0px;' align='center'>");
		sb.append("<img align='center' border='0' src='http://hoohee0331.cdn3.cafe24.com/img/LOGOALL.jpg' style='outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: block !important;border: none;height: auto;float: none;width: 100%;max-width: 200px;' width='200'>");
		
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</table>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("<div class=\"email-row-container\" style=\"padding: 0px 10px 1px;background-color: rgba(255,255,255,0)\">");
		sb.append("<div style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ff6f00;\" class=\"email-row\">");
		sb.append("<div style=\"border-collapse: collapse;display: table;width: 100%;background-color: #ff6f00;\">");
		sb.append("<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
		sb.append("<div style=\"width: 100% !important;\">");
		sb.append("<div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">");
		sb.append("<table id=\"u_content_text_1\" class=\"u_content_text\" style=\"font-family:'Montserrat',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
		sb.append("<tbody>");
		sb.append(" <tr>");
		sb.append("<td style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 20px 43px;font-family:'Montserrat',sans-serif;\" align=\"left\">");
		sb.append(" <div style=\"color: #000; line-height: 130%; text-align: center; word-wrap: break-word;\">");
		sb.append("<p style=\"line-height: 130%; font-size: 14px;\"><span style=\"font-size: 36px; line-height: 46.8px;\"><span style=\"color: #ffffff; font-family: helvetica, sans-serif; font-size: 36px; line-height: 46.8px;\">");
		sb.append("<span style=\"line-height: 46.8px; font-size: 36px;\"><strong>라온모아 '즐거움을 모으다.'</strong>");
		sb.append("</span>");
		sb.append("</span>");
		sb.append("</span>");
		sb.append("</p>");
		sb.append("<p style=\"line-height: 130%; font-size: 14px;\">&nbsp;</p>");
		sb.append("<p style=\"line-height: 130%; font-size: 14px;\">");
		sb.append("<span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 14px; line-height: 18.2px;\">축제 / 뮤지컬 / 공연 / 전시회의 문화정보를 모아 정보 제공을 취지로 시작되었습니다.</span>");
		sb.append("<br style=\"box-sizing: border-box; color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 16px; background-color: #ffffff;\" />");
		sb.append("<span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 14px; line-height: 18.2px;\">라온은 '즐거움' , 모아는 '모으다' 의 순 우리말을 합쳐 '즐거움을 한데 모으다'라는 </span>");
		sb.append("</p>");
		sb.append("<p style=\"line-height: 130%; font-size: 14px;\">");
		sb.append("<span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 14px; line-height: 18.2px;\">의미를 가지고 공공의 목적을 가지고 있습니다.</span>");
		sb.append("<br style=\"box-sizing: border-box; color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 16px; background-color: #ffffff;\" />");
		sb.append("<span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 14px; line-height: 18.2px;\">라온모아는자신이 가고싶은 문화 생활을 한눈에 보고 찜하여 </span>");
		sb.append("</p>");
		sb.append("<p style=\"line-height: 130%; font-size: 14px;\">");
		sb.append("<span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 14px; line-height: 18.2px;\">담아 놓을 수 있는 기능을 지금 즐기세요!</span>");
		sb.append("</p>");
		
		sb.append("<p style=\"line-height: 130%; font-size: 14px;\">&nbsp;</p>");
		sb.append("</div>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("<div class=\"email-row-container\" style=\"padding: 0px;background-color: rgba(255,255,255,0)\">");
		sb.append("<div style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\" class=\"email-row\">");
		sb.append("<div style=\"border-collapse: collapse;display: table;width: 100%;background-color: #ffffff;\">");
		sb.append("<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
		sb.append("<div style=\"width: 100% !important;\">");
		sb.append("<div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">");
		sb.append("<table id=\"u_content_text_9\" class=\"u_content_text\" style=\"font-family:'Montserrat',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
		
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append("<td style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 30px 15px;font-family:'Montserrat',sans-serif;\" align=\"left\">");
		sb.append("<div style=\"color: #000; line-height: 150%; text-align: left; word-wrap: break-word;\">");
		sb.append(" <p style=\"line-height: 150%; font-size: 14px; text-align: center;\">");
		sb.append("<span style=\"font-size: 24px; line-height: 36px;\">");
		
		sb.append("<strong>");
		sb.append("<span style=\"line-height: 36px; font-size: 24px;\">");
		sb.append("<span style=\"line-height: 36px; font-size: 24px;\">라온모아 인증 센터</span>");
		sb.append("</span>");
		sb.append("</strong>");
		sb.append("</span>");
		sb.append("</p>");
		sb.append("</div>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("<div class=\"email-row-container\" style=\"padding: 0px 10px;background-color: rgba(255,255,255,0)\">");
		sb.append("<div style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\" class=\"email-row\">");
		sb.append("<div style=\"border-collapse: collapse;display: table;width: 100%;background-color: #ffffff;\">");
		sb.append("<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
		sb.append("<div style=\"width: 100% !important;\">");
		sb.append("<div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">");
		sb.append("<table id=\"u_content_text_10\" class=\"u_content_text\" style=\"font-family:'Montserrat',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append("<td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Montserrat',sans-serif;\" align=\"left\">");
		sb.append("<div style=\"color: #000; line-height: 140%; text-align: left; word-wrap: break-word;\">");
		sb.append("<p style=\"font-size: 14px; line-height: 140%; text-align: center;\">");
		sb.append("<span style=\"font-size: 20px; line-height: 28px;\">요청하신 인증키는&nbsp;&nbsp;&nbsp;&nbsp;"+AuthenticationKey.toString()+"&nbsp;&nbsp;&nbsp;&nbsp;입니다.</span>");
		sb.append("</p>");
		sb.append("</div>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("<div class=\"email-row-container\" style=\"padding: 0px;background-color: rgba(255,255,255,0)\">");
		sb.append("<div style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\" class=\"email-row\">");
		sb.append("<div style=\"border-collapse: collapse;display: table;width: 100%;background-color: #ffffff;\">");
		sb.append("<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
		sb.append("<div style=\"width: 100% !important;\">");
		sb.append("<div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">");
		sb.append("<table id=\"u_content_text_7\" class=\"u_content_text\" style=\"font-family:'Montserrat',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append("<td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 30px 20px;font-family:'Montserrat',sans-serif;\" align=\"left\">");
		sb.append("<div style=\"color: #292929; line-height: 160%; text-align: center; word-wrap: break-word;\">");
		sb.append("<p style=\"font-size: 14px; line-height: 160%;\"><span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; text-align: center; line-height: 22.4px; font-size: 14px;\">");
		sb.append("<div style=\"color: #000000; font-size: 14px; line-height: 22.4px;\">위의 키를 띄어쓰기 없이 정확히 입력해주시기 바랍니다.</div>");
		sb.append("<div style=\"color: #000000; font-size: 14px; line-height: 22.4px;\">본 메일은 발신 전용이므로 메일로 문의 시 확인이 불가능합니다.</div>");
		sb.append("</span>");
		sb.append("<span style=\"color: #ffffff; font-family: NanumSquare, sans-serif; font-size: 16px; text-align: center; line-height: 25.6px;\">&nbsp;</span>");
		sb.append("</p>");
		sb.append("</div>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
	
		sb.append("<div class=\"email-row-container\" style=\"padding: 0px;background-color: rgba(255,255,255,0)\">");
		sb.append("<div style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\" class=\"email-row\">");
		sb.append("<div style=\"border-collapse: collapse;display: table;width: 100%;background-color: #ffffff;\">");
		sb.append("<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
		sb.append("<div style=\"width: 100% !important;\">");
		sb.append("<div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">");
		sb.append("<table id=\"u_content_button_1\" class=\"u_content_button\" style=\"font-family:'Montserrat',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append(" <td style=\"overflow-wrap:break-word;word-break:break-word;padding:20px 20px 50px;font-family:'Montserrat',sans-serif;\" align=\"left\">");
		sb.append("<div align=\"center\">");
		sb.append("<a href='http://localhost:8080/' target=\"_blank\" style=\"display: inline-block;font-family:'Montserrat',sans-serif;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #FFF; background-color: #ff6f00; border-radius: 32px; -webkit-border-radius: 32px; -moz-border-radius: 32px; width: auto; padding: 10px 30px; mso-border-alt: none;\">");
		sb.append(" <span style=\"line-height:150%;\">");
		sb.append("<span style=\"font-size: 18px; line-height: 27px;\">");
		sb.append("<strong>");
		sb.append("<em>");
		sb.append("<span style=\"line-height: 27px; font-size: 18px;\">&gt; 라온모아 홈페이지 바로가기</span>");
		sb.append("</em>");
		sb.append("</strong>");
		sb.append("</span>");
		sb.append("</span>");
		sb.append("</a>");
		sb.append("</div>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("<div class=\"email-row-container\" style=\"padding: 30px;background-color: rgba(240,240,240,0)\">");
		sb.append("<div style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\" class=\"email-row\">");
		sb.append("<div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">");
		sb.append("<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
		sb.append("<div style=\"width: 100% !important;\">");
		sb.append("<div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">");
		sb.append("<table id=\"u_content_text_8\" class=\"u_content_text\" style=\"font-family:'Montserrat',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append("<td style=\"overflow-wrap:break-word;word-break:break-word;padding:20px;font-family:'Montserrat',sans-serif;\" align=\"left\">");
	
		sb.append("<div style=\"color: #000; line-height: 120%; text-align: left; word-wrap: break-word;\">");
		sb.append("<div style=\"font-family: arial, helvetica, sans-serif;\">");
		sb.append("<span style=\"font-size: 14px; line-height: 16.8px; color: #808080;\">");
		sb.append("<a style=\"box-sizing: border-box; color: #808080; background-color: #f3f3f3; transition: all 0.5s ease 0s; font-family: NanumSquare, sans-serif; text-align: center;\" href=\"http://localhost:8080/laonmoa\">");
		sb.append(" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&copy; 라온모아프로젝트&nbsp;\r\n" + 
				"          <span class=\"color-a\" style=\"box-sizing: border-box; line-height: 16.8px; font-size: 14px;\">유민웅 신지혜 이건희 김현성 추수아</span>");
		sb.append("&nbsp;\"즐거움을 모으다.\"</a>");
		sb.append("</a>");
		sb.append(" </span>");
		sb.append("<ul class=\"list-unstyled\" style=\"box-sizing: border-box; margin-bottom: 1rem; padding-left: 0px; list-style: none; color: #555555; font-family: NanumSquare, sans-serif; font-size: 16px; text-align: center; background-color: #f3f3f3;\">");
		sb.append("<li class=\"color-a\" style=\"box-sizing: border-box; color: #000000; font-size: 16px; line-height: 19.2px;\">");
		sb.append("<span style=\"font-size: 14px; line-height: 16.8px; color: #808080;\">");
		sb.append("<span class=\"color-text-a\" style=\"box-sizing: border-box; line-height: 16.8px; font-size: 14px;\">Email .</span>");
		sb.append("&nbsp;laonmoa@gmail.com</span>");
		sb.append("</li>");
		sb.append("</ul>");
		sb.append("<p class=\"copyright color-text-a\" style=\"box-sizing: border-box; margin-bottom: 1rem; color: #555555; font-family: NanumSquare, sans-serif; font-size: 16px; text-align: center; background-color: #f3f3f3; line-height: 120%;\">");
		sb.append("<span style=\"font-size: 14px; line-height: 16.8px; color: #808080;\">");
		sb.append("&copy; Copyright&nbsp;<span class=\"color-a\" style=\"box-sizing: border-box; line-height: 16.8px; font-size: 14px;\">Laonmoa</span>");
		sb.append("&nbsp;All Rights Reserved.</span>");
		sb.append("</p>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</boby>");
		sb.append("</html>");
		//전송 메일 본문 구간 끝--------------------
		
		//전송을 위한 구간--------------------------
		//본문
		sendMail.setText(sb.toString());
		//발송인
		sendMail.setFrom("laonmoa@gmail.com", "라온모아 서비스");
		//수신인
		sendMail.setTo(email);
		sendMail.send();
		//-----------------------------
		logger.info(email + "로 email전송완료!");
	}

	// 이메일 인증 키 검증
	@Override
	public MemberVO userAuth(MemberVO user) throws Exception {
		MemberVO vo = new MemberVO();
		System.out.println(user + "user");
		vo = dao.chkAuth(user);

		if (vo != null) {
			try {
				System.out.println(vo + "vo");
				dao.userAuth(user);
				dao.successAuth(vo);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return vo;
	}

	// 아이디 찾기
	@Override
	public String FindingId(String name, String tel) {
		Map<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("tel", tel);
		return dao.FindingId(map);
	}

	// 임시 비번 전송용
	@Override
	public int newPassword(Map<String, String> map) {
		logger.info("임시 비번 정송 service");
		logger.info(map.toString());
		return dao.newPassword(map);
	}

	// 비번 찾기(정보 확인용)
	@Override
	public String findingPassword(String id, String email) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("email", email);
		return dao.findingPassword(map);
	}

	// 이름 중복체크
	@Override
	public int NameCheck(String name) {
		return dao.NameCheck(name);
	}

	// 번호 중복체크
	@Override
	public int TelCheck(String tel) {
		return dao.TelCheck(tel);
	}

	// 아이디체크
	@Override
	public int IdCheck(String id) {
		return dao.IdCheck(id);
	}

	// 이메일체크
	@Override
	public int EmailCheck(String email) {
		return dao.EmailCheck(email);
	}

	// 회원가입
	@Override
	public int join(MemberVO user) {
		System.out.println(user + "service!!!!!!!!!!!!!");
		return dao.join(user);
	}

	// 로그인
	@Override
	public MemberVO login(String id, String password, String level) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("password", password);
		map.put("level", level);
		dao.lastLoginTime(id);
		return dao.login(map);
	}

	// 내 정보보기
	@Override
	public MemberVO mypage(String id) {
		return dao.mypage(id);
	}

	// 내 정보 수정
	@Override
	public int update(MemberVO vo) {
		return dao.update(vo);
	}

	// 회원탈퇴
	@Override
	public int memberout(Map<String, String> map) {
		return dao.memberout(map);
	}

	// 페이징을 위한 내게시글 갯수
	@Override
	public int myBoardCount(Map<String, Object> map) {
		return dao.myBoardCount(map);
	}

	// 내가 쓴 게시글 리스트
	@Override
	public List<BoardVO> myBoard(Map<String, Object> map) {
		return dao.myBoard(map);
	}

	// 비밀번호 수정
	@Override
	public int changePw(Map<String, String> map) {
		return dao.changePw(map);
	}

	// 페이징을 위한 쪽지갯수
	@Override
	public int notecount(Map<String, Object> map) {
		return dao.notecount(map);
	}

	// 쪽지리스트
	@Override
	public List<MessageVO> noteList(Map<String, Object> map) {
		return dao.noteList(map);
	}

	// 쪽지보내기
	@Override
	public int noteSend(MessageVO vo) {
		return dao.noteSend(vo);
	}

	// 쪽지상세보기
	@Override
	public MessageVO notedetail(int mnum) {
		return dao.notedetail(mnum);
	}

	// 쪽지 열람
	@Override
	public void noteread(MessageVO vo) {
		dao.noteread(vo);
	}

	// 쪽지 삭제
	@Override
	public int notedelete(int mnum) {
		return dao.notedelete(mnum);
	}

	// 페이징을 위한 회원수
	@Override
	public int memberSearchCnt(Map<String, Object> map) {
		return dao.memberSearchCnt(map);
	}

	// 회원찾는 팝업
	@Override
	public List<MemberVO> searchMember(Map<String, Object> map) {
		return dao.searchMember(map);
	}

	// 안읽은 쪽지갯수
	@Override
	public int noteCnt(String id) {
		return dao.noteCnt(id);
	}

}
