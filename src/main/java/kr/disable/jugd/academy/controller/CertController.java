package kr.disable.jugd.academy.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.ApplyVO;
import kr.disable.jugd.academy.domain.CertVO;
import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.domain.EduVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.domain.SearchVO;
import kr.disable.jugd.academy.service.AdminService;
import kr.disable.jugd.academy.service.ApplyService;
import kr.disable.jugd.academy.service.CertService;
import kr.disable.jugd.academy.service.CommonService;
import kr.disable.jugd.academy.service.EduService;
import kr.disable.jugd.academy.utils.Constants;

@Controller
@RequestMapping("/cert/")
public class CertController {

	private Logger logger = LoggerFactory.getLogger(CertController.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private EduService eduService;
	
	@Autowired
	private ApplyService applyService;	
	
	@Autowired
	private CertService certService;
	
	@Autowired
	private AdminService adminService;
	
	/**
	 * 관리자가 등록한 수료증 미리보기 및 출력
	 * @param request
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/certificate")
	public String certificate(HttpServletRequest request, Model model) {
		String applyNo = (String) request.getParameter("applyNo");
		
		HttpSession session = request.getSession();
		JudgeVO judge = (JudgeVO) session.getAttribute("USER");
		
		Map<String, Object> paramMap = new HashMap<>();
		ApplyVO certInfo = new ApplyVO();
		List<CodeVO> judgeKindList = null;
		
		// 발급번호(yyyy)
		String year = new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime());
		// 수료증 미리보기 & 발급 날짜
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		// pdf로 변환할 파일 이름
		String fileName = new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(Calendar.getInstance().getTime());
		
		paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
		paramMap.put("judgeNo", judge.getJudgeNo());
		paramMap.put("eduApplyInfoNo", applyNo);
		
		try {
			judgeKindList = commonService.selectCommonCode(paramMap);
			certInfo = certService.selectCertInfo(paramMap);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}

		model.addAttribute("year", year);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("fileName", fileName);
		model.addAttribute("certInfo", certInfo);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "judge/cert/certificate";
	}
	
	/**
	 * 수료 관리 화면
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/confirm")
	public String certAdminConfirm(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		Map<String, Object> paramMap = new HashMap<>();
		List<CertVO> certList = null;
		List<EduVO> eduTitleList = null;
		List<CodeVO> applyStateList = null;
		List<CodeVO> judgeKindList = null;
		List<AdminVO> adminList = null;
		int certListCnt = 0;
		
		if(search.getYear() == null || "".equals(search.getYear())) { //Year값이 null이거나 ""일 때!
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) ); //yyyy형식으로 Calendar.getInstance().getTime() 현재시간 구하기
		}
		
		// 02: 신청확정(수료대기), 03: 수료확정, 05: 미수료
		String[] codeList = {Constants.APPLY_STATE_APPLY_COMP, Constants.APPLY_STATE_CERT_COMP, Constants.APPLY_STATE_CERT_NOT};
		
		paramMap.put("year", search.getYear());
		paramMap.put("eduTitle", search.getEduTitle());
		paramMap.put("applyState", search.getApplyState());
		paramMap.put("judgeNo", search.getJudgeNo());
		
		try {
			paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
			judgeKindList = commonService.selectCommonCode(paramMap);
			paramMap.put("groupCode", Constants.APPLY_STATE); // 수강 상태
			paramMap.put("codeList", codeList);
			eduTitleList = eduService.selectEduTitleListByYear(paramMap); // 교육과정 목록(selectBox)
			applyStateList = commonService.selectCommonCode(paramMap); // 수료상태(selectBox)
			adminList = adminService.selectAdminList();
			
			certListCnt = certService.selectCertListCnt(paramMap);
			paramMap.put("certListCnt", certListCnt);
			certList = certService.selectCertList(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("adminInfo", adminInfo);
		model.addAttribute("adminList", adminList);
		model.addAttribute("search", search);
		model.addAttribute("certList", certList);
		model.addAttribute("certListCnt", certListCnt);
		model.addAttribute("eduTitleList", eduTitleList);
		model.addAttribute("applyStateList", applyStateList);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "admin/cert/confirm";
	}
	
	/**
	 * 수료 확정 및 미수료 처리
	 * @param request
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/decide")
	@ResponseBody
	public Map<String, Object> certAdminDecide(HttpServletRequest request, @RequestBody CertVO cert) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		cert.setCertConfirmId(adminInfo.getAdminId());
		cert.setCertNoArr(cert.getCertNo().split(","));
		cert.setApplyNoArr(cert.getApplyNo().split(","));
		
		if("cert".equals(cert.getState())) {
			cert.setState(Constants.APPLY_STATE_CERT_COMP);	// 수료 확정
		} else if("noCert".equals(cert.getState())) {
			cert.setState(Constants.APPLY_STATE_CERT_NOT);	// 미수료
		}
		
		try {
			// 수료 확정 / 미수료 처리
			result = certService.updateCertState(cert); // 0: 성공, 1: 실패
			resultMap.put("result", result);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return resultMap;
	}
	
	/**
	 * 수료 관리 목록 엑셀 저장
	 * @param request
	 * @param model
     * @return 
     * @throws Exception
	 */
	@RequestMapping("admin/excel")
	public String certAdminExcel(Model model, SearchVO search) {
		Map<String, Object> paramMap = new HashMap<>();
		List<CertVO> certList = null;
		List<EduVO> eduTitleList = null;
		List<CodeVO> applyStateList = null;
		List<CodeVO> judgeKindList = null;
		List<AdminVO> adminList = null;
		int certListCnt = 0;
		
		if(search.getYear() == null || "".equals(search.getYear())) {
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		
		// 엑셀 파일로 저장할 파일이름
		String fileName = new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(Calendar.getInstance().getTime());
		
		// 02: 신청확정, 03: 수료확정, 05: 미수료
		String[] codeList = {Constants.APPLY_STATE_APPLY_COMP, Constants.APPLY_STATE_CERT_COMP, Constants.APPLY_STATE_CERT_NOT};
		paramMap.put("year", search.getExcelYear());
		paramMap.put("eduTitle", search.getExcelEduTitle());
		paramMap.put("applyState", search.getExcelApplyState());
		paramMap.put("judgeNo", search.getExcelJudgeNo());
		
		try {
			paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
			judgeKindList = commonService.selectCommonCode(paramMap);
			paramMap.put("groupCode", Constants.APPLY_STATE); // 수강 상태
			paramMap.put("codeList", codeList);
			eduTitleList = eduService.selectEduTitleListByYear(paramMap); // 교육과정 목록(selectBox)
			applyStateList = commonService.selectCommonCode(paramMap); // 신청상태(selectBox)
			adminList = adminService.selectAdminList();
			
			certListCnt = certService.selectCertListCnt(paramMap);
			paramMap.put("certListCnt", certListCnt);
			certList = certService.selectCertList(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("fileName", fileName);
		model.addAttribute("search", search);
		model.addAttribute("adminList", adminList);
		model.addAttribute("certList", certList);
		model.addAttribute("certListCnt", certListCnt);
		model.addAttribute("eduTitleList", eduTitleList);
		model.addAttribute("applyStateList", applyStateList);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "admin/cert/excel";
	}
	
	/**
	 * 등록된 수료증 미리보기 팝업
	 * @param model
     * @return
	 * @throws Exception 
	 */
	@RequestMapping("popup/view")
	public String viewCert(HttpServletRequest request, Model model) throws Exception {
		String certNo =(String) request.getParameter("certNo");
		CertVO certInfo = new CertVO();
		
		try {
			certInfo = certService.selectCertPath(Integer.parseInt(certNo));
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("certInfo", certInfo);
		model.addAttribute("certNo", certNo);
		return "admin/cert/view";
	}
	
	/**
	 * 확정취소(수료확정, 미수료 상태를 취소하여 신청확정으로 되돌린다.)
	 * @param request
     * @return
     * @throws Exception
	 */
	@RequestMapping("cancel/cert")
	@ResponseBody
	public Map<String, Object> applyCancelApply(HttpServletRequest request, @RequestBody CertVO cert) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		// 확정취소
		cert.setModId(adminInfo.getAdminId());
		cert.setState(Constants.APPLY_STATE_APPLY_COMP); // 신청확정
		cert.setApplyNoArr(cert.getApplyNo().split(","));
		cert.setCertNoArr(cert.getCertNo().split(","));
		
		try {
			// 수료확정(03) 또는 미수료(05)를 신청확정(02)으로 되돌린다.
			result = applyService.updateApplyInfoByApplyNoArr(cert);
			
			if(result > 0) {
				// 수료증 파일 경로값, 파일등록시간, 파일등록자 값 null로 수정
				result = certService.updateCertInfoByCertNoArr(cert);
			}
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
}
