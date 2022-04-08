package kr.disable.jugd.academy.controller;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.domain.EduVO;
import kr.disable.jugd.academy.domain.SearchVO;
import kr.disable.jugd.academy.service.*;
import kr.disable.jugd.academy.utils.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/code/")
public class CodeController {
    //0408
    private Logger logger = LoggerFactory.getLogger(CodeController.class);

    @Autowired
    private CommonService commonService;

    @Autowired
    private EduService eduService;

    @Autowired
    private ApplyService applyService;

    @Autowired
    private CertService certService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private CodeService codeService;

    /**
     * 코드관리하는 컨트롤러
     * @param model //CertController.java - certAdminConfirm 참고!
     * @return
     * @throws Exception //왜 쓸까?
     */

    @RequestMapping("admin/confirm")
    public String codeAdminConfirm (HttpServletRequest request, Model model, SearchVO search) throws Exception {
        //HttpServletRequest :
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //Admin 로그인 정보를 유지하기위해 사용.

        Map<String, Object> paramMap = new HashMap<>();
        //왜 List<CodeVO>를 두번이나 하는가?
        List<CodeVO> applyStatusList = null; //code_name
        List<CodeVO> judgeKindList = null; //code_name

        //List<CodeVO> groupCode = null; //group_code_name

        List<EduVO> eduTitleList = null; //종목?
        List<AdminVO> adminList = null;
        int codeListCnt = 0; //

        if (search.getYear() == null || "".equals(search.getYear())) {
            search.setYear(new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()));
        } //연도 null이면 지금 연도로 설정하나보다.

        String[] groupCode = {Constants.JUDGE_KIND, Constants.APPLY_STATE, Constants.EDU_STATUS};
        String[] codeList = {Constants.APPLY_STATE_APPLY_COMP, Constants.APPLY_STATE_CERT_COMP, Constants.APPLY_STATE_CERT_NOT};
        //다른 코드들은 우짜지?

        //map에 데이터 삽입
        paramMap.put("year", search.getYear());
        paramMap.put("applyState", search.getApplyState());
        paramMap.put("judgeNo", search.getJudgeNo());

        try {
            //paramMap.put("groupCode", Constants.JUDGE_KIND); //심판종목코드
            judgeKindList = commonService.selectCommonCode(paramMap);
            //paramMap.put("groupCode", Constants.APPLY_STATE); //신청진행상태
            //paramMap.put("groupCode", Constants.EDU_STATUS); //교육과정상태

            paramMap.put("codeList", codeList); //02,03,05
            eduTitleList = eduService.selectEduTitleListByYear(paramMap); //교육과정목록(셀렉박스라구여?)
            applyStatusList = commonService.selectCommonCode(paramMap); //수료상태(셀렉박스라구여!?!?)

            paramMap.put("codeListCnt", codeListCnt);
            //codeList = codeService.selectCodeList(paramMap);
            adminList = adminService.selectAdminList(); //list라서 paramMap을 안넣나
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        model.addAttribute("adminInfo", adminInfo);
        model.addAttribute("adminList", adminList);
        model.addAttribute("search", search);

        //model.addAttribute("codeList", codeList);
        model.addAttribute("groupCode", groupCode);
        model.addAttribute("codeListCnt", codeListCnt);
        model.addAttribute("eduTitleList", eduTitleList);
        model.addAttribute("applyStatusList", applyStatusList);
        model.addAttribute("judgeKindList", judgeKindList);

        return "admin/code/confirm";
    }

}
