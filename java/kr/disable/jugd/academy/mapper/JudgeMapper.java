package kr.disable.jugd.academy.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.JudgeVO;

@Repository
@Mapper
public interface JudgeMapper {

	/** 심판 정보 */
	public JudgeVO selectJudgeInfo(JudgeVO judge);
}
