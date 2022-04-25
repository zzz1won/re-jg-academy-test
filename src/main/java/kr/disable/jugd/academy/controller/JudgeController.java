package kr.disable.jugd.academy.controller;

import kr.disable.jugd.academy.domain.*;
import kr.disable.jugd.academy.service.*;
import kr.disable.jugd.academy.utils.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/judge/")
public class JudgeController {
    //0414
    private Logger logger = LoggerFactory.getLogger(CodeController.class);

    @Autowired
    private CodeService codeService;

    @Autowired
    private JudgeService judgeService;

    /** 심판관리 화면, 수료관리참고
     * */
    @RequestMapping("admin/judgeList")
    public String judgeAdminConfirmList(HttpServletRequest request, SearchVO searchVO, Model model) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //필요없다고 생각했는데 session(admin)정보를 입력하지 않으니까 로그인시 공백으로 나옴.

        Map<String,Object> paramMap = new HashMap<>();
        //그럼 검색을 위해 여기서 map을 쓴건가?? 데이터를 꺼내 쓰려고...??
        List<JudgeVO> judgeList = null; //심판
        List<CodeVO> judgeKindList = null; //심판 종목체크용

        paramMap.put("searchArea", searchVO.getSearchArea()); //검색단어
        paramMap.put("searchChkValue",searchVO.getSearchChkValue()); //검색어분류
        paramMap.put("groupCode","100001"); //100001이라는 object를 지닌 groupCode를 paramMap에 추가. //현재 groupCode의 값은 100001
        //paramMap.put("groupCode","100002"); //100002이라는 object를 지닌 groupCode를 paramMap에 추가+덮어씌움 //groupCode의 최종값은 100002
        //paramMap.put("groupCode","100003"); //100003이라는 object를 지닌 groupCode를 paramMap에 추가+덮어씌움+덮어씌움 //groupCode의 최종값은 100003
        //paramMap만 불러오면 데이터가 걸러질테니 굳이 searchVOList를 생성 할 필요가 없다.

        try{
            judgeList = judgeService.selectJudgeList(paramMap);
            judgeKindList = codeService.selectCode(paramMap);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("judgeList",judgeList);
        model.addAttribute("judgeKindList",judgeKindList);
        model.addAttribute("adminInfo",adminInfo);

        //0422 검색어 값을 저장하기 위해 searchVO도 담아둔다.
        model.addAttribute("searchVO", searchVO);
        System.out.println(searchVO);

        return "admin/judge/confirm";
    }

    @RequestMapping("admin/detail")
    public String judgeUpdateForm(HttpServletRequest request, Model model, JudgeVO judgeVO) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //로그인 정보 유지용으로(안만들면 상단 로그인정보 공란으로 보여짐)

        Map<String,Object> paramMap = new HashMap<>();
        List<CodeVO> judgeKindList = null; //종목List를 담으려고 선언~
        paramMap.put("groupCode","100001");//groupCode가 100001인 값들만 출력됨...

        String searchChkValue = judgeVO.getViewSearchChkValue();
        String searchArea = judgeVO.getViewSearchArea();

        try{
            judgeVO = judgeService.selectDetailJudge(judgeVO); //judgeService에서 judge의 List를 가져와서 출력하려고...
            judgeKindList = codeService.selectCode(paramMap); //codeService에서 종목List를 가져와 담는다.
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("judgeVO",judgeVO); //심판 정보를 담는다.
        model.addAttribute("adminInfo",adminInfo);//로그인용
        model.addAttribute("judgeKindList",judgeKindList);
        //담아온 judgeKindList를 model에 담아주지않으면 말짱도루묵...

        model.addAttribute("searchChkValue",searchChkValue);
        model.addAttribute("searchArea",searchArea);

        //paramMap.put("searchChkValue", searchVO.getSearchChkValue());
        //paramMap.put("searchArea", searchVO.getSearchArea());

        //System.out.println("judgeController에서 searchVO: "+searchVO);
        System.out.println("searchChkValue: "+searchChkValue);
        System.out.println("searchArea: "+searchArea);
        //0421 검색값을 담아서 수정,목록 페이지로 이동할 때 이 값을 유지한 상태로 화면이동...

        return "admin/judge/update";
    }

    /** 심판 수정처리
     * */
    @RequestMapping("admin/update")
    @ResponseBody
    public Map<String,Object> judgeUpdate(@RequestBody JudgeVO judgeVO, HttpServletRequest request) throws Exception{
        Map<String,Object> resultMap = new HashMap<>();
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        int result = 0;

        try{
            result = judgeService.updateJudgeData(judgeVO);
            resultMap.put("result", result);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("adminInfo",adminInfo);
        return resultMap;
    }


    /** 계정 사용(Y)체크 */
    @RequestMapping("admin/stateChkY")
    @ResponseBody
    public Map<String,Object> useStateChkY (HttpServletRequest request, @RequestBody JudgeVO judgeVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0;
        HttpSession session = request.getSession(); //로그인정보...
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        judgeVO.setJudgeState("Y"); //Constants를 사용하지않아도 되겠지...
        judgeVO.setJudgeNoArr(judgeVO.getJudgeChkNo().split(",")); //다중선택시 "," 로 나누겠다.
        //처음엔 judgeVO.getJudgeNo로 했는데 못찾아서 새로이 추가를 해줬다.

        try{
            result = judgeService.updateJudgeStateY(judgeVO);
            //Mapper에 있는 forEach를 이용해 돌아간 수정데이터가 몇개인지 체크? 으음...
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);
        resultMap.put("adminInfo", adminInfo);
        return resultMap;
    }

    /** 계정 미사용(N)체크 */
    @RequestMapping("admin/stateChkN")
    @ResponseBody
    public Map<String,Object> useStateChkN (HttpServletRequest request, @RequestBody JudgeVO judgeVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0;
        HttpSession session = request.getSession(); //로그인정보...
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        //judgeVO.setJudgeState("N");
        judgeVO.setJudgeState(Constants.JUDGE_STATE_N); //계정미사용
        judgeVO.setJudgeNoArr(judgeVO.getJudgeChkNo().split(",")); //다중선택시 "," 로 나누겠다.
        //judgeNo로 했는데 못찾아서 새로이 추가를 해줬다.

        try{
            result = judgeService.updateJudgeStateN(judgeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);
        resultMap.put("adminInfo",adminInfo);
        return resultMap;
    }

    /** 신규 심판 등록 요청 */
    @RequestMapping("admin/registerPage")
    public String registerForm (HttpServletRequest request, Model model) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        Map<String,Object> paramMap = new HashMap<>();
        List<CodeVO> judgeKindList = null; //종목추가용
        paramMap.put("groupCode","100001"); //groupCode 100001만 출력되게끔!

        try{
            judgeKindList = codeService.selectCode(paramMap);//paramMap을 담아 code를 judgeKindList에 담는다.
            //아 이 순서에 따랐고, 그래서 groupCode 100001인애만 가져올 수 있던거군...!!
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("judgeKindList",judgeKindList); //model에 judgeKindList를 담기
        model.addAttribute("adminInfo",adminInfo);  //관리자 로그인 정보

        return "admin/judge/register";
    }

    /** 신규 심판 등록 처리
     * @param   //judgeVO, request
     * @return  //Map
     * @throws  //exception 
     * */
    
    @RequestMapping("admin/register")
    @ResponseBody
    public Map<String, Object> insertJudge (@RequestBody JudgeVO judgeVO, HttpServletRequest request) throws Exception{
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("adminInfo",adminInfo);
        //로그인 정보 등등등

        int result = 0;
        try{
            result = judgeService.insertJudge(judgeVO); //judgeVO를 추가하는 Mapper 를 들고 result 에 담은 후
            resultMap.put("result",result); //mapper 에 넣어준다.
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        return resultMap;
    }
}
