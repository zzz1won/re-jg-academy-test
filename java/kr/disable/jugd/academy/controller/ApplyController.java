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

import kr.disable.jugd.academy.domain.ApplyVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.service.ApplyService;
import kr.disable.jugd.academy.utils.Pagination;

@Controller
@RequestMapping("/apply/")
public class ApplyController {

	Logger logger = LoggerFactory.getLogger(ApplyController.class);
	
	@Autowired
	private ApplyService applyService;
	
	/**
	 * 신청 상태 및 수료 현황
	 * @param model
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/status")
	public String applyJudgeStatus(HttpServletRequest request, Model model, @RequestBody Pagination pagination) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		
		// 수강신청 날짜와 비교하기 위한 오늘 날짜
		String nowDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		
		// 넘어온 값이 있으면 넘어온 값으로 세팅
		if(pagination.getPageNo() == 0) pagination.setPageNo(1);
		if(pagination.getPageSize() == 0) pagination.setPageSize(10);

        paramMap.put("firstNo", pagination.getPageNo()-1);
        paramMap.put("lastNo", pagination.getPageSize());
        paramMap.put("year", pagination.getYear());
        
		try {
			List<ApplyVO> applyList = applyService.selectApplyList(paramMap);
			int applyListCnt = applyService.selectApplyListCnt(paramMap);
			pagination.setTotalCount(applyListCnt);
			
			model.addAttribute("nowDate", nowDate);
			model.addAttribute("eduList", applyList);
			model.addAttribute("eduListCnt", applyListCnt);
			model.addAttribute("pagination", pagination);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return "judge/edu/eduSchedule";
	}
	
	/**
	 * 수강신청
	 * @param apply
     * @return
     * @throws Exception
	 */
	@RequestMapping("judge/register")
	@ResponseBody
	public Map<String, Object> ajaxApply(HttpServletRequest request, @RequestBody ApplyVO apply) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		String message = "";
		
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
				applyService.insertApply(apply);
				
				message = "수강신청이 성공적으로 완료되었습니다 \n교육신청이 확정되면 학습이 가능합니다.";
			} else {
				message = "이미 수강신청 되어있는 과목입니다.";
			}
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		resultMap.put("message", message);
		
		return resultMap;
	}
	
	/**
	 * 수료증 미리보기 및 출력
	 * @param apply
     * @return
     * @throws Exception
	 */
	@RequestMapping("print")
	public String applyPrint() {
		return "/judge/applyPrint";
	}
}
