package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import kr.disable.jugd.academy.mapper.CodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.mapper.CommonMapper;

@Service
public class CommonService {

	@Autowired
	private CommonMapper commonMapper;

	@Autowired
	private CodeMapper codeMapper;

	public List<CodeVO> selectCommonCode(Map<String, Object> paramMap){
		return commonMapper.selectCommonCode(paramMap);
	}

	public List<CodeVO> selectToCommonCode(Map<String, Object> paramMap){
		return codeMapper.selectCommonCode(paramMap);
	}

}
