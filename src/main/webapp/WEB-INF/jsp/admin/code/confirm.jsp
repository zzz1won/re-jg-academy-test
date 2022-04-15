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

            var codeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var codeNo = $(this).val();
                codeNoArr += codeNo + ",";
            });

            codeNoArr = {
                "codeNo": codeNoArr
            };

            <%-- 신청확정 --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/code/admin/approve'/>",
                data: JSON.stringify(codeNoArr),
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
                    alert("y로 변경에서 fail ajax !!!");
                }
            });
        });

        <%-- 0413 코드변경(N) --%>
        $("#btn_change_code_state").click(function () {
            $('#pop_change_code_state').bPopup().close();

            var codeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var codeNo = $(this).val();
                codeNoArr += codeNo + ",";
            });

            codeNoArr = {
                "codeNo": codeNoArr,
                "useState": "N"    <%-- 코드 미사용 --%>
            };

            <%-- 코드변경(N) --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/code/admin/stateChkN'/>",
                data: JSON.stringify(codeNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_change_code_state_success').bPopup();
                    } else {
                        $('#pop_change_code_state_fail').bPopup();
                    }
                },
                error: function () {
                    alert("코드변경(N) fail ajax ㅠㅠ !!!");
                }
            });
        });

        <%-- 코드 삭제 --%>
        $("#btn_delete_confirm").click(function () {
            $('#pop_delete_confirm').bPopup().close();

            var codeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var codeNo = $(this).val();
                codeNoArr += codeNo + ",";
            });

            codeNoArr = {
                "codeNo": codeNoArr
            };

            console.log(codeNoArr) //로그는 찍힌당.

            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/code/admin/delete'/>",
                data: JSON.stringify(codeNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_delete_success').bPopup();
                    } else {
                        $('#pop_delete_fail').bPopup();
                    }

                },
                error: function () {
                    alert("fail ajax !!!");
                }
            });
        });
    });

    <%-- 상세화면 이동 --%>

    function fn_detailPage(codeNo) {
        $('#commonCodeNo').val(codeNo);
        $('#detailView').attr("method", "post");
        $('#detailView').attr("action", "<c:out value='${pageContext.request.contextPath}/code/admin/detail'/>");
        $('#detailView').submit();
        console.log(commonCodeNo);
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
                <%--menu: 3개--%>
                <div class="tab-wrap tab5">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    <%-- 220408 4개로 추가--%>
                    <a href="javascript:fn_codeList();" class="tablinks active"> 코드 관리</a>
                    <%-- 220408 5개로 추가--%>
                    <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
                </div>
                <%-- menu --%>
            </div>
        </div>
        <!-- search area -->
        <div class="search-wrap">
            <div class="search-container">
                <form id="searchForm" name="searchForm">
                    <ul class="filter-row">
                        <li>
                            <label for="codeListCheck">분 류</label>
                            <select name="codeListCheck" id="codeListCheck" class="wd_120">
                                <option value="00">전체</option>
                                <option value="01">그룹코드명</option>
                                <option value="02">코드명</option>
                                <%-- 검색부분 체크할 것 --%>
                            </select>
                        </li>
                        <li>
                            <input type="text" id="codeName" name="codeName" class="input-text" style="width:140px"
                                   value="<c:out value="${search.codeName}"/>">
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
                        <th style="width: 210px;">코드명</th>
                        <th>코드값</th>
                        <th>순서</th>
                        <th>그룹코드명</th>
                        <th>그룹코드값</th>
                        <th>등록일</th>
                        <th>비고</th>
                        <th>사용여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="code" items="${codeList}" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="chk${code.commonCodeNo}" name="chk"
                                       value="<c:out value="${code.commonCodeNo}"/>"></td>
                            <td><c:out value="${code.commonCodeNo}"></c:out></td>
                            <td style="width: 210px;"><c:out value="${code.codeName}"></c:out></td>
                            <td><c:out value="${code.code}"></c:out></td>
                            <td><c:out value="${code.displayOrder}"></c:out></td>
                            <td><c:out value="${code.groupCodeName}"></c:out></td>
                            <td><c:out value="${code.groupCode}"></c:out></td>
                            <td><fmt:formatDate value="${code.regDate}" pattern="yyyy/MM/dd"/></td>
                            <td><c:choose>
                                <c:when test="${code.etcInfo eq null}">
                                    -
                                </c:when>
                                <c:when test="${empty code.etcInfo}">
                                    -
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${code.etcInfo}"></c:out>
                                </c:otherwise>
                            </c:choose>
                            </td>
                            <td><c:out value="${code.useState}"/></td>
                            <td><c:out value="${code.commonCodeNo}"/></td>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //table -->
            </div>
            <!-- btn area-->
            <div class="btn-wrap">
                <button type="button" id="btn_register" class="btn2 btn-blue">신규코드 등록</button>
                <button type="button" id="btn_change_code_state" class="btn2 btn-blue">코드상태변경</button>
                <button type="button" id="btn_delete" class="btn2 btn-gray">삭제</button>
            </div>
            <!-- //btn area -->
        </div>
        <!-- //table-wrap -->
    </div>
    <!-- //container -->

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

</div>
<!-- //wrapper -->

<!-- popup 01-->
<div class="modal no_close" id="pop_delete_confirm">
    <div class="popup-content">
        <p class="pop-text">선택한 과정을 삭제하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_delete_confirm" class="btn2 btn-blue">삭제</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 01-->
<!-- popup 02-->
<div class="modal no_close" id="pop_delete_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_delete_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 02-->
<!-- popup 03-->
<div class="modal no_close" id="pop_delete_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다.<br>관리자에게 문의해주시기 바랍니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_delete_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-->

<!-- popup 04-->
<div class="modal" id="pop_detail" style="width: 900px;"></div>
<!-- //popup 04-->

<!-- popup 03-1 --><%-- codeState == N --%>
<div class="modal no_close" id="pop_change_code_state">
    <div class="popup-content">
        <p class="pop-text">코드 상태를 N으로 변경하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_pop_change_code_state" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 03-1-->

<!-- popup 03-2 -->
<div class="modal no_close" id="pop_change_code_state_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_change_code_state_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-2 -->

<!-- popup 03-3 -->
<div class="modal no_close" id="pop_change_code_state_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_change_code_state_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-3 -->


<%-- 상세화면으로 가기 위한 파라미터 --%>
<form id="detailView" method="post">
    <input type="hidden" id="commonCodeNo" name="commonCodeNo">
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
                        if (type === 'display') { //detail.jsp 열어야함.
                            data = '<a href="javascript:fn_detailPage(' + row[10] + ');">' + data + '</a>';
                        }
                        return data;
                    }
                },
                {
                    targets: [0],
                    orderable: false,
                    searchable: false,
                    className: 'dt-body-center',
                },
                {
                    targets: [10],
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

<%-- 코드상태변경 관련 --%>
<script>
    <%-- 코드변경(N) 처리하시겠습니까? --%>
    $('#btn_change_code_state').click(function () {
        <%-- 체크한 값이 있는지 확인 --%>
        if ($("input[name=chk]:checked").length < 1) {
            alert("상태를 변경할 데이터를 선택해주세요.");
            return false;
        } else {
            var codeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var codeNo = $(this).val();
                codeNoArr += codeNo + ",";
            });

            codeNoArr = {
                "codeNo": codeNoArr,
                /*"useState": "Ngsdaaf"*/    <%-- 코드 미사용 --%>
            };
        }
    });
    <%-- 코드변경(N) 성공 --%>
    $("#btn_change_code_state_success").click(function () {
        $('#pop_change_code_state_success').bPopup().close();
        location.href = "<c:out value='${pageContext.request.contextPath}/code/admin/confirm'/>";
    });
    <%-- 코드변경(N) 실패 --%>
    $("#btn_change_code_state_fail").click(function () {
        $('#pop_change_code_state_fail').bPopup().close();
    });
</script>
<%-- 코드상태변경 관련 --%>


<%-- 팝업 및 버튼, 검색 관련 --%>
<script type="text/javascript">
    $(document).ready(function () {
        <%-- 코드 삭제 확인 팝업 --%>
        $('#btn_delete').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("삭제할 코드를 선택해주세요.");
                console.log("코드선택을 안함")
                return false;
            }
            $('#pop_delete_confirm').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
        });

        <%-- 신규 코드과정 등록화면으로 이동 --%>
        $('#btn_register').click(function () {
            location.href = "<c:out value='${pageContext.request.contextPath}/code/admin/registerPage'/>";
        });

        <%-- 삭제 성공 --%>
        $("#btn_delete_success").click(function () {
            $('#pop_delete_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/code/admin/confirm'/>";
            console.log("삭제성공")
        });
        <%-- 삭제 실패 --%>
        $("#btn_delete_fail").click(function () {
            $('#pop_delete_fail').bPopup().close();
            console.log("삭제실패")
        });

        <%-- 검색 --%>
        $('#btn_search').click(function () {
            $('#searchForm').attr("method", "post");
            $('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/code/admin/confirm'/>");
            $('#searchForm').submit();
            console.log("검색!")
        });
    });
</script>
<%-- 팝업 및 버튼, 검색 관련 --%>
</body>
</html>