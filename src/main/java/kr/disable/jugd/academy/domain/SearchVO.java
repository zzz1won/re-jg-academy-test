package kr.disable.jugd.academy.domain;

import java.util.Date;

public class SearchVO {

	//private Date   regDate;		// 등록일시... 헐 변경하면 이것저것 바뀌는 건 아닌가
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

	/** code 관리용 **/
	private String groupCodeName; //그룹코드명
	//private String codeName; //코드명
	//private String codeListCheck; //검색용

	/** judge 관리용 */
	private String searchArea; //검색칸
	private String searchChkValue; //검색기준

	/** update param2 */
	private String viewSearchChkValue;
	private String viewSearchArea;

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

	/** 0411 추가 **/
	public String getGroupCodeName() { return groupCodeName;	}
	public void setGroupCodeName(String groupCodeName) { this.groupCodeName = groupCodeName; }
	/*public String getCodeName() { return codeName;	}
	public void setCodeName(String codeName) { this.codeName = codeName; }

	public String getCodeListCheck() {		return codeListCheck;	}
	public void setCodeListCheck(String codeListCheck) {  this.codeListCheck = codeListCheck;
	}*/

	/** 0414 심판 검색용 추가*/
	public String getSearchArea() {		return searchArea;	}
	public void setSearchArea(String searchArea) { 		this.searchArea = searchArea;	}
	public String getSearchChkValue() {		return searchChkValue;}
	public void setSearchChkValue(String searchChkValue) {		this.searchChkValue = searchChkValue;	}

	@Override
	public String toString() {
		return "SearchVO{" +
				"regDate=" + regDate +
				", regId='" + regId + '\'' +
				", modDate=" + modDate +
				", modId='" + modId + '\'' +
				", year='" + year + '\'' +
				", eduStatus='" + eduStatus + '\'' +
				", rownum=" + rownum +
				", eduId='" + eduId + '\'' +
				", eduTitle='" + eduTitle + '\'' +
				", acEduTitleMask='" + acEduTitleMask + '\'' +
				", judgeNo='" + judgeNo + '\'' +
				", applyState='" + applyState + '\'' +
				", excelYear='" + excelYear + '\'' +
				", excelEduStatus='" + excelEduStatus + '\'' +
				", excelEduTitle='" + excelEduTitle + '\'' +
				", excelJudgeNo='" + excelJudgeNo + '\'' +
				", excelApplyState='" + excelApplyState + '\'' +
				", updateYear='" + updateYear + '\'' +
				", updateEduStatus='" + updateEduStatus + '\'' +
				", start='" + start + '\'' +
				", end='" + end + '\'' +
				", groupCodeName='" + groupCodeName + '\'' +
				/*", codeName='" + codeName + '\'' +
				", codeListCheck='" + codeListCheck + '\'' +*/
				", searchArea='" + searchArea + '\'' +
				", searchChkValue='" + searchChkValue + '\'' +
				'}';
	}

	public String getViewSearchChkValue() {	return viewSearchChkValue;	}
	public void setViewSearchChkValue(String viewSearchChkValue) {	this.viewSearchChkValue = viewSearchChkValue;	}

	public String getViewSearchArea() {	return viewSearchArea;	}
	public void setViewSearchArea(String viewSearchArea) {	this.viewSearchArea = viewSearchArea;	}
}
