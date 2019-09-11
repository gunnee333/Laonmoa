package com.laon.moa.ManagerService;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.laon.moa.ManagerDAO.DeclarationDAO;
import com.laon.moa.VO.WarVO;

@Service
public class DeclarationServiceImpl implements DeclarationService{
	private static final Logger logger = LoggerFactory.getLogger(DeclarationServiceImpl.class);
	@Inject
	private DeclarationDAO dao;
	
	//신고내역 전체리스트
	@Override
	public List<WarVO> DecList(Map<String, Object> map) throws Exception {
		return dao.DecList(map);
	}
	
	// 신고리스트 갯수세기
	@Override
	public int warListCnt(Map<String, Object> map) {
		return dao.warListCnt(map);
	}
	
	//신고내역 상세보기
	@Override
	public WarVO DecDetail(int wnum) throws Exception {
		return dao.DecDetail(wnum);
	}
	
	//신고 접수
	@Override
	public int DecUpdate(int wnum) throws Exception {
		return dao.DecUpdate(wnum);
	}
	
	// 신고횟수 3회 이상시 블랙회원으로 변경
	@Override
	public void warCntUp(String warid) {
		// 신고횟수 늘려준 후 신고당한 회원의 신고횟수 가져옴
		int warcnt = dao.warCnt(warid);
		if(warcnt >= 3) {
			dao.blackMemberChange(warid);
		}
	}

	// 신고 기각
	@Override
	public int DecDelete(int wnum) throws Exception {
		return dao.DecDelete(wnum);
	}

	//미처리신고 갯수
	@Override
	public int waralarm() {
		return dao.waralarm();
	}

	

}
