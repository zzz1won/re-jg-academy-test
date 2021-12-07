package kr.disable.jugd.academy.domain;

import java.sql.Date;

public class JudgeVO {

	private Integer acEduCertInfoNo;
	private String  judgeNo;
	private String  judgeName;
	private String  judgeKind;
	private String  acEduId;
	private String  acEduCertFilePath;
	private Date    regDate;
	private String  regId;
	private Date    modDate;
	private String  modId;
	
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
}
