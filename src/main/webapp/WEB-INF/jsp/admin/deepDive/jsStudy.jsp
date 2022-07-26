<%--
  Created by IntelliJ IDEA.
  User: home
  Date: 2022-04-27
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
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
    <title>심판아카데미 운영 Admin-deepDive 연습</title>
</head>
<%--Failed to load resource: the server responded with a status of 404 ()--%>
<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>
<%--아이콘 없다고 404뜨길래, 추가했더니 되었다 ^^--%>

<script>
    $(function () {
        alert('jsStudy 입장');
        click53Btn();
        click54Btn();
        click726Btn();
    })

    //버튼을 누르면 ~0523 js공부 페이지로 이동
    function click53Btn() {
        $('#before53btn').click(function () {
            alert('before53btn click_이동합니다.');
            console.log('before53btn click_이동합니다.');
            location.href = "<c:out value="${pageContext.request.contextPath}/code/admin/js0523"/>";
        })
    };

    function click54Btn() {
        $('#after54btn').click(function () {
            alert('after54btn click_이동합니다.');
            console.log('after54btn click_이동합니다.');
            location.href = "<c:out value="${pageContext.request.contextPath}/code/admin/js0524"/>";
        })
    }

    function click726Btn(){
        $('#after726').click(function(){
          location.href= "<c:out value="${pageContext.request.contextPath}/code/admin/js0726"/>";
        })
    }
</script>

<style>

</style>
<body>
<div id="wrapper">
    <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>
    <div class="sub-tit-wrap">
        <div class="sub-tit-container">
            <!-- menu: 3개->6개 -->
            <div class="tab-wrap tab6">
                <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                <%-- 220408 4개로 추가--%>
                <a href="javascript:fn_codeList();" class="tablinks active"> 코드 관리</a>
                <%-- 220408 5개로 추가--%>
                <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
                <%-- 220510 6개로 추가--%>
                <%-- adminHeader.jsp 파일에 선언해두었기 때문에 파일마다 일일히 function~ 할 필요 없음.--%>
                <a href="javascript:fn_codingEx();" class="tablinks"> 지원 관리</a>
            </div>
            <!-- //menu -->
        </div>
    </div>
</div>
<div class="content-wrap">
    <div class="btn-wrap" align="right">
        <div class="jquery" id="jquery1"></div>
        <div class="jquery" id="jquery2"></div>
        <div class="jsStudy" id="before53" style="margin-bottom: 20px"><input type="button" class="btn2 btn-search" id="before53btn"
                                                  value="😎53btn"> <%--누르면 0523 이전 js 공부 페이지로 이동--%></div>
        <div class="jsStudy" id="after54" style="margin-bottom: 20px"><input type="button" class="btn2 btn-search" id="after54btn"
                                                 value="💕54btn"> <%--누르면 0524 이후 js 공부 페이지로 이동 --%></div>
        <div class="jsStudy" id="after726" style="margin-bottom: 20px"><input type="button" class="btn2 btn-search" id="after54btn"
                                                                             value="💕0726btn"> <%--누르면 0726 이후 js 공부 페이지로 이동 --%></div>
    </div>
</div>
</body>
</html>
