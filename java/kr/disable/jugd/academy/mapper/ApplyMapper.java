package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.ApplyVO;

@Repository
@Mapper
public interface ApplyMapper {

	/** 신청 상태 및 수료 현황 목록 */
	public List<ApplyVO> selectApplyList(Map<String, Object> paramMap);
	
	/** 신청 상태 및 수료 현황 목록 개수 */
	public Integer selectApplyListCnt(Map<String, Object> paramMap);
	
	/** 수강 신청 되어있는 과목인지 확인 */
	public Integer checkDupApply(ApplyVO apply);
	
	/** 수강 신청 진행 */
	public void insertApply(ApplyVO apply);
}
