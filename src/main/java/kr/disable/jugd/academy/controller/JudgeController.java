package kr.disable.jugd.academy.controller;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.domain.JudgeVO;
import kr.disable.jugd.academy.domain.SearchVO;
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


    @RequestMapping("admin/judgeList")
    public String judgeAdminConfirmList(HttpServletRequest request, SearchVO searchVO, Model model){
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        //필요없다고 생각했는데 session(admin)정보를 입력하지 않으니까 로그인시 공백으로 나옴.

        Map<String,Object> paramMap = new HashMap<>();
        //그럼 검색을 위해 여기서 map을 쓴건가?? 데이터를 꺼내 쓰려고...??
        List<JudgeVO> judgeList = null; //심판
        List<CodeVO> judgeKindList = null; //심판 종목체크용
        List<SearchVO> searchList = null; //검색용

        paramMap.put("searchArea", searchVO.getSearchArea()); //검색단어
        paramMap.put("searchChkValue",searchVO.getSearchChkValue()); //검색어분류
        paramMap.put("groupCode","100001"); //100001이라는 object를 지닌 groupCode를 paramMap에 추가. //현재 groupCode의 값은 100001
        //paramMap.put("groupCode","100002"); //100002이라는 object를 지닌 groupCode를 paramMap에 추가+덮어씌움 //groupCode의 최종값은 100002
        //paramMap.put("groupCode","100003"); //100003이라는 object를 지닌 groupCode를 paramMap에 추가+덮어씌움+덮어씌움 //groupCode의 최종값은 100003
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
        /*model.addAttribute("searchList",searchList);*/

        return "admin/judge/confirm";
    }

    @RequestMapping("admin/detail")
    public String judgeUpdateForm(HttpServletRequest request, Model model, JudgeVO judgeVO) throws Exception {
        HttpSession session = request.getSession();
        AdminVO adminInfo = (AdminVO) session.getAttribute("ADMIN");
        Map<String,Object> paramMap = new HashMap<>();
        List<CodeVO> judgeKindList = null; //종목List를 담으려고 선언~
        paramMap.put("groupCode","100001");
        try{
            judgeVO = judgeService.selectDetailJudge(judgeVO);
            judgeKindList = codeService.selectCode(paramMap); //codeService에서 종목List를 가져와 담는다.
        }
        catch (Exception e){
            logger.debug(e.getMessage());
        }
        model.addAttribute("judgeVO",judgeVO); //심판 정보를 담는다.
        model.addAttribute("adminInfo",adminInfo);
        model.addAttribute("judgeKindList",judgeKindList); //ㅎㅎ
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
        //judgeNo로 했는데 못찾아서 새로이 추가를 해줬다.

        try{
            result = judgeService.updateJudgeStateY(judgeVO);
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
        model.addAttribute("adminInfo",adminInfo);
        //model.addAttribute("judgeList", judgeList);

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
