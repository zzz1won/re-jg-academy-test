package kr.disable.jugd.academy.test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class TestController {
	@Autowired
	TestService testService;

	@RequestMapping(value = "/test")
	public ModelAndView dbTest() throws Exception {
		ModelAndView mav = new ModelAndView("test");
		List<TestVo> testList = testService.selectTest();
		mav.addObject("list", testList);
		return mav;
	}

	@RequestMapping("/")
	public ModelAndView test() throws Exception {
		ModelAndView mav = new ModelAndView("test");
		mav.addObject("name", "goddaehee");
		List<String> testList = new ArrayList<String>();
		testList.add("a");
		testList.add("b");
		testList.add("c");
		mav.addObject("list", testList);
		return mav;
	}
}
