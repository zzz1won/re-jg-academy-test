package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import kr.disable.jugd.academy.domain.SearchVO;
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

	/** 심판정보 */
	public List<JudgeVO> selectJudgeList(Map<String, Object> paramMap);

	/** 심판정보출력-수정할것 */
	public JudgeVO selectDetailJudge(JudgeVO judgeVO);

	/** 심판정보수정용!*/
	public Integer updateJudgeData(JudgeVO judgeVO);

	/** 심판 계정 사용여부 Y로 변경*/
    public Integer updateJudgeStateY(JudgeVO judgeVO);

	/** 심판 계정 사용여부 N으로 변경*/
	public Integer updateJudgeStateN(JudgeVO judgeVO);

	/** 심판 신규등록 */
	public Integer insertJudge(JudgeVO judgeVO);

	/** 검색용*/
    //SearchVO selectDetailJudgeAndSearch(JudgeVO judgeVO);
}
