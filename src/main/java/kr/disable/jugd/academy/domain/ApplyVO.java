package kr.disable.jugd.academy.domain;

import java.util.Date;

public class ApplyVO extends SearchVO {

	private Integer eduApplyInfoNo;
	private String  judgeNo;
	private String  judgeName;
	private String  judgeKind;
	private String  acEduId;
	private String  state;
	private String  etcInfo;
	private String  useYn;
	private Date    applyConfirmDate;
	private String  applyConfirmId;
	private Date    certConfirmDate;
	private String  certConfirmId;
	
	/** 교육 과정 정보 */
	private Integer acEduScheduleNo;
	private String  acEduTitle;
	private String  acEduStartDate;
	private String  acEduEndDate;
	private String  acEduPlace;
	private String  acEduInstitute;
	
	/** 오늘 날짜(수료증 표시) */
	private Date nowDate;
	/** 수료 번호 */
	private Integer acEduCertInfoNo;
	/** eduId 배열(교육과정 삭제시 필요) */
	private String[] acEduIdArr;
	/** applyNo (수강확정시 필요) */
	private String applyNo;
	/** applyNo 배열(수강확정시 필요) */
	private String[] applyNoArr;
	/** 수료증 파일 이름 */
	private String acEduCertFilePath;
	/** state array */
	private String[] stateArr;
	
	public Integer getEduApplyInfoNo() {
		return eduApplyInfoNo;
	}
	public void setEduApplyInfoNo(Integer eduApplyInfoNo) {
		this.eduApplyInfoNo = eduApplyInfoNo;
	}
	public String getJudgeNo() {
		return judgeNo;
	}
	public void setJudgeNo(String judgeNo) {
		this.judgeNo = judgeNo;
	}
	public String getJudgeName() {
		return judgeName;
	}
	public void setJudgeName(String judgeName) {
		this.judgeName = judgeName;
	}
	public String getJudgeKind() {
		return judgeKind;
	}
	public void setJudgeKind(String judgeKind) {
		this.judgeKind = judgeKind;
	}
	public String getAcEduId() {
		return acEduId;
	}
	public void setAcEduId(String acEduId) {
		this.acEduId = acEduId;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getEtcInfo() {
		return etcInfo;
	}
	public void setEtcInfo(String etcInfo) {
		this.etcInfo = etcInfo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public Date getApplyConfirmDate() {
		return applyConfirmDate;
	}
	public void setApplyConfirmDate(Date applyConfirmDate) {
		this.applyConfirmDate = applyConfirmDate;
	}
	public String getApplyConfirmId() {
		return applyConfirmId;
	}
	public void setApplyConfirmId(String applyConfirmId) {
		this.applyConfirmId = applyConfirmId;
	}
	public Date getCertConfirmDate() {
		return certConfirmDate;
	}
	public void setCertConfirmDate(Date certConfirmDate) {
		this.certConfirmDate = certConfirmDate;
	}
	public String getCertConfirmId() {
		return certConfirmId;
	}
	public void setCertConfirmId(String certConfirmId) {
		this.certConfirmId = certConfirmId;
	}
	public Integer getAcEduScheduleNo() {
		return acEduScheduleNo;
	}
	public void setAcEduScheduleNo(Integer acEduScheduleNo) {
		this.acEduScheduleNo = acEduScheduleNo;
	}
	public String getAcEduTitle() {
		return acEduTitle;
	}
	public void setAcEduTitle(String acEduTitle) {
		this.acEduTitle = acEduTitle;
	}
	public String getAcEduStartDate() {
		return acEduStartDate;
	}
	public void setAcEduStartDate(String acEduStartDate) {
		this.acEduStartDate = acEduStartDate;
	}
	public String getAcEduEndDate() {
		return acEduEndDate;
	}
	public void setAcEduEndDate(String acEduEndDate) {
		this.acEduEndDate = acEduEndDate;
	}
	public String getAcEduPlace() {
		return acEduPlace;
	}
	public void setAcEduPlace(String acEduPlace) {
		this.acEduPlace = acEduPlace;
	}
	public String getAcEduInstitute() {
		return acEduInstitute;
	}
	public void setAcEduInstitute(String acEduInstitute) {
		this.acEduInstitute = acEduInstitute;
	}
	public Date getNowDate() {
		return nowDate;
	}
	public void setNowDate(Date nowDate) {
		this.nowDate = nowDate;
	}
	public Integer getAcEduCertInfoNo() {
		return acEduCertInfoNo;
	}
	public void setAcEduCertInfoNo(Integer acEduCertInfoNo) {
		this.acEduCertInfoNo = acEduCertInfoNo;
	}
	public String[] getAcEduIdArr() {
		return acEduIdArr;
	}
	public void setAcEduIdArr(String[] acEduIdArr) {
		this.acEduIdArr = acEduIdArr;
	}
	public String getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(String applyNo) {
		this.applyNo = applyNo;
	}
	public String[] getApplyNoArr() {
		return applyNoArr;
	}
	public void setApplyNoArr(String[] applyNoArr) {
		this.applyNoArr = applyNoArr;
	}
	public String getAcEduCertFilePath() {
		return acEduCertFilePath;
	}
	public void setAcEduCertFilePath(String acEduCertFilePath) {
		this.acEduCertFilePath = acEduCertFilePath;
	}
	public String[] getStateArr() {
		return stateArr;
	}
	public void setStateArr(String[] stateArr) {
		this.stateArr = stateArr;
	}
}
