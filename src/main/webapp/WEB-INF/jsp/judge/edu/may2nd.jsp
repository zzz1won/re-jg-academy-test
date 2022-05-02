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

    <jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
</head>

<script>
    $(document).ready(function () {

        console.log("document ready~");
    })

</script>
<style>
    .scheduleView {
        display: inline-flex;
        width:80%;
    }
    .content-wrap {
        display: inline-block;
        width: 50%;
    }
    .table-write-wrap {
        display: inline-block;
        width: 50%;
    }
</style>

<body>

<div id="wrapper">

    <jsp:include page="/WEB-INF/jsp/include/judgeHeader.jsp"/>

    <!-- container -->
    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <!-- tab: 2개-->
                <div class="tab-wrap tab3">
                    <a href="javascript:fn_scheduleList();" class="tablinks">수강신청</a>
                    <a href="javascript:fn_scheduleList2();" class="tablinks active">수강신청2</a>
                    <a href="javascript:fn_applyList();" class="tablinks">수강내역</a>
                </div>
                <!-- //tab -->
            </div>
        </div>

        <!-- search area -->
        <div class="search-wrap">
            <div class="search-container">
                <form id="searchForm" name="searchForm">
                    <ul class="filter-row">
                        <li>
                            <label for="year">조회기간</label>
                            <input type="text" id="year" name="year" value="<c:out value='${search.year}'/>"
                                   class="input-text year icon_calendar" style="width:100px" placeholder="년도"/>
                        </li>
                        <li>
                            <button type="button" id="btn-search" class="btn2 btn-search">
                                <span>조회</span>
                            </button>
                        </li>
                    </ul>
                </form>
            </div>
        </div>
        <!-- //search area -->
    </div>

    <div class="scheduleView">
        <!-- table-wrap -->
        <div class="content-wrap">
            <div class="table-wrap">
                <!-- table -->
                <table id="listTable" class="cell-border hover dataTable" width="100%">
                    <thead>
                    <tr>
                        <th>No</th>
                        <th>과정명</th>
                        <th>수강기간</th>
                        <th>장소</th>
                        <th>인원</th>
                        <th>신청기간</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="edu" items="${eduList}" varStatus="status">
                        <c:if test="${eduListCnt > 0}">
                            <tr>
                                <td><c:out value="${edu.rownum}"/></td>
                                <td><c:out value="${edu.acEduTitleMask}"/></td>
                                <td>
                                    <fmt:parseDate var="acEduStartDate" value="${edu.acEduStartDate}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd"/>
                                    ~
                                    <fmt:parseDate var="acEduEndDate" value="${edu.acEduEndDate}" pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd"/>
                                </td>
                                <td><c:out value="${edu.acEduPlace}"/></td>
                                <td><c:out value="${edu.acApplyCount}"/>/<c:out value="${edu.acApplyLimitCount}"/></td>
                                <td>
                                    <fmt:parseDate var="acApplyStartDate" value="${edu.acApplyStartDate}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${acApplyStartDate}" pattern="yyyy/MM/dd"/>
                                    ~
                                    <fmt:parseDate var="acApplyEndDate" value="${edu.acApplyEndDate}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${acApplyEndDate}" pattern="yyyy/MM/dd"/>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //table -->
            </div>
        </div>
        <div class="table-write-wrap">
            <!-- table -->
            <table>
                <caption>과정상세 정보 테이블</caption>
                <colgroup>
                    <col width="110px">
                    <col width="">
                    <col width="110px">
                    <col width="">
                </colgroup>
                <tbody>
                <tr>
                    <th>과 정 명</th>
                    <td colspan="3" class="t_tit"><c:out value="${eduInfo.acEduTitle}"/></td>
                </tr>
                <tr>
                    <th>주관기관</th>
                    <td><c:out value="${eduInfo.acEduInstitute}"/></td>
                    <th>교육사이트</th>
                    <td><a href="<c:out value="${eduInfo.acEduUrl}"/>" target="_blank"><c:out value="${eduInfo.acEduUrl}"/></a></td>
                </tr>
                <tr>
                    <th>수강신청</th>
                    <td colspan="3">
                        <div class="view_box">
                            <c:out value="${eduInfo.acEduContents}" escapeXml="false"/>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <!-- //table -->
        </div>
        <!-- //table-wrap -->
    </div>
</body>
</html>
