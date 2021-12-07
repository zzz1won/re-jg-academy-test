package kr.disable.jugd.academy.domain;

public class AdminVO extends SearchVO {

	private String adminId;
	private String adminPw;
	private String adminName;
	private String adminDept;
	private String adminEtcInfo;
	private String useYn;
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminDept() {
		return adminDept;
	}
	public void setAdminDept(String adminDept) {
		this.adminDept = adminDept;
	}
	public String getAdminEtcInfo() {
		return adminEtcInfo;
	}
	public void setAdminEtcInfo(String adminEtcInfo) {
		this.adminEtcInfo = adminEtcInfo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
}
