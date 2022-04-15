package kr.disable.jugd.academy.controller;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.domain.SearchVO;
import kr.disable.jugd.academy.service.*;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/judge/")
public class JudgeController {
    //0414
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

    @Autowired
    private JudgeService judgeService;


    @RequestMapping("admin/judgeList")
    public String judgeAdminConfirmList(HttpServletRequest request, SearchVO searchVO, Model model){
        HttpSession session = request.getSession();

        Map<String,Object> paramMap = new HashMap<>();
        List<JudgeVO> judgeList = null; //심판
        List<CodeVO> judgeKindList = null; //심판 종목체크용
        List<SearchVO> searchList = null; //검색용

        paramMap.put("searchArea", searchVO.getSearchArea()); //검색단어
        paramMap.put("searchChkValue",searchVO.getSearchChkValue()); //검색어분류
        paramMap.put("groupCode","100001");
        try{
            judgeList = judgeService.selectJudgeList(paramMap);
            judgeKindList = codeService.selectCode(paramMap);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }

        model.addAttribute("judgeList",judgeList);
        model.addAttribute("judgeKindList",judgeKindList);
        /*model.addAttribute("searchList",searchList);*/

        return "admin/judge/confirm";
    }

    @RequestMapping("admin/detail")
    public String judgeUpdateForm(HttpServletRequest request, Model model, JudgeVO judgeVO) throws Exception {
        HttpSession session = request.getSession();
        Map<String,Object> paramMap = new HashMap<>();
        List<CodeVO> judgeKindList = null;
        List<JudgeVO> judgeList = null;
        paramMap.put("groupCode","100001");
        try{
            judgeVO = judgeService.selectDetailJudge(judgeVO);
            judgeKindList = codeService.selectCode(paramMap);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("judgeVO",judgeVO); //얘만 제대로 작동하는 중
        model.addAttribute("judgeKindList",judgeKindList); //ㅎㅎ
        model.addAttribute("judgeList", judgeList); //ㅎㅎ
        return "admin/judge/update";
    }

    /** 심판 수정처리
     * */
    @RequestMapping("admin/update")
    @ResponseBody
    public Map<String,Object> judgeUpdate(@RequestBody JudgeVO judgeVO, HttpServletRequest request) throws Exception{
        Map<String,Object> resultMap = new HashMap<>();
        HttpSession session = request.getSession();
        int result = 0;

        try{
            result = judgeService.updateJudgeData(judgeVO);
            resultMap.put("result", result);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        return resultMap;
    }


    /** 계정 사용(Y)체크 */
    @RequestMapping("admin/stateChkY")
    @ResponseBody
    public Map<String,Object> useStateChkY (HttpServletRequest request, @RequestBody JudgeVO judgeVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0;
        HttpSession session = request.getSession(); //로그인정보...

        judgeVO.setJudgeState("Y"); //Constants를 사용하지않아도 되겠지...
        judgeVO.setJudgeNoArr(judgeVO.getJudgeChkNo().split(",")); //다중선택시 "," 로 나누겠다.
        //judgeNo로 했는데 못찾아서 새로이 추가를 해줬다.

        try{
            result = judgeService.updateJudgeStateY(judgeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);

        return resultMap;
    }

    /** 계정 사용(Y)체크 */
    @RequestMapping("admin/stateChkN")
    @ResponseBody
    public Map<String,Object> useStateChkN (HttpServletRequest request, @RequestBody JudgeVO judgeVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0;
        HttpSession session = request.getSession(); //로그인정보...

        judgeVO.setJudgeState("N");
        judgeVO.setJudgeNoArr(judgeVO.getJudgeChkNo().split(",")); //다중선택시 "," 로 나누겠다.
        //judgeNo로 했는데 못찾아서 새로이 추가를 해줬다.

        try{
            result = judgeService.updateJudgeStateN(judgeVO);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        resultMap.put("result", result);

        return resultMap;
    }

    /** 신규 심판 등록 요청 */
    @RequestMapping("admin/registerPage")
    public String registerForm (HttpServletRequest request, Model model) throws Exception{
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");

        Map<String,Object> paramMap = new HashMap<>();
        List<CodeVO> judgeKindList = null; //종목추가용
        //List<JudgeVO> judgeList = null;

        try{
            judgeKindList = codeService.selectCode(paramMap);
            //judgeList = judgeService.selectJudgeList(paramMap);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("judgeKindList",judgeKindList);
        //model.addAttribute("judgeList", judgeList);

        return "admin/judge/register";
    }

    @RequestMapping("admin/register")
    @ResponseBody
    public Map<String, Object> insertJudge (@RequestBody JudgeVO judgeVO, HttpServletRequest request) throws Exception{
        HttpSession session = request.getSession();
        Map<String, Object> resultMap = new HashMap<>();
        int result = 0;

        try{
            result = judgeService.insertJudge(judgeVO);
            resultMap.put("result",result);
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        return resultMap;
    }
}
