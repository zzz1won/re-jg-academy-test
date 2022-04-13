package kr.disable.jugd.academy.controller;

import kr.disable.jugd.academy.domain.*;
import kr.disable.jugd.academy.service.*;
import kr.disable.jugd.academy.utils.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
     *
     * @param model //CertController.java - certAdminConfirm 참고!
     * @return
     * @throws Exception
     */

    @RequestMapping("admin/confirm")
    public String codeAdminConfirm(HttpServletRequest request, Model model, SearchVO search) throws Exception {
        //HttpServletRequest :
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //Admin 로그인 정보를 유지하기위해 사용.

        Map<String, Object> paramMap = new HashMap<>();
        List<CodeVO> codeList = null;
        List<CodeVO> searchList = null; //검색용추가
        int codeListCnt = 0;

        /*if(search.getYear() == null || "".equals(search.getYear())){
            search.setYear(new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime())); //날짜 셋팅하는 문법
        }*/
        //삭제해도 괜찮은 듯...
        String[] groupCodeNameList = {Constants.GROUP_CODE_APPLY_STATE, Constants.GROUP_CODE_EDU_STATE, Constants.GROUP_CODE_JUDGE_KIND};

        paramMap.put("codeListCheck", search.getCodeListCheck());
        paramMap.put("codeName", search.getCodeName());
        paramMap.put("regDate", search.getRegDate()); //reg_date 등록일

        try {
            //codeListCnt = codeService.selectCodeListCnt(paramMap); //
            paramMap.put("groupCodeNameList", groupCodeNameList);
            codeList = commonService.selectToCommonCode(paramMap); //표준
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        model.addAttribute("codeListCnt", codeListCnt);
        model.addAttribute("adminInfo", adminInfo);
        model.addAttribute("codeList", codeList);

        return "admin/code/confirm";
    }

    /**
     * 코드 삭제
     *
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping("admin/delete")
    @ResponseBody
    public Map<String, Object> deleteCode(@RequestBody CodeVO codeVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<CodeVO> codeNoList = null;
        /*ApplyVO apply = new ApplyVO(); //관련내용 삭제할거야!*/
        String codeNoArr = "";
        int result = 0;
        //코드를 삭제하면 해당 코드와 관련된 자료도 모두 삭제를 해야 맞잖어?
        //하지만 일단 코드만 삭제한다! 안되넹

        codeVO.setCodeNoArr(codeVO.getCodeNo().split(","));

        try {
            codeNoList = codeService.selectCodeNo(codeVO);
            for (CodeVO codeNo : codeNoList) {
                //code에서 no값을 가져온다.
                codeNoArr += codeNo.getCommonCodeNo() + ",";
            }

            result = codeService.deleteCode(codeVO);
            resultMap.put("result", result);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        return resultMap;
    }

    /**
     * 코드 신규등록 화면 호출
     *
     * @param request
     * @return String
     * @throws Exception
     */

    @RequestMapping("admin/registerPage")
    public String codeRegisterPage(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        model.addAttribute("adminInfo", adminInfo);
        return "admin/code/register";
    }

    /**
     * 코드 신규등록 처리
     *
     * @param
     * @param
     * @return resultMap
     */
    @RequestMapping("admin/register")
    @ResponseBody
    public Map<String, Object> insertCode(@RequestBody CodeVO codeVO, HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        int nullChk = 0;
        int result = 0;
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //굳이?
        codeVO.setRegId(adminInfo.getAdminId());
        try {
            //insert
            result = codeService.insertCode(codeVO);
            resultMap.put("result", result);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        return resultMap;
    }

    /** 코드 상세보기 페이지
     * @param codeVO
     * @return request
     * @throws Exception
     * */

    @RequestMapping("admin/detail")
    public String detailPage (HttpServletRequest request, Model model, CodeVO codeVO) {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        try {
            codeVO = codeService.selectDetailCode(codeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }

        model.addAttribute("codeVO", codeVO);
        model.addAttribute("adminInfo",adminInfo);
        System.out.println("-----------------selected:"+codeVO);
        return "admin/code/detail";
    }

    /** 코드 수정요청 페이지 아...!
     * @param
     * @return
     * @throws Exception
     * */
    @RequestMapping("admin/updatePage")
    public String codeUpdatePage(HttpServletRequest request, Model model, CodeVO codeVO){
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO)session.getAttribute("ADMIN");
        try {
        codeVO = codeService.selectDetailCode(codeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }

        model.addAttribute("codeVO", codeVO);
        return "admin/code/update";
    }


    /** 코드 수정처리
     * @param
     * @return
     * @throws Exception
     * */

    @RequestMapping("admin/update")
    @ResponseBody
    public Map<String, Object> codeUpdate(@RequestBody CodeVO codeVO, HttpServletRequest request){
        Map<String,Object> resultMap = new HashMap<>();
        int result = 0;

        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO)session.getAttribute("ADMIN");

        try{
            result = codeService.updateCode(codeVO);
            resultMap.put("result", result);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        return resultMap;
    }
}

