package kr.disable.jugd.academy.domain;

import java.sql.Date;

public class ApplyVO {

	private Integer eduApplyInfoNo;
	private String  judgeNo;
	private String  judgeName;
	private String  judgeKind;
	private String  acEduId;
	private String  state;
	private String  etcInfo;
	private String  useYn;
	private Date    regDate;
	private String  regId;
	private Date    applyConfirmDate;
	private String  applyConfirmId;
	private Date    certConfirmDate;
	private String  certConfirmId;
	
	/**  */
	private String  acEduTitle;
	private String  acEduStartDate;
	private String  acEduEndDate;
	private String  acEduPlace;
	
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
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
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
}
