package kr.disable.jugd.academy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.mapper.AdminMapper;

@Service
public class AdminService {

	@Autowired
	private AdminMapper adminMapper;
	
	/** 관리자 정보 */
	public AdminVO selectAdminInfo(AdminVO admin) {
		return adminMapper.selectAdminInfo(admin);
	}
	
	/** 관리자 목록 */
	public List<AdminVO> selectAdminList(){
		return adminMapper.selectAdminList();
	}
}
