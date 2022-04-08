<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<script src="${pageContext.request.contextPath}/resources/js/admin-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.modal.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/modal-box.js"></script>

<!-- header -->
<div id="header">
    <div class="header-container">
        <h1 class="logo-wrap">
            <a href="javascript:fn_adminPage();">
                <img alt="심판아카데미 운영 Admin" src="${pageContext.request.contextPath}/resources/images/logo_admin.png">
            </a>
        </h1>
        <div class="util-wrap">
            <ul class="util-list">
                <li class="util-my">
                    <span><em><c:out value="${adminInfo.adminName}"/></em>님</span>
                </li>
                <li class="util-logout">
                    <a href="#" id="btn_pop_logout">로그아웃</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- //header -->

<%-- 로그아웃 팝업 --%>
<div class="modal no_close" id="pop_logout">
    <div class="popup-content">
        <p class="pop-text">로그아웃 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_confirm_logout" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<%-- //로그아웃 팝업 --%>

<script type="text/javascript">
$(function(){
	//bPopup 사용
    $('#btn_pop_logout').click(function(){
        $('#pop_logout').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
    });
    $("#btn_confirm_logout").click(function(){ //확인
        $('#pop_logout').bPopup().close();
        location.href = "<c:out value='${pageContext.request.contextPath}/admin/logout'/>";
    });
});

<%-- 관리자 화면(교육 일정 관리) --%>
function fn_adminPage(){
	location.href = "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
}

<%-- 교육 일정 관리 화면으로 이동 --%>
function fn_scheduleList(){
	location.href="<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
}

<%-- 신청 관리 화면으로 이동 --%>
function fn_applyList(){
	location.href="<c:out value='${pageContext.request.contextPath}/apply/admin/confirm'/>";
}

<%-- 수료 관리 화면으로 이동 --%>
function fn_certList(){
	location.href="<c:out value='${pageContext.request.contextPath}/cert/admin/confirm'/>";
}

<%-- 220408 코드 관리 화면으로 이동--%>
function fn_codeList(){
    location.href="<c:out value='${pageContext.request.contextPath}/code/admin/confirm'/>";
    //살아있남?
}
<%-- 심판 관리 화면으로 이동 --%>
/*function fn_judgeMemberList(){
	location.href="<c:out value='${pageContext.request.contextPath}/judge/admin/judgeMemberList'/>";
}*/
</script>