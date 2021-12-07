package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.EduVO;
import kr.disable.jugd.academy.mapper.EduMapper;

@Service
public class EduService {

	@Autowired
	private EduMapper eduMapper;
	
	public List<EduVO> selectEduList(Map<String, Object> paramMap){
		return eduMapper.selectEduList(paramMap);
	}
	
	public Integer selectEduListCnt(Map<String, Object> paramMap) {
		return eduMapper.selectEduListCnt(paramMap);
	}
}
