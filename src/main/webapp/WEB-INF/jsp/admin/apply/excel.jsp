<%-- 엑셀파일 선언 --%>
<%@ page contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>

<%@ page import="kr.disable.jugd.academy.domain.EduVO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	// 파일명에 다운로드 날짜 붙여주기위해 작성
	Date date = new Date();
	SimpleDateFormat dayFormat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	SimpleDateFormat hourFormat = new SimpleDateFormat("hhmmss", Locale.KOREA);
	String fileName = (String) request.getAttribute("fileName");
	
	String day = dayFormat.format(date);
	String hour = hourFormat.format(date);
	fileName = "Apply_List_" + fileName;
	
	// 필수선언부분
	//.getBytes("KSC5601"), "8859_1")을 통한 한글파일명 깨짐 방지
	response.setHeader("Content-Disposition", "attachment; filename=" + new String((fileName).getBytes("KSC5601"), "8859_1") + ".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<style>
table thead th{
	border-bottom: 3px solid #cccccc;
    background: #a6d18e;
    border-right: 1px solid #d1d7dc;
    color: #333333;
    text-align: center;
    vertical-align: middle;
    font-size: 19px;
    height: 40px;
}
table tbody td{
	text-align: center;
	border: 1px solid #cccccc;
}
.txt_l{
	text-align: left;
}
.txt_c{
	text-align: center;
}
.txt_r{
	text-align: right;
}
.excelText{
	mso-number-format:"\@";
}
.excelDate{
	mso-number-format:"yyyy\/mm\/dd hh\:mm\:ss";
}
</style>

</head>
<body>
	<table>
	<thead>
		<tr align="center">
			<th style="width: 50px">No</th>
			<th style="width: 500px">과정명</th>
			<th style="width: 230px">수강기간</th>
			<th style="width: 100px">종목</th>
			<th style="width: 90px">심판번호</th>
			<th style="width: 90px">이름</th>
			<th style="width: 190px">신청일시</th>
			<th style="width: 90px">신청확정</th>
			<th style="width: 190px">확정일시</th>
			<th style="width: 90px">확정자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="apply" items="${applyList}" varStatus="status">
			<tr>
				<td><c:out value="${apply.rownum}"/></td>
				<td class="txt_l"><c:out value="${apply.acEduTitle}"/></td>
				<td>
					<fmt:parseDate var="acEduStartDate" value="${apply.acEduStartDate}" pattern="yyyyMMdd"/>
					<fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd" />
					 ~ 
					<fmt:parseDate var="acEduEndDate" value="${apply.acEduEndDate}" pattern="yyyyMMdd"/>
					<fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd" />
				</td>
				<td>
					<c:forEach var="kind" items="${judgeKindList}" varStatus="status">
						<c:if test="${kind.code eq apply.judgeKind}">
							<c:out value="${kind.codeName}"/>
						</c:if>
					</c:forEach>
				</td>
				<td><c:out value="${apply.judgeNo}"/></td>
				<td><c:out value="${apply.judgeName}"/></td>
				<td class="excelDate"><fmt:formatDate value="${apply.regDate}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
				<td>
					<c:forEach var="applyState" items="${applyStateList}" varStatus="status">
					<c:if test="${applyState.code eq apply.state}">
						<c:out value="${applyState.codeName}"/>
					</c:if>
					</c:forEach>
				</td>
				<td class="excelDate"><fmt:formatDate value="${apply.applyConfirmDate}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
				<td>
					<c:forEach var="admin" items="${adminList}" varStatus="status">
					<c:if test="${admin.adminId eq apply.applyConfirmId}">
						<c:out value="${admin.adminName}"/>
					</c:if>
					</c:forEach>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</body>
</html>