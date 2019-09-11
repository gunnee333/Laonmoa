package com.laonmoa.member.MemberService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.MemberVO;
import com.laonmoa.member.VO.MessageVO;

public interface MemberInfoService {

	// 메일인증
	public MemberVO userAuth(MemberVO user) throws Exception;

	void regist(String email, String AuthenticationKey) throws Exception;
	// ----------------------

	//임시비번 전송용
	public int newPassword(Map<String, String> map);	
	//비번 찾기(정보 확인용)
	public String findingPassword(String id, String email);
	
	// 아이디를 찾겠다는 의지
	public String FindingId(String name, String tel);

	// 이름 중복체크
	public int NameCheck(String name);

	// 번호 중복 체크
	public int TelCheck(String tel);

	// 아이디 중복체크
	public int IdCheck(String id);

	// 이메일 체크
	public int EmailCheck(String email);

	// 회원가입
	public int join(MemberVO user);

	// 로그인
	public MemberVO login(String id, String password, String level);

	// 내 정보보기
	public MemberVO mypage(String id);

	// 내 정보 수정
	public int update(MemberVO vo);

	// 회원탈퇴
	public int memberout(Map<String, String> map);

	// 페이징을 위한 내게시글 갯수
	public int myBoardCount(Map<String, Object> map);

	// 내가 쓴 게시글 리스트
	public List<BoardVO> myBoard(Map<String, Object> map);

	// 비밀번호 수정
	public int changePw(Map<String, String> map);

	// 페이징을 위한 쪽지갯수
	public int notecount(Map<String, Object> map);

	// 쪽지리스트
	public List<MessageVO> noteList(Map<String, Object> map);

	// 쪽지보내기
	public int noteSend(MessageVO vo);

	// 쪽지상세보기
	public MessageVO notedetail(int mnum);

	// 쪽지 열람
	public void noteread(MessageVO vo);

	// 쪽지 삭제
	public int notedelete(int mnum);

	// 페이징을 위한 회원수
	public int memberSearchCnt(Map<String, Object> map);

	// 회원찾는 팝업
	public List<MemberVO> searchMember(Map<String, Object> map);

	// 안읽은 쪽지갯수
	public int noteCnt(String id);

}
