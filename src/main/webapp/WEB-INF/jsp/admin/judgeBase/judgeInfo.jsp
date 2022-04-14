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
	
});

<%-- 수정화면 이동 --%>
function fn_updatePage(judgeNo){
	$('#judgeNo').val(judgeNo);
	
	$('#updateForm').attr("method", "post");
	$('#updateForm').attr("action", "<c:out value='${pageContext.request.contextPath}/judge/admin/updateJudgePage'/>");
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
                    <div class="tab-wrap tab4">
                        <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                        <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                        <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    </div>
                    <!-- //menu -->
                </div>
            </div>
            
            <!-- table-wrap -->
            <div class="content-wrap">
                <div class="table-wrap">
                    <!-- table -->
                    <table id="listTable" class="cell-border hover dataTable" width="100%">
                        <thead>
                            <tr>
                                <th>심판이름</th>
                                <th>전화번호</th>
                                <th>메모</th>
                                <th>심판종목</th>
                                <th>수정일시</th>
                                <th>id</th>
                            </tr>
                        </thead>
                        <tbody>
							<c:forEach var="edu" items="${judgeMemberList}" varStatus="status">
								<tr>
									<td><c:out value="${edu.judgeName}"/></td>
									<td><c:out value="${edu.phoneNumber}"/></td>
									<td><c:out value="${edu.judgeMemo}"/></td>
									<td>
										<c:forEach var="eduStatus" items="${judgeKindList}" varStatus="status">
										<c:if test="${eduStatus.code eq edu.judgeKind}">
											<c:out value="${eduStatus.codeName}"/>
										</c:if>
										</c:forEach>
									</td>
									<td>
										<fmt:formatDate value="${edu.modDate}" pattern="yyyy/MM/dd HH:mm:ss" />
									</td>
									<td>'${edu.judgeNo}'</td>
								</tr>
							</c:forEach>
                        </tbody>
                    </table>
                    <!-- //table -->
                </div>
                <!-- btn area-->
                <div class="btn-wrap">
                    <button type="button" id="btn_vue" class="btn2">vue화면으로 이동</button>
                </div>
                <!-- //btn area -->
            </div>
            <!-- //table-wrap -->
        </div>
        <!-- //container -->
        
        <jsp:include page = "/WEB-INF/jsp/include/footer.jsp"/>
        
    </div>
    <!-- //wrapper -->

	<%-- 수정 화면으로 이동하기 위한 파라미터 --%>
	<form id="updateForm" method="post">
		<input type="hidden" id="updateYear" name="updateYear" value="<c:out value="${search.year}"/>">
		<input type="hidden" id="updateEduStatus" name="updateEduStatus" value="<c:out value="${search.eduStatus}"/>">
		<input type="hidden" id="acEduScheduleNo" name="acEduScheduleNo">
		<input type="hidden" id="judgeNo" name="judgeNo">
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
                "emptyTable": "심판이 없습니다.",
                "paginate": {
                    "first": "<<",
                    "last": ">>",
                    "next": ">",
                    "previous": "<",
                }
            },

            //정렬, 링크
            "columnDefs": [
                { className: "dt-body-left", "targets": [0] },
                {
                    targets: [0],
                    render: function(data, type, row, meta) {
                        if (type === 'display') {
                            data = '<a href="javascript:fn_updatePage(' + row[5] + ');">' + data + '</a>';
                        }
                        return data;
                    }
                },
                {
                	targets: [5],
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
        
        $('#btn_vue').click(function(){
        	location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeMemberListVue'/>";
        });
    });
    </script>
</body>
</html>
