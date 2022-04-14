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
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //Admin 로그인 정보를 유지하기위해 사용.

        Map<String, Object> paramMap = new HashMap<>();
        List<CodeVO> codeList = null;
        List<SearchVO> searchList = null;
        /* codeState 정리용 */
        /*List<CodeVO> codeStateList = null;*/

        paramMap.put("codeName",search.getCodeName()); //검색이 안돼서 추가
        /*검색이 안돼서 추가*/
        paramMap.put("codeListCheck", search.getCodeListCheck()); //검색 체크는 이 아이 ^^;

        String[] codeStateList = {Constants.CODE_USE_STATE, Constants.CODE_USE_STATE_N};
        try {
            /*codeList = commonService.selectToCommonCode(paramMap); //표준*/
            codeList = codeService.selectCode(paramMap);
            paramMap.put("codeStateList",codeStateList);
            /*codeStateList = codeService.selectCode(paramMap);*/
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        model.addAttribute("adminInfo", adminInfo);
        model.addAttribute("codeList", codeList);
        model.addAttribute("codeStateList",codeStateList);

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
    public String codeRegisterPage(HttpServletRequest request, Model model) throws Exception {
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
    public Map<String, Object> insertCode(@RequestBody CodeVO codeVO, HttpServletRequest request) throws Exception {
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
    public String detailPage (HttpServletRequest request, Model model, CodeVO codeVO) throws Exception {
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
    /*@RequestMapping("admin/updatePage")
    public String codeUpdatePage(HttpServletRequest request, Model model, CodeVO codeVO) throws Exception {
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
    }*/


    /** 코드 수정처리
     * @param
     * @return
     * @throws Exception
     * */

    @RequestMapping("admin/update")
    @ResponseBody
    public Map<String, Object> codeUpdate(@RequestBody CodeVO codeVO, HttpServletRequest request) throws Exception {
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

    /** 코드를 삭제하지않고 사용여부 체크를 하는 기능.
     * 취소처리
     * @param
     * @return
     * @throws Exception
     * */
    @RequestMapping("admin/stateChkN")
    @ResponseBody
    public Map<String,Object> useStateChkN (HttpServletRequest request, @RequestBody CodeVO codeVO) throws Exception {
        Map<String,Object> resultMap = new HashMap<>();
        int result = 0;
        /*로그인정보*/
        HttpSession session = request.getSession();

        codeVO.setUseState(Constants.CODE_USE_STATE_N);
        /*codeVO.setUseState(Constants.CODE_USE_STATE); //오늘도 바보짓을 한 걸루! ^^*/
        codeVO.setCodeNoArr(codeVO.getCodeNo().split(","));

        try{
            //취소처리. 신청->수료 넘어가는 기능은 없기때문에 변경만 하는 걸로!
            /*codeList = codeService.insertUseState(codeVO);*/
            result = codeService.updateCodeUseState(codeVO);
            /*resultMap.put("result"+result);*/
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);

        return resultMap;
    }



}

