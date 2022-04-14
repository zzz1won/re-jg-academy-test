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
	<%-- 교육내용 삭제 --%>
    $("#btn_delete_confirm").click(function(){
    	$('#pop_delete_confirm').bPopup().close();

    	var eduNoArr = "";
    	$("input[name=chk]:checked").each(function() {
			var eduNo = $(this).val();
			eduNoArr += eduNo + ",";
		});
    	
    	eduNoArr = {
    			"acEduNo" : eduNoArr
    	};
    	
    	$.ajax({
			type: "post",
			url: "<c:out value='${pageContext.request.contextPath}/edu/admin/delete'/>",
			data: JSON.stringify(eduNoArr),
			dataType: "json",
			contentType: "application/json;charset=UTF-8",
			success: function(data){
				if(data.result > 0){
    		        $('#pop_delete_success').bPopup();
    			} else{
    				$('#pop_delete_fail').bPopup();
    			}
				
			},
			error: function(){
				alert("fail ajax !!!");
			}
		});
    });
    
    <%-- 엑셀 저장 --%>
    $("#btn_excel_confirm").click(function(){
    	$('#pop_excel_confirm').bPopup().close();
    	
   		$('#eduExcelForm').attr("method", "post");
   		$('#eduExcelForm').attr("action", "<c:out value='${pageContext.request.contextPath}/edu/admin/excel'/>");
   		$('#eduExcelForm').submit();
    });
});

<%-- 수정화면 이동 --%>
function fn_updatePage(eduNo){
	$('#acEduScheduleNo').val(eduNo);
	
	$('#updateForm').attr("method", "post");
	$('#updateForm').attr("action", "<c:out value='${pageContext.request.contextPath}/edu/admin/updatePage'/>");
	$('#updateForm').submit();
}
</script>

<body>
    <!-- wrapper -->
    <div id="wrapper">

        <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>

        <!-- container -->
        <div id="container">
            <div class="sub-tit-wrap">
                <div class="sub-tit-container">
                    <!-- menu: 3개-->
                    <div class="tab-wrap tab5">
                        <a href="javascript:fn_scheduleList();" class="tablinks active">교육 일정 관리</a>
                        <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                        <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                        <%-- 220408 4개로 추가--%>
                        <a href="javascript:fn_codeList();" class="tablinks"> 코드 관리</a>
                        <%-- 220408 5개로 추가--%>
                        <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
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
	                            <input type="text" id="year" name="year" value="<c:out value='${search.year}'/>" class="input-text year icon_calendar" style="width:100px" placeholder="년도" />
	                        </li>
	                        <li>
	                            <label for="eduStatus">상태</label>
	                            <select name="eduStatus" id="eduStatus" class="wd_140">
	                            	<option value="">전 체</option>
	                            	<c:forEach var="eduStatus" items="${eduStatusList}" varStatus="status">
	                                	<option value="<c:out value="${eduStatus.code}"/>" <c:if test="${eduStatus.code eq search.eduStatus}">selected="selected"</c:if>><c:out value="${eduStatus.codeName}"/></option>
	                                </c:forEach>
	                            </select>
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
                                <th><input type="checkbox" id="allChk" name="allChk"/></th>
                                <th>No</th>
                                <th>과정명</th>
                                <th>수강기간</th>
                                <th>신청인원</th>
                                <th>신청기간</th>
                                <th>상태</th>
                                <th>등록/수정일시</th>
                                <th>작업자</th>
                                <th>id</th>
                            </tr>
                        </thead>
                        <tbody>
							<c:forEach var="edu" items="${eduList}" varStatus="status">
								<tr>
									<td><input type="checkbox" id="chk${edu.rownum}" name="chk" value="<c:out value="${edu.acEduScheduleNo}"/>"></td>
									<td><c:out value="${edu.rownum}"/></td>
									<td><c:out value="${edu.acEduTitleMask}"/></td>
									<td>
										<fmt:parseDate var="acEduStartDate" value="${edu.acEduStartDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd" />
										 ~ 
										<fmt:parseDate var="acEduEndDate" value="${edu.acEduEndDate}" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd" />
									</td>
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
											<c:out value="${eduStatus.codeName}"/>
										</c:if>
										</c:forEach>
									</td>
									<td>
										<c:choose>
										<c:when test="${empty edu.modDate}">
											<fmt:formatDate value="${edu.regDate}" pattern="yyyy/MM/dd HH:mm:ss" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${edu.modDate}" pattern="yyyy/MM/dd HH:mm:ss" />
										</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
										<c:when test="${empty edu.modId}">
											<c:forEach var="admin" items="${adminList}" varStatus="status">
											<c:if test="${admin.adminId eq edu.regId}">
												<c:out value="${admin.adminName}"/>
											</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach var="admin" items="${adminList}" varStatus="status">
											<c:if test="${admin.adminId eq edu.modId}">
												<c:out value="${admin.adminName}"/>
											</c:if>
											</c:forEach>
										</c:otherwise>
										</c:choose>
									</td>
									<td><c:out value="${edu.acEduScheduleNo}"/></td>
								</tr>
							</c:forEach>
                        </tbody>
                    </table>
                    <!-- //table -->
                </div>
                <!-- btn area-->
                <div class="btn-wrap">
                    <button type="button" id="btn_register" class="btn2 btn-blue">신규과정 등록</button>
                    <button type="button" id="btn_delete" class="btn2 btn-gray">삭제</button>
                    <button type="button" id="btn_excel" class="btn2">엑셀 저장</button>
                </div>
                <!-- //btn area -->
            </div>
            <!-- //table-wrap -->
        </div>
        <!-- //container -->
        
        <jsp:include page = "/WEB-INF/jsp/include/footer.jsp"/>
        
    </div>
    <!-- //wrapper -->

    <!-- popup 01-->
    <div class="modal no_close" id="pop_delete_confirm">
        <div class="popup-content">
            <p class="pop-text">선택한 과정을 삭제하시겠습니까?</p>
            <div class="btn-wrap">
                <button type="button" id="btn_delete_confirm" class="btn2 btn-blue">삭제</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 01-->
    <!-- popup 02-->
    <div class="modal no_close" id="pop_delete_success">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되었습니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_delete_success" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->
    <!-- popup 03-->
    <div class="modal no_close" id="pop_delete_fail">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리하지 못했습니다.<br>관리자에게 문의해주시기 바랍니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_delete_fail" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 03-->
    
    <!-- popup 04-->
    <div class="modal" id="pop_detail" style="width: 900px;"></div>
    <!-- //popup 04-->
    
    <!-- popup 05-->
    <div class="modal no_close" id="pop_excel_confirm">
        <div class="popup-content">
            <p class="pop-text">엑셀 파일로 저장하시겠습니까?</p>
            <div class="btn-wrap">
                <button type="button" id="btn_excel_confirm" class="btn2 btn-blue">확인</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 05-->

	<%-- 엑셀 저장하기 위한 파라미터 --%>
	<form id="eduExcelForm" method="post">
		<input type="hidden" id="excelYear" name="excelYear" value="<c:out value="${search.year}"/>">
		<input type="hidden" id="excelEduStatus" name="excelEduStatus" value="<c:out value="${search.eduStatus}"/>">
	</form>
	
	<%-- 수정 화면으로 이동하기 위한 파라미터 --%>
	<form id="updateForm" method="post">
		<input type="hidden" id="updateYear" name="updateYear" value="<c:out value="${search.year}"/>">
		<input type="hidden" id="updateEduStatus" name="updateEduStatus" value="<c:out value="${search.eduStatus}"/>">
		<input type="hidden" id="acEduScheduleNo" name="acEduScheduleNo">
	</form>

    <script>
    $(document).ready(function() {
        // listTable
        var table = $('#listTable').DataTable({
            // "scrollY": "370px",
            // "ordering": true,
            "pagingType": "full_numbers",
            "searching": false,
            "lengthChange": false,
            "ordering": false,
            "info": false,

            "language": {
                "emptyTable": "교육 일정이 없습니다.",
                "paginate": {
                    "first": "<<",
                    "last": ">>",
                    "next": ">",
                    "previous": "<",
                }
            },

            //정렬, 링크
            "columnDefs": [
                { className: "dt-body-left", "targets": [2] },
                { className: "dt-body-right", "targets": [4] },
                {
                    targets: [2],
                    render: function(data, type, row, meta) {
                        if (type === 'display') {
                            data = '<a href="javascript:fn_updatePage(' + row[9] + ');">' + data + '</a>';
                        }
                        return data;
                    }
                },
                {
                    targets: [0],
                    orderable: false,
                    searchable: false,
                    className: 'dt-body-center'
                    /*,
                    render: function(data, type, full, meta) {
                        return '<input type="checkbox" name="id[]" value="' +
                            $('<div/>').text(data).html() + '">';
                    }*/
                },
                {
                	targets: [9],
                	visible : false
                }
            ],
            order: [1, 'asc'],

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

        // 체크박스 모두 선택 "Select all" control
        $('#allChk').on('click', function() {
            // Check/uncheck all checkboxes in the table
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        // Handle click on checkbox to set state of "Select all" control
        $('#listTable tbody').on('change', 'input[type="checkbox"]', function() {
            // If checkbox is not checked
            if (!this.checked) {
                var el = $('#allChk').get(0);
                // If "Select all" control is checked and has 'indeterminate' property
                if (el && el.checked && ('indeterminate' in el)) {
                    // Set visual state of "Select all" control
                    // as 'indeterminate'
                    el.indeterminate = true;
                }
            }
        });
    });
    </script>

	<%-- 팝업 및 버튼, 검색 관련 --%>
    <script type="text/javascript">
        $(document).ready(function () {
            <%-- 교육과정 삭제 확인 팝업 --%>
            $('#btn_delete').click(function(){
            	<%-- 체크한 값이 있는지 확인 --%>
            	if( $("input[name=chk]:checked").length < 1){
            		alert("삭제할 과정을 선택해주세요.");
            		return false;
            	}
            	
                $('#pop_delete_confirm').bPopup({
                    speed: 450,
                    // transition: 'slideDown'
                });
            });
            
            <%-- 신규 교육과정 등록화면으로 이동 --%>
            $('#btn_register').click(function(){
            	location.href="<c:out value='${pageContext.request.contextPath}/edu/admin/registerPage'/>";
            });
            
            <%-- 삭제 성공 --%>
            $("#btn_delete_success").click(function(){
                $('#pop_delete_success').bPopup().close();
                location.href = "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
            });
            <%-- 삭제 실패 --%>
            $("#btn_delete_fail").click(function(){
                $('#pop_delete_fail').bPopup().close();
            });
            
            <%-- 엑셀 저장 확인 팝업 --%>
            $('#btn_excel').click(function(){
            	var eduListCnt = '<c:out value="${eduListCnt}"/>';
            	if(eduListCnt < 1){
            		alert("데이터가 없어 엑셀 파일로 다운받으실 수 없습니다.");
            		return false;
            	}
            	
                $('#pop_excel_confirm').bPopup({
                    speed: 450,
                    // transition: 'slideDown'
                });
            });
            
            <%-- 검색 --%>
            $('#btn-search').click(function(){
            	$('#searchForm').attr("method", "post");
            	$('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>");
            	$('#searchForm').submit();
            });
        });
    </script>
</body>
</html>
