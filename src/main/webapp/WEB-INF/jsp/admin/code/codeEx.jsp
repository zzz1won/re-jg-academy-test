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
    <title>심판아카데미 운영 Admin</title>
    <%-- jquery cdn을 포함하고 있기 때문에 script보다 위에 위치해야한다. --%>
    <jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
</head>
<script>
    $(function () {

        alert("지원관리 입장");
        $("#btn_search").click(function () {
            alert("year: " + $("#year").val() + "\t eduTitle: " + $("#eduTitle").val() + "\t applyState: " + $("#applyState").val() + "\t judgeNo: " + $("#judgeNo").val());
        })

        ajaxTest();

    })

    function ajaxTest() {
        var param = {"year": "${searchVO.year}",
            "eduTitle":"${searchVO.eduTitle}",
            "applyState":"${searchVO.applyState}",
            "judgeNo":"${searchVO.judgeNo}"
        }
        //일단 year만!
        //var param = { "연도: ":$('#year').val()   }; //일단 year만!
        console.log(param);
        $.ajax({
            type: "post",
            url: "<c:out value='${pageContext.request.contextPath}/code/admin/codeEx2'/>",
            dataType: "json",
            data: JSON.stringify(param), //여기의 제이슨은 대문자로만 써야하나봐
            contentType: "application/json;charset=UTF-8",  //헤더값 설정(?)
            success: function(data) {
                if(data.result >0){
                    alert('됐다!');
                    $('#listTable2').text(''); //공백으로 만든다.

                }
                else    {
                    alert('ajax는 성공, 코드를 다시.');


                }
            },
            error: function(){
                    alert('ajax 실패');
                    console.log('힝입니다')
            }

        })
    }


</script>
<body>
<%--이 위치는 상관없는건가?--%>
<div id="wrapper">
    <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>
    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <!-- menu: 3개->6개 -->
                <div class="tab-wrap tab6">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    <%-- 220408 4개로 추가--%>
                    <a href="javascript:fn_codeList();" class="tablinks"> 코드 관리</a>
                    <%-- 220408 5개로 추가--%>
                    <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
                    <%-- 220510 6개로 추가--%>
                    <%-- adminHeader.jsp 파일에 선언해두었기 때문에 파일마다 일일히 function~ 할 필요 없음.--%>
                    <a href="javascript:fn_codingEx();" class="tablinks active"> 지원 관리</a>
                </div>
                <!-- //menu -->
            </div>
        </div>
        <!-- search area -->
        <div class="search-wrap">
            <div class="search-container">
                <form id="searchForm" name="searchForm">
                    <ul class="filter-row">
                        <li>
                            <label for="year">조회기간</label>
                            <input type="text" id="year" name="year" value="<c:out value='${searchVO.year}'/>"
                                   class="input-text year icon_calendar" style="width:100px" placeholder="년도"/>
                        </li>
                        <li>
                            <label for="eduTitle">과정명</label>
                            <input type="text" id="eduTitle" name="eduTitle" class="input-text" style="width:300px"
                                   value="<c:out value="${search.eduTitle}"/>" placeholder="과정명 입력"/>
                        </li>
                        <li>
                            <label for="applyState">수료확정</label>
                            <select id="applyState" name="applyState" class="wd_140">
                                <option value="">전체</option>
                                <c:forEach var="applyState" items="${applyStateList}" varStatus="Status">
                                    <option value="<c:out value="${applyState.code}"/>"
                                            <c:if test="${applyState.code eq search.applyState}">selected="selected"</c:if>>
                                        <c:out value="${applyState.codeName}"/></option>
                                </c:forEach>
                            </select>
                        </li>
                        <li>
                            <label for="judgeNo">심판번호</label>
                            <input type="text" id="judgeNo" name="judgeNo" class="input-text" style="width:140px"
                                   value="<c:out value="${search.judgeNo}"/>"/>
                        </li>
                        <li>
                            <button type="button" id="btn_search" class="btn2 btn-search">
                                <span>조회</span>
                            </button>
                        </li>
                    </ul>
                </form>
            </div>
        </div>
    </div>

    <div class="content-wrap">
        <div class="table-wrap">
            <table id="listTable" class="cell-border hover dataTable" width="100%">
                <thead>
                <tr>
                    <th><input name="select_all" value="1" id="select-all" type="checkbox"/></th>
                    <th>No</th>
                    <th style="width: 210px;">과정명</th>
                    <th>종목</th>
                    <th>심판번호</th>
                    <th>이름</th>
                    <th>수료기간</th>
                    <th>수료확정</th>
                    <th>수료증</th>
                    <th>확정일시</th>
                    <th>확정자</th>
                    <th>등록일시</th>
                    <th>등록자</th>
                </tr>
                </thead>
                <tbody id="listTable2">
                </tbody>
            </table>
        </div>
    </div>
    연습!
</div>
<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
</html>