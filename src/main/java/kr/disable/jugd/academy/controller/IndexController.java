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
import org.springframework.web.bind.annotation.RequestMapping;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.service.CommonService;
import kr.disable.jugd.academy.utils.Constants;

@Controller
public class IndexController {

	private Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	private CommonService commonService;
	
	/**
     * 로그인화면 (심판용)
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/judge/index")
	public String judgeIndex(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		JudgeVO judge = (JudgeVO) session.getAttribute("USER"); // 심판
		
		if(judge != null) {
			return "redirect:/edu/judge/schedule";
		} else {
			Map<String, Object> paramMap = new HashMap<>();
			List<CodeVO> judgeKindList = null;
			
			paramMap.put("groupCode", Constants.JUDGE_KIND); // 스포츠 종목(심판이 해당하는 종목)
			
			try {
				judgeKindList = commonService.selectCommonCode(paramMap);
				
			} catch(Exception e) {
				logger.debug(e.getMessage());
			}
			
			model.addAttribute("judgeKindList", judgeKindList);
			
			return "judge/index";
		}
	}

	/** 220413 심판등록 화면출력
	 * @param
	 * @retyrn String
	 * @throws Exception
	 * */
	@RequestMapping("/judge/hello")
	public String joinForm(HttpServletRequest request, Model model, JudgeVO judgeVO){
		HttpSession session = request.getSession();
		/*model.addAttribute("judgeList",judgeVO);*/
		return "judge/join/join";
	}


	
	/**
     * 로그인화면 (관리자용)
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/admin/index")
	public String adminIndex(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		AdminVO admin = (AdminVO) session.getAttribute("ADMIN"); // 관리자
		
		if(admin != null) {
			return "redirect:/edu/admin/schedule";
		} else {
			return "admin/index";
		}
	}



	/** 220413 심판등록 요청 하는중!
	 * @param
	 * @retyrn ResultMap
	 * @throws Exception
	 * */
	/*@RequestMapping("judge/join")
	@ResponseBody
	public Map<String,Object> join(HttpServletRequest request, Model model, JudgeVO judgeVO){
		HttpSession session = request.getSession();

		Map<String, Object> resultMap = new HashMap<>();
		List<JudgeVO> judgeKindList = null;
		List<JudgeVO> judgeList = null;

		resultMap.put("judgeNo", judgeVO.getJudgeNo());
		resultMap.put("judgeName", judgeVO.getJudgeName());

		try{

		}
		catch (Exception e){
			logger.debug(e.getMessage());
		}
		model.addAttribute("judgeKindList",judgeKindList); //종목체크용
		model.addAttribute("judgeList",judgeList);
		return resultMap;
	}*/

}
