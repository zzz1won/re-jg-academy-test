package kr.disable.jugd.academy.domain;

public class EduVO {

	private Integer acEduScheduleNo;
	private String  acEduId;
	private Integer acEduSeq;
	private String  acEduTitle;
	private String  acEduStartDate;
	private String  acEduEndDate;
	private String  acEduPlace;
	private String  acEduContents;
	private String  acApplyStartDate;
	private String  acApplyEndDate;
	private Integer acApplyLimitCount;
	
	/** 현재 수강 인원 */
	private Integer acApplyCount;
	/** 해당 심판이 수강중인지 여부 (Y/N) */
	private String  acApplyYn;
	
	public Integer getAcEduScheduleNo() {
		return acEduScheduleNo;
	}
	public void setAcEduScheduleNo(Integer acEduScheduleNo) {
		this.acEduScheduleNo = acEduScheduleNo;
	}
	public String getAcEduId() {
		return acEduId;
	}
	public void setAcEduId(String acEduId) {
		this.acEduId = acEduId;
	}
	public Integer getAcEduSeq() {
		return acEduSeq;
	}
	public void setAcEduSeq(Integer acEduSeq) {
		this.acEduSeq = acEduSeq;
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
	public String getAcEduContents() {
		return acEduContents;
	}
	public void setAcEduContents(String acEduContents) {
		this.acEduContents = acEduContents;
	}
	public String getAcApplyStartDate() {
		return acApplyStartDate;
	}
	public void setAcApplyStartDate(String acApplyStartDate) {
		this.acApplyStartDate = acApplyStartDate;
	}
	public String getAcApplyEndDate() {
		return acApplyEndDate;
	}
	public void setAcApplyEndDate(String acApplyEndDate) {
		this.acApplyEndDate = acApplyEndDate;
	}
	public Integer getAcApplyLimitCount() {
		return acApplyLimitCount;
	}
	public void setAcApplyLimitCount(Integer acApplyLimitCount) {
		this.acApplyLimitCount = acApplyLimitCount;
	}
	public Integer getAcApplyCount() {
		return acApplyCount;
	}
	public void setAcApplyCount(Integer acApplyCount) {
		this.acApplyCount = acApplyCount;
	}
	public String getAcApplyYn() {
		return acApplyYn;
	}
	public void setAcApplyYn(String acApplyYn) {
		this.acApplyYn = acApplyYn;
	}
}
