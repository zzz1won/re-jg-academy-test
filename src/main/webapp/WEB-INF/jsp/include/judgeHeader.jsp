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
            <a href="javascript:fn_judgePage();">
                <img alt="심판아카데미 운영시스템" src="${pageContext.request.contextPath}/resources/images/logo_system.png">
            </a>
        </h1>
        <div class="util-wrap">
            <ul class="util-list">
                <li class="util-my">
                    <span>
                    	<c:forEach var="kind" items="${judgeKindList}" varStatus="status">
							<c:if test="${kind.code eq judgeInfo.judgeKind}">
								<c:out value="${kind.codeName}"/>
							</c:if>
						</c:forEach>
                    </span>
                    <span><c:out value="${judgeInfo.judgeNo}"/></span>
                    <span><em><c:out value="${judgeInfo.judgeName}"/></em>님</span>
                </li>
                <li class="util-logout">
                    <a href="#" id="btn_pop_logout">나가기</a>
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
        location.href = "<c:out value='${pageContext.request.contextPath}/judge/logout'/>";
    });
});

<%-- 심판 화면(수강 신청) --%>
function fn_judgePage(){
	location.href = "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule'/>";
}

<%-- 수강신청 목록 --%>
function fn_scheduleList(){
	location.href = "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule'/>";
}

<%-- 수강내역 목록 --%>
function fn_applyList(){
	location.href = "<c:out value='${pageContext.request.contextPath}/apply/judge/history'/>";
}

function fn_calendar(){
	location.href = "<c:out value='${pageContext.request.contextPath}/calendar/judge/calendarList'/>";
}

</script>