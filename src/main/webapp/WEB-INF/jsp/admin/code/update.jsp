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

    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <!-- menu: 3개-->
                <div class="tab-wrap tab4">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    <a href="javascript:fn_codeList();" class="tablinks active"> 코드 관리</a>
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
                        <caption>코드 수정 테이블</caption>
                        <colgroup>
                            <col width="140px">
                            <col width="">
                            <col width="140px">
                            <col width="">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th required_need>그룹코드명</th>
                            <td><input type="text" name="groupCodeName" id="groupCodeName" value="<c:out value="${codeVO.groupCodeName}"/>"></td>
                            <th required_need>그룹코드값</th>
                            <td><input type="text" name="groupCode" id="groupCode" value="<c:out value="${codeVO.groupCode}"/>"></td>
                        </tr>
                        <tr>
                            <th required_need>코드명</th>
                            <td><input type="text" name="codeName" id="codeName" value="<c:out value="${codeVO.codeName}"/>"></td>
                            <th required_need>코드값</th>
                            <td><input type="text" name="code" id="code" value="<c:out value="${codeVO.code}"/>"></td>
                        </tr>
                        <tr>
                            <th required_need>순서</th>
                            <%--<td colspan="3"><input type="text" name="displayOrder" id="displayOrder" value="<c:out value="${codeVO.displayOrder}"/>"></td>--%>
                            <td colspan="3"><c:out value="${codeVO.displayOrder}"/></td>
                        </tr>

                        <%-- 비고란이 비어있다면 -로 표시--%>
                        <tr>
                            <th>비고</th>
                            <td colspan="3"><input type="text" name="etcInfo" id="etcInfo" value="<c:out value="${codeVO.etcInfo}"/>"></td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- //table -->
                </div>
                <!-- btn area -->
                <input type="text" readonly name="commonCodeNo" id="commonCodeNo"
                       value="<c:out value="${codeVO.commonCodeNo}"/>">
            </form>

            <div class="btn-wrap">
                <button type="button" id="btn_update" class="btn2 btn-blue">수정</button>
                <button type="button" id="btn_code_list" class="btn2 btn-gray">목록</button>
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
        <p class="pop-text">해당 코드를 수정 하시겠습니까?</p>
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
<div class="modal no_close" id="pop_check_form_title">
    <div class="popup-content">
        <p class="pop-text">코드명을 확인해 주세요.</p>
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

<%-- 목록 --%>
<form id="listForm" name="listForm">
    <input type="hidden" id="year" name="year" value="<c:out value="${year}"/>">
    <input type="hidden" id="eduStatus" name="eduStatus" value="<c:out value="${eduStatus}"/>">
</form>

<%-- 버튼, 팝업 --%>
<script type="text/javascript">
    $(document).ready(function () {
        <%-- 목록 버튼 클릭--%>
        $('#btn_schedule_list').click(function(){
            $('#listForm').attr("method", "post");
            $('#listForm').attr("action", "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>");
            $('#listForm').submit();
        });

        <%-- 등록 성공 --%>
        $("#btn_update_success").click(function(){
            $('#pop_update_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/edu/admin/schedule'/>";
        });
        <%-- 등록 실패 --%>
        $("#btn_update_fail").click(function(){
            $('#pop_update_fail').bPopup().close();
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
</script>
</body>
</html>