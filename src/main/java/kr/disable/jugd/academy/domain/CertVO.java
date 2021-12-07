package kr.disable.jugd.academy.domain;

import java.util.Date;

public class CertVO extends SearchVO {

	private Integer acEduCertInfoNo;
	private String  judgeNo;
	private String  judgeName;
	private String  judgeKind;
	private String  acEduId;
	private String  acEduCertFilePath;
	private Date    fileDate;
	private String  fileId;
	
	/** 신청 정보 */
	private Integer eduApplyInfoNo;
	private String  state;
	private Date    applyConfirmDate;
	private Date    certConfirmDate;
	private String  certConfirmId;
	
	/** 교육 과정 정보 */
	private Integer acEduScheduleNo;
	private String  acEduTitle;
	private String  acEduStartDate;
	private String  acEduEndDate;
	private String  acEduPlace;
	private String  acEduInstitute;
	
	/** 수료 확정 및 미수료 처리시 필요 */
	/** certNo */
	private String   certNo;
	/** certNo 배열 */
	private String[] certNoArr;
	/** certNo  */
	private String   applyNo;
	/** certNo 배열 */
	private String[] applyNoArr;
	
	public Integer getAcEduCertInfoNo() {
		return acEduCertInfoNo;
	}
	public void setAcEduCertInfoNo(Integer acEduCertInfoNo) {
		this.acEduCertInfoNo = acEduCertInfoNo;
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
	public String getAcEduCertFilePath() {
		return acEduCertFilePath;
	}
	public void setAcEduCertFilePath(String acEduCertFilePath) {
		this.acEduCertFilePath = acEduCertFilePath;
	}
	public Date getFileDate() {
		return fileDate;
	}
	public void setFileDate(Date fileDate) {
		this.fileDate = fileDate;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public Integer getEduApplyInfoNo() {
		return eduApplyInfoNo;
	}
	public void setEduApplyInfoNo(Integer eduApplyInfoNo) {
		this.eduApplyInfoNo = eduApplyInfoNo;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getApplyConfirmDate() {
		return applyConfirmDate;
	}
	public void setApplyConfirmDate(Date applyConfirmDate) {
		this.applyConfirmDate = applyConfirmDate;
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
	public String getCertNo() {
		return certNo;
	}
	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}
	public String[] getCertNoArr() {
		return certNoArr;
	}
	public void setCertNoArr(String[] certNoArr) {
		this.certNoArr = certNoArr;
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
}
