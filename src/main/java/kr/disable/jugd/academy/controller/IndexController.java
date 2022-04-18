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



}
