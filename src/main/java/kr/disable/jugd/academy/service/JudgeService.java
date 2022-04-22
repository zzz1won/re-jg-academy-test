package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import kr.disable.jugd.academy.domain.SearchVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.mapper.JudgeMapper;

@Service
public class JudgeService {

	@Autowired
	private JudgeMapper judgeMapper;
	
	/** 심판 정보 */
	public JudgeVO selectJudgeInfo(JudgeVO judge) {
		return judgeMapper.selectJudgeInfo(judge);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public int selectJudgeMemberListCnt(Map<String, Object> paramMap) {
		return judgeMapper.selectJudgeMemberListCnt(paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public List<JudgeVO> selectJudgeMemberList(Map<String, Object> paramMap) {
		return judgeMapper.selectJudgeMemberList(paramMap);
	}

	/**
	 * @param //eduInfo
	 * @return
	 */
	public Integer updateJudgeInfo(JudgeVO judgeInfo) {
		return judgeMapper.updateJudgeInfo(judgeInfo);
	}

	/** 화면에 judge 내용 띄우기
	 * @param paramMap
	 * @return
	 * */
    public List<JudgeVO> selectJudgeList(Map<String, Object> paramMap) {
		return judgeMapper.selectJudgeList(paramMap);
    }

    public JudgeVO selectDetailJudge(JudgeVO judgeVO) {
		return judgeMapper.selectDetailJudge(judgeVO);
    }

	/**judge 심판 수정*/
    public Integer updateJudgeData(JudgeVO judgeVO) {
		return judgeMapper.updateJudgeData(judgeVO);
    }

	/**judge 계정사용여부 judgeList페이지에서 변경 */
    public Integer updateJudgeStateY(JudgeVO judgeVO) {
		return judgeMapper.updateJudgeStateY(judgeVO);
    }

	/**judge 계정사용여부 judgeList페이지에서 변경 */
	public Integer updateJudgeStateN(JudgeVO judgeVO) {
		return judgeMapper.updateJudgeStateN(judgeVO);
	}

	/**judge 심판 신규 등록 */
	public Integer insertJudge(JudgeVO judgeVO) {
		return judgeMapper.insertJudge(judgeVO);
	}

	//** judge 검색어 띄우기용 */
    //public SearchVO selectDetailJudgeAndSearch(JudgeVO judgeVO) { return judgeMapper.selectDetailJudgeAndSearch(judgeVO); }
}
