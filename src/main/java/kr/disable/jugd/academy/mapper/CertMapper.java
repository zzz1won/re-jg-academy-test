package kr.disable.jugd.academy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.disable.jugd.academy.domain.ApplyVO;
import kr.disable.jugd.academy.domain.CertVO;


@Repository
@Mapper
public interface CertMapper {

	/** 수료관리 목록 */
	public List<CertVO> selectCertList(Map<String, Object> paramMap);
	
	/** 수료관리 목록 개수 */
	public Integer selectCertListCnt(Map<String, Object> paramMap);
	
	/** 수료 확정 / 미수료 처리(상태값 변경) */
	public Integer updateCertState(CertVO cert);
	
	/** 수료 확정 / 미수료 처리(확정자 등록) */
	public Integer updateCertModyInfo(CertVO cert);
	
	/** 수료증 업로드시 파일 경로 저장 */
	public Integer updateCertPath(CertVO cert);
	
	/** 수료증 미리보기 */
	public CertVO selectCertPath(Integer acEduCertInfoNo);
	
	/** 수료증 정보 */
	public ApplyVO selectCertInfo(Map<String, Object> paramMap);
	
	/** 수강 확정 = 수료대기로 보며  수료 테이블에 insert해준다. */
	public Integer insertCertInfo(ApplyVO apply);
	
	/** 신청확정되어 cert테이블에 insert된 row삭제 */
	public Integer deleteCertInfoByJudgeNoEudId(ApplyVO apply);
	
	/** 확정취소(수료증 파일 경로값, 파일등록시간, 파일등록자 값 null로 수정) */
	public Integer updateCertInfoByCertNoArr(CertVO cert);
}
