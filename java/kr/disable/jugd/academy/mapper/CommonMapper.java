package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.CommonVO;

@Repository
@Mapper
public interface CommonMapper {

	/** common code의 목록 */
	public List<CodeVO> selectCommonCode(Map<String, Object> paramMap);
}
