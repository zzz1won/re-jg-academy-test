package kr.disable.jugd.academy.controller;

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
import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.domain.SearchVO;
import kr.disable.jugd.academy.service.CommonService;
import kr.disable.jugd.academy.service.JudgeService;
import kr.disable.jugd.academy.utils.Constants;

@Controller
@RequestMapping("/judge/")
public class JudgeController {

	private Logger logger = LoggerFactory.getLogger(EduController.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private JudgeService judgeService;
	
	/**
	 * 심판 목록 화면
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/judgeMemberList")
	public String judgeMemberList(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		System.out.println("@#@#@#@#@# admin/judgeMemberList @#@#@#");
		Map<String, Object> paramMap = new HashMap<>();
		List<JudgeVO> judgeMemberList = null;
		List<CodeVO> judgeKindList = null;
		int judgeMemberListCnt = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
		
		try {
			judgeKindList = commonService.selectCommonCode(paramMap);
			paramMap.put("groupCode", Constants.EDU_STATUS); // 교육과정 상태
			judgeMemberListCnt = judgeService.selectJudgeMemberListCnt(paramMap);
			paramMap.put("judgeMemberListCnt", judgeMemberListCnt);
			judgeMemberList = judgeService.selectJudgeMemberList(paramMap);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("adminInfo", adminInfo);
		model.addAttribute("judgeKindList", judgeKindList);
		model.addAttribute("judgeMemberList", judgeMemberList);
		model.addAttribute("judgeMemberListCnt", judgeMemberListCnt);
		
		return "admin/judge/judgeInfo";
	}
	
	/**
	 * 심판 vue 목록 화면
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/judgeMemberListVue")
	public String judgeMemberListVue(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		System.out.println("@#@#@#@#@# admin/judgeMemberListVue @#@#@#");
		
		return "admin/judge/judgeInfoVue";
	}
	
	/**
	 * 심판 vue 목록 조회
	 */
	@RequestMapping("admin/selectJudgeMemberList")
	@ResponseBody
	public Map<String, Object> selectJudgeMemberList(@RequestBody JudgeVO judgeInfo, HttpServletRequest request) {
		
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
		
		resultMap.put("adminInfo", adminInfo);
		resultMap.put("judgeKindList", commonService.selectCommonCode(paramMap));
		resultMap.put("resultCnt", judgeService.selectJudgeMemberListCnt(paramMap));
		resultMap.put("result", judgeService.selectJudgeMemberList(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 심판 수정 화면 이동
	 * @param eduInfo
	 * @param request
     * @return resultMap
     * @throws Exception
	 */
	@RequestMapping("admin/updateJudgePage")
	public String updateJudgePage(HttpServletRequest request, Model model, JudgeVO judgeInfo) {
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		List<CodeVO> judgeKindList = null;
		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
		
		try {
			judgeInfo = judgeService.selectJudgeInfo(judgeInfo);
			judgeKindList = commonService.selectCommonCode(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}

		model.addAttribute("judgeInfo", judgeInfo);
		model.addAttribute("adminInfo", adminInfo);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "admin/judge/update";
	}
	
	/**
	 * 심판 정보 수정
	 * @param eduInfo
	 * @param request
     * @return resultMap
     * @throws Exception
	 */
	@RequestMapping("admin/update")
	@ResponseBody
	public Map<String, Object> updateJudgeInfo(@RequestBody JudgeVO judgeInfo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		judgeInfo.setModId(adminInfo.getAdminId());
		
		try {
			result = judgeService.updateJudgeInfo(judgeInfo);
			resultMap.put("result", result);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return resultMap;
	}

}
