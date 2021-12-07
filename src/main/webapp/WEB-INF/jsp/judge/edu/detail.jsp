<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교육 상세정보</title>
</head>

<script type="text/javascript">
$(function(){
	<%-- 교육내용 수정 --%>
    $("#btn_update_confirm").click(function(){
    	$('#pop_update_confirm').bPopup().close();
    	oEditors.getById["acEduContents"].exec("UPDATE_CONTENTS_FIELD", []);

    	$('#acEduStartDate').val( fn_split($('#acEduStartDate').val()) );
    	$('#acEduEndDate').val( fn_split($('#acEduEndDate').val()) );
    	$('#acApplyStartDate').val( fn_split($('#acApplyStartDate').val()) );
    	$('#acApplyEndDate').val( fn_split($('#acApplyEndDate').val()) );
    	
    	$.ajax({
    		type: "post",
    		url: "<c:out value='${pageContext.request.contextPath}/edu/admin/update'/>",
    		data: JSON.stringify($('#updateForm').serializeObject()),
    		dataType: "json",
    		contentType: "application/json;charset=UTF-8",
    		success: function(data){
    			if(data.result > 0){
    		        $('#pop_update_success').bPopup();
    			} else{
    				$('#pop_update_fail').bPopup();
    			}
    		},
    		error: function(){
    			$('#pop_update_fail').bPopup();
    		}
    	});
    });
});

<%-- split --%>
function fn_split(str){
	var returnStr = "";
	var splitStr = str.split('/');
	
	for(var i in splitStr){
		returnStr += splitStr[i];
	}
	
	return returnStr; 
}
</script>

<!-- content -->
<h1 class="popup_tit">과정상세 정보</h1>
<div class="popup-content">
	<form id="updateForm" name="updateForm">
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
	                	<th>신청기간</th>
	                    <td>
							<fmt:parseDate var="acApplyStartDate" value="${eduInfo.acApplyStartDate}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${acApplyStartDate}" pattern="yyyy/MM/dd" />
							 ~ 
							<fmt:parseDate var="acApplyEndDate" value="${eduInfo.acApplyEndDate}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${acApplyEndDate}" pattern="yyyy/MM/dd" />
	                    </td>
	                    <th>수강기간</th>
	                    <td>
	                    	<fmt:parseDate var="acEduStartDate" value="${eduInfo.acEduStartDate}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd" />
							 ~ 
							<fmt:parseDate var="acEduEndDate" value="${eduInfo.acEduEndDate}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>장 소</th>
	                    <td><c:out value="${eduInfo.acEduPlace}"/></td>
	                    <th>인원제한</th>
	                    <td><c:out value="${eduInfo.acApplyLimitCount}"/></td>
	                </tr>
	                <tr>
	                    <th>주관기관</th>
	                    <td><c:out value="${eduInfo.acEduInstitute}"/></td>
	                    <th>교육사이트</th>
	                    <td><a href="<c:out value="${eduInfo.acEduUrl}"/>" target="_blank"><c:out value="${eduInfo.acEduUrl}"/></a></td>
	                </tr>
	                <tr>
	                    <th>교육내용</th>
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
	    <!-- btn area -->
	    
	    <input type="hidden" id="acEduScheduleNo" name="acEduScheduleNo" value="<c:out value="${eduInfo.acEduScheduleNo}"/>">
	</form>   
	
    <div class="btn-wrap">
        <button type="button" class="btn2 b-close">닫기</button>
    </div>
    <!-- //btn area -->
    
    <!-- popup 01-->
    <div class="modal no_close" id="pop_update_confirm">
        <div class="popup-content">
            <p class="pop-text">내용을 수정하시겠습니까?</p>
            <div class="btn-wrap">
                <button type="button" id="btn_update_confirm" class="btn2 btn-blue">확인</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 01-->
    <!-- popup 02-->
    <div class="modal no_close" id="pop_update_success">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되었습니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_update_success" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->
    <!-- popup 03-->
    <div class="modal no_close" id="pop_update_fail">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리하지 못했습니다.<br>관리자에게 문의해주시기 바랍니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_update_fail" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
</div>
<!-- //content -->

<script type="text/javascript">
$(function(){
	<%-- 수정 여부 확인--%>
	$("#btn_update").click(function(){
        $('#pop_update_confirm').bPopup();
    });
	<%-- 수정 성공 --%>
    $("#btn_update_success").click(function(){
        $('#pop_update_success').bPopup().close();
        $('#pop_detail').bPopup().close();
        location.href = "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
    });
    <%-- 수정 실패 --%>
    $("#btn_update_fail").click(function(){
    	$('#pop_detail').bPopup().close();
        $('#pop_update_fail').bPopup().close();
    });
});
</script>