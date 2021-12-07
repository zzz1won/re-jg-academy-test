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
var eduNo;
var eduId;

$(function(){
	<%-- 수강신청 버튼 --%>
	$('#btn_register_confirm').click(function(){
		<%-- 중복 클릭 방지 --%>
		if(doubleSubmitCheck()) return;
		<%-- 다중 클릭 방지 --%>
		if(fn_overClick()) return;
		
	    $('#pop_register_confirm').bPopup().close();
	    
	    var data = {
				"acEduScheduleNo" : eduNo,
				"acEduId" : eduId
		}
	    
	 	// insert 작업 실행
	    $.ajax({
	    	type: "post",
	    	url: "<c:out value='${pageContext.request.contextPath}/edu/judge/register'/>",
	    	data: JSON.stringify(data),
	    	dataType: "json",
	    	contentType: "application/json;charset=UTF-8",
	    	success: function(data){
	    		if(data.result > 0){
	    			// 신청 성공시
	            	$('#pop_register_success').bPopup({
	                    speed: 450,
	                    // transition: 'slideDown'
	                });
	    		} else{
	    			// 신청 실패시
	            	$('#pop_register_fail').bPopup({
	                    speed: 450,
	                    // transition: 'slideDown'
	                });
	    		}
	    	},
	    	error: function(){
	    		// 신청 실패시
	        	$('#pop_register_fail').bPopup({
	                speed: 450,
	                // transition: 'slideDown'
	            });
	    	}
	    });
	    
	    doubleSubmitFlag = false;
	});
});

<%-- 수강신청 팝업 --%>
function fn_apply(paramEduNo, paramEduId){
	eduNo = paramEduNo;
	eduId = paramEduId;
	
	<%-- 수강신청 팝업 --%>
    $('#pop_register_confirm').bPopup({
        speed: 450,
        // transition: 'slideDown'
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
                    <div class="tab-wrap tab3">
                        <a href="javascript:fn_scheduleList();" class="tablinks active">수강신청</a>
                        <a href="javascript:fn_applyList();" class="tablinks">수강내역</a>
                        <a href="javascript:fn_calendar();" class="tablinks">달력</a>
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
                                <th>장소</th>
                                <th>인원</th>
                                <th>신청기간</th>
                                <th>수강신청</th>
                                <th>id</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="edu" items="${eduList}" varStatus="status">
							<c:if test="${eduListCnt > 0}">
								<tr>
									<td><c:out value="${edu.rownum}"/></td>
									<td><c:out value="${edu.acEduTitleMask}"/></td>
									<td>
										<fmt:parseDate var="acEduStartDate" value="${edu.acEduStartDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd" />
										 ~ 
										<fmt:parseDate var="acEduEndDate" value="${edu.acEduEndDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd" />
									</td>
									<td><c:out value="${edu.acEduPlace}"/></td>
									<td><c:out value="${edu.acApplyCount}"/>/<c:out value="${edu.acApplyLimitCount}"/></td>
									<td>
										<fmt:parseDate var="acApplyStartDate" value="${edu.acApplyStartDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acApplyStartDate}" pattern="yyyy/MM/dd" />
										 ~ 
										<fmt:parseDate var="acApplyEndDate" value="${edu.acApplyEndDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acApplyEndDate}" pattern="yyyy/MM/dd" />
									</td>
									<td>
										<c:forEach var="eduStatus" items="${eduStatusList}" varStatus="status">
										<c:if test="${eduStatus.code eq edu.acEduStatus}">
											<c:choose>
											<c:when test="${edu.acEduStatus eq '02' && edu.acApplyYn eq 'N'}">
												<a href="javascript:fn_apply('<c:out value="${edu.acEduScheduleNo}"/>', '<c:out value="${edu.acEduId}"/>');" class="btn2 btn-table-line btn-ms">신청</a>
											</c:when>
											<c:otherwise>
												<c:out value="${eduStatus.codeName}"/>
											</c:otherwise>
											</c:choose>
										</c:if>
										</c:forEach>
									</td>
									<td><c:out value="${edu.acEduScheduleNo}"/></td>
								</tr>
							</c:if>
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
    <div class="modal no_close" id="pop_register_confirm">
        <div class="popup-content">
            <p class="pop-text">수강신청 하시겠습니까?<br>신청 이후 취소 불가합니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_register_confirm" class="btn2 btn-blue">신청</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 01-->
    
    <!-- popup 02-->
    <div class="modal no_close" id="pop_register_success">
        <div class="popup-content">
            <p class="pop-text">신청이 완료 되었습니다.<br>교육신청이 확정되면 학습 가능 합니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_register_success" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->
    
    <!-- popup 03-->
    <div class="modal no_close" id="pop_register_fail">
        <div class="popup-content">
            <p class="pop-text">신청에 실패하였습니다.<br>관리자에게 문의해주시기 바랍니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_register_fail" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 03-->
    
    <!-- popup 04-->
    <div class="modal" id="pop_detail" style="width: 900px;"></div>
    <!-- //popup 04-->

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
                "emptyTable": "개설된 과정이 없습니다.",
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
                { className: "dt-body-right", "targets": [4] },
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
       $(document).ready(function () {
           //bPopup 사용
           $("#btn_register_success").click(function(){ // 수강신청 성공
               $('#pop_register_success').bPopup().close();
               location.href = "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule'/>";
           });
           $("#btn_register_fail").click(function(){ // 수강신청 실패
               $('#pop_register_fail').bPopup().close();
           });

           $('#btn-search').click(function(){
				$('#searchForm').attr("method", "post");
				$('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule'/>");
				$('#searchForm').submit();
           });
       });
   </script>
   <%-- //팝업 및 검색 관련 --%>

</body>
</html>