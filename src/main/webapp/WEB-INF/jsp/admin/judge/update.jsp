<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>심판아카데미 운영 Admin</title>
</head>

<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>

<script type="text/javascript">
    var check = false;

    $(function () {
        <%-- 코드 수정 --%>
        $("#btn_update").click(function () {
            <%-- 필수입력값 체크 --%>
            check = fn_checkForm();
            console.log("필수입력값 체크")
            if (check) {
                $('#pop_confirm_update').bPopup({
                    speed: 450,
                    // transition: 'slideDown'
                });
            }
        });

        <%-- 수정 버튼 클릭 --%>
        $('#btn_confirm_update').click(function () {
            $('#pop_confirm_update').bPopup().close();
            console.log("등록버튼 클릭")
            if (check) {
                <%-- 중복 클릭 방지 --%>
                if (doubleSubmitCheck()) return;

                $('#judgeKind').val(fn_split($('#judgeKind').val()));
                $('#judgeNo').val(fn_split($('#judgeNo').val()));
                $('#judgeName').val(fn_split($('#judgeName').val()));
                $('#judgeState').val(fn_split($('#judgeState').val()));

                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/judge/admin/update'/>",
                    data: JSON.stringify($('#updateForm').serializeObject()),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if (data.result > 0) {
                            $('#pop_success_update').bPopup();
                        } else {
                            $('#pop_fail_update').bPopup();
                        }
                    },
                    error: function () {
                        $('#pop_fail_update').bPopup();
                    }
                });

                doubleSubmitFlag = false;
            } else {
                alert("다시 한 번 확인해주시기바랍니다.");
            }
        });
    });

    <%-- 필수입력값 체크 --%>

    function fn_checkForm() {
        var judgeKind = fn_split($('#judgeKind').val());
        <%-- 종목값 --%>
        var judgeNo = fn_split($('#judgeNo').val());
        <%-- 심판번호 --%>
        var judgeName = fn_split($('#judgeName').val());
        <%-- 심판이름 --%>
        var judgeState = fn_split($('#judgeState').val());
        <%-- 계정사용여부 --%>

        <%-- 종목값 --%>
        if ($('#judgeKind').val().length < 1) {
            $('#pop_check_form_judge_kind').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("judgeKind:" + judgeKind);
            console.log("judgeName:" + judgeName);
            console.log("judgeState:" + judgeState);
            return false;
        }
        <%-- 심판번호 --%>
        if ($('#judgeNo').val().length < 1) {
            $('#pop_check_form_judge_name').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("judgeKind:" + judgeKind);
            console.log("judgeName:" + judgeName);
            console.log("judgeState:" + judgeState);
            return false;
        }
        <%-- 심판이름 --%>
        if ($('#judgeName').val().length < 1) {
            $('#pop_check_form_judge_name').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("judgeKind:" + judgeKind);
            console.log("judgeName:" + judgeName);
            console.log("judgeState:" + judgeState);
            return false;
        }
        <%-- 계정사용여부 --%>
        if ($('#judgeState').val().length < 1) {
            $('#pop_check_form_judge_state').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
            console.log("judgeKind:" + judgeKind);
            console.log("judgeName:" + judgeName);
            console.log("judgeState:" + judgeState);
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
                <div class="tab-wrap tab5">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    <a href="javascript:fn_codeList();" class="tablinks"> 코드 관리</a>
                    <a href="javascript:fn_judgeList();" class="tablinks active"> 심판 관리</a>
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
                        <caption>코드 수정 테이블</caption>
                        <colgroup>
                            <col width="140px">
                            <col width="">
                            <col width="140px">
                            <col width="">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="required_need">종목</th>
                            <td>
                                <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                                    <option selected><c:out value="${judgeVO.codeName}"/></option>
                                </select>
                            </td>

                            <th class="required_need">심판번호</th>
                            <td><input type="text" disabled name="judgeNo" id="judgeNo"
                                       value="<c:out value="${judgeVO.judgeNo}"/>"></td>
                        </tr>
                        <tr>
                            <th class="required_need">이름</th>
                            <td><input type="text" name="judgeName" id="judgeName"
                                       value="<c:out value="${judgeVO.judgeName}"/>"></td>
                            <th class="required_need">계정사용여부</th>
                            <td>
                                <c:choose>
                                    <c:when test="${judgeVO.judgeState eq 'Y'}">
                                        <input class="form-check-input" type="radio" name="judgeState" id="exampleRadios1" value="${judgeVO.judgeState}" checked>
                                        <label class="form-check-label" for="exampleRadios1">
                                            예
                                        </label>
                                        <input class="form-check-input" type="radio" name="judgeState" id="exampleRadios2" value="${judgeVO.judgeState}">
                                        <label class="form-check-label" for="exampleRadios2">
                                            아니오
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <input class="form-check-input" type="radio" name="judgeState" id="exampleRadios1" value="${judgeVO.judgeState}">
                                        <label class="form-check-label" for="exampleRadios1">
                                            예
                                        </label>
                                        <input class="form-check-input" type="radio" name="judgeState" id="exampleRadios2" value="${judgeVO.judgeState}" checked>
                                        <label class="form-check-label" for="exampleRadios2">
                                            아니오
                                        </label>
                                    </c:otherwise>
                                </c:choose>

                                <input type="radio" name="judgeState" id="judgeSate"
                                       value="<c:out value="${judgeVO.judgeState}"/>"></td>
                        </tr>
                        <tr>
                            <th>비고</th>
                            <td colspan="3"><c:choose>
                                <c:when test="${judge.judgeEtc eq null}">
                                    <input type="text" name="judgeEtc" id="judgeEtc"
                                           placeholder="비고란이 비어있습니다.">
                                </c:when>
                                <c:when test="${empty judge.judgeEtc}">
                                    <input type="text" name="judgeEtc" id="judgeEtc"
                                           placeholder="비고란이 비어있습니다.">
                                </c:when>
                                <c:otherwise>
                                    <input type="text" name="judgeEtc" id="judgeEtc"
                                           value="<c:out value="${judge.judgeEtc}"/>">
                                </c:otherwise>
                            </c:choose>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- //table -->
                </div>
                <%--<!-- btn area -->--%>
            </form>

            <div class="btn-wrap">
                <button type="button" id="btn_update" class="btn2 btn-blue">수정</button>
                <button type="button" id="btn_judge_list" class="btn2 btn-gray">목록</button>
            </div>
            <!-- //btn area -->
        </div>
        <!-- //table-wrap -->
    </div>
    <!-- //container -->

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

</div>
<%--<!-- //wrapper -->--%>
<!-- popup 01-->
<div class="modal no_close" id="pop_confirm_update">
    <div class="popup-content">
        <p class="pop-text">해당 심판정보를 수정 하시겠습니까?</p>
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
<div class="modal no_close" id="pop_check_form_judge_kind">
    <div class="popup-content">
        <p class="pop-text">종목을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_kind" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_no">
    <div class="popup-content">
        <p class="pop-text">번호는 비활성화~</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_no" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->
<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_name">
    <div class="popup-content">
        <p class="pop-text">이름을 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_name" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->

<!-- popup 04-->
<div class="modal no_close" id="pop_check_form_judge_state">
    <div class="popup-content">
        <p class="pop-text">계정사용여부를 확인해 주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_check_form_judge_state" class="btn2 btn-blue b-close">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->


<%-- 버튼, 팝업 --%>
<script type="text/javascript">
    $(document).ready(function () {

        <%-- 목록 버튼 클릭--%>
        $('#btn_judge_list').click(function () {
            location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeList'/>";
        });

        <%-- 수정 성공 --%>
        $("#btn_success_update").click(function () {
            $('#pop_success_update').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeList'/>";
        });
        <%-- 수정 실패 --%>
        $("#btn_fail_update").click(function () {
            $('#pop_fail_update').bPopup().close();
        });

        <%-- 종목 포커스 --%>
        $("#btn_check_form_judge_kind").click(function () {
            $('#judgeKind').focus();
        });
        <%-- 심판번호 포커스 --%>
        $("#btn_check_form_judge_no").click(function () {
            $('#judgeNo').focus();
        });
        <%-- 심판이름 포커스 --%>
        $("#btn_check_form_judge_name").click(function () {
            $('#judgeName').focus();
        });
        <%-- 계정사용여부 포커스 --%>
        $("#btn_check_form_judge_state").click(function () {
            $('#judgeState').focus();
        });
    });
</script>
</body>
</html>