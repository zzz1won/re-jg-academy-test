package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.JudgeVO;

@Repository
@Mapper
public interface JudgeMapper {

	/** 심판 정보 */
	public JudgeVO selectJudgeInfo(JudgeVO judge);

	/**
	 * @param paramMap
	 * @return
	 */
	public int selectJudgeMemberListCnt(Map<String, Object> paramMap);

	/**
	 * @param paramMap
	 * @return
	 */
	public List<JudgeVO> selectJudgeMemberList(Map<String, Object> paramMap);

	/**
	 * @param judgeInfo
	 * @return
	 */
	public Integer updateJudgeInfo(JudgeVO judgeInfo);
}
