package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.EduVO;

@Repository
@Mapper
public interface EduMapper {

	/** 교육 일정 및 신청 목록(심판) */
	public List<EduVO> selectJudgeEduList(Map<String, Object> paramMap);
	
	/** 교육 일정 및 신청 목록 개수(심판) */
	public Integer selectJudgeEduListCnt(Map<String, Object> paramMap);
	
	/** 교육 상세정보 */
	public EduVO selectEduInfo(EduVO edu);
	
	/** 교육 일정 관리 목록(관리자) */
	public List<EduVO> selectAdminEduList(Map<String, Object> paramMap);
	
	/** 교육 일정 관리 목록 개수(관리자) */
	public Integer selectAdminEduListCnt(Map<String, Object> paramMap);
	
	/** 해당하는 교육일정에 대한 상세 정보 */
	public EduVO selectEduScheduleInfo(String acEduId);
	
	/** sequence */
	public Integer selectEduSeq();
	
	/** edu id 중복확인 */
	public Integer checkDupEduId(String eduId);
	
	/** 교육일정 등록 */
	public Integer insertEduSchedule(EduVO edu);
	
	/** 교육일정 수정 */
	public Integer updateEduSchedule(EduVO edu);
	
	/** 교육일정 삭제 */
	public Integer deleteEduSchedule(EduVO edu);
	
	/** edu_no값으로 edu_id값 가져오기 */
	public List<EduVO> selectEduIdByEduScheduleNo(EduVO edu);
	
	/** 교육과정명 목록 */
	public List<EduVO> selectEduTitleListByYear(Map<String, Object> paramMap);

	/**
	 * @param paramMap
	 * @return
	 */
	public List<EduVO> selectJudgeEduCalendar(Map<String, Object> paramMap);

	/**
	 * @param paramMap
	 * @return
	 */
	public List<EduVO> selectHolidayList(Map<String, Object> paramMap);

	/** 테스트*/
    public List<EduVO> selectEduSchedule(Map<String, Object> resultMap);
}
