<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코드 상세정보</title>
</head>
<script type="text/javascript">

</script>

<!-- content -->
<h1 class="popup_tit">코드 상세 정보</h1>
<div class="popup-content">
    <form id="updateForm" name="updateForm">
        <div class="table-write-wrap">
            <!-- table -->
            <table>
                <caption>코드 상세 정보 테이블</caption>
                <colgroup>
                    <col width="110px">
                    <col width="">
                    <col width="110px">
                    <col width="">
                </colgroup>
                <tbody>
                <tr>
                    <th>그룹코드명</th>
                    <td><c:out value="${codeVO.groupCodeName}"/></td>
                    <th>그룹코드값</th>
                    <td><c:out value="${codeVO.groupCode}"/></td>
                </tr>
                <tr>
                    <th>코드명</th>
                    <td><c:out value="${codeVO.codeName}"/></td>
                    <th>코드값</th>
                    <td><c:out value="${codeVO.code}"/></td>
                </tr>
                <tr>
                    <th>순서</th>
                    <td colspan="3"> <c:out value="${codeVO.displayOrder}"/></td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="3"><c:out value="${codeVO.etcInfo}"/></td>
                </tr>
                </tbody>
            </table>
            <!-- //table -->
        </div>
        <!-- btn area -->

        <input type="hidden" id="commonCodeNo" name="commonCodeNo" value="<c:out value="${codeVO.commonCodeNo}"/>">
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