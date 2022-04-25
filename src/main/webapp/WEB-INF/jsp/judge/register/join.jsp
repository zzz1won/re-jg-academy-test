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
    <title>심판아카데미 운영 judge</title>
</head>

<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>

<%--잘 보고 진행 할 것, 차근차근...--%>
<script type="text/javascript">
    var check = false;

    $(function(){
        <%-- 심판정보 등록 --%>
        $("#btn_register").click(function(){
            <%-- 필수입력값 체크 --%>
            check = fn_checkForm();
            console.log("필수입력값 체크")
            if(check){
                $('#pop_confirm_register').bPopup({
                    speed: 450,
                    // transition: 'slideDown'
                });
            }
        });

        <%-- 등록 버튼 클릭 --%>
        $('#btn_confirm_register').click(function(){
            $('#pop_confirm_register').bPopup().close();
            console.log("신규심판등록 버튼 클릭")
            if(check){
                <%-- 중복 클릭 방지 --%>
                if(doubleSubmitCheck()) return;

                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/judge/register'/>",
                    data: JSON.stringify($('#registerForm').serializeObject()),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function(data){
                        if(data.result > 0){
                            $('#pop_success_register').bPopup();
                        } else{
                            $('#pop_fail_register').bPopup();
                        }
                    },
                    error: function(){
                        $('#pop_fail_register').bPopup();
                    }
                });

                doubleSubmitFlag = false;
            } else{
                alert("다시 한 번 확인해주시기바랍니다.");
            }
        });
    });

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

    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <div class="tab-wrap">
                    <a href="javascript:fn_applyList();" class="tablinks">가입 후 이용 가능</a>
                    <a href="javascript:fn_applyList();" class="tablinks"> 😎 </a>
                </div>
                <!-- //menu -->
            </div>
        </div>
        <!-- table-wrap -->
        <div class="content-wrap">
            <form id="registerForm" name="registerForm">
                <div class="table-write-wrap">
                    <!-- table -->
                    <table>
                        <caption>코드 등록 테이블</caption>
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
                                        <option value="<c:out value="${code.code}"/>"> <c:out value="${code.codeName}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>

                            <th>심판번호</th>
                            <td>자동부여됩니다~</td>
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
                            <td colspan="3"><input type="text" name="judgeEtc" id="judgeEtc"
                                                   placeholder="내용을 입력해주세요">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <%--<input type = "hidden" name="judgeNo" value="${judgeVO.judgeNo}">--%>
                    <!-- //table -->
                </div>
                <%--<!-- btn area -->--%>
            </form>

            <div class="btn-wrap">
                <button type="button" id="btn_register" class="btn2 btn-blue">등록</button>
                <button type="button" id="btn_judge_list" class="btn2 btn-gray">목록</button>
            </div>
            <!-- //btn area -->
        </div>
        <!-- //table-wrap -->
    </div>
    <!-- //container -->

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

</div>
<%--<!-- //wrapper -->--%>
<!-- popup 01-->
<div class="modal no_close" id="pop_confirm_register">
    <div class="popup-content">
        <p class="pop-text">신규심판정보를 등록 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_confirm_register" class="btn2 btn-blue">등록</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 01-->
<!-- popup 02-->
<div class="modal no_close" id="pop_success_register">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.
        <div class="btn-wrap">
            <button type="button" id="btn_success_register" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 02-->
<div class="modal no_close" id="pop_fail_register">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되지 않았습니다.<br>관리자에게 문의해주세요.
        <div class="btn-wrap">
            <button type="button" id="btn_fail_register" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_kind">
    <div class="popup-content">
        <p class="pop-text">종목을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_kind" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_no">
    <div class="popup-content">
        <p class="pop-text">번호는 비활성화~</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_no" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_name">
    <div class="popup-content">
        <p class="pop-text">이름을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_name" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->

<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_state">
    <div class="popup-content">
        <p class="pop-text">계정사용여부를 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_state" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->


<%-- 버튼, 팝업 --%>
<script type="text/javascript">
    $(document).ready(function () {

        <%-- 목록 버튼 클릭--%>
        $('#btn_judge_list').click(function () {
            location.href = "<c:out value='${pageContext.request.contextPath}/judge/index'/>";
            console.log("목록버튼클릭");
        });

        <%-- 등록 성공 --%>
        $("#btn_success_register").click(function () {
            $('#pop_success_register').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/judge/index'/>";
            console.log("등록성공");
        });
        <%-- 등록 실패 --%>
        $("#btn_fail_register").click(function () {
            $('#pop_fail_register').bPopup().close();
            console.log("등록실패");
        });

        <%-- 종목 포커스 --%>
        $("#btn_check_form_judge_kind").click(function () {
            $('#judgeKind').focus();
        });
        <%-- 심판이름 포커스 --%>
        $("#btn_check_form_judge_name").click(function () {
            $('#judgeName').focus();
        });
        <%-- 계정사용여부 포커스 --%>
        $("#btn_check_form_judge_state").click(function () {
            $('#judgeState').focus();
        });
    });
</script>
</body>
</html>