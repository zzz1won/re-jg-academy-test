package kr.disable.jugd.academy.domain;

public class CodeVO extends SearchVO {

	private Integer commonCodeNo; //No
	private String  groupCode; //그룹코드값
	private String  groupCodeName; //그룹코드명
	private String  code; //코드값
	private String  codeName; //코드명
	private String  etcInfo; //비고
	private Integer displayOrder; //순서
	/** codeNo 코드삭제시 필요(eduNo참고) */
	private String codeNo;
	/** codeNoArr 코드삭제시 필요(eduNo참고) */
	private String[] codeNoArr;

	
	public Integer getCommonCodeNo() {
		return commonCodeNo;
	}
	public void setCommonCodeNo(Integer commonCodeNo) {
		this.commonCodeNo = commonCodeNo;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public String getGroupCodeName() {
		return groupCodeName;
	}
	public void setGroupCodeName(String groupCodeName) {
		this.groupCodeName = groupCodeName;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getEtcInfo() {
		return etcInfo;
	}
	public void setEtcInfo(String etcInfo) {
		this.etcInfo = etcInfo;
	}
	public Integer getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}

	/* 0412 코드삭제용 추가 */
	public String getCodeNo() {	return codeNo;	}
	public void setCodeNo(String codeNo) {	this.codeNo = codeNo;	}
	public String[] getCodeNoArr() {	return codeNoArr;	}
	public void setCodeNoArr(String[] codeNoArr) {		this.codeNoArr = codeNoArr;	}
}
