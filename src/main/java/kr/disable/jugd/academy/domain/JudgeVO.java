package kr.disable.jugd.academy.domain;

public class JudgeVO extends SearchVO {

	private String  judgeNo;
	private String  judgeName;
	private String  judgeKind;
	private String  phoneNumber;
	private String  judgeMemo;
	
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
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getJudgeMemo() {
		return judgeMemo;
	}
	public void setJudgeMemo(String judgeMemo) {
		this.judgeMemo = judgeMemo;
	}
}
