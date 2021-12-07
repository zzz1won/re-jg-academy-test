package kr.disable.jugd.academy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.service.JudgeService;

@Controller
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private JudgeService judgeService;
	
	/**
     * 로그인
     * @param request
     * @param JudgeVO
     * @return
     * @throws Exception
     */
	@RequestMapping("/judge/login")
	public String login(HttpServletRequest request, Model model, JudgeVO judge) throws Exception{

		// 해당 심판의 로그인 정보 가지고온다.
		JudgeVO judgeInfo = judgeService.selectJudgeInfo(judge);
		System.out.println("2222222222222222222222222222222");
		if(judgeInfo != null) {
			// 조회된 정보를 session에 등록
			HttpSession session = request.getSession();
			session.setAttribute("USER", judgeInfo);
			
			return "redirect:/judge/page";
			
		} else {
			// 로그인 실패
			return "redirect:/judge/index";
		}
	}
	
	/**
     * 로그아웃
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/judge/logout")
	public String logout(HttpServletRequest request) throws Exception{
		// session 초기화
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/judge/index";
	}
}
