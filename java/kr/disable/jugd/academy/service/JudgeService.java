package kr.disable.jugd.academy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.mapper.JudgeMapper;

@Service
public class JudgeService {

	@Autowired
	private JudgeMapper judgeMapper;
	
	public JudgeVO selectJudgeInfo(JudgeVO judge) {
		return judgeMapper.selectJudgeInfo(judge);
	}
}
