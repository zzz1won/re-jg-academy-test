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
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static kr.disable.jugd.academy.utils.Constants.APPLY_STATE;
import static kr.disable.jugd.academy.utils.Constants.JUDGE_KIND;

@Controller
@RequestMapping("/code/")
public class CodeController {
    //0408
    private Logger logger = LoggerFactory.getLogger(CodeController.class);

    @Autowired
    private CodeService codeService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private EduService eduService;
    @Autowired
    private CertService certService;
    @Autowired
    private AdminService adminService;

    /**
     * 코드관리하는 컨트롤러
     *
     * @param model //CertController.java - certAdminConfirm 참고!
     * @return //
     * @throws //Exception
     */
    @RequestMapping("admin/confirm")
    public String codeAdminConfirm(HttpServletRequest request, Model model, SearchVO search) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //Admin 로그인 정보를 유지하기위해 사용.

        Map<String, Object> paramMap = new HashMap<>();
        List<CodeVO> codeList = null;

        paramMap.put("searchChkValue", search.getSearchChkValue()); //검색 selected 체크
        paramMap.put("searchArea", search.getSearchArea()); //검색이 안돼서 추가
        //기존 codeName, codeListCheck (통일) search~ 로 수정 완료

        String[] codeStateList = {Constants.CODE_USE_STATE, Constants.CODE_USE_STATE_N};
        try {
            codeList = codeService.selectCode(paramMap);
            paramMap.put("codeStateList", codeStateList);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        model.addAttribute("adminInfo", adminInfo);
        model.addAttribute("codeList", codeList);
        model.addAttribute("codeStateList", codeStateList);
        model.addAttribute("search", search); //검색담당!

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
        resultMap.put("adminInfo", adminInfo);   //로그인 정보는 보여야하므로 adminInfo 추가
        try {
            result = codeService.insertCode(codeVO);
            resultMap.put("result", result);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        return resultMap;
    }

    /**
     * 코드 상세보기 페이지
     *
     * @param codeVO
     * @return request
     * @throws //Exception
     */

    @RequestMapping("admin/detail")
    public String detailPage(HttpServletRequest request, Model model, CodeVO codeVO) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        /*원래 데이터*/
        String searchChkValue = codeVO.getViewSearchChkValue();
        String searchArea = codeVO.getViewSearchArea();

        try {
            codeVO = codeService.selectDetailCode(codeVO);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        model.addAttribute("codeVO", codeVO);
        model.addAttribute("adminInfo", adminInfo);

        model.addAttribute("searchChkValue", searchChkValue);
        model.addAttribute("searchArea", searchArea);
        System.out.println("searchChkValue: " + searchChkValue);
        System.out.println("searchArea: " + searchArea);
        return "admin/code/detail";
    }

    /**
     * 코드 수정처리
     *
     * @param
     * @return
     * @throws //Exception
     */

    @RequestMapping("admin/update")
    @ResponseBody
    //ResponseBody : @RequestBody 의 요청에 따라 POST 방식으로 전송 된 HTTP 요청 데이터를
    //String type 의 Body Parameter로 전달받는 것[수신] 둘이 짝꿍.
    public Map<String, Object> codeUpdate(@RequestBody CodeVO codeVO, HttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0; //건수

        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        resultMap.put("adminInfo", adminInfo); //adminHeader 에 의해 적용되는 부분.

        try {
            result = codeService.updateCode(codeVO);
            resultMap.put("result", result);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        return resultMap;
    }

    /**
     * 코드를 삭제하지않고 사용여부 체크를 하는 기능.
     * 취소처리
     *
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping("admin/stateChkN")
    @ResponseBody
    public Map<String, Object> useStateChkN(HttpServletRequest request, @RequestBody CodeVO codeVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0;
        /*로그인정보*/
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        resultMap.put("adminInfo", adminInfo);

        codeVO.setUseState(Constants.CODE_USE_STATE_N);
        codeVO.setCodeNoArr(codeVO.getCodeNo().split(","));

        try {
            result = codeService.updateCodeUseState(codeVO);
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);

        return resultMap;
    }

    @RequestMapping("admin/deepDive")
    public String deepDive() {
        System.out.println("deepDive요청");
        return "admin/deepDive/jsStudy";
    }


    /**
     * 220510 js랑 jquery보다가 adminCertPage가 매우 복잡해보여 따라할건데, 이제 Ajax를 곁들인...
     *
     * @return: String
     * @throws: Exception
     * @param: model, request, searchVO
     */
    @RequestMapping("admin/codeEx")
    public String jCodeExPage(HttpServletRequest request, Model model, SearchVO search) throws Exception {
        System.out.println("controller.codeEx");
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        Map<String,Object> paramMap = new HashMap<>();

        if (search.getYear() == null || "".equals(search.getYear())) {
            search.setYear(new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()));
        }
        paramMap.put("year", search.getYear());
        paramMap.put("eduTitle", search.getEduTitle());
        paramMap.put("applyState", search.getApplyState());
        paramMap.put("judgeNo",search.getJudgeNo());

        List<EduVO> eduTitleList = null;
        List<CodeVO> applyStateList = null;
        //List<CertVO> certList = null;


        // 02: 신청확정(수료대기), 03: 수료확정, 05: 미수료
        String[] codeList = {Constants.APPLY_STATE_APPLY_COMP, Constants.APPLY_STATE_CERT_COMP, Constants.APPLY_STATE_CERT_NOT};

        try{
            paramMap.put("groupCode", Constants.JUDGE_KIND); // 심판종목구분[100001] 한글출력용
            paramMap.put("groupCode", Constants.APPLY_STATE); // 수강 상태 [수료확정에 영향]
            //얘가 없으면 전체<-만 뜨고 수료확정 02,03,05가 나오지 않는다.
            paramMap.put("codeList", codeList); //codeList에 있는 애들만 나오게하는가보다.
            eduTitleList = eduService.selectEduTitleListByYear(paramMap); // 교육과정 목록(selectBox)
            applyStateList = commonService.selectCommonCode(paramMap); // [수료확정에 영향] 수료상태(selectBox)
            //certList = certService.selectCertList(paramMap);
        } catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("eduTitleList", eduTitleList);
        model.addAttribute("applyStateList", applyStateList);
        //model.addAttribute("certList",certList);
        model.addAttribute("searchVO",search);
        model.addAttribute("adminInfo",adminInfo);
        System.out.println("codeEx 코드 실행완료");
        return "admin/code/codeEx";
    }

    @RequestMapping("admin/codeEx2")
    @ResponseBody
    public Map<String, Object> jCodeEx(@RequestBody SearchVO search, HttpServletRequest request) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        System.out.println("controller.codeEx2");
        List<CertVO> certList = null;
        List<EduVO> eduTitleList = null;
        List<CodeVO> applyStateList = null;
        List<CodeVO> judgeKindList = null;
        List<AdminVO> adminList = null;
        int certListCnt = 0;

        paramMap.put("year", search.getYear());
        paramMap.put("eduTitle", search.getEduTitle());
        paramMap.put("applyState", search.getApplyState());
        paramMap.put("judgeNo",search.getJudgeNo());

        try {
            certList = certService.selectCertList(paramMap);
            paramMap.put("certList",certList);
            eduTitleList = eduService.selectEduTitleListByYear(paramMap);
            paramMap.put("eduTitleList",eduTitleList);

            certListCnt=certService.selectCertListCnt(paramMap);
            paramMap.put("certListCnt",certListCnt);

        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        paramMap.put("search",search);
        System.out.println("codeEx2 코드 실행완료");
        return paramMap;
    }

}

