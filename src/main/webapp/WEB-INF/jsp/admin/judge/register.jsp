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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
var check = false;

$(function(){
	<%-- 교육내용 등록 --%>
    $("#btn_register").click(function(){
    	<%-- 필수입력값 체크 --%>
    	check = fn_checkForm();
    	
    	if(check){
    		$('#pop_confirm_register').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
    	}
    });
    
    <%-- 등록 버튼 클릭 --%>
    $('#btn_confirm_register').click(function(){
    	$('#pop_confirm_register').bPopup().close();
    	
    	if(check){
    		<%-- 중복 클릭 방지 --%>
    		if(doubleSubmitCheck()) return;
    		
    		oEditors.getById["acEduContents"].exec("UPDATE_CONTENTS_FIELD", []);

        	$('#acEduStartDate').val( fn_split($('#acEduStartDate').val()) );
        	$('#acEduEndDate').val( fn_split($('#acEduEndDate').val()) );
        	$('#acApplyStartDate').val( fn_split($('#acApplyStartDate').val()) );
        	$('#acApplyEndDate').val( fn_split($('#acApplyEndDate').val()) );
        	
        	$.ajax({
        		type: "post",
        		url: "<c:out value='${pageContext.request.contextPath}/edu/admin/register'/>",
        		data: JSON.stringify($('#registerForm').serializeObject()),
        		dataType: "json",
        		contentType: "application/json;charset=UTF-8",
        		success: function(data){
        			if(data.result > 0){
        		        $('#pop_success_register').bPopup();
        			} else{
        				$('#pop_fail_register').bPopup();
        			}
        		},
        		error: function(){
        			$('#pop_fail_register').bPopup();
        		}
        	});
        	
        	doubleSubmitFlag = false;
    	} else{
    		alert("다시 한 번 확인해주시기바랍니다.");
    	}
    });
});

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

<body>
    <!-- wrapper -->
    <div id="wrapper">
        
		<jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>

        <!-- container -->
        <div id="container">
            <div class="sub-tit-wrap">
                <div class="sub-tit-container">
                    <!-- menu: 3개-->
                    <div class="tab-wrap tab3">
                        <a href="javascript:fn_scheduleList();" class="tablinks active">교육 일정 관리</a>
                        <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                        <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    </div>
                    <!-- //menu -->
                </div>
            </div>
            <!-- table-wrap -->
            <div class="content-wrap">
            	<form id="registerForm" name="registerForm">
	                <div class="table-write-wrap">
	                    <!-- table -->
	                    <table>
	                        <caption>교육 일정 관리 등록 테이블</caption>
	                        <colgroup>
	                            <col width="140px">
	                            <col width="">
	                            <col width="140px">
	                            <col width="">
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                        <th class="required_need">과 정 명</th>
	                        <td colspan="3">
	                            <input type="text" id="acEduTitle" name="acEduTitle" class="input-text" style="width: 100%;" placeholder="입력해 주세요.">
	                        </td>
		                   </tr>
		                   <tr>
		                       <th class="required_need">신청기간</th>
		                       <td>
		                           <input type="text" id="acApplyStartDate" name="acApplyStartDate" value="<c:out value="${applyStartDate}"/>" class="input-text datepick icon_calendar" style="width:120px" placeholder="날짜" />
		                           <span class="txt-dash">~</span>
		                           <input type="text" id="acApplyEndDate" name="acApplyEndDate" value="<c:out value="${applyEndDate}"/>" class="input-text datepick icon_calendar" style="width:120px" placeholder="날짜" />
		                       </td>
							   <th class="required_need">수강기간</th>
		                       <td>
		                           <input type="text" id="acEduStartDate" name="acEduStartDate" value="<c:out value="${eduStartDate}"/>" class="input-text datepick icon_calendar" style="width:120px" placeholder="날짜" />
		                           <span class="txt-dash">~</span>
		                           <input type="text" id="acEduEndDate" name="acEduEndDate" value="<c:out value="${eduEndDate}"/>" class="input-text datepick icon_calendar" style="width:120px" placeholder="날짜" />
		                       </td>
		                   </tr>
		                   <tr>
		                       <th>장 소</th>
		                       <td>
		                           <input type="text" id="acEduPlace" name="acEduPlace" class="input-text" style="width: 100%;" placeholder="입력해 주세요.">
		                       </td>
		                       <th class="required_need">인원제한</th>
		                       <td><input type="number" id="acApplyLimitCount" name="acApplyLimitCount" min="10" max="300" step="5" class="input-text" style="width:140px"></td>
		                   </tr>
		                   <tr>
		                       <th>주관기관</th>
		                       <td>
		                           <input type="text" id="acEduInstitute" name="acEduInstitute" class="input-text" style="width: 100%;" placeholder="입력해 주세요.">
		                       </td>
		                       <th>교육사이트</th>
		                       <td>
		                           <input type="text" id="acEduUrl" name="acEduUrl" class="input-text" style="width: 100%;" placeholder="입력해 주세요.">
		                       </td>
		                   </tr>
		                        <tr>
		                            <th>교육내용</th>
		                            <td colspan="3">
		                                <div class="editor_box">
			                                <textarea id="acEduContents" name="acEduContents" rows="12" cols="175"></textarea>
			                            </div>
		                            </td>
		                        </tr>
		                        <%-- <tr>
		                            <th>파일등록</th>
		                            <td colspan="3">
		                                <div class="file-box">
		                                <input type="text" class="fileName input-text" readonly="readonly">
		                                <label for="upload-name" class="btn btn-file">파일추가</label>
		                                <input type="file" id="upload-name" class="upload-name">
		                              </div>
		                            </td>
		                        </tr> --%>
	                        </tbody>
	                    </table>
	                    <!-- //table -->
	                </div>
                	<!-- btn area -->
               	</form>
               	
                <div class="btn-wrap">
                    <button type="button" id="btn_register" class="btn2 btn-blue">등록 하기</button>
                    <button type="button" id="btn_schedule_list" class="btn2 btn-gray">목록</button>
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
    <div class="modal no_close" id="pop_confirm_register">
        <div class="popup-content">
            <p class="pop-text">해당 과정을 등록 하시겠습니까?</p>
            <div class="btn-wrap">
                <button type="button" id="btn_confirm_register" class="btn2 btn-blue">등록</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 01-->
    <!-- popup 02-->
    <div class="modal no_close" id="pop_success_register">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되었습니다.
            <div class="btn-wrap">
                <button type="button" id="btn_success_register" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->
    <!-- popup 03-->
    <div class="modal no_close" id="pop_fail_register">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되지 않았습니다.<br>관리자에게 문의해주세요.
            <div class="btn-wrap">
                <button type="button" id="btn_fail_register" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 03-->
    <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_title">
        <div class="popup-content">
            <p class="pop-text">과정명을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_title" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
     <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_edu_start_date">
        <div class="popup-content">
            <p class="pop-text">수강기간 시작일을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_edu_start_date" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
    <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_edu_end_date">
        <div class="popup-content">
            <p class="pop-text">수강기간 종료일을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_edu_end_date" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
     <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_apply_start_date">
        <div class="popup-content">
            <p class="pop-text">신청기간 시작일을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_apply_start_date" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
    <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_apply_end_date">
        <div class="popup-content">
            <p class="pop-text">신청기간 종료일을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_apply_end_date" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
     <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_limit_count">
        <div class="popup-content">
            <p class="pop-text">인원제한을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_limit_count" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->

	<%-- 버튼, 팝업 --%>
    <script type="text/javascript">
        $(document).ready(function () {
        	<%-- 목록 버튼 클릭--%>
            $('#btn_schedule_list').click(function(){
            	location.href="<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
            });
            
            <%-- 등록 성공 --%>
            $("#btn_success_register").click(function(){
                $('#pop_success_register').bPopup().close();
                location.href = "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
            });
            <%-- 등록 실패 --%>
            $("#btn_fail_register").click(function(){
                $('#pop_fail_register').bPopup().close();
            });
            
            <%-- 과졍명 포커스 --%>
            $("#btn_check_form_title").click(function(){
            	$('#acEduTitle').focus();
            });
            <%-- 신청기간 시작일 포커스 --%>
            $("#btn_check_form_apply_start_date").click(function(){
            	$('#acApplyStartDate').focus();
            });
            <%-- 신청기간 종료일 포커스 --%>
            $("#btn_check_form_apply_end_date").click(function(){
            	$('#acApplyEndDate').focus();
            });
            <%-- 수강기간 시작일 포커스 --%>
            $("#btn_check_form_edu_start_date").click(function(){
            	$('#acEduStartDate').focus();
            });
            <%-- 수강기간 종료일 포커스 --%>
            $("#btn_check_form_edu_end_date").click(function(){
            	$('#acEduEndDate').focus();
            });
            <%-- 인원제한 포커스 --%>
            $("#btn_check_form_limit_count").click(function(){
            	$('#acApplyLimitCount').focus();
            });
            
        });

        <%-- 네이버 smartEditor2 사용 --%>
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
        	oAppRef: oEditors,
        	elPlaceHolder: "acEduContents",
        	sSkinURI: "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
        	fCreator: "createSEditor2"
        });
    </script>
</body>
</html>