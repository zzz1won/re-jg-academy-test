package kr.disable.jugd.academy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.AdminVO;

@Repository
@Mapper
public interface AdminMapper {
	
	/** 관리자 정보 */
	public AdminVO selectAdminInfo(AdminVO admin);
	
	/** 관리자 목록 */
	public List<AdminVO> selectAdminList();
}