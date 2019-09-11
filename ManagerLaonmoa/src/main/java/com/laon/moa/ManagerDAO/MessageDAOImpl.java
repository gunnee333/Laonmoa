package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.laon.moa.VO.MessageVO;

@Repository
public class MessageDAOImpl implements MessageDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "Message";
	
	//페이징을 위한 총갯수
	public int messageListCnt(Map<String, Object> map) {
		return session.selectOne(namespace + ".messageListCnt", map);
	}
	
	//리스트불러오기
	@Override
	public List<MessageVO> messageList(Map<String, Object> map) {
		return session.selectList(namespace + ".list", map);
	}
	
	//메시지 보내기
	@Override
	public int messageInsert(MessageVO vo) {
		System.out.println(vo.toString());
		session.insert(namespace + ".insert", vo);
		int mnum = vo.getMnum();
		return mnum;
	}
	
	//메시지 상세보기
	@Override
	public MessageVO messageDetail(Map<String, Object> map) {
		MessageVO vo = session.selectOne(namespace + ".detail", map);
		System.out.println(map.toString());
		if(vo.getIfread() == 0) {
			if(vo.getRecid().equals(map.get("id"))) {
				session.update(namespace + ".readok", vo);
			}
		}
		System.out.println("vo :: " + vo.toString());
		return vo;
	}
	
	//메시지 삭제
	@Override
	public void messageDelete(int mnum) {
		session.delete(namespace + ".del", mnum);
	}

	//메시지검색
	@Override
	public List<MessageVO> messageSearch(Map<String, String> map) {
		return session.selectList(namespace + ".search", map);
	}
	
	//열람여부로 조회
	@Override
	public List<MessageVO> listRead(int ifread) {
		return session.selectList(namespace + ".listRead", ifread);
	}
	
	// 안읽은 쪽지 갯수
	@Override
	public int alarmCnt(String id) {
		return session.selectOne(namespace + ".alarmCnt", id);
	}

}
