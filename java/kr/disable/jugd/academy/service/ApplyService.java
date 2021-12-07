package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.ApplyVO;
import kr.disable.jugd.academy.mapper.ApplyMapper;

@Service
public class ApplyService {

	@Autowired
	private ApplyMapper applyMapper;
	
	/** 신청 상태 및 수료 현황 목록 */
	public List<ApplyVO> selectApplyList(Map<String, Object> paramMap){
		return applyMapper.selectApplyList(paramMap);
	}
	
	/** 신청 상태 및 수료 현황 목록 개수 */
	public Integer selectApplyListCnt(Map<String, Object> paramMap) {
		return applyMapper.selectApplyListCnt(paramMap);
	}
	
	/** 수강 신청 되어있는 과목인지 확인 */
	public Integer checkDupApply(ApplyVO apply) {
		return applyMapper.checkDupApply(apply);
	};
	
	/** 수강신청 진행 */
	public void insertApply(ApplyVO apply) {
		applyMapper.insertApply(apply);
	}
}
