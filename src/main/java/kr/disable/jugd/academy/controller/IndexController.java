package kr.disable.jugd.academy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.disable.jugd.academy.service.CodeService;
import kr.disable.jugd.academy.service.JudgeService;
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

	@Autowired
	private CodeService codeService;

	@Autowired
	private JudgeService judgeService;
	
	/**
     * 로그인화면 (심판용)
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/judge/index")
	public String judgeIndex(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();

		JudgeVO judge = (JudgeVO) session.getAttribute("USER"); // 심판로그인 정보(LoginController 에 USER 이름으로 session 값을 넣어두었음!)
		System.out.println("IndexController~~~~~~~~~");

		if(judge != null) { //얜 왜 들어간걸까?
			//오 이미 로그인 해 있으면 index로 가지않고 바로 edu/judge/schedule로 가기위해서 그런가보다!
			//아깐 왜 안된거지ㅋ
			return "redirect:/edu/judge/schedule";
		} else {
			Map<String, Object> paramMap = new HashMap<>();
			List<CodeVO> judgeKindList = null;

			paramMap.put("groupCode", Constants.JUDGE_KIND); // 스포츠 종목(심판이 해당하는 종목)

			try {
				judgeKindList = commonService.selectCommonCode(paramMap);

			} catch (Exception e) {
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


	/**
	 * 신규심판등록화면
	 * @param
	 * @return
	 * @throws Exception */
	@RequestMapping("/judge/registerPage")
	public String judgeJoin(Model model, JudgeVO judgeVO) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		List<CodeVO> codeVO = null;
		paramMap.put("groupCode","100001"); //100001인 값을 groupCode라는 이름으로 paramMap에 담기
		//이 과정을 생략하면 모든 groupCode를 다 불러온다 ^^...
		try{
			codeVO = codeService.selectCode(paramMap);
		}
		catch (Exception e){
			logger.debug(e.getMessage());
		}
		model.addAttribute("judgeVO", judgeVO);
		model.addAttribute("codeVO", codeVO);
		System.out.println("judgeRegister!");
		return "judge/register/join";
	}


}