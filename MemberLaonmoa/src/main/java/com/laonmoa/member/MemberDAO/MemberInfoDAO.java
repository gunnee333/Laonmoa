package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.MemberVO;
import com.laonmoa.member.VO.MessageVO;

public interface MemberInfoDAO {
	// 메일 인증
	public MemberVO chkAuth(MemberVO vo) throws Exception;

	public void userAuth(MemberVO vo) throws Exception;

	public MemberVO authenticate(String str) throws Exception;

	public void insertUser(MemberVO vo) throws Exception;

	// ----------------------

	public void successAuth(MemberVO vo);

	// 비번 찾기(정보 확인용)
	public String findingPassword(Map<String, Object> map);

	// 임시비번 전송
	public int newPassword(Map<String, String> map);

	// 아이디 찾기
	public String FindingId(Map<String, Object> map);

	// 중복 번호 체크
	public int TelCheck(String tel);

	// 중복 이름 체크
	public int NameCheck(String name);

	// 중복아이디체크
	public int IdCheck(String id);

	// 중복이메일체크
	public int EmailCheck(String email);

	// 회원가입
	public int join(MemberVO user);

	// 로그인
	public MemberVO login(Map<String, Object> map);
	
	// 마지막로그인시간 업데이트
	public int lastLoginTime(String id);

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
