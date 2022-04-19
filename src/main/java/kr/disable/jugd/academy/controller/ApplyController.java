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
@RequestMapping("/apply/")
public class ApplyController {

	private Logger logger = LoggerFactory.getLogger(ApplyController.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private EduService eduService;
	
	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private CertService certService;
	
	
	/**
	 * 신청 상태 및 수료 현황
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/history")
	public String applyJudgeHistory(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		List<ApplyVO> applyList = null;
		List<CodeVO> applyStateList = null;
		List<CodeVO> judgeKindList = null;
		int applyListCnt = 0;
		
		HttpSession session = request.getSession();
		JudgeVO judgeInfo = (JudgeVO) session.getAttribute("USER");
		
		if(search.getYear() == null || "".equals(search.getYear())) {
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		
		// 수강신청 날짜와 비교하기 위한 오늘 날짜
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		
		paramMap.put("year", search.getYear());
        paramMap.put("judgeNo", judgeInfo.getJudgeNo());
        paramMap.put("groupCode", Constants.APPLY_STATE); // 수강 상태
        
		try {
			applyStateList = commonService.selectCommonCode(paramMap);
			paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
			judgeKindList = commonService.selectCommonCode(paramMap);
			
			applyListCnt = applyService.selectJudgeApplyListCnt(paramMap);
			paramMap.put("applyListCnt", applyListCnt);
			applyList = applyService.selectJudgeApplyList(paramMap);

		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("search", search);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("judgeInfo", judgeInfo);
		model.addAttribute("applyList", applyList);
		model.addAttribute("applyListCnt", applyListCnt);
		model.addAttribute("applyStateList", applyStateList);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "judge/apply/history";
	}
	
	/**
	 * 신청 확정 관리
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/confirm")
	public String applyAdminConfirm(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		Map<String, Object> paramMap = new HashMap<>();
		List<ApplyVO> applyList = null;
		List<EduVO> eduTitleList = null;
		List<CodeVO> applyStateList = null;
		List<CodeVO> judgeKindList = null;
		List<AdminVO> adminList = null;
		int applyListCnt = 0;
		
		if(search.getYear() == null || "".equals(search.getYear())) {
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		
		String[] codeList = {Constants.APPLY_STATE_APPLY_WAIT, Constants.APPLY_STATE_APPLY_COMP}; // 신청, 신청확정만 필요
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
			applyStateList = commonService.selectCommonCode(paramMap); // 신청상태(selectBox)
			adminList = adminService.selectAdminList();
			
			applyListCnt = applyService.selectAdminApplyListCnt(paramMap);
			paramMap.put("applyListCnt", applyListCnt);
			applyList = applyService.selectAdminApplyList(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("adminInfo", adminInfo);
		model.addAttribute("adminList", adminList);
		model.addAttribute("search", search);
		model.addAttribute("applyList", applyList);
		model.addAttribute("applyListCnt", applyListCnt);
		model.addAttribute("eduTitleList", eduTitleList);
		model.addAttribute("applyStateList", applyStateList);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "admin/apply/confirm";
	}
	
	/**
	 * 신청확정
	 * @param request
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/approve")
	@ResponseBody
	public Map<String, Object> applyAdminApprove(HttpServletRequest request, @RequestBody ApplyVO apply) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		List<ApplyVO> applyList = null;
		
		// 신청확정 insert 파라미터
		apply.setState(Constants.APPLY_STATE_APPLY_COMP); // 신청확정
		apply.setApplyConfirmId(adminInfo.getAdminId());
		apply.setApplyNoArr(apply.getApplyNo().split(","));
		
		try {
			// 신청확정 로직
			result = applyService.updateApplyState(apply);
			
			// 신청확정 = 수료대기로 보며 수료 테이블에 insert해준다.
			if(result > 0) {
				applyList = applyService.selectApplyListByApplyNo(apply);
				
				if(!applyList.isEmpty()) {
					for(ApplyVO applyInfo : applyList) {
						// 수료 테이블 insert 파라미터
						apply.setJudgeNo(applyInfo.getJudgeNo());
						apply.setJudgeName(applyInfo.getJudgeName());
						apply.setJudgeKind(applyInfo.getJudgeKind());
						apply.setAcEduId(applyInfo.getAcEduId());
						apply.setRegId(adminInfo.getAdminId());
						
						certService.insertCertInfo(apply);
					}
				}
			}
			resultMap.put("result", result);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return resultMap;
	}
	
	/**
	 * 확정취소
	 * @param request
     * @return
     * @throws Exception
	 */
	@RequestMapping("cancel/confirm")
	@ResponseBody
	public Map<String, Object> applyCancelConfirm(HttpServletRequest request, @RequestBody ApplyVO apply) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0; //변경 할 건수 확인용
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		//로그인 정보
		
		// 신청확정(02) -> 신청(01)으로 update
		apply.setState(Constants.APPLY_STATE_APPLY_WAIT); // 신청(01) 으로 state 값 변경
		apply.setModId(adminInfo.getAdminId());			// 확정자는 여기서 set 안해줘도 되지 않나? null을 시킬건데...
		apply.setApplyNoArr(apply.getApplyNo().split(","));	//여러건일 경우, split ','을 이용해 코드를 나눠줌.
		
		try {
			// 확정취소
			result = applyService.updateConfirmCancel(apply);
			//확정취소하려 선택한 건수를 result에 담는다~

			if(result > 0) { //result가 0보다 클 때(1개 이상일 때!)
				List<ApplyVO> deleteList = applyService.selectApplyListByApplyNo(apply);
			// apply no값으로 신청 정보 목록 조회 라는데,
			// 이 값을 가져와 for문 돌림.
				
				for(ApplyVO delete : deleteList) {
					certService.deleteCertInfoByJudgeNoEudId(delete);
					//확정취소 누를 시, 신청확정되어 cert(수료)테이블에 insert된 row삭제
					//연결된 정보 함께 수정해준다.
				}
			}
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("result", result);
		return resultMap;
		//resultMap, result가 담겨있으니 try에 있는 과정들 실행...?
	}
	
	/**
	 * 신청취소
	 * @param request
     * @return
     * @throws Exception
	 */
	@RequestMapping("cancel/apply")
	@ResponseBody
	public Map<String, Object> applyCancelApply(HttpServletRequest request, @RequestBody ApplyVO apply) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		// 신청(01) -> delete
		apply.setModId(adminInfo.getAdminId());
		apply.setApplyNoArr(apply.getApplyNo().split(","));
		
		try {
			// 신청취소
			result = applyService.deleteApplyInfoByApplyNo(apply);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	/**
	 * 신청 관리 목록 엑셀 저장
	 * @param request
	 * @param model
     * @return 
     * @throws Exception
	 */
	@RequestMapping("admin/excel")
	public String adminApplyExcel(Model model, SearchVO search) {
		Map<String, Object> paramMap = new HashMap<>();
		List<ApplyVO> applyList = null;
		List<EduVO> eduTitleList = null;
		List<CodeVO> applyStateList = null;
		List<CodeVO> judgeKindList = null;
		List<AdminVO> adminList = null;
		int applyListCnt = 0;
		
		// 엑셀 파일로 저장할 파일이름
		String fileName = new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(Calendar.getInstance().getTime());
		
		if(search.getYear() == null || "".equals(search.getYear())) {
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		
		String[] codeList = {Constants.APPLY_STATE_APPLY_WAIT, Constants.APPLY_STATE_APPLY_COMP}; // 신청, 신청확정만 필요
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
			
			applyListCnt = applyService.selectAdminApplyListCnt(paramMap);
			paramMap.put("applyListCnt", applyListCnt);
			applyList = applyService.selectAdminApplyList(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("search", search);
		model.addAttribute("fileName", fileName);
		model.addAttribute("adminList", adminList);
		model.addAttribute("applyList", applyList);
		model.addAttribute("applyListCnt", applyListCnt);
		model.addAttribute("eduTitleList", eduTitleList);
		model.addAttribute("applyStateList", applyStateList);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "admin/apply/excel";
	}
	
	/**
	 * 신청 진행상태 값으로 몇 건 있는지 확인
	 * @param apply
     * @return 
     * @throws Exception
	 */
	@RequestMapping("count/state")
	@ResponseBody
	public Map<String, Object> applyCountState(@RequestBody ApplyVO apply) {
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		apply.setStateArr(apply.getState().split(","));
		apply.setApplyNoArr(apply.getApplyNo().split(","));
		
		try {
			result = applyService.selectApplyCountState(apply);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
}
