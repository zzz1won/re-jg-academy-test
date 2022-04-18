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

	//0413 code useState 용
	/** 코드 사용 상태 기본값 Y*/
	public static final String CODE_USE_STATE = "Y"; //코드 사용
	/** 코드 사용 상태 코드값 변경시 N으로 */
	public static final String CODE_USE_STATE_N = "N"; //코드 미사용

	//0418 userStateChk Y면 로그인 가능, N면 로그인 불가
	public static final String JUDGE_STATE_Y = "Y"; //계정사용
	public static final String JUDGE_STATE_N = "N"; //계정미사용(로그인불가)


}
