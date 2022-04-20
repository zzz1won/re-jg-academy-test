<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>심판아카데미 운영시스템</title>
</head>

<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>

<script type="text/javascript">
    var check = false; //왜 false로 해두는걸까?
    //true로 두면 어떻게 되는가?

    $(function (){ //function ready script!

        /*심판 정보 등록*/
        $('#btn_register').click(function (){ //등록 버튼을 누르면
            /*필수 입력값 체크*/
            check = fn_checkForm();
            console.log("필수입력값 체크")
            if(check){ //false일 때 = fn_checkForm 비어있는 경우
                $('#pop_confirm_register').bPopup({
                    speed:450
                });
            }
        });

        /*등록버튼 클릭*/
        $('#btn_confirm_register').click(function (){
            //등록버튼을 클릭하면, 등록을 시켜야지...
            $('#pop_confirm_register').bPopup().close();
            console.log("신규심판등록 버튼 클릭")
            if(check){ //false
                if(doubleSubmitCheck()) return; //common.jsp에 있는 doubleSubmitCheck 함수 호출-실행

                $.ajax({
                    type:"post",
                    url: "<c:out value="${pageContext.request.contextPath}/judge/register/"/>",
                    data: JSON.stringify($('#registerform').serializeObject()),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data){
                        if(data.result> 0){
                            $('#pop_success_register').bPopup(); //ajax 통신완료, 등록에 성공할 경우 팝업띄우기
                            console.log("ajax 통신 성공");
                        } else {
                            $('#pop_fail_register').bPopup(); //ajax 통신완료, 등록에 실패할 경우 팝업띄우기
                            console.log("ajax 통신 성공");
                        }
                    },
                    error: function (){
                        $('#pop_fail_register').bPopup(); //ajax 통신실패, 등록에 실패
                        console.log("ajax 통신 실패");
                    }
                });

                doubleSubmitFlag = false; //굳이 여기에 쓰는 이유가 있는가?
            } else {
                alert("다시 한 번 확인 해주세요")
            }
        })
    })

    <%-- 필수입력값 체크 --%>
    function fn_checkForm(){

        <%-- 종목 --%>
        if($('#judgeKind').val().length < 1){
            $('#pop_check_form_judge_kind').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            return false;
        }
        <%-- 심판이름 --%>
        if($('#judgeName').val().length < 1){
            $('#pop_check_form_judge_name').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            return false;
        }

        <%-- 계정사용여부 --%>
        if($('#judgeState').val().length < 1){
            $('#pop_check_form_judge_state').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            return false;
        }
        return true;
    }

</script>

<body>
<!-- wrapper -->
<div id="wrapper">
    <jsp:include page="/WEB-INF/jsp/include/judgeHeader.jsp"/>
    <!-- container -->
    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <!-- tab: 2개-->
                <div class="tab-wrap">
                    <a href="javascript:fn_scheduleList();" class="tablinks">수강신청</a>
                    <a href="javascript:fn_applyList();" class="tablinks active">수강내역</a>
                </div>
                <!-- //tab -->
            </div>
        </div>
    </div>
    <!-- table-wrap -->
    <div class="content-wrap">
        <form id="registerForm" name="registerForm">
            <div class="table-write-wrap">
                <!-- table -->
                <table>
                    <caption>신규 심판 등록 테이블</caption>
                    <colgroup>
                        <col width="140px">
                        <col width="">
                        <col width="140px">
                        <col width="">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th class="required_need">종목</th>
                        <td>
                            <select id="judgeKind" name="judgeKind" class="login_select wide">
                                <option value="">종목을 선택하세요</option>
                                    <c:forEach var="code" items="${codeVO}" varStatus="status">
                                        <option value="<c:out value="${code.code}"/>"><c:out value="${code.codeName}"/></option>
                                    </c:forEach>
                            </select>
                        </td>

                        <th>심판번호</th>
                        <td>자동부여</td>
                    </tr>
                    <tr>
                        <th class="required_need">이름</th>
                        <td><input type="text" name="judgeName" id="judgeName"
                                   placeholder="이름"></td>
                        <th class="required_need">계정사용여부</th>
                        <td>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="judgeState" id="judgeState" value="Y">
                                <label class="form-check-label" for="judgeState">
                                    예
                                </label>
                                <input class="form-check-input" type="radio" name="judgeState" value="N">
                                <label class="form-check-label" for="judgeState">
                                    아니오
                                </label>
                            </div>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td colspan="3"><input type="text" name="judgeEtc" id="judgeEtc" placeholder="내용을 입력해주세요">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </form>

        <div class="btn-wrap">
            <button type="button" id="btn_register" class="btn2 btn-blue">등록</button>
            <button type="button" id="btn_index" class="btn2 btn-gray">등록 안 함</button>
        </div>
        <!-- //btn area -->
    </div>
    <!-- //table-wrap -->
    <!-- //container -->
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</div>
<!-- //wrapper -->


<!-- popup 01-->
<div class="modal" id="pop_detail" style="width: 900px;"></div>
<!-- //popup 01-->

<%-- popup 02 --%>
<div class="modal no_close" id="pop_check_form_judge_kind">
    <div class="popup-content">
        <p class="pop-text"> 종목을 선택해주세요</p>
        <div class="btn_wrap">
            <button type="button" id="btn_check_form_judge_kind" class="btn2 btn-blue b-close"> 확인 </button>
        </div>
    </div>
</div>
<%-- popup 02 --%>
<%-- popup 02 --%>
<div class="modal no_close" id="pop_check_form_judge_name">
    <div class="popup-content">
        <p class="pop-text"> 이름을 확인 해주세요</p>
        <div class="btn_wrap">
            <button type="button" id="btn_check_form_judge_name" class="btn2 btn-blue b-close"> 확인 </button>
        </div>
    </div>
</div>
<%-- popup 02 --%>
<%-- popup 02 --%>
<div class="modal no_close" id="pop_check_form_judge_state">
    <div class="popup-content">
        <p class="pop-text"> 계정상태를 체크해주세요</p>
        <div class="btn_wrap">
            <button type="button" id="btn_check_form_judge_state" class="btn2 btn-blue b-close"> 확인 </button>
        </div>
    </div>
</div>
<%-- popup 02 --%>


<%-- 버튼, 팝업 --%>
<script type="text/javascript">
    $(document).ready(function (){
        /* 등록안함 : index로 돌아가기 */
        $('#btn_index').click(function(){
            location.href ="<c:out value="${pageContext.request.contextPath}/judge/index"/>";
            console.log("등록 안 함 클릭 ")
        }) //버튼누르고 이동하는건 이 코드를 참고하면 좋을 것 같다.

        /* 등록(가입) 성공 */
        $('#btn_success_register').click(function(){
            $('#pop_success_register').bPopup().close(); //
            location.href = "<c:out value="${pageContext.request.contextPath}/judge/index"/>";
            console.log("심판 가입 성공");
        })
        /* 등록(가입) 실패 */
        $('#btn_fail_register').click(function (){
            $('#pop_fail_register').bPopup().close();
            console.log("심판 가입 실패")
        })

        /* --- required 항목들 기재 포커스 --- */
        /* 종목 포커스 */
        $('#btn_check_form_judgeKind').click(function (){
            $('#judgeKind').focus();
        })
        /* 이름 포커스 */
        $('#btn_check_form_judge_name').click(function(){
            $('#judgeName').focus();
        })
        /* 계정사용여부 포커스 */
        $('btn_check_form_judge_state').click(function(){
            $('#judgeState').focus();
        })

    })
</script>
</body>
</html>