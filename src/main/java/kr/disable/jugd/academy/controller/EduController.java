package kr.disable.jugd.academy.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
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
import kr.disable.jugd.academy.service.CommonService;
import kr.disable.jugd.academy.service.EduService;
import kr.disable.jugd.academy.utils.Constants;
import kr.disable.jugd.academy.utils.FunctionUtil;

@Controller
@RequestMapping("/edu/")
public class EduController {

	private Logger logger = LoggerFactory.getLogger(EduController.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private EduService eduService;
	
	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private AdminService adminService;
	
	/**
	 * 교육 일정
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/schedule")
	public String judgeEduSchedule(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		List<EduVO> eduList = null;
		List<CodeVO> judgeKindList = null;
		List<CodeVO> eduStatusList = null;
		int eduListCnt = 0;
		
		HttpSession session = request.getSession();
		JudgeVO judgeInfo = (JudgeVO) session.getAttribute("USER");
		
		if(search.getYear() == null || "".equals(search.getYear())) {
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		
		paramMap.put("year", search.getYear());
		paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
		paramMap.put("judgeNo", judgeInfo.getJudgeNo());
		
		try {
			judgeKindList = commonService.selectCommonCode(paramMap);
			paramMap.put("groupCode", Constants.EDU_STATUS); // 교육과정 상태
			eduStatusList = commonService.selectCommonCode(paramMap);
			eduListCnt = eduService.selectJudgeEduListCnt(paramMap);
			paramMap.put("eduListCnt", eduListCnt);
			eduList = eduService.selectJudgeEduList(paramMap);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("search", search);
		model.addAttribute("judgeInfo", judgeInfo);
		model.addAttribute("judgeKindList", judgeKindList);
		model.addAttribute("eduStatusList", eduStatusList);
		model.addAttribute("eduList", eduList);
		model.addAttribute("eduListCnt", eduListCnt);
		
		return "judge/edu/schedule";
	}
	
	/**
	 * 수강신청
	 * @param apply
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/register")
	@ResponseBody
	public Map<String, Object> judgeEduRegister(HttpServletRequest request, @RequestBody ApplyVO apply) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		JudgeVO judge = (JudgeVO) session.getAttribute("USER");
		
		apply.setJudgeNo(judge.getJudgeNo());
		apply.setJudgeName(judge.getJudgeName());
		apply.setJudgeKind(judge.getJudgeKind());
		
		try {
			// 신청한 과목이 있는지 확인
			int checkDupApply = applyService.checkDupApply(apply);
			
			if(checkDupApply < 1) {
				// 신청 로직
				result = applyService.insertApply(apply);
			}
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	/**
	 * 교육 상세
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/detail")
	public String judgeEduDetail(Model model, @RequestBody EduVO edu) throws Exception{
		EduVO eduInfo = new EduVO();
		
		try {
			eduInfo = eduService.selectEduInfo(edu);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("eduInfo", eduInfo);
		
		return "judge/edu/detail";
	}
	
	
	/**
	 * 교육 일정 관리
	 * @param request
	 * @param model
	 * @param //pagination
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/schedule")
	public String adminEduSchedule(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		List<EduVO> eduList = null;
		List<CodeVO> eduStatusList = null;
		List<AdminVO> adminList = null;
		int eduListCnt = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		if(search.getYear() == null || "".equals(search.getYear())) {
			search.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		
		paramMap.put("year", search.getYear());
		paramMap.put("eduStatus", search.getEduStatus());
        paramMap.put("groupCode", Constants.EDU_STATUS); // 교육과정 상태
        
		try {
			eduListCnt = eduService.selectAdminEduListCnt(paramMap);
			paramMap.put("eduListCnt", eduListCnt); // 게시글 순번을 구하기 위해 총 게시글 수가 필요하다.
			eduList = eduService.selectAdminEduList(paramMap);
			eduStatusList = commonService.selectCommonCode(paramMap);
			adminList = adminService.selectAdminList();
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("search", search);
		model.addAttribute("adminInfo", adminInfo);
		model.addAttribute("adminList", adminList);
		model.addAttribute("eduList", eduList);
		model.addAttribute("eduListCnt", eduListCnt);
		model.addAttribute("eduStatusList", eduStatusList);
		
		return "admin/edu/schedule";
	}
	
	/**
	 * 신규 교육과정 등록 화면 이동
	 * @param //eduInfo
	 * @param request
     * @return resultMap
     * @throws Exception
	 */
	@RequestMapping("admin/registerPage")
	public String registerPage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		
		model.addAttribute("adminInfo", adminInfo);
		return "admin/edu/register";
	}
	
	/**
	 * 교육과정 등록
	 * @param eduInfo
	 * @param request
     * @return resultMap
     * @throws Exception
	 */
	@RequestMapping("admin/register")
	@ResponseBody
	public Map<String, Object> insertEduSchedule(@RequestBody EduVO eduInfo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		String eduId = "";
		int checkDupEduId = 0;
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		eduInfo.setRegId(adminInfo.getAdminId());
		eduInfo.setModId(adminInfo.getAdminId());
		
		try {
			// insert
			// edu id를 랜덤으로 생성
			while(true) {
				eduId = FunctionUtil.createRandom();
				
				// 중복체크
				checkDupEduId = eduService.checkDupEduId(eduId);
				if(checkDupEduId < 1) break;
			}
			
			eduInfo.setAcEduSeq(eduService.selectEduSeq());
			eduInfo.setAcEduId(eduId);
			result = eduService.insertEduSchedule(eduInfo);
			resultMap.put("result", result);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return resultMap;
	}
	
	/**
	 * 신규 교육과정 등록 화면 이동
	 * @param eduInfo
	 * @param request
     * @return resultMap
     * @throws Exception
	 */
	@RequestMapping("admin/updatePage")
	public String updatePage(HttpServletRequest request, Model model, EduVO eduInfo) {
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		String year = eduInfo.getUpdateYear();
		String eduStatus = eduInfo.getUpdateEduStatus();
		
		// 시작일자, 종료일자(시작일자 +7일) 설정
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());

		try {
			eduInfo = eduService.selectEduInfo(eduInfo);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}

		System.out.println("year: "+year);
		System.out.println("eduStatus: "+eduStatus);
		model.addAttribute("year", year);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("eduStatus", eduStatus);
		model.addAttribute("eduInfo", eduInfo);
		model.addAttribute("adminInfo", adminInfo);
		
		return "admin/edu/update";
	}
	
	/**
	 * 교육과정 수정
	 * @param eduInfo
	 * @param request
     * @return resultMap
     * @throws Exception
	 */
	@RequestMapping("admin/update")
	@ResponseBody
	public Map<String, Object> updateEduSchedule(@RequestBody EduVO eduInfo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
		eduInfo.setModId(adminInfo.getAdminId());
		
		try {
			result = eduService.updateEduSchedule(eduInfo);
			resultMap.put("result", result);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return resultMap;
	}
	
	/**
	 * 교육과정 삭제
	 * @param //request
	 * @param //model
     * @return
     * @throws Exception
	 */
	@RequestMapping("admin/delete")
	@ResponseBody
	public Map<String, Object> deleteEduSchedule(@RequestBody EduVO edu) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		List<EduVO> eduIdList = null;
		ApplyVO apply = new ApplyVO();
		String eduIdArr = "";
		int result = 0;
		
		edu.setAcEduNoArr(edu.getAcEduNo().split(","));
		
		try{
			eduIdList = eduService.selectEduIdByEduScheduleNo(edu);
			for(EduVO eduId : eduIdList) {
				// edu에서 no로 id값을 가지고온다.
				eduIdArr += eduId.getAcEduId() + ",";
			}
			apply.setAcEduIdArr(eduIdArr.split(","));
			
			result = eduService.deleteEduSchedule(edu);
			if(result > 0) 	applyService.deleteApplyInfoByEduId(apply); // 교육일정 삭제시 과거에 심판이 삭제될 교육과정을 신청한 정보도 모두 삭제
			
			resultMap.put("result", result);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return resultMap;
	}
	
	/**
	 * 교육과정 엑셀 저장
	 * @param //request
	 * @param model
     * @return 
     * @throws Exception
	 */
	@RequestMapping("admin/excel")
	public String adminEduScheduleExcel(Model model, SearchVO search) {
		Map<String, Object> paramMap = new HashMap<>();
		List<EduVO> eduList = null;
		List<AdminVO> adminList = null;
		List<CodeVO> eduStatusList = null;
		int eduListCnt = 0;
		
		// 엑셀 파일로 저장할 파일이름
		String fileName = new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(Calendar.getInstance().getTime());
		
		paramMap.put("year", search.getExcelYear());
		paramMap.put("eduStatus", search.getExcelEduStatus());
        paramMap.put("groupCode", Constants.EDU_STATUS); // 교육과정 상태
        
        try {
        	eduListCnt = eduService.selectAdminEduListCnt(paramMap);
        	if(eduListCnt > 0) {
        		paramMap.put("eduListCnt", eduListCnt); // 게시글 순번을 구하기 위해 총 게시글 수가 필요하다.
            	eduList = eduService.selectAdminEduList(paramMap);
            	adminList = adminService.selectAdminList();
            	eduStatusList = commonService.selectCommonCode(paramMap);
        	}
        	
        } catch(Exception e) {
        	logger.debug(e.getMessage());
        }
		
        model.addAttribute("fileName", fileName);
        model.addAttribute("eduList", eduList);
        model.addAttribute("eduListCnt", eduListCnt);
        model.addAttribute("adminList", adminList);
        model.addAttribute("eduStatusList", eduStatusList);
        
		return "admin/edu/excel";
	}

	//0502
	/** 새로운 과제~
	 * @param searchVO, model, request
	 * @return string, "judge/edu/schedule2"
	 * @throws //Exception
	 *  */
	@RequestMapping("judge/schedule2")
	//@ResponseBody
	public String newEduSchedule(SearchVO searchVO, Model model, HttpServletRequest request) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		HttpSession session = request.getSession();
		JudgeVO judgeInfo = (JudgeVO) session.getAttribute("USER");

		if(searchVO.getYear()==null || "".equals(searchVO.getYear())){
			searchVO.setYear( new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()) );
		}
		List<CodeVO> judgeKindList = null;
		//List<EduVO> eduVO = null;

		paramMap.put("year", searchVO.getYear());
		paramMap.put("groupCode", Constants.JUDGE_KIND); //심판 종목 표기를 위해
		paramMap.put("judgeNo", judgeInfo.getJudgeNo()); //심판 고유번호 표기를 위해
		judgeKindList = commonService.selectCommonCode(paramMap); //심판종목 가져오기 위해
		//eduVO = eduService.selectJudgeEduList(paramMap);
		paramMap.put("groupCode", Constants.EDU_STATUS); // 교육과정 상태

		System.out.println("0502 새로운 과제 후덜덜 😎 ..");
		model.addAttribute("judgeInfo",judgeInfo); //세션정보 띄움
		model.addAttribute("judgeKindList",judgeKindList); //심판종목 담아 띄움
		model.addAttribute("searchVO", searchVO); //연도 및 주 내용들이 담긴 VO
		//model.addAttribute("EduVO", eduVO);
		return "judge/edu/may2nd";
	}

	@RequestMapping("judge/schedule2Ajax")
	@ResponseBody
	public Map<String, Object> newEduScheduleAjax (@RequestBody SearchVO searchVO, Model model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		JudgeVO judgeInfo = (JudgeVO) session.getAttribute("USER");
		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("year", searchVO.getYear());
		paramMap.put("groupCode", Constants.JUDGE_KIND); //심판 종목 표기를 위해
		paramMap.put("judgeNo",judgeInfo.getJudgeNo());
		/*기본자료*/

		List<EduVO> eduList = null;
		List<CodeVO> eduStatusList = null;
		int eduListCnt = 0;

		/* ajax로 넘기고싶은 애들 */
		eduStatusList = commonService.selectCommonCode(paramMap);
		paramMap.put("eduStatusList",eduStatusList);
		paramMap.put("groupCode", Constants.EDU_STATUS); // 교육과정 상태
		eduListCnt = eduService.selectJudgeEduListCnt(paramMap);
		paramMap.put("eduListCnt", eduListCnt);

		eduList = eduService.selectJudgeEduList(paramMap);
		paramMap.put("eduList", eduList);
		/* ajax로 넘기고싶은 값 */

		int result = 0;
		result = eduService.selectJudgeEduListCnt(paramMap);

		paramMap.put("result",result);
		//model.addAttribute("eduList", eduList);
		model.addAttribute("searchVO",searchVO);
		return paramMap;
	}

	@RequestMapping("judge/detailAjax")
	@ResponseBody
	public Map<String, Object> detailPageAjax (@RequestBody EduVO edu) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		EduVO eduInfo = new EduVO();
		eduInfo = eduService.selectEduInfo(edu);
		resultMap.put("eduInfo",eduInfo);

		return resultMap;
	}



}
