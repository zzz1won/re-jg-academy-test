package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

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
	 * @param eduInfo
	 * @return
	 */
	public Integer updateJudgeInfo(JudgeVO judgeInfo) {
		return judgeMapper.updateJudgeInfo(judgeInfo);
	}
}
