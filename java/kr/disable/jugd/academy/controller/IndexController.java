package kr.disable.jugd.academy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String index(HttpServletRequest request, Model model) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("groupCode", Constants.JUDGE_KIND); // 스포츠 종목(심판이 해당하는 종목)
		
		List<CodeVO> judgeKindList = commonService.selectCommon(paramMap);
		model.addAttribute("judgeKindList", judgeKindList);
		
		return "judge/index";
	}
}
