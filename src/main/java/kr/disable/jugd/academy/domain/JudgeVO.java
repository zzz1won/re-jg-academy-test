package kr.disable.jugd.academy.domain;

import java.util.Date;

public class JudgeVO extends SearchVO {

	private String  judgeNo;
	private String  judgeName;
	private String  judgeKind;
	private String  phoneNumber;
	private String  judgeMemo;
	/**0414 추가*/
	private String judgeEtc; //비고
	private String judgeState; //계정사용여부
	private Date regDate; //등록일
	/**0415 추가, 계정체크 여러개 */
	private String judgeChkNo;
	private String[] judgeNoArr;

	
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

	public String getJudgeEtc() {	return judgeEtc;	}
	public void setJudgeEtc(String judgeEtc) {	this.judgeEtc = judgeEtc;	}
	public String getJudgeState() {		return judgeState;	}
	public void setJudgeState(String judgeState) {		this.judgeState = judgeState;	}

	public Date getRegDate() {		return regDate;	}
	public void setRegDate(Date regDate) {		this.regDate = regDate;	}

	public String getJudgeChkNo() {		return judgeChkNo;	}
	public void setJudgeChkNo(String judgeChkNo) {		this.judgeChkNo = judgeChkNo;	}
	public String[] getJudgeNoArr() {		return judgeNoArr;	}
	public void setJudgeNoArr(String[] judgeNoArr) {		this.judgeNoArr = judgeNoArr;	}
}
