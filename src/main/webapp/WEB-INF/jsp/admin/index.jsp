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
    <title>심판아카데미 운영 Admin</title>
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
    <div class="login-wrap login-admin">
        <div class="login-box">
            <h1 class="logo-login">LOGIN</h1>
            <form id="loginForm">
                <hr class="hr-2line">
                <div class="inp-group">
                    <label for="adminId" class="hidden">사번</label>
                    <input type="text" class="input-form" id="adminId" name="adminId" placeholder="사번을 입력해주세요.">
                </div>
                <div class="inp-group">
                    <label for="adminName" class="hidden">이름</label>
                    <input type="text" class="input-form" id="adminName" name="adminName" placeholder="이름을 입력해주세요.">
                </div>
                <div class="inp-group">
                    <button type="button" name="btn_login" id="btn_login" class="btn2 btn-login">로그인</button>
                </div>
            </form>
            <div id="login-footer">
                Copyright Smart5, ALL RIGHT RESERVED.
            </div>
        </div>
    </div>
    <!-- //login-wrap -->
    <!-- popup 01-->
    <div class="modal no_close" id="pop_confirm_login">
        <div class="popup-content">
            <p class="pop-text">로그인 정보 오류 입니다. <br>확인 후 다시 시도해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_confirm_login" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 01-->

	<!-- popup 02-->
    <div class="modal no_close" id="pop_fail_login">
        <div class="popup-content">
            <p class="pop-text"><c:out value="${message}" escapeXml="false"/></p>
            <div class="btn-wrap">
                <button type="button" id="btn_fail_login" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->

    <!-- custom js -->
    <script type="text/javascript">
        $(document).ready(function () {
            <%-- 로그인 시도 --%>
            $('#btn_login').click(function(){
            	return checkForm();
            });
            <%-- 로그인 정규식 실패 --%>
            $("#btn_confirm_login").click(function(){
                $('#pop_confirm_login').bPopup().close();
            });
            <%-- 로그인 실패 팝업 닫기 --%>
            $("#btn_fail_login").click(function(){
                $('#pop_fail_login').bPopup().close();
            });
        });

        <%-- 로그인 폼 체크 --%>
        function checkForm(){
        	var adminId = $('#adminId').val();
        	var adminName = $('#adminName').val();
        	
        	if( (checkAdminId(adminId) && checkAdminName(adminName)) != true ){
        		$('#pop_confirm_login').bPopup({
                    speed: 450,
                    // transition: 'slideDown'
                });
        		return false;
        	}
        	
        	$('#loginForm').attr("method", "post");
        	$('#loginForm').attr("action", "<c:out value='${pageContext.request.contextPath}/admin/login'/>");
        	$('#loginForm').submit();
        }

        <%-- 관리자id 유효성 검사 --%>
        function checkAdminId(adminId){
        	
        	<%-- 영어, 숫자만 사용하며 2~10글자인지 확인 --%>
        	var regExp = RegExp(/^[a-zA-Z0-9]{2,10}$/);
        	return regExp.test(adminId);
        }

        <%-- 관리자이름 유효성 검사 --%>
        function checkAdminName(adminName){
        	
        	<%-- 한글, 영어만 사용하며 2~10글자인지 확인 --%>
        	var regExp = RegExp(/^[가-힣a-zA-Z]{2,10}$/);
        	return regExp.test(adminName);
        }
        
    </script>
    
</body>
</html>