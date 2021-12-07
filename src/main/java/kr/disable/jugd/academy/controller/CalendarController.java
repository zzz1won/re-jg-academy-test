package kr.disable.jugd.academy.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
@RequestMapping("/calendar/")
public class CalendarController {

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
	
	@RequestMapping("judge/calendarList")
	public String calendarList(HttpServletRequest request, Model model, SearchVO search) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		List<CodeVO> judgeKindList = null;
		
		// List<EduVO> holidayList = null;
		
		HttpSession session = request.getSession();
		JudgeVO judgeInfo = (JudgeVO) session.getAttribute("USER");
		
        paramMap.put("judgeNo", judgeInfo.getJudgeNo());
        paramMap.put("groupCode", Constants.APPLY_STATE); // 수강 상태
        
		try {
			paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목
			judgeKindList = commonService.selectCommonCode(paramMap);
			// holidayList = eduService.selectHolidayList(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("search", search);
		model.addAttribute("judgeInfo", judgeInfo);
		model.addAttribute("judgeKindList", judgeKindList);
		
		// model.addAttribute("holidayList", holidayList);
		
		return "judge/calendar/calendarList";
	}
	
	@RequestMapping("judge/getCalendar")
	@ResponseBody
	public Map<String, Object> getCalendar(HttpServletRequest request, SearchVO search) {
		
		System.out.println("@#@#@# search : " + search.getStart());
		System.out.println("@#@#@# search : " + search.getEnd());
		
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		
		List<EduVO> eduList = null;

		paramMap.put("start", search.getStart());
		paramMap.put("end", search.getEnd());
		try {
			eduList = eduService.selectJudgeEduCalendar(paramMap);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("result", eduList);
		return resultMap;
	}
	
	@RequestMapping("judge/getHoliday")
	@ResponseBody
	public Map<String, Object> getHoliday(HttpServletRequest request, SearchVO search) {
		
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		
		List<EduVO> holidayList = null;
		
		paramMap.put("start", search.getStart());
		paramMap.put("end", search.getEnd());
		
		try {
			holidayList = eduService.selectHolidayList(paramMap);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		resultMap.put("result", holidayList);
		return resultMap;
	}
	
	@RequestMapping("judge/calendarDetail")
	public String calendarDetail(Model model, @RequestBody EduVO edu) throws Exception{
		EduVO eduInfo = new EduVO();
		String year = eduInfo.getUpdateYear();
		String eduStatus = eduInfo.getUpdateEduStatus();
		
		// 시작일자, 종료일자(시작일자 +7일) 설정
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());

		try {
			eduInfo = eduService.selectEduInfo(edu);
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		model.addAttribute("year", year);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("eduStatus", eduStatus);
		model.addAttribute("eduInfo", eduInfo);
		
		return "judge/calendar/calendarDetail";
	}
	
}
