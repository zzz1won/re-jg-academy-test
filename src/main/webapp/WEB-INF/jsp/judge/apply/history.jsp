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
<%-- 수강신청 목록 --%>
function fn_scheduleList(){
	location.href = "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule'/>";
}

<%-- 수강내역 목록 --%>
function fn_applyList(){
	location.href = "<c:out value='${pageContext.request.contextPath}/apply/judge/history'/>";
}

<%-- 교육과정 상세 팝업 --%>
function fn_detail(eduNo){
	var data = {
			"acEduScheduleNo" : eduNo
	}
	
	$.ajax({
		type: "post",
		url: "<c:out value='${pageContext.request.contextPath}/edu/judge/detail'/>",
		data: JSON.stringify(data),
		dataType: "text",
		contentType: "application/json;charset=UTF-8",
		success: function(data){
			$('#pop_detail').html(data);
			
			$('#pop_detail').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
		},
		error: function(){
			alert("ajax error");
		}
	});
}

<%-- 수료증 팝업 --%>
function fn_popupCert(applyNo){
    $('#pop_cert').bPopup({
    	content: 'iframe',
        contentContainer: '.content-print',
        loadUrl: '<c:out value="${pageContext.request.contextPath}/cert/judge/certificate"/>' + '?applyNo=' + applyNo,
        iframeAttr: 'scrolling="no" frameborder="0" style="height:1240px;width:800px;"'
       	//loadData: { 'applyNo' : applyNo }
    });
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
            <!-- search area -->
            <div class="search-wrap">
                <div class="search-container">
                	<form id="searchForm" name="searchForm">
	                    <ul class="filter-row">
	                        <li>
	                            <label for="year">조회기간</label>
	                            <input type="text" id="year" name="year" value="<c:out value='${search.year}'/>" class="input-text year icon_calendar" style="width:100px" placeholder="년도" />
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
                                <th>수료기간</th>
                                <th>장소</th>
                                <th>진행상태</th>
                                <th>수료증</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="apply" items="${applyList}" varStatus="status">
								<tr>
									<td><c:out value="${apply.rownum}"/></td>
									<td><c:out value="${apply.acEduTitleMask}"/></td>
									<td>
										<fmt:parseDate var="acEduStartDate" value="${apply.acEduStartDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd" />
										 ~ 
										<fmt:parseDate var="acEduEndDate" value="${apply.acEduEndDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd" />
									</td>
									<td>
										<c:choose>
										<c:when test="${apply.state ne '01'}">
											<fmt:formatDate value="${apply.applyConfirmDate}" pattern="yyyy/MM/dd" /> ~ 
											<fmt:formatDate value="${apply.certConfirmDate}" pattern="yyyy/MM/dd" />
										</c:when>
										<c:otherwise>
											- 
										</c:otherwise>
										</c:choose>
									</td>
									<td><c:out value="${apply.acEduPlace}"/></td>
									<td>
										<c:forEach var="applyState" items="${applyStateList}" varStatus="status">
										<c:if test="${applyState.code eq apply.state}">
											<c:out value="${applyState.codeName}"/>
										</c:if>
										</c:forEach>
									</td>
									<td>
										<c:choose>
										<c:when test="${apply.state eq '03'}">
											<c:choose>
											<%-- 수료확정 & 수료증 등록상태 --%>
											<c:when test="${not empty apply.acEduCertFilePath}">
												<a href="javascript:fn_popupCert('<c:out value="${apply.eduApplyInfoNo}"/>')" class="btn2 btn-table-line btn-ms">수료증</a>
											</c:when>
											<%-- 수료확정 & 수료증 미등록상태 --%>
											<c:otherwise>
												수료증미등록
											</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
										</c:choose>
									</td>
									<td><c:out value="${apply.acEduScheduleNo}"/></td>
								</tr>
							</c:forEach>
                        </tbody>
                    </table>
                    <!-- //table -->
                </div>
            </div>
            <!-- //table-wrap -->
        </div>
        <!-- //container -->
        
        <jsp:include page = "/WEB-INF/jsp/include/footer.jsp"/>
        
    </div>
    <!-- //wrapper -->
    <!-- popup 01-->
    <div class="modal" id="pop_detail" style="width: 900px;"></div>
    <!-- //popup 01-->

    <!-- popup 02-->
    <div class="modal" id="pop_cert" style="width: 900px;">
        <span class="button close-modal b-close"><span>X</span></span>
        <!-- content -->
        <h1 class="popup_tit no_margin">수료증</h1>
        <div class="popup-content">
            <div class="content-print"></div>
        </div>
        <!-- //content -->
    </div>
    <!-- //popup 02-->

	<%-- DataTable --%>
    <script>
    $(document).ready(function() {
        // listTable
        $('#listTable').DataTable({
            // "scrollY": "370px",
            // "ordering": true,
            "pagingType": "full_numbers",
            "searching": false,
            "lengthChange": false,
            "ordering": false,
            "info": false,

            "language": {
                "emptyTable": "수강내역이 없습니다.",
                "paginate": {
                    "first": "<<",
                    "last": ">>",
                    "next": ">",
                    "previous": "<",
                }
            },

            //정렬, 링크
            "columnDefs": [
                { className: "dt-body-left", "targets": [1] },
                {
                    targets: [1],
                    render: function(data, type, row, meta) {
                        if (type === 'display') {
                            data = '<a href="javascript:fn_detail(' + row[7] + ');">' + data + '</a>';
                        }
                        return data;
                    }
                },
                {
                	targets: [7],
                	visible : false
                }
            ],

            // 페이징처리
            "fnDrawCallback": function() {
                if (Math.ceil((this.fnSettings().fnRecordsDisplay()) / this.fnSettings()._iDisplayLength) > 1) {
                    $('.dataTables_paginate').css("display", "block");
                } else {
                    $('.dataTables_paginate').css("display", "none");
                    $('.table-wrap+.btn-wrap').css("bottom", "-25px");
                }
            }
        });
    });
    </script>
    <%-- //DataTable --%>
    
    <%-- 팝업 및 검색 관련 --%>
    <script type="text/javascript">
    $(document).ready(function() {
        //bPopup 사용
        $('#btn_detail_info').click(function() {
            $('#pop_detail').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
        });

        $('#btn-search').click(function(){
        	$('#searchForm').attr("method", "post");
        	$('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/apply/judge/history'/>");
        	$('#searchForm').submit();
        });
    });
    </script>
    <%-- //팝업 및 검색 관련 --%>
    
</body>
</html>