package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.EduVO;

@Repository
@Mapper
public interface EduMapper {

	/** 교육 일정 및 신청 목록 */
	public List<EduVO> selectEduList(Map<String, Object> paramMap);
	
	/** 교육 일정 및 신청 목록 개수 */
	public Integer selectEduListCnt(Map<String, Object> paramMap);
}
