package com.laon.moa.ManagerDAO;

import java.util.List;
import java.util.Map;

import com.laon.moa.VO.MessageVO;

public interface MessageDAO {
	//페이징을 위한 총갯수
	public int messageListCnt(Map<String, Object> map);
	
	//쪽지 리스트
	public List<MessageVO> messageList(Map<String, Object> map);
	
	//쪽지 보내기
	public int messageInsert(MessageVO vo);
	
	//쪽지 상세보기
	public MessageVO messageDetail(Map<String, Object> map);
	
	//쪽지 삭제
	public void messageDelete(int mnum);
	
	//쪽지 검색
	public List<MessageVO> messageSearch(Map<String, String> map);
	
	//열람여부로 검색
	public List<MessageVO> listRead(int ifread);
	
	// 안읽은 쪽지 갯수
	public int alarmCnt(String id);
}
