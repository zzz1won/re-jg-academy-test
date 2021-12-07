package kr.disable.jugd.academy.domain;

import java.util.Date;

public class SearchVO {

	private Date   regDate;		// 등록일시
	private String regId;		// 등록자 
	private Date   modDate;		// 수정일시
	private String modId;		// 수정자
	
    /** 년도 */
    private String  year;
    /** 교육과정 상태 */
    private String  eduStatus;
    /** rownum(게시글 순번) */
    private Integer rownum;
    /** 교육과정id */
    private String  eduId;
    /** 교육과정명 */
    private String  eduTitle;
    /** 교육과정명 마스크처리 */
    private String  acEduTitleMask;
    /** 심판번호 */
    private String  judgeNo;
    /** 신청상태(01: 신청, 02: 신청확정, 03: 수료확정, 04: 신청취소, 05: 미수료 */
    private String  applyState;
    
    /** Excel param */
    private String  excelYear;
    private String  excelEduStatus;
    private String  excelEduTitle;
    private String  excelJudgeNo;
    private String  excelApplyState;
    
    /** update param */
    private String updateYear;
    private String updateEduStatus;
    
    private String start;
    private String end;
    
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
	public Date getModDate() {
		return modDate;
	}
	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getEduStatus() {
		return eduStatus;
	}
	public void setEduStatus(String eduStatus) {
		this.eduStatus = eduStatus;
	}
	public Integer getRownum() {
		return rownum;
	}
	public void setRownum(Integer rownum) {
		this.rownum = rownum;
	}
	public String getEduId() {
		return eduId;
	}
	public void setEduId(String eduId) {
		this.eduId = eduId;
	}
	public String getEduTitle() {
		return eduTitle;
	}
	public void setEduTitle(String eduTitle) {
		this.eduTitle = eduTitle;
	}
	public String getJudgeNo() {
		return judgeNo;
	}
	public void setJudgeNo(String judgeNo) {
		this.judgeNo = judgeNo;
	}
	public String getApplyState() {
		return applyState;
	}
	public void setApplyState(String applyState) {
		this.applyState = applyState;
	}
	public String getExcelYear() {
		return excelYear;
	}
	public void setExcelYear(String excelYear) {
		this.excelYear = excelYear;
	}
	public String getExcelEduStatus() {
		return excelEduStatus;
	}
	public void setExcelEduStatus(String excelEduStatus) {
		this.excelEduStatus = excelEduStatus;
	}
	public String getExcelEduTitle() {
		return excelEduTitle;
	}
	public void setExcelEduTitle(String excelEduTitle) {
		this.excelEduTitle = excelEduTitle;
	}
	public String getExcelJudgeNo() {
		return excelJudgeNo;
	}
	public void setExcelJudgeNo(String excelJudgeNo) {
		this.excelJudgeNo = excelJudgeNo;
	}
	public String getExcelApplyState() {
		return excelApplyState;
	}
	public void setExcelApplyState(String excelApplyState) {
		this.excelApplyState = excelApplyState;
	}
	public String getUpdateYear() {
		return updateYear;
	}
	public void setUpdateYear(String updateYear) {
		this.updateYear = updateYear;
	}
	public String getUpdateEduStatus() {
		return updateEduStatus;
	}
	public void setUpdateEduStatus(String updateEduStatus) {
		this.updateEduStatus = updateEduStatus;
	}
	public String getAcEduTitleMask() {
		return acEduTitleMask;
	}
	public void setAcEduTitleMask(String acEduTitleMask) {
		this.acEduTitleMask = acEduTitleMask;
	}
}
