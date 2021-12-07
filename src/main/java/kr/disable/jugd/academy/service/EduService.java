package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.EduVO;
import kr.disable.jugd.academy.mapper.EduMapper;

@Service
public class EduService {

	@Autowired
	private EduMapper eduMapper;
	
	/** 교육 일정 및 신청 목록 */
	public List<EduVO> selectJudgeEduList(Map<String, Object> paramMap){
		return eduMapper.selectJudgeEduList(paramMap);
	}
	
	/** 교육 일정 및 신청 목록 개수 */
	public Integer selectJudgeEduListCnt(Map<String, Object> paramMap) {
		return eduMapper.selectJudgeEduListCnt(paramMap);
	}
	
	/** 교육 상세정보 */
	public EduVO selectEduInfo(EduVO edu) {
		return eduMapper.selectEduInfo(edu);
	}
	
	/** 교육 일정 관리 목록(관리자) */
	public List<EduVO> selectAdminEduList(Map<String, Object> paramMap){
		return eduMapper.selectAdminEduList(paramMap);
	}
	
	/** 교육 일정 관리 목록 개수(관리자) */
	public Integer selectAdminEduListCnt(Map<String, Object> paramMap) {
		return eduMapper.selectAdminEduListCnt(paramMap);
	}
	
	/** 해당하는 교육일정에 대한 상세 정보 */
	public EduVO selectEduScheduleInfo(String acEduId) {
		return eduMapper.selectEduScheduleInfo(acEduId);
	}
	
	/** sequence */
	public Integer selectEduSeq() {
		return eduMapper.selectEduSeq();
	}
	
	/** edu id 중복확인 */
	public Integer checkDupEduId(String eduId) {
		return eduMapper.checkDupEduId(eduId);
	}
	
	/** 교육일정 등록 */
	public Integer insertEduSchedule(EduVO edu) {
		return eduMapper.insertEduSchedule(edu);
	}
	
	/** 교육일정 수정 */
	public Integer updateEduSchedule(EduVO edu) {
		return eduMapper.updateEduSchedule(edu);
	}
	
	/** 교육일정 삭제 */
	public Integer deleteEduSchedule(EduVO edu) {
		return eduMapper.deleteEduSchedule(edu);
	}
	
	/** edu_no값으로 edu_id값 가져오기 */
	public List<EduVO> selectEduIdByEduScheduleNo(EduVO edu){
		return eduMapper.selectEduIdByEduScheduleNo(edu);
	}
	
	/** 교육과정명 목록 */
	public List<EduVO> selectEduTitleListByYear(Map<String, Object> paramMap){
		return eduMapper.selectEduTitleListByYear(paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public List<EduVO> selectJudgeEduCalendar(Map<String, Object> paramMap) {
		return eduMapper.selectJudgeEduCalendar(paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public List<EduVO> selectHolidayList(Map<String, Object> paramMap) {
		return eduMapper.selectHolidayList(paramMap);
	}
}
