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
    private CodeService codeService;

    /**
     * 코드관리하는 컨트롤러
     *
     * @param model //CertController.java - certAdminConfirm 참고!
     * @return //
     * @throws //Exception
     */
/*    @RequestMapping("admin/confirm")
    public String codeAdminConfirm(HttpServletRequest request, Model model, SearchVO search) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //Admin 로그인 정보를 유지하기위해 사용.

        Map<String, Object> paramMap = new HashMap<>();
        List<CodeVO> codeList = null;

        paramMap.put("codeName",search.getCodeName()); //검색이 안돼서 추가
        paramMap.put("codeListCheck", search.getCodeListCheck()); //검색 selected 체크는 이 아이 ^^;

        String[] codeStateList = {Constants.CODE_USE_STATE, Constants.CODE_USE_STATE_N};
        try {
            codeList = codeService.selectCode(paramMap);
            paramMap.put("codeStateList",codeStateList);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        model.addAttribute("adminInfo", adminInfo);
        model.addAttribute("codeList", codeList);
        model.addAttribute("codeStateList",codeStateList);
        model.addAttribute("search",search);

        return "admin/code/confirm";
    }*/


    @RequestMapping("admin/confirm")
    public String codeAdminConfirm(HttpServletRequest request, Model model, SearchVO search) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //Admin 로그인 정보를 유지하기위해 사용.

        Map<String, Object> paramMap = new HashMap<>();
        List<CodeVO> codeList = null;

        paramMap.put("searchChkValue",search.getSearchChkValue()); //검색이 안돼서 추가
        //기존 codeName 이라고 붙여진거 전부 searchArea 로 수정 할 것
        paramMap.put("searchArea", search.getSearchArea()); //검색 selected 체크
        //기존 codeName 이라고 붙여진거 전부 searchChkValue 로 수정 할 것

        String[] codeStateList = {Constants.CODE_USE_STATE, Constants.CODE_USE_STATE_N};
        try {
            codeList = codeService.selectCode(paramMap);
            paramMap.put("codeStateList",codeStateList);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        model.addAttribute("adminInfo", adminInfo);
        model.addAttribute("codeList", codeList);
        model.addAttribute("codeStateList",codeStateList);
        model.addAttribute("search",search); //검색담당!

        System.out.println("searchArea: "+search.getSearchArea());
        System.out.println("searchChkValue: "+search.getSearchChkValue());

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
        Map<String, Object> resultMap = new HashMap<>(); //data를 담을 Map : resultMap
        List<CodeVO> codeNoList = null; //CodeVO의 데이터를 기반으로 하는 List 타입의 codeNoList 선언
        String codeNoArr = "";          //String 타입의 codeNoArr 선언
        int result = 0;                 //int 타입의 result 선언(삭제할 갯수 체크)

        //왜 이 문구를 try catch 이전에 진행하는가? 의미가 있는걸까?
        codeVO.setCodeNoArr(codeVO.getCodeNo().split(","));
        //CodeVO의 codeNo을 가져온 후 ','으로 구분하여 codeNoArr 값을 셋팅한다.

        try {
            codeNoList = codeService.selectCodeNo(codeVO);
                //codeService 의 selectCodeNo를 가져와 codeVO의 리스트를 볼 수 있게 지정 후...
            for (CodeVO codeNo : codeNoList) {
                //for 문에 의해 codeNoList 를 반복, codeNo 라는 이름으로 for 문 실행
                codeNoArr += codeNo.getCommonCodeNo() + ",";
                //forEach 돌려 codeNoList 를 codeNo 라는 이름으로 CommonCodeNo(pk) 를 꺼내와
                //codeNoArr 에 추가, 값의 구분은 ',' 를 사용.
            }

            result = codeService.deleteCode(codeVO);
            //codeService 의 deleteCode를 가져와 선택한 codeVO를 삭제할 수 있게 지정.
            resultMap.put("result", result);
            //그 값을 result 에 담는다.

        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        return resultMap;
            // Exception 발생하지 않을 시 return resultMap 실행.
            // resultMap에 든 result값이 실행(삭제) 처리됨.
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
        int result = 0;
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        resultMap.put("adminInfo",adminInfo);   //로그인 정보는 보여야하므로 adminInfo 추가
        try {
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
     * @throws //Exception
     * */

    @RequestMapping("admin/detail")
    public String detailPage (HttpServletRequest request, Model model, CodeVO codeVO) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        String searchChkValue = codeVO.getViewSearchChkValue();
        String searchArea = codeVO.getViewSearchArea();

        try {
            codeVO = codeService.selectDetailCode(codeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }

        model.addAttribute("codeVO", codeVO);
        model.addAttribute("adminInfo",adminInfo);

        model.addAttribute("searchChkValue", searchChkValue);
        model.addAttribute("searchArea", searchArea);
        System.out.println("searchChkValue: "+searchChkValue);
        System.out.println("searchArea: "+searchArea);
        return "admin/code/detail";
    }

    /** 코드 수정처리
     * @param
     * @return
     * @throws //Exception
     * */

    @RequestMapping("admin/update")
    @ResponseBody
    //ResponseBody : @RequestBody 의 요청에 따라 POST 방식으로 전송 된 HTTP 요청 데이터를
    //String type 의 Body Parameter로 전달받는 것[수신] 둘이 짝꿍.
    public Map<String, Object> codeUpdate(@RequestBody CodeVO codeVO, HttpServletRequest request) throws Exception {
        Map<String,Object> resultMap = new HashMap<>();
        int result = 0; //건수

        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO)session.getAttribute("ADMIN");
        resultMap.put("adminInfo",adminInfo); //adminHeader 에 의해 적용되는 부분.

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
        AdminVO adminInfo = (AdminVO)session.getAttribute("ADMIN");
        resultMap.put("adminInfo",adminInfo);

        codeVO.setUseState(Constants.CODE_USE_STATE_N);
        codeVO.setCodeNoArr(codeVO.getCodeNo().split(","));

        try{
            result = codeService.updateCodeUseState(codeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);

        return resultMap;
    }



}

