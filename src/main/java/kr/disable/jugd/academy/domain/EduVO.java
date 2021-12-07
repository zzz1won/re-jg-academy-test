package kr.disable.jugd.academy.domain;

public class EduVO extends SearchVO {

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
	private String  acEduInstitute;
	private String  acEduUrl;
	private String  start;
	private String  end;
	private String  title;
	
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the start
	 */
	public String getStart() {
		return start;
	}
	/**
	 * @param start the start to set
	 */
	public void setStart(String start) {
		this.start = start;
	}
	/**
	 * @return the end
	 */
	public String getEnd() {
		return end;
	}
	/**
	 * @param end the end to set
	 */
	public void setEnd(String end) {
		this.end = end;
	}
	/** 현재 수강 인원 */
	private Integer acApplyCount;
	/** 해당 심판이 수강중인지 여부 (Y/N) */
	private String  acApplyYn;
	/** 교육과정 상태(관리자) */
	private String  acEduStatus;
	/** eduNo(교육과정 삭제시 필요) */
	private String acEduNo;
	/** eduNo 배열(교육과정 삭제시 필요) */
	private String[] acEduNoArr;
	
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
	public String getAcEduInstitute() {
		return acEduInstitute;
	}
	public void setAcEduInstitute(String acEduInstitute) {
		this.acEduInstitute = acEduInstitute;
	}
	public String getAcEduUrl() {
		return acEduUrl;
	}
	public void setAcEduUrl(String acEduUrl) {
		this.acEduUrl = acEduUrl;
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
	public String getAcEduStatus() {
		return acEduStatus;
	}
	public void setAcEduStatus(String acEduStatus) {
		this.acEduStatus = acEduStatus;
	}
	public String getAcEduNo() {
		return acEduNo;
	}
	public void setAcEduNo(String acEduNo) {
		this.acEduNo = acEduNo;
	}
	public String[] getAcEduNoArr() {
		return acEduNoArr;
	}
	public void setAcEduNoArr(String[] acEduNoArr) {
		this.acEduNoArr = acEduNoArr;
	}
	
}
