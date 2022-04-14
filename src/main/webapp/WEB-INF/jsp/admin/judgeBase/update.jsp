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
    
    <%-- 수정 버튼 클릭 --%>
    $('#btn_update_confirm').click(function(){
    	$('#pop_update_confirm').bPopup().close();
    	
    	if(check){
    		
        	$.ajax({
        		type: "post",
        		url: "<c:out value='${pageContext.request.contextPath}/judge/admin/update'/>",
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

<%-- 필수입력값 체크 --%>
function fn_checkForm(){
	<%-- 심판이름 --%>
	if($('#judgeName').val().length < 1){
		$('#pop_check_form_name').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 전화번호 --%>
	if($('#phoneNumber').val().length < 1){
		$('#pop_check_form_phone').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 메모 --%>
	if($('#judgeMemo').val().length < 1){
		$('#pop_check_form_memo').bPopup({
            speed: 450,
            // transition: 'slideDown'
        });
		return false;
	}
	
	<%-- 종목 --%>
	if($('#judgeKind').val().length < 1){
		$('#pop_check_form_kind').bPopup({
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
                    <div class="tab-wrap tab4">
                        <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                        <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                        <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                        <a href="javascript:fn_judgeMemberList();" class="tablinks active">심판 관리</a>
                    </div>
                    <!-- //menu -->
                </div>
            </div>
            <!-- table-wrap -->
            <div class="content-wrap">
            	<form id="updateForm" name="updateForm">
	                <div class="table-write-wrap">
	                    <!-- table -->
	                    <table>
	                        <caption>교육 일정 관리 수정 테이블</caption>
	                        <colgroup>
	                            <col width="140px">
	                            <col width="">
	                            <col width="140px">
	                            <col width="">
	                        </colgroup>
	                        <tbody>
                        		<tr>
			                        <th class="required_need">심판 번호</th>
			                        <td colspan="3">
			                        	<input type="hidden" id="judgeNo" name="judgeNo" value="<c:out value="${judgeInfo.judgeNo}"/>">
			                           ${judgeInfo.judgeNo}
			                        </td>
			                   </tr>
                        		<tr>
			                        <th class="required_need">심판 이름</th>
			                        <td colspan="3">
			                            <input type="text" id="judgeName" name="judgeName" class="input-text" value="<c:out value="${judgeInfo.judgeName}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
			                        </td>
			                   </tr>
			                   <tr>
			                        <th class="required_need">전화번호</th>
			                        <td colspan="3">
			                            <input type="text" id="phoneNumber" name="phoneNumber" class="input-text" value="<c:out value="${judgeInfo.phoneNumber}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
			                        </td>
			                   </tr>
			                   <tr>
			                        <th class="required_need">메모</th>
			                        <td colspan="3">
			                            <input type="text" id="judgeMemo" name="judgeMemo" class="input-text" value="<c:out value="${judgeInfo.judgeMemo}"/>" style="width: 100%;" placeholder="직접입력(00자 이내)">
			                        </td>
			                   </tr>
			                   <tr>
			                        <th class="required_need">종목</th>
			                        <td colspan="3">
			                            <select name="judgeKind" id="judgeKind" class="wd_120">
			                            	<option value="">전 체</option>
			                            	<c:forEach var="judgeKindList" items="${judgeKindList}" varStatus="status">
			                                	<option value="<c:out value="${judgeKindList.code}"/>" <c:if test="${judgeKindList.code eq judgeInfo.judgeKind}">selected="selected"</c:if>><c:out value="${judgeKindList.codeName}"/></option>
			                                </c:forEach>
			                            </select>
			                        </td>
			                   </tr>
	                        </tbody>
	                    </table>
	                    <!-- //table -->
	                </div>
                	<!-- btn area -->
               	</form>
               	
                <div class="btn-wrap">
                	<%-- 수강기간이 종료되지 않은 과정이면 수정 가능하도록 설정 --%>
                    <button type="button" id="btn_judge_list" class="btn2 btn-gray">목록</button>
                    <button type="button" id="btn_update" class="btn2 btn-blue">수정 하기</button>
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
    <div class="modal no_close" id="pop_update_confirm">
        <div class="popup-content">
            <p class="pop-text">해당 과정을 수정 하시겠습니까?</p>
            <div class="btn-wrap">
                <button type="button" id="btn_update_confirm" class="btn2 btn-blue">수정</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 01-->
    <!-- popup 02-->
    <div class="modal no_close" id="pop_update_success">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되었습니다.
            <div class="btn-wrap">
                <button type="button" id="btn_update_success" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->
    <!-- popup 03-->
    <div class="modal no_close" id="pop_update_fail">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되지 않았습니다.<br>관리자에게 문의해주세요.
            <div class="btn-wrap">
                <button type="button" id="btn_update_fail" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 03-->
    <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_name">
        <div class="popup-content">
            <p class="pop-text">심판이름을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_name" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
    <!-- //popup 04-->
     <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_phone">
        <div class="popup-content">
            <p class="pop-text">전화번호를 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_phone" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
    <!-- popup 04-->
    <div class="modal no_close" id="pop_check_form_memo">
        <div class="popup-content">
            <p class="pop-text">메모를 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_memo" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
    
    <div class="modal no_close" id="pop_check_form_kind">
        <div class="popup-content">
            <p class="pop-text">종목을 확인해 주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_check_form_kind" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->

	<%-- 버튼, 팝업 --%>
    <script type="text/javascript">
      $(document).ready(function () {
      	<%-- 목록 버튼 클릭--%>
          $('#btn_judge_list').click(function(){
        	  location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeMemberList'/>";
          });
          
          <%-- 등록 성공 --%>
          $("#btn_update_success").click(function(){
              $('#pop_update_success').bPopup().close();
              location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeMemberList'/>";
          });
          <%-- 등록 실패 --%>
          $("#btn_update_fail").click(function(){
              $('#pop_update_fail').bPopup().close();
          });
          
          <%-- 심판이름 포커스 --%>
          $("#btn_check_form_name").click(function(){
          	$('#judgeName').focus();
          });
          <%-- 전화번호 포커스 --%>
          $("#btn_check_form_phone").click(function(){
          	$('#phoneNumber').focus();
          });
          <%-- 신청기간 종료일 포커스 --%>
          $("#btn_check_form_memo").click(function(){
          	$('#judgeMemo').focus();
          });
          <%-- 수강기간 시작일 포커스 --%>
          $("#btn_check_form_kind").click(function(){
          	$('#judgeKind').focus();
          });
      });
    </script>
</body>
</html>