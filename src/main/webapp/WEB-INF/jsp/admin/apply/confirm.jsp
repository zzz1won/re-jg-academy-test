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

<script type="text/javascript">
    $(function () {
        <%-- 신청확정 --%>
        $("#btn_approve_confirm").click(function () {
            $('#pop_approve_confirm').bPopup().close();

            var applyNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var applyNo = $(this).val();
                applyNoArr += applyNo + ",";
            });

            applyNoArr = {
                "applyNo": applyNoArr
            };

            <%-- 신청확정 --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/apply/admin/approve'/>",
                data: JSON.stringify(applyNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_approve_success').bPopup();
                    } else {
                        $('#pop_approve_fail').bPopup();
                    }
                },
                error: function () {
                    alert("fail ajax !!!");
                }
            });
        });

        <%-- 확정취소 --%>
        $("#btn_pop_cancel_confirm").click(function () {
            $('#pop_cancel_confirm').bPopup().close();

            var applyNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var applyNo = $(this).val();
                applyNoArr += applyNo + ",";
            });

            applyNoArr = {
                "applyNo": applyNoArr
            };

            <%-- 확정취소 --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/apply/cancel/confirm'/>",
                data: JSON.stringify(applyNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_cancel_confirm_success').bPopup();
                    } else {
                        $('#pop_cancel_confirm_fail').bPopup();
                    }
                },
                error: function () {
                    alert("fail ajax !!!");
                }
            });
        });

        <%-- 신청취소 --%>
        $("#btn_pop_cancel_apply").click(function () {
            $('#pop_cancel_apply').bPopup().close();

            var applyNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var applyNo = $(this).val();
                applyNoArr += applyNo + ",";
            });

            applyNoArr = {
                "applyNo": applyNoArr,
                "state": "02"    <%-- 신청확정 --%>
            };

            <%-- 신청취소 --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/apply/cancel/apply'/>",
                data: JSON.stringify(applyNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_cancel_apply_success').bPopup();
                    } else {
                        $('#pop_cancel_apply_fail').bPopup();
                    }
                },
                error: function () {
                    alert("fail ajax !!!");
                }
            });
        });

        <%-- 엑셀 저장 --%>
        $("#btn_excel_confirm").click(function () {
            $('#pop_excel_confirm').bPopup().close();

            $('#applyExcelForm').attr("method", "post");
            $('#applyExcelForm').attr("action", "<c:out value='${pageContext.request.contextPath}/apply/admin/excel'/>");
            $('#applyExcelForm').submit();
        });
    });
</script>

<body>
<!-- wrapper -->
<div id="wrapper">

    <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>

    <!-- container -->
    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <!-- menu: 3개->6개 -->
                <div class="tab-wrap tab6">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks active">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    <%-- 220408 4개로 추가--%>
                    <a href="javascript:fn_codeList();" class="tablinks"> 코드 관리</a>
                    <%-- 220408 5개로 추가--%>
                    <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
                    <%-- 220510 6개로 추가--%>
                    <%-- adminHeader.jsp 파일에 선언해두었기 때문에 파일마다 일일히 function~ 할 필요 없음.--%>
                    <a href="javascript:fn_codingEx();" class="tablinks"> 지원 관리</a>
                </div>
                <!-- //menu -->
            </div>
        </div>
        <!-- search area -->
        <div class="search-wrap">
            <div class="search-container">
                <form id="searchForm" name="searchForm">
                    <ul class="filter-row">
                        <li>
                            <label for="year">조회기간</label>
                            <input type="text" id="year" name="year" value="<c:out value='${search.year}'/>"
                                   class="input-text year icon_calendar" style="width:100px" placeholder="년도"/>
                        </li>
                        <li>
                            <label for="eduTitle">과정명</label>
                            <input type="text" id="eduTitle" name="eduTitle" class="input-text" style="width:350px"
                                   value="<c:out value="${search.eduTitle}"/>"/>
                        </li>
                        <li>
                            <label for="applyState">신청확정</label>
                            <select name="applyState" id="applyState" class="wd_120">
                                <option value="">전 체</option>
                                <c:forEach var="applyState" items="${applyStateList}" varStatus="status">
                                    <option value="<c:out value="${applyState.code}"/>"
                                            <c:if test="${applyState.code eq search.applyState}">selected="selected"</c:if>>
                                        <c:out value="${applyState.codeName}"/></option>
                                </c:forEach>
                            </select>
                        </li>
                        <li>
                            <label for="judgeNo">심판번호</label>
                            <input type="text" id="judgeNo" name="judgeNo" class="input-text" style="width:140px"
                                   value="<c:out value="${search.judgeNo}"/>"/>
                        </li>
                        <li>
                            <button type="button" id="btn_search" class="btn2 btn-search">
                                <span>조회</span>
                            </button>
                        </li>
                    </ul>
                </form>
            </div>
        </div>
        <!-- //search area -->
        <!-- table-wrap -->
        <div class="content-wrap">
            <div class="table-wrap">
                <!-- table -->
                <table id="listTable" class="cell-border hover dataTable" width="100%">
                    <thead>
                    <tr>
                        <th><input name="select_all" value="1" id="select-all" type="checkbox"/></th>
                        <th>No</th>
                        <th style="width: 210px;">과정명</th>
                        <th>수강기간</th>
                        <th>종목</th>
                        <th>심판번호</th>
                        <th>이름</th>
                        <th>신청일시</th>
                        <th>신청확정</th>
                        <th>확정일시</th>
                        <th>확정자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="apply" items="${applyList}" varStatus="status">
                        <tr>
                            <td>
                                <input type="checkbox" id="chk${apply.rownum}" name="chk"
                                       value="<c:out value="${apply.eduApplyInfoNo}"/>">
                            </td>
                            <td><c:out value="${apply.rownum}"/></td>
                            <td><c:out value="${apply.acEduTitleMask}"/></td>
                            <td>
                                <fmt:parseDate var="acEduStartDate" value="${apply.acEduStartDate}" pattern="yyyyMMdd"/>
                                <fmt:formatDate value="${acEduStartDate}" pattern="yyyy/MM/dd"/>
                                ~
                                <fmt:parseDate var="acEduEndDate" value="${apply.acEduEndDate}" pattern="yyyyMMdd"/>
                                <fmt:formatDate value="${acEduEndDate}" pattern="yyyy/MM/dd"/>
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
                            <td><fmt:formatDate value="${apply.regDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                            <td>
                                <c:forEach var="applyState" items="${applyStateList}" varStatus="status">
                                    <c:if test="${applyState.code eq apply.state}">
                                        <c:out value="${applyState.codeName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td><fmt:formatDate value="${apply.applyConfirmDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                            <td>
                                <c:forEach var="admin" items="${adminList}" varStatus="status">
                                    <c:if test="${admin.adminId eq apply.applyConfirmId}">
                                        <c:out value="${admin.adminName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td><c:out value="${apply.acEduScheduleNo}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //table -->
            </div>
            <!-- btn area-->
            <div class="btn-wrap">
                <button type="button" id="btn_confirm" class="btn2 btn-blue">신청확정</button>
                <button type="button" id="btn_cancel_confirm" class="btn2 btn-blue">확정취소</button>
                <button type="button" id="btn_cancel_apply" class="btn2 btn-gray">신청취소</button>
                <button type="button" id="btn_excel" class="btn2">엑셀 저장</button>
            </div>
            <!-- //btn area -->
        </div>
        <!-- //table-wrap -->
    </div>
    <!-- //container -->

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

</div>
<!-- //wrapper -->

<!-- popup 01 -->
<div class="modal" id="pop_detail" style="width: 900px;"></div>
<!-- //popup 01-->

<!-- popup 02-1 -->
<div class="modal no_close" id="pop_approve_confirm">
    <div class="popup-content">
        <p class="pop-text">신청확정 처리 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_approve_confirm" class="btn2 btn-blue">확정</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 02-1 -->

<!-- popup 02-2 -->
<div class="modal no_close" id="pop_approve_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_approve_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 02-2 -->

<!-- popup 02-3 -->
<div class="modal no_close" id="pop_approve_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_approve_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 02-3 -->

<!-- popup 03-1 -->
<div class="modal no_close" id="pop_cancel_confirm">
    <div class="popup-content">
        <p class="pop-text">확정취소 처리 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_pop_cancel_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 03-1-->

<!-- popup 03-2 -->
<div class="modal no_close" id="pop_cancel_confirm_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cancel_confirm_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-2 -->

<!-- popup 03-3 -->
<div class="modal no_close" id="pop_cancel_confirm_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cancel_confirm_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-3 -->

<!-- popup 04-1 -->
<div class="modal no_close" id="pop_cancel_apply">
    <div class="popup-content">
        <p class="pop-text">신청취소 처리 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_pop_cancel_apply" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 04-1-->

<!-- popup 04-2 -->
<div class="modal no_close" id="pop_cancel_apply_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cancel_apply_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-2 -->

<!-- popup 04-3 -->
<div class="modal no_close" id="pop_cancel_apply_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cancel_apply_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-3 -->

<!-- popup 06-->
<div class="modal no_close" id="pop_excel_confirm">
    <div class="popup-content">
        <p class="pop-text">엑셀 파일로 저장하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_excel_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 06-->

<%-- 엑셀 저장하기 위한 파라미터 --%>
<form id="applyExcelForm" method="post">
    <input type="hidden" id="excelYear" name="excelYear" value="<c:out value="${search.year}"/>">
    <input type="hidden" id="excelEduTitle" name="excelEduTitle" value="<c:out value="${search.eduTitle}"/>">
    <input type="hidden" id="excelApplyState" name="excelApplyState" value="<c:out value="${search.applyState}"/>">
    <input type="hidden" id="excelJudgeNo" name="excelJudgeNo" value="<c:out value="${search.judgeNo}"/>">
</form>

<script>
    $(document).ready(function () {
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
                "emptyTable": "수강 신청 대상이 없습니다.",
                "paginate": {
                    "first": "<<",
                    "last": ">>",
                    "next": ">",
                    "previous": "<",
                }
            },

            //정렬, 링크
            "columnDefs": [
                {className: "dt-body-left", "targets": [2]},
                {className: "dt-body-right", "targets": [5, 6]},
                {
                    targets: [2],
                    render: function (data, type, row, meta) {
                        if (type === 'display') {
                            data = '<a href="javascript:fn_detail(' + row[11] + ');">' + data + '</a>';
                        }
                        return data;
                    }
                },
                {
                    targets: [0],
                    orderable: false,
                    searchable: false,
                    className: 'dt-body-center',
                    /* render: function(data, type, full, meta) {
                        return '<input type="checkbox" name="id[]" value="' +
                            $('<div/>').text(data).html() + '">';
                    } */
                },
                {
                    targets: [11],
                    visible: false
                }
            ],
            order: [1, 'asc'],

            // 페이징처리
            "fnDrawCallback": function () {
                if (Math.ceil((this.fnSettings().fnRecordsDisplay()) / this.fnSettings()._iDisplayLength) > 1) {
                    $('.dataTables_paginate').css("display", "block");
                } else {
                    $('.dataTables_paginate').css("display", "none");
                    $('.table-wrap+.btn-wrap').css("bottom", "-25px");
                }
            }
        });

        // 체크박스 모두 선택 "Select all" control
        $('#select-all').on('click', function () {
            // Check/uncheck all checkboxes in the table
            var rows = table.rows({'search': 'applied'}).nodes();
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        // Handle click on checkbox to set state of "Select all" control
        $('#listTable tbody').on('change', 'input[type="checkbox"]', function () {
            // If checkbox is not checked
            if (!this.checked) {
                var el = $('#select-all').get(0);
                // If "Select all" control is checked and has 'indeterminate' property
                if (el && el.checked && ('indeterminate' in el)) {
                    // Set visual state of "Select all" control
                    // as 'indeterminate'
                    el.indeterminate = true;
                }
            }
        });
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
        <%-- 검색 --%>
        $('#btn_search').click(function () {
            $('#searchForm').attr("method", "post");
            $('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/apply/admin/confirm'/>");
            $('#searchForm').submit();
        });

        <%-- 신청확정 처리하시겠습니까? --%>
        $('#btn_confirm').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("신청확정할 데이터를 선택해주세요.");
                return false;

            } else {
                var applyNoArr = "";
                $("input[name=chk]:checked").each(function () {
                    var applyNo = $(this).val();
                    applyNoArr += applyNo + ",";
                });

                applyNoArr = {
                    "applyNo": applyNoArr,
                    "state": "02"    <%-- 신청확정 --%>
                };

                <%--
                    신청확정을 위해 현재 신청확인 값만 있는지 확인
                    * 선택한 값에서 신청확정(02)값이 있을 경우, 신청확정을 못하도록 설정
                --%>
                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/apply/count/state'/>",
                    data: JSON.stringify(applyNoArr),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if (data.result > 0) {
                            <%-- 선택한 값에 신청확정 값이 존재하므로 stop --%>
                            alert("선택한 값에 신청확정 값이 있습니다.\n다시 한 번 선택해주세요.");
                            return false;

                        } else {
                            $('#pop_approve_confirm').bPopup({
                                speed: 450,
                            });
                        }
                    },
                    error: function () {
                        alert("fail ajax !!!");
                    }
                });
            }
        });

        <%-- 신청확정 성공 --%>
        $("#btn_approve_success").click(function () {
            $('#pop_approve_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/apply/admin/confirm'/>";
        });
        <%-- 신청확정 실패 --%>
        $("#btn_approve_fail").click(function () {
            $('#pop_approve_fail').bPopup().close();
        });

        <%-- 확정취소 처리하시겠습니까? --%>
        $('#btn_cancel_confirm').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("확정취소할 데이터를 선택해주세요.");
                return false;
            } else {
                var applyNoArr = "";
                $("input[name=chk]:checked").each(function () {
                    var applyNo = $(this).val();
                    applyNoArr += applyNo + ",";
                });

                applyNoArr = {
                    "applyNo": applyNoArr,
                    "state": "01"    <%-- 신청 --%>
                };

                <%--
                    확정취소를 위해 현재 신청확정 값만 있는지 확인
                    * 선택한 값에서 신청(01)값이 있을 경우, 확정취소를 못하도록 설정
                --%>
                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/apply/count/state'/>",
                    data: JSON.stringify(applyNoArr),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if (data.result > 0) {
                            <%-- 선택한 값에 신청 값이 존재하므로 stop --%>
                            alert("선택한 값에 신청 값이 있습니다. \n다시 한 번 선택해주세요.");
                            return false;
                        } else {
                            $('#pop_cancel_confirm').bPopup({
                                speed: 450,
                            });
                        }
                    },
                    error: function () {
                        alert("fail ajax !!!");
                    }
                });
            }
        });
        <%-- 확정취소 성공 --%>
        $("#btn_cancel_confirm_success").click(function () {
            $('#pop_cancel_confirm_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/apply/admin/confirm'/>";
        });
        <%-- 확정취소 실패 --%>
        $("#btn_cancel_confirm_fail").click(function () {
            $('#pop_cancel_confirm_fail').bPopup().close();
        });

        <%-- 신청취소 처리하시겠습니까? --%>
        $('#btn_cancel_apply').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("확정취소할 데이터를 선택해주세요.");
                return false;
            } else {
                var applyNoArr = "";
                $("input[name=chk]:checked").each(function () {
                    var applyNo = $(this).val();
                    applyNoArr += applyNo + ",";
                });

                applyNoArr = {
                    "applyNo": applyNoArr,
                    "state": "02"    <%-- 신청확정 --%>
                };

                <%--
                    신청취소를 위해 현재 신청중인 값만 있는지 확인
                    * 선택한 값에서 신청확정(02)값이 있을 경우, 신청취소를 못하도록 설정
                --%>
                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/apply/count/state'/>",
                    data: JSON.stringify(applyNoArr),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if (data.result > 0) {
                            <%-- 선택한 값에 신청확정 값이 존재하므로 stop --%>
                            alert("선택한 값에 신청확정 값이 있습니다. \n다시 한 번 선택해주세요.");
                            return false;

                        } else {
                            $('#pop_cancel_apply').bPopup({
                                speed: 450,
                            });
                        }
                    },
                    error: function () {
                        alert("fail ajax !!!");
                    }
                });
            }
        });
        <%-- 신청취소 성공 --%>
        $("#btn_cancel_apply_success").click(function () {
            $('#pop_cancel_apply_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/apply/admin/confirm'/>";
        });
        <%-- 신청취소 실패 --%>
        $("#btn_cancel_apply_fail").click(function () {
            $('#pop_cancel_apply_fail').bPopup().close();
        });

        <%-- 엑셀 저장 확인 팝업 --%>
        $('#btn_excel').click(function () {
            var applyListCnt = '<c:out value="${applyListCnt}"/>';
            if (applyListCnt < 1) {
                alert("데이터가 없어 엑셀 파일로 다운받으실 수 없습니다.");
                return false;
            }

            $('#pop_excel_confirm').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
        });
    });

</script>
</body>
</html>