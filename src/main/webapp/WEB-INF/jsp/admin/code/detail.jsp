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
        <%-- 코드 수정 --%>
        $("#btn_update").click(function(){
            <%-- 필수입력값 체크 --%>
            check = fn_checkForm();
            console.log("필수입력값 체크")
            if(check){
                $('#pop_confirm_update').bPopup({
                    speed: 450,
                    // transition: 'slideDown'
                });
            }
        });

        <%-- 수정 버튼 클릭 --%>
        $('#btn_confirm_update').click(function(){
            $('#pop_confirm_update').bPopup().close();
            console.log("등록버튼 클릭")
            if(check){
                <%-- 중복 클릭 방지 --%>
                if(doubleSubmitCheck()) return;

                $('#groupCodeName').val( fn_split($('#groupCodeName').val()) );
                $('#groupCode').val( fn_split($('#groupCode').val()) );
                $('#codeName').val( fn_split($('#codeName').val()) );
                $('#code').val( fn_split($('#code').val()) );
                $('#displayOrder').val( fn_split($('#displayOrder').val()) );

                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/code/admin/update'/>",
                    data: JSON.stringify($('#registerForm').serializeObject()),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function(data){
                        if(data.result > 0){
                            $('#pop_success_update').bPopup();
                        } else{
                            $('#pop_fail_update').bPopup();
                        }
                    },
                    error: function(){
                        $('#pop_fail_update').bPopup();
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
        var groupCodeName = fn_split($('#groupCodeName').val()); <%-- 그룹코드명 --%>
        var groupCode = fn_split($('#groupCode').val()); <%-- 그룹코드값 --%>
        var codeName = fn_split($('#codeName').val());	 <%-- 코드명 --%>
        var code = fn_split($('#code').val());	 <%-- 코드값 --%>
        var displayOrder = fn_split($('#displayOrder').val());		 <%-- 순서 --%>

        <%-- 그룹코드명 --%>
        if($('#groupCodeName').val().length < 1){
            $('#pop_check_form_group_code_name').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("commonCodeNo:"+commonCodeNo);
            console.log("groupCodeName:"+groupCodeName);
            console.log("groupCode:"+groupCode);
            console.log("codeName:"+codeName);
            console.log("code:"+code);
            console.log("displayOrder:"+displayOrder);
            return false;
        }
        <%-- 그룹코드값 --%>
        if($('#groupCode').val().length < 1){
            $('#pop_check_form_group_code').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("commonCodeNo:"+commonCodeNo);
            console.log("groupCodeName:"+groupCodeName);
            console.log("groupCode:"+groupCode);
            console.log("codeName:"+codeName);
            console.log("code:"+code);
            console.log("displayOrder:"+displayOrder);
            return false;
        }
        <%-- 코드명 --%>
        if($('#codeName').val().length < 1){
            $('#pop_check_form_code_name').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("groupCodeName:"+groupCodeName);
            console.log("groupCode:"+groupCode);
            console.log("codeName:"+codeName);
            console.log("code:"+code);
            console.log("displayOrder:"+displayOrder);
            return false;
        }
        <%-- 코드값 --%>
        if($('#code').val().length < 1){
            $('#pop_check_form_code').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("groupCodeName:"+groupCodeName);
            console.log("groupCode:"+groupCode);
            console.log("codeName:"+codeName);
            console.log("code:"+code);
            console.log("displayOrder:"+displayOrder);
            return false;
        }
        <%-- 순서 --%>
        if($('#displayOrder').val().length < 1){
            $('#pop_check_form_display_order').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("groupCodeName:"+groupCodeName);
            console.log("groupCode:"+groupCode);
            console.log("codeName:"+codeName);
            console.log("code:"+code);
            console.log("displayOrder:"+displayOrder);
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
                        <caption>코드 관리 등록 테이블</caption>
                        <colgroup>
                            <col width="140px">
                            <col width="">
                            <col width="140px">
                            <col width="">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="required_need">그룹코드명</th>
                            <td>
                                <input type="text" id="groupCodeName" name="groupCodeName" class="input-text" style="width: 100%;" value="<c:out value="${codeVO.groupCodeName}"/>">
                            </td>
                            <th class="required_need">그룹코드값</th>
                            <td>
                                <input type="text" id="groupCode" name="groupCode" class="input-text" style="width: 100%;" value="<c:out value="${codeVO.groupCode}"/>">
                            </td>
                        </tr>
                        <tr>
                            <th class="required_need">코드명</th>
                            <td>
                                <input type="text" id="codeName" name="codeName" class="input-text" style="width: 100%;" value="<c:out value="${codeVO.codeName}"/>">
                            </td>
                            <th class="required_need">코드값</th>
                            <td>
                                <input type="text" id="code" name="code" class="input-text" style="width: 100%;" value="<c:out value="${codeVO.code}"/>">
                            </td>
                        </tr>
                        <tr>
                            <th class="required_need">순서</th>
                            <td colspan="3">
                                <input type="text" id="displayOrder" name="displayOrder" class="input-text" style="width: 100%;" value="<c:out value="${codeVO.displayOrder}"/>">
                            </td>
                        </tr>
                        <tr>
                            <th>비고</th>
                            <td colspan="3">
                                <input type="text" id="etcInfo" name="etcInfo" class="input-text" value="<c:out value="${codeVO.etcInfo}"/>">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- //table -->
                    <input type="hidden" name="commonCodeNo" id="commonCodeNo" value="<c:out value="${codeVO.commonCodeNo}"/>">

                </div>
                <!-- btn area -->
            </form>

            <div class="btn-wrap">
                <button type="button" id="btn_update" class="btn2 btn-blue">수정하기</button>
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
<div class="modal no_close" id="pop_confirm_update">
    <div class="popup-content">
        <p class="pop-text">해당 코드를 수정 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_confirm_update" class="btn2 btn-blue">수정</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 01-->
<!-- popup 02-->
<div class="modal no_close" id="pop_success_update">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.
        <div class="btn-wrap">
            <button type="button" id="btn_success_update" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 02-->
<!-- popup 03-->
<div class="modal no_close" id="pop_fail_update">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되지 않았습니다.<br>관리자에게 문의해주세요.
        <div class="btn-wrap">
            <button type="button" id="btn_fail_update" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_group_code_name">
    <div class="popup-content">
        <p class="pop-text">그룹코드명을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_group_code_name" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_group_code">
    <div class="popup-content">
        <p class="pop-text">그룹코드값을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_group_code" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_code_name">
    <div class="popup-content">
        <p class="pop-text">코드명을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_code_name" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_code">
    <div class="popup-content">
        <p class="pop-text">코드값을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_code" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_display_order">
    <div class="popup-content">
        <p class="pop-text">순서를 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_display_order" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->


<%-- 버튼, 팝업 --%>
<script type="text/javascript">
    $(document).ready(function () {

        <%-- 목록 버튼 클릭--%>
        $('#btn_code_list').click(function(){
            location.href="<c:out value='${pageContext.request.contextPath}/code/admin/confirm'/>";
        });

        <%-- 수정 성공 --%>
        $("#btn_success_update").click(function(){
            $('#pop_success_update').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/code/admin/confirm'/>";
        });
        <%-- 수정 실패 --%>
        $("#btn_fail_update").click(function(){
            $('#pop_fail_update').bPopup().close();
        });

        <%-- 그룹코드명 포커스 --%>
        $("#btn_check_form_group_code_name").click(function(){
            $('#groupCodeName').focus();
        });
        <%-- 그룹코드 포커스 --%>
        $("#btn_check_form_group_code").click(function(){
            $('#groupCode').focus();
        });
        <%-- 코드명 포커스 --%>
        $("#btn_check_form_code_name").click(function(){
            $('#codeName').focus();
        });
        <%-- 코드값 포커스 --%>
        $("#btn_check_form_code").click(function(){
            $('#code').focus();
        });
        <%-- 순서 포커스 --%>
        $("#btn_check_form_display_order").click(function(){
            $('#displayOrder').focus();
        });
    });
</script>
</body>
</html>