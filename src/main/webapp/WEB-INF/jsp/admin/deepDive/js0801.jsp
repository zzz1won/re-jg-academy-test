<%--
  Created by IntelliJ IDEA.
  User: home
  Date: 2022-07-26
  Time: 오후 3:36
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
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

    <title>심판아카데미 운영 Admin-deepDive 연습</title>

</head>
<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>
<%--아이콘 없다고 404뜨길래, 추가했더니 되었다 ^^--%>
<script>
    $(function () {
        //fn_after();
        btnClick();
        btnClick2();
    })

    function btnClick() {
        $('#btn1').click(function () {
            fn_after();
            fn_prepend();
            fn_text()
        });
    }

    function btnClick2(){
        $('#btn2').click(function(){
           fn_append();
            fn_wrap();
            fn_empty();
        });

    }

    function fn_after() {
        $('p.paa').before("🌞");
    }
    function fn_prepend() {
        $('.htmlFn').prepend("🍊상큼하게 오렌지 🍎말끔하게 사과");
    }
    function fn_append(){
        $('span#saa').append("🥺");
    }
    function fn_wrap(){
        $('#sbb').wrap('<p class="paa"></p>'); //굳이 왜 이렇게 하지?
    }
    function fn_empty(){
        $('p').empty();
    }
    function fn_text(){
        $('.sss').html('구운 계란 3개');
    }
</script>
<style>

</style>
<body>
<div class="jqueryEx">
    <div id="wrapper">

        <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>

        <!-- container -->
        <div id="container">
            <div class="sub-tit-wrap">
                <div class="sub-tit-container">
                    <!-- menu: 6개-->
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
    </div>
    <%-- 상단 메뉴 박스 --%>

    <input type="button" value="🍙" id="btn1">
    <div class="htmlFn">
        <p> 아침에 부족한 단백질을 맛있게 채우다 </p>
        <p> 프로틴 그래놀라 </p>
        <p> 다크 초코볼 </p>
        <p class="paa"> 켈로그 프로틴 라인업을 만나보세요! </p>
        <h4><p class="pbb" style="color:blue"> 파랑 </p></h4>
        <h4><p class="pcc" style="color:red"> 빨강 </p></h4>

        <input type="button" value="🍙🍙" id="btn2">
        <h3><span class="sss"> 삶은 계란 3개* 분량의 </span></h3>
        <h3> 단백질(17g**)로 </h3>
        <h4> 아침을 든든하게 시작하세요! </h4>
        <span> *중란 / 전란x3개 기준 </span>
        <span id="saa"> **제품 100g당 기준</span>
        <h5><span id="sbb"> 제품정보 </span></h5>
        <h5><span id="scc"> 중량 450g | 유통기한 : 생산일로부터 12개월 </span></h5>
    </div><br>

    <%-- 220802 --%>
    <div id="chkBoxTest">
        <p>checkBox Test 고양이🐱 </p>
        <input type="checkbox" class="chkBox" name="내가 젤 좋아하는 코리안숏헤어"/> 코리안숏헤어<br>
        <input type="checkbox" class="chkBox" name="친화적인 러시안블루"/> 러시안블루<br>
        <input type="checkbox" class="chkBox" name="조금 사나운 아비니시안"/> 아비니시안<br>
        <input type="checkbox" class="chkBox" name="맨들맨들 스핑크스"/> 스핑크스<br>
        <input type="checkbox" class="chkBox" name="조금 커다란 아메리칸숏헤어"/> 아메리칸숏헤어<br>
        <input type="checkbox" class="chkBox" name="동글동글 브리티쉬숏헤어"/> 브리티쉬숏헤어<br>
        <input type="checkbox" class="chkBox" name="크다란 메인쿤"/> 메인쿤<br>
        <br>
        <textarea></textarea>
    </div>

</div>
</body>
</html>
