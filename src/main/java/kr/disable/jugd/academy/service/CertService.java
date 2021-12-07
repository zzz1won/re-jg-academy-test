package kr.disable.jugd.academy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.disable.jugd.academy.domain.ApplyVO;
import kr.disable.jugd.academy.domain.CertVO;
import kr.disable.jugd.academy.mapper.CertMapper;

@Service
public class CertService {

	@Autowired
	private CertMapper certMapper;
	
	/** 수료관리 목록 */
	public List<CertVO> selectCertList(Map<String, Object> paramMap){
		return certMapper.selectCertList(paramMap);
	}
	
	/** 수료관리 목록 개수 */
	public Integer selectCertListCnt(Map<String, Object> paramMap) {
		return certMapper.selectCertListCnt(paramMap);
	}
	
	/** 수료 확정 / 미수료 처리 */
	public Integer updateCertState(CertVO cert) {
		int state = certMapper.updateCertState(cert);		// 상태값 변경
		int mody = 0;
		
		if(state > 0) {
			mody = certMapper.updateCertModyInfo(cert);	// 확정자 등록
		}
		
		return (state + mody) % 2;
	}
	
	/** 수료증 업로드시 파일 경로 저장 */
	public Integer updateCertPath(CertVO cert) {
		return certMapper.updateCertPath(cert);
	}
	
	/** 수료증 미리보기 */
	public CertVO selectCertPath(Integer acEduCertInfoNo) {
		return certMapper.selectCertPath(acEduCertInfoNo);
	}
	
	/** 수료증 */
	public ApplyVO selectCertInfo(Map<String, Object> paramMap) {
		return certMapper.selectCertInfo(paramMap);
	}
	
	/** 수강 확정 = 수료대기로 보며  수료 테이블에 insert해준다. */
	public Integer insertCertInfo(ApplyVO apply) {
		return certMapper.insertCertInfo(apply);
	}
	
	/** 신청확정되어 cert테이블에 insert된 row삭제 */
	public Integer deleteCertInfoByJudgeNoEudId(ApplyVO apply) {
		return certMapper.deleteCertInfoByJudgeNoEudId(apply);
	}
	
	/** 확정취소(수료증 파일 경로값, 파일등록시간, 파일등록자 값 null로 수정) */
	public Integer updateCertInfoByCertNoArr(CertVO cert) {
		return certMapper.updateCertInfoByCertNoArr(cert);
	}
}
