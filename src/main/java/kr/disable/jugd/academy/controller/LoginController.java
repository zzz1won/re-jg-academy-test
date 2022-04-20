package kr.disable.jugd.academy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.disable.jugd.academy.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.service.AdminService;
import kr.disable.jugd.academy.service.JudgeService;

@Controller
public class LoginController {

    private Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private JudgeService judgeService;

    @Autowired
    private AdminService adminService;

    /**
     * 로그인 (심판)
     *
     * @param request
     * @param //model
     * @param judge
     * @return
     * @throws Exception
     */
    @RequestMapping("/judge/login")
    public String judgeLogin(HttpServletRequest request, JudgeVO judge, RedirectAttributes redirectAttributes) throws Exception {
        JudgeVO judgeInfo = new JudgeVO();

        try {
            // 로그인 정보와 일치하는 심판 정보를 가지고온다.
            judgeInfo = judgeService.selectJudgeInfo(judge);


        } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        System.out.println("judgeInfo.getJudgeState() : " + judgeInfo.getJudgeState());
        //System.out.println("judgeInfo: "+ judgeInfo.getJudgeKind()+" "+judgeInfo.getJudgeNo()+" "+judgeInfo.getJudgeName()); //0420 이렇게 쓰면 null로 잡히는...? 당연한건가 흠
        System.out.println(!StringUtils.equals(judgeInfo.getJudgeState(), Constants.JUDGE_STATE_N));

		boolean judgeStateN = StringUtils.equals(judgeInfo.getJudgeState(), Constants.JUDGE_STATE_N); //해당 데이터의 JudgeState가 N일때
		boolean judgeNameChk = StringUtils.equals(judgeInfo.getJudgeName(), judge.getJudgeName());	 //입력한 JudgeName 값이 기존 데이터와 일치하는 경우
		boolean judgeKindChk = StringUtils.equals(judgeInfo.getJudgeKind(), judge.getJudgeKind());	//입력한 JudegKind 값이 기존 데이터와 일치하는 경우

        if (judgeInfo != null && !judgeStateN && judgeNameChk && judgeKindChk) {
            // 조회된 정보를 session에 등록
            HttpSession session = request.getSession();
            session.setAttribute("USER", judgeInfo);
            session.setMaxInactiveInterval(30 * 60);
            return "redirect:/edu/judge/schedule";

        } else if (judgeStateN) {
            redirectAttributes.addFlashAttribute("message", "계정미사용 상태입니다.<br>관리자에게 문의하세요.");
            return "redirect:/judge/index";
        } else if (!judgeNameChk) {
            redirectAttributes.addFlashAttribute("message", "회원매칭 불가<br> 정보를 다시 확인해주세요.");
            return "redirect:/judge/index";
        } else if (!judgeKindChk) {
            redirectAttributes.addFlashAttribute("message", "종목을 확인해주세요.");
            return "redirect:/judge/index";
        } else {
            // 로그인 실패
            redirectAttributes.addFlashAttribute("message", "로그인에 실패하셨습니다.<br>다시 시도해주세요.");
            return "redirect:/judge/index";
        }
    }

    /**
     * 로그아웃 (심판)
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/judge/logout")
    public String judgeLogout(HttpServletRequest request) throws Exception {
        // session 초기화
        HttpSession session = request.getSession();
        session.removeAttribute("USER");
        //session.invalidate();

        return "redirect:/judge/index";
    }

    /**
     * 로그인 (관리자)
     *
     * @param request
     * @param model
     * @param admin
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/login")
    public String adminLogin(HttpServletRequest request, AdminVO admin, RedirectAttributes redirectAttributes) throws Exception {

        // 로그인 정보와 일치하는 관리자 정보를 가지고온다.
        AdminVO adminInfo = new AdminVO();
        try {
            adminInfo = adminService.selectAdminInfo(admin);

        } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        if (adminInfo != null) {
            // 조회된 정보를 session에 등록
            HttpSession session = request.getSession();
            session.setAttribute("ADMIN", adminInfo);
            session.setMaxInactiveInterval(30 * 60);

            return "redirect:/edu/admin/schedule";

        } else {
            // 로그인 실패
            redirectAttributes.addFlashAttribute("message", "로그인에 실패하셨습니다.<br>다시 시도해주세요.");
            return "redirect:/admin/index";
        }
    }

    /**
     * 로그아웃 (관리자)
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/logout")
    public String adminLogout(HttpServletRequest request) throws Exception {
        // session 초기화
        HttpSession session = request.getSession();
        session.removeAttribute("ADMIN");
        //session.invalidate();

        return "redirect:/admin/index";
    }
}
