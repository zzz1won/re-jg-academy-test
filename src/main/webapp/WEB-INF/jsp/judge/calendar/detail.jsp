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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var check = false;

$(function(){
	<%-- 교육내용 등록 --%>
    $("#btn_update").click(function(){
    	<%-- 필수입력값 체크 --%>
    	check = fn_checkForm();
    	
    	if(check){
    		$('#pop_update_confirm').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
    	}
    });
    
	<%-- 교육내용 수정 --%>
    $("#btn_update_confirm").click(function(){
    	$('#pop_update_confirm').bPopup().close();
    	if(check){
	    	// oEditors.getById["acEduContents"].exec("UPDATE_CONTENTS_FIELD", []);
	
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
    	} else{
    		alert("다시 한 번 확인해주시기바랍니다.");
    	}
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

<%-- 필수입력값 체크 --%>
function fn_checkForm(){
	var applyStartDate = fn_split($('#acApplyStartDate').val()); <%-- 신청 시작일 --%>
	var applyEndDate = fn_split($('#acApplyEndDate').val());	 <%-- 신청 종료일 --%>
	var eduStartDate = fn_split($('#acEduStartDate').val());	 <%-- 수강 시작일 --%>
	var eduEndDate = fn_split($('#acEduEndDate').val());		 <%-- 수강 종료일 --%>
	
	applyStartDate = Number(applyStartDate);
	applyEndDate = Number(applyEndDate);
	eduStartDate = Number(eduStartDate);
	eduEndDate = Number(eduEndDate);
	
	<%-- 과정명 --%>
	if($('#acEduTitle').val().length < 1){
		$('#pop_check_form_title').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 신청기간 시작일 --%>
	if($('#acApplyStartDate').val().length < 1){
		$('#pop_check_form_apply_start_date').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 신청기간 종료일 --%>
	if($('#acApplyEndDate').val().length < 1){
		$('#pop_check_form_apply_end_date').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 수강기간 시작일 --%>
	if($('#acEduStartDate').val().length < 1){
		$('#pop_check_form_edu_start_date').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 수강기간 종료일 --%>
	if($('#acEduEndDate').val().length < 1){
		$('#pop_check_form_edu_end_date').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 신청 시작일 유효성 검사 --%>
	if (applyStartDate > applyEndDate){
    	alert("신청기간 시작일은 신청기간 종료일보다 늦게 설정하실 수 없습니다.");
    	$('#acApplyStartDate').val("");
    	return false;
	}
	
	<%-- 신청 종료일 유효성 검사 1 --%>
	if (applyEndDate < applyStartDate){
    	alert("신청기간 종료일은 신청기간 시작일보다 빠르게 설정하실 수 없습니다.");
    	$('#acApplyEndDate').val("");
    	return false;
	}
	
	<%-- 신청 종료일 유효성 검사 2 --%>
	if (applyEndDate >= eduStartDate){
    	alert("신청기간 종료일은 수강기간 시작일보다 같거나 늦게 설정하실 수 없습니다.");
    	$('#acApplyEndDate').val("");
    	return false;
	}

	<%-- 수강 시작일 유효성 검사 1 --%>
	if (eduStartDate <= applyEndDate){
    	alert("수강기간 시작일은 신청기간 종료일보다 같거나 빠르게 설정하실 수 없습니다.");
    	$('#acEduStartDate').val("");
    	return false;
	}
	
	<%-- 수강 시작일 유효성 검사 2 --%>
	if (eduStartDate > eduEndDate){
    	alert("수강기간 시작일은 수강기간 종료일보다 늦게 설정하실 수 없습니다.");
    	$('#acEduStartDate').val("");
    	return false;
	}
	
	<%-- 수강 종료일 유효성 검사 --%>
	if (eduEndDate < eduStartDate){
    	alert("수강기간 종료일은 수강기간 시작일보다 빠르게 설정하실 수 없습니다.");
    	$('#acEduStartDate').val("");
    	return false;
	}
	
	<%-- 인원제한 --%>
	if($('#acApplyLimitCount').val() < 5 || $('#acApplyLimitCount').val() > 300 || $('#acApplyLimitCount').val() == ''){
		$('#pop_check_form_limit_count').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	return true;
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
	                <fmt:parseNumber var="eduEndDate" type="number" value="${eduInfo.acEduEndDate}" />
	                <fmt:parseNumber var="nowDate" type="number" value="${nowDate}" />
	                <c:choose>
	                <c:when test="${eduEndDate >= nowDate}">
	                	<tr>
	                        <th class="required_need">과 정 명</th>
	                        <td colspan="3">
	                        	<input type="hidden" id="acEduScheduleNo" name="acEduScheduleNo" value="<c:out value="${eduInfo.acEduScheduleNo}"/>">
	                            <input type="text" id="acEduTitle" name="acEduTitle" class="input-text" value="<c:out value="${eduInfo.acEduTitle}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
	                        </td>
	                   </tr>
	                   <tr>
	                   	   <th class="required_need">신청기간</th>
	                       <td>
	                       		<fmt:parseDate var="acApplyStartDate" value="${eduInfo.acApplyStartDate}" pattern="yyyyMMdd"/>
								<fmt:parseDate var="acApplyEndDate" value="${eduInfo.acApplyEndDate}" pattern="yyyyMMdd"/>
	                       
	                           <input type="text" id="acApplyStartDate" name="acApplyStartDate" class="input-text datepick icon_calendar" value="<fmt:formatDate value="${acApplyStartDate}" pattern="yyyy/MM/dd" />" style="width:120px" placeholder="날짜" />
	                           <span class="txt-dash">~</span>
	                           <input type="text" id="acApplyEndDate" name="acApplyEndDate" class="input-text datepick icon_calendar" value="<fmt:formatDate value="${acApplyEndDate}" pattern="yyyy/MM/dd" />" style="width:120px" placeholder="날짜" />
	                       </td>
	                       <th class="required_need">수강기간</th>
	                       <td>
	                       		<fmt:parseDate var="acEduStartDate" value="${eduInfo.acEduStartDate}" pattern="yyyyMMdd"/>
								<fmt:parseDate var="acEduEndDate" value="${eduInfo.acEduEndDate}" pattern="yyyyMMdd"/>
	                       
	                           <input type="text" id="acEduStartDate" name="acEduStartDate" class="input-text datepick icon_calendar" value="<fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd" />" style="width:120px" placeholder="날짜" />
	                           <span class="txt-dash">~</span>
	                           <input type="text" id="acEduEndDate" name="acEduEndDate" class="input-text datepick icon_calendar" value="<fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd" />" style="width:120px" placeholder="날짜" />
	                       </td>
	                   </tr>
	                   <tr>
	                       <th>장 소</th>
	                       <td>
	                           <input type="text" id="acEduPlace" name="acEduPlace" class="input-text" value="<c:out value="${eduInfo.acEduPlace}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
	                       </td>
	                       <th class="required_need">인원제한</th>
	                       <td><input type="number" id="acApplyLimitCount" name="acApplyLimitCount" min="10" max="300" step="5" class="input-text" value="<c:out value="${eduInfo.acApplyLimitCount}"/>" style="width:140px"></td>
	                   </tr>
	                   <tr>
	                       <th>주관기관</th>
	                       <td>
	                           <input type="text" id="acEduInstitute" name="acEduInstitute" class="input-text" value="<c:out value="${eduInfo.acEduInstitute}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
	                       </td>
	                       <th>교육사이트</th>
	                       <td>
	                           <input type="text" id="acEduUrl" name="acEduUrl" class="input-text" value="<c:out value="${eduInfo.acEduUrl}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
	                       </td>
	                   </tr>
	                       <tr>
	                           <th>교육내용</th>
	                           <td colspan="3">
	                               <div class="editor_box">
	                                <textarea id="acEduContents" name="acEduContents" rows="12" cols="175"><c:out value="${eduInfo.acEduContents}"/></textarea>
	                            </div>
	                           </td>
	                       </tr>	
	                </c:when>
	                <c:otherwise>
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
	                </c:otherwise>
	                </c:choose>
	            </tbody>
	        </table>
	        <!-- //table -->
	    </div>
	    <!-- btn area -->
	    
	    <input type="hidden" id="acEduScheduleNo" name="acEduScheduleNo" value="<c:out value="${eduInfo.acEduScheduleNo}"/>">
	</form>   
	
    <div class="btn-wrap">
        <c:if test="${eduEndDate >= nowDate}">
        	<button type="button" id="btn_update" class="btn2 btn-blue">수정 하기</button>
        </c:if>
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
$(document).ready(function () {
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
    <%-- 수강기간이 종료되지 않은 과정이면 수정 가능하도록 설정 --%>
	<c:if test="${eduEndDate >= nowDate}">
	
    <%-- 네이버 smartEditor2 사용 --%>
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
    	oAppRef: oEditors,
    	elPlaceHolder: "acEduContents",
    	sSkinURI: "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
    	fCreator: "createSEditor2"
    });
    
    </c:if>
});
</script>