package kr.disable.jugd.academy.utils;

public final class Constants {

	/** 심판종목구분 */
	public static final String JUDGE_KIND	= "100001";		// 심판종목구분
	
	/**
	 * 신청 진행상태(수강신청)
	 * 01: 신청, 02: 신청확정(수료대기), 03: 수료확정, 04: 신청취소(관리자취소), 05: 미수료
	 */
	public static final String APPLY_STATE	= "100002";
	
	/** 신청 진행상태 코드값 */
	public static final String APPLY_STATE_APPLY_WAIT		= "01"; // 01: 신청
	public static final String APPLY_STATE_APPLY_COMP		= "02"; // 02: 신청확정(수료대기)
	public static final String APPLY_STATE_CERT_COMP		= "03"; // 03: 수료확정
	public static final String APPLY_STATE_APPLY_CANCEL		= "04"; // 04: 신청취소(관리자취소) -- 미사용
	public static final String APPLY_STATE_CERT_NOT			= "05"; // 05: 미수료
	
	/** 교육과정 상태 */
	public static final String EDU_STATUS	= "100003";		// 01: 대기중, 02: 신청중, 03: 인원마감, 04: 종료
}
