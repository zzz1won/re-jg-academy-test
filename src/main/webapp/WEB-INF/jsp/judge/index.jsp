<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>심판아카데미 운영시스템</title>
</head>

<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>

<script type="text/javascript">
    $(function(){
        <c:if test="${not empty message}">
        $('#pop_fail_login').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
        </c:if>
    });
</script>

<body class="login_bg">
<!-- login-wrap -->
<div class="login-wrap">
    <div class="login-box">
        <h1 class="logo-login">LOGIN</h1>
        <form id="loginForm">
            <hr class="hr-2line">
            <div class="inp-group">
                <label for="judgeKind" class="hidden">종목</label>
                <select id="judgeKind" name="judgeKind" class="login_select wide">
                    <option value="">종목을 선택해주세요.</option>
                    <c:forEach var="judgeKind" items="${judgeKindList}" varStatus="status">
                        <option value="<c:out value="${judgeKind.code}"/>"> <c:out value="${judgeKind.codeName}"/> </option>
                    </c:forEach>
                </select>
            </div>
            <div class="inp-group">
                <label for="judgeNo" class="hidden">개인번호</label>
                <input type="text" class="input-form" id="judgeNo" name="judgeNo" placeholder="개인번호를 입력해주세요.">
            </div>
            <div class="inp-group">
                <label for="judgeName" class="hidden">이름</label>
                <input type="text" class="input-form" id="judgeName" name="judgeName" placeholder="이름을 입력해주세요.">
            </div>
            <div class="inp-group">
                <button type="button" id="btn_login" class="btn2 btn-login">입장하기</button>
                <button type="button" id="btn_join" class="btn2 btn-login">심판신규등록</button>
            </div>
        </form>
        <div id="login-footer">
            Copyright © 2018 Smart5, ALL RIGHT RESERVED.
        </div>
    </div>
</div>
<!-- //login-wrap -->

<!-- popup 01-->
<div class="modal no_close" id="pop_judgeKind">
    <div class="popup-content">
        <p class="pop-text">종목 선택이 누락 되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_judgeKind" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 01-->

<!-- popup 02-->
<div class="modal no_close" id="pop_judgeInfo">
    <div class="popup-content">
        <p class="pop-text">심판번호 또는 이름이 누락 되었거나 <br>잘못된 형식 입니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_judgeInfo" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 02-->

<!-- popup 03-->
<div class="modal no_close" id="pop_fail_login">
    <div class="popup-content">
        <p class="pop-text"><c:out value="${message}" escapeXml="false"/></p>
        <div class="btn-wrap">
            <button type="button" id="btn_fail_login" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-->

<!-- custom js -->
<script type="text/javascript">
    $(document).ready(function () {
        <%-- 신규가입 시도 --%>
        $('#btn_join').click(function(){
            return checkForm();
        });
        <%-- 신규 교육과정 등록화면으로 이동 --%>
        $('#btn_join').click(function(){
            location.href="<c:out value='${pageContext.request.contextPath}/judge/registerPage'/>";
            console.log("register 버튼 누름")
        });

        //로그인 셀렉트메뉴
        $('.login_select').niceSelect();

        <%-- 로그인 시도 --%>
        $('#btn_login').click(function(){
            return checkForm();
        });
        <%-- 종목 누락 팝업 닫기 --%>
        $("#btn_judgeKind").click(function(){
            $('#pop_judgeKind').bPopup().close();
        });
        <%-- 심판정보 팝업 닫기 --%>
        $("#btn_judgeInfo").click(function(){
            $('#pop_judgeInfo').bPopup().close();
        });
        <%-- 로그인 실패 팝업 닫기 --%>
        $("#btn_fail_login").click(function(){
            $('#pop_fail_login').bPopup().close();
        });
        /* 간편 로그인 */
        $("#judgeKind").val('100017')
        $("#judgeNo").val('23')
        $("#judgeName").val('이리아')

    });

    <%-- 로그인 폼 체크 --%>
    function checkForm(){
        <%-- 종목 --%>
        if($('#judgeKind option:selected').val() == ''){
            $('#pop_judgeKind').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            return false;
        }

        var judgeKind = $('#judgeKind').val();
        var judgeNo = $('#judgeNo').val();
        var judgeName = $('#judgeName').val();

        if( (checkJudgeNo(judgeNo) && checkJudgeName(judgeName)) != true ){
            $('#pop_judgeInfo').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            return false;
        }

        $('#loginForm').attr("method", "post");
        $('#loginForm').attr("action", "<c:out value='${pageContext.request.contextPath}/judge/login'/>");
        $('#loginForm').submit();
    }

    <%-- 심판번호 유효성 검사 --%>
    function checkJudgeNo(judgeNo){
        <%-- 한글, 영어, 숫자만 사용하며 2~10글자인지 확인 --%>
        var regExp = RegExp(/^[가-힣a-zA-Z0-9]{1,10}$/);
        return regExp.test(judgeNo);
    }

    <%-- 이름 유효성 검사 --%>
    function checkJudgeName(judgeName){
        <%-- 한글, 영어만 사용하며 2~10글자인지 확인 --%>
        var regExp = RegExp(/^[가-힣a-zA-Z]{2,10}$/);
        return regExp.test(judgeName);
    }

    <%-- 그룹코드명 포커스 --%>
    $("#btn_judgeKind").click(function(){
        $('#judgeKind').focus();
    });
</script>

</body>
</html>