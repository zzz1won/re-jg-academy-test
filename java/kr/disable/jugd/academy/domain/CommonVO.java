package kr.disable.jugd.academy.domain;

import java.sql.Date;

public class CommonVO {

	private Integer commonCodeNo;
	private String  groupCode;
	private String  groupCodeName;
	private String  code;
	private String  codeName;
	private String  etcInfo;
	private String  regId;
	private Date    regDate;
	
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
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
