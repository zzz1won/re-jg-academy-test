package kr.disable.jugd.academy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;

import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.service.CommonService;
import kr.disable.jugd.academy.utils.Constants;
import kr.disable.jugd.academy.utils.Pagination;

@Controller
@RequestMapping("/judge/")
public class JudgeController {

	private Logger logger = LoggerFactory.getLogger(JudgeController.class);
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * 심판 페이지
	 * @param request
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("page")
	public String judgePage(HttpServletRequest request, Model model) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		
		// 로그인 정보
		HttpSession session = request.getSession();
		JudgeVO judgeInfo = (JudgeVO) session.getAttribute("USER");
		
		// 년도
		Calendar now = Calendar.getInstance();
		int currentYear = now.get(Calendar.YEAR); // 현재년도
		int startYear = now.get(Calendar.YEAR)-10; // 시작년도
		// 수강신청 날짜와 비교하기 위한 오늘 날짜
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		
		List<Integer> yearList = new ArrayList<Integer>();
		for(int i=currentYear; i>=startYear; i--) {
			yearList.add(i);
		}
		
		// 페이징(초기값)
		Pagination pagination = new Pagination();
		pagination.setTabMenu(Constants.TAB_EDU);
		
		// 연도
		if(pagination.getYear() != null) {
			paramMap.put("year", pagination.getYear());
		} else {
			pagination.setYear(currentYear);
			paramMap.put("year", currentYear);
		}
		
		try {
			// 심판 종목
			paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판 종목
			List<CodeVO> judgeKindList = commonService.selectCommon(paramMap);
			
			model.addAttribute("nowDate", nowDate);
			model.addAttribute("judgeInfo", judgeInfo);
			model.addAttribute("judgeKindList", judgeKindList);
			model.addAttribute("yearList", yearList);
			model.addAttribute("pagination", pagination);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return "judge/page";
	}
	
}
