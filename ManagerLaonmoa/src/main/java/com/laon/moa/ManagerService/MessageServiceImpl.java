package com.laon.moa.ManagerService;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.laon.moa.ManagerDAO.MessageDAO;
import com.laon.moa.VO.MessageVO;

@Service
public class MessageServiceImpl implements MessageService{

	@Inject
	private MessageDAO dao;
	
	//페이징을 위한 총갯수
	public int messageListCnt(Map<String, Object> map){
		return dao.messageListCnt(map);
	}
	
	//쪽지리스트
	public List<MessageVO> messageList(Map<String, Object> map){
		return dao.messageList(map);
	}
	
	//메시지보내기
	@Override
	public int messageInsert(MessageVO vo) {
		return dao.messageInsert(vo);
	}

	//메시지 상세보기
	@Override
	public MessageVO messageDetail(Map<String, Object> map) {
		return dao.messageDetail(map);
	}
	
	//메시지삭제
	@Override
	public void messageDelete(int mnum) {
		dao.messageDelete(mnum);
	}
	
	//메시지 검색
	@Override
	public List<MessageVO> messageSearch(Map<String, String> map) {
		return dao.messageSearch(map);
	}

	//열람여부로 조회
	@Override
	public List<MessageVO> listRead(int ifread) {
		return dao.listRead(ifread);
	}
	
	// 안읽은 쪽지 갯수
	@Override
	public int alarmCnt(String id) {
		return dao.alarmCnt(id);
	}

}
