package kr.disable.jugd.academy.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.disable.jugd.academy.domain.EduVO;
import kr.disable.jugd.academy.service.EduService;
import kr.disable.jugd.academy.utils.Constants;
import kr.disable.jugd.academy.utils.Pagination;

@Controller
@RequestMapping("/edu/")
public class EduController {

	Logger logger = LoggerFactory.getLogger(EduController.class);
	
	@Autowired
	private EduService eduService;
	
	/**
	 * 교육 일정 및 신청 목록
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/schedule")
	public String eduJudgeSchedule(HttpServletRequest request, Model model, @RequestBody Pagination pagination) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		
		// 수강신청 날짜와 비교하기 위한 오늘 날짜
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		
		// 넘어온 값이 없으면 초기값으로 설정
		if(pagination.getTabMenu() == null || "".equals(pagination.getTabMenu())) pagination.setTabMenu(Constants.TAB_EDU);
		if(pagination.getPageNo() == 0) pagination.setPageNo(1);
		if(pagination.getPageSize() == 0) pagination.setPageSize(5);

        paramMap.put("firstNo", pagination.getPageNo()-1);
        paramMap.put("lastNo", pagination.getPageSize());
        paramMap.put("year", pagination.getYear());
        
		try {
			List<EduVO> eduList = eduService.selectEduList(paramMap);
			int eduListCnt = eduService.selectEduListCnt(paramMap);
			pagination.setTotalCount(eduListCnt);
			
			model.addAttribute("nowDate", nowDate);
			model.addAttribute("eduList", eduList);
			model.addAttribute("eduListCnt", eduListCnt);
			model.addAttribute("pagination", pagination);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return "judge/edu/schedule";
	}
}
