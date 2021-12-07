package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.ApplyVO;
import kr.disable.jugd.academy.domain.CertVO;
import kr.disable.jugd.academy.mapper.ApplyMapper;

@Service
public class ApplyService {

	@Autowired
	private ApplyMapper applyMapper;
	
	/** 신청 상태 및 수료 현황 목록 */
	public List<ApplyVO> selectJudgeApplyList(Map<String, Object> paramMap){
		return applyMapper.selectJudgeApplyList(paramMap);
	}
	
	/** 신청 상태 및 수료 현황 목록 개수 */
	public Integer selectJudgeApplyListCnt(Map<String, Object> paramMap) {
		return applyMapper.selectJudgeApplyListCnt(paramMap);
	}
	
	/** 수강 신청 되어있는 과목인지 확인 */
	public Integer checkDupApply(ApplyVO apply) {
		return applyMapper.checkDupApply(apply);
	};
	
	/** 수강신청 진행 */
	public Integer insertApply(ApplyVO apply) {
		return applyMapper.insertApply(apply);
	}
	
	/** 교육일정 삭제시 과거에 심판이 삭제될 교육과정을 신청한 정보도 모두 삭제 */
	public Integer deleteApplyInfoByEduId(ApplyVO apply) {
		return applyMapper.deleteApplyInfoByEduId(apply);
	}
	
	/** 신청 확정 관리 목록 */
	public List<ApplyVO> selectAdminApplyList(Map<String, Object> paramMap) {
		return applyMapper.selectAdminApplyList(paramMap);
	}
	
	/** 신청 확정 관리 목록 개수 */
	public Integer selectAdminApplyListCnt(Map<String, Object> paramMap) {
		return applyMapper.selectAdminApplyListCnt(paramMap);
	}
	
	/** 신청확정 */
	public Integer updateApplyState(ApplyVO apply) {
		return applyMapper.updateApplyState(apply);
	}
	
	/** 확정취소 */
	public Integer updateConfirmCancel(ApplyVO apply) {
		return applyMapper.updateConfirmCancel(apply);
	}
	
	/** 신청취소 */
	public Integer deleteApplyInfoByApplyNo(ApplyVO apply) {
		return applyMapper.deleteApplyInfoByApplyNo(apply);
	}
	
	/** apply no값으로 신청 정보 목록 조회 */
	public List<ApplyVO> selectApplyListByApplyNo(ApplyVO apply){
		return applyMapper.selectApplyListByApplyNo(apply);
	}
	
	/** 신청 진행상태 값으로 몇 건 있는지 확인 */
	public Integer selectApplyCountState(ApplyVO apply) {
		return applyMapper.selectApplyCountState(apply);
	}
	
	/** 확정취소(수료확정, 미수료 상태를 취소하여 신청확정으로 되돌린다.) */
	public Integer updateApplyInfoByApplyNoArr(CertVO cert) {
		return applyMapper.updateApplyInfoByApplyNoArr(cert);
	}
}
