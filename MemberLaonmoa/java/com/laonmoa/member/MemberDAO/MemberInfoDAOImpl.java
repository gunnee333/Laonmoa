package com.laonmoa.member.MemberDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.laonmoa.member.VO.BoardVO;
import com.laonmoa.member.VO.MemberVO;
import com.laonmoa.member.VO.MessageVO;

@Repository
public class MemberInfoDAOImpl implements MemberInfoDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberInfoDAOImpl.class);
	@Inject
	private SqlSession session;

	private static String namespace = "Member";

	// 회원 정보 입력
	@Override
	public void insertUser(MemberVO vo) throws Exception {
		System.out.println("회원등록완료 !!!");
		session.insert(namespace + ".insertUser", vo);
		System.out.println("//////////////////////////////////");
		System.out.println("회원등록완료 !!!");
	}

	// email 중복 확인
	@Override
	public MemberVO authenticate(String str) throws Exception {
		return session.selectOne(namespace + ".checkdupl", str);
	}

	// 이메일 인증 코드 확인
	@Override
	public MemberVO chkAuth(MemberVO vo) throws Exception {
		return session.selectOne(namespace + ".chkAuth", vo);
	}

	// 인증 후 계정 활성화
	@Override
	public void userAuth(MemberVO vo) throws Exception {
		System.out.println("인증하나요??");
		session.update(namespace + ".userAuth", vo);
	}

	@Override
	public void successAuth(MemberVO vo) {
		// TODO Auto-generated method stub

	}

	// ---------------------메일끝
	@Override
	public int join(MemberVO user) {
		// TODO Auto-generated method stub
		System.out.println(user + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		return session.insert(namespace + ".join", user);
	}

	// 비번 찾기(정보 확인용)
	@Override
	public String findingPassword(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectOne("Member.findingPassword", map);
	}

	// 임시 비번 전송
	@Override
	public int newPassword(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("임시 비번 정송 DAO");
		return session.update(namespace + ".newPassword", map);
	}

	// 아이디 찾기
	@Override
	public String FindingId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectOne("Member.findingId", map);
	}

	// 번호 쳌흐
	@Override
	public int TelCheck(String tel) {
		// TODO Auto-generated method stub
		return session.selectOne("Member.telCheck", tel);
	}

	// 이름 쳌흐
	@Override
	public int NameCheck(String name) {
		// TODO Auto-generated method stub
		return session.selectOne("Member.nameCheck", name);
	}

	// 아이디 체크
	@Override
	public int IdCheck(String id) {
		// TODO Auto-generated method stub
		return session.selectOne("Member.idCheck", id);
	}

	// 이메일 체크
	@Override
	public int EmailCheck(String email) {
		// TODO Auto-generated method stub
		return session.selectOne("Member.emailcheck", email);
	}

	// 로그인
	@Override
	public MemberVO login(Map<String, Object> map) {
		return session.selectOne(namespace + ".login", map);
	}
	
	// 마지막로그인시간 업데이트
	@Override
	public int lastLoginTime(String id) {
		return session.update(namespace + ".lastLoginTime", id);
	}

	// 내 정보보기
	@Override
	public MemberVO mypage(String id) {
		return session.selectOne(namespace + ".mypage", id);
	}

	// 내 정보 수정
	@Override
	public int update(MemberVO vo) {
		return session.update(namespace + ".update", vo);
	}

	// 회원탈퇴
	@Override
	public int memberout(Map<String, String> map) {
		int number1 = session.update(namespace + ".memberout", map);
		return number1;
	}

	// 페이징을 위한 내게시글 갯수
	@Override
	public int myBoardCount(Map<String, Object> map) {
		return session.selectOne(namespace + ".myBoardCnt", map);
	}

	// 내가 쓴 게시글 리스트
	@Override
	public List<BoardVO> myBoard(Map<String, Object> map) {
		return session.selectList(namespace + ".myBoard", map);
	}

	// 비밀번호 수정
	@Override
	public int changePw(Map<String, String> map) {
		return session.update(namespace + ".pwupdate", map);
	}

	// 페이징을 위한 쪽지갯수
	@Override
	public int notecount(Map<String, Object> map) {
		System.out.println(map.toString());
		return session.selectOne(namespace + ".notecount", map);
	}

	// 쪽지리스트
	@Override
	public List<MessageVO> noteList(Map<String, Object> map) {
		return session.selectList(namespace + ".noteLsit", map);
	}

	// 쪽지보내기
	@Override
	public int noteSend(MessageVO vo) {
		session.insert(namespace + ".noteSend", vo);
		System.out.println(vo.getMnum());
		return vo.getMnum();
	}

	// 쪽지상세보기
	@Override
	public MessageVO notedetail(int mnum) {
		return session.selectOne(namespace + ".notedetail", mnum);
	}

	// 쪽지 열람
	@Override
	public void noteread(MessageVO vo) {
		session.update(namespace + ".noteread", vo);
	}

	// 쪽지 삭제
	@Override
	public int notedelete(int mnum) {
		return session.delete(namespace + ".notedelete", mnum);
	}

	// 페이징을 위한 회원수
	@Override
	public int memberSearchCnt(Map<String, Object> map) {
		return session.selectOne(namespace + ".memberSearchCnt", map);
	}

	// 회원찾는 팝업
	@Override
	public List<MemberVO> searchMember(Map<String, Object> map) {
		System.out.println("MAP ::: " + map.toString());
		return session.selectList(namespace + ".searchMember", map);
	}
	
	// 안읽은 쪽지갯수
	@Override
	public int noteCnt(String id) {
		return session.selectOne(namespace + ".noteCnt", id);
	}

}
