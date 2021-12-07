package kr.disable.jugd.academy.domain;

public class CodeVO extends SearchVO {

	private Integer commonCodeNo;
	private String  groupCode;
	private String  groupCodeName;
	private String  code;
	private String  codeName;
	private String  etcInfo;
	private Integer displayOrder;
	
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
}
