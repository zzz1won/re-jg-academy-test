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

            var judgeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var judgeNo = $(this).val();
                judgeNoArr += judgeNo + ",";
            });

            judgeNoArr = {
                "judgeChkNo": judgeNoArr
            };

            <%-- 신청확정 --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/code/admin/approve'/>",
                data: JSON.stringify(judgeNoArr),
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

        <%-- 0415 계정사용 상태변경(Y) --%>
        $("#btn_change_state_Y").click(function () {
            $('#pop_change_state_Y').bPopup().close();

            var judgeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var judgeChkNo = $(this).val();
                judgeNoArr += judgeChkNo + ",";
            });

            judgeNoArr = {
                "judgeChkNo": judgeNoArr,
                "state": "Y"    <%-- 계정사용 --%>
            };

            <%-- 계정상태 변경(Y) --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/judge/admin/stateChkY'/>",
                data: JSON.stringify(judgeNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_change_state_Y_success').bPopup();
                    } else {
                        $('#pop_change_state_Y_fail').bPopup();
                    }
                },
                error: function () {
                    alert("계정상태(Y) fail ajax ㅠㅠ !!!");
                }
            });
        });

        <%-- 0415 계정사용 상태변경(N) --%>
        $("#btn_change_state_N").click(function () {
            $('#pop_change_state_N').bPopup().close();

            var judgeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var judgeChkNo = $(this).val();
                judgeNoArr += judgeChkNo + ",";
            });

            judgeNoArr = {
                "judgeChkNo": judgeNoArr,
                "state": "N"    <%-- 계정사용 --%>
            };

            <%-- 계정상태 변경(N) --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/judge/admin/stateChkN'/>",
                data: JSON.stringify(judgeNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_change_state_N_success').bPopup();
                    } else {
                        $('#pop_change_state_N_fail').bPopup();
                    }
                },
                error: function () {
                    alert("계정상태(N) fail ajax ㅠㅠ !!!");
                }
            });
        });


        <%-- 코드 삭제 --%>
        $("#btn_delete_confirm").click(function () {
            $('#pop_delete_confirm').bPopup().close();

            var judgeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var judgeNo = $(this).val();
                judgeNoArr += judgeNo + ",";
            });

            judgeNoArr = {
                "judgeNo": judgeNoArr
            };

            console.log(judgeNoArr) //로그는 찍힌당.

            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/judge/admin/delete'/>",
                data: JSON.stringify(judgeNoArr),
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

    function fn_detailPage(judgeNo) {
        $('#judgeNo').val(judgeNo);
        $('#detailView').attr("method", "post");
        $('#detailView').attr("action", "<c:out value='${pageContext.request.contextPath}/judge/admin/detail'/>");
        $('#detailView').submit();
        console.log(judgeNo);
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
                <!-- menu: 3개->6개 -->
                <div class="tab-wrap tab6">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                    <%-- 220408 4개로 추가--%>
                    <a href="javascript:fn_codeList();" class="tablinks"> 코드 관리</a>
                    <%-- 220408 5개로 추가--%>
                    <a href="javascript:fn_judgeList();" class="tablinks active"> 심판 관리</a>
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
                            <label for="searchChkValue">분 류</label>
                            <select id="searchChkValue" name="searchChkValue" class="wd_120">
                                <option value="">전체</option>
                                <c:forEach var="judgeKind" items="${judgeKindList}" varStatus="status">
                                    <option value="<c:out value="${judgeKind.code}"/>"
                                            <c:if test="${judgeKind.code eq searchVO.searchChkValue}">selected="selected"</c:if>> <%--선택한 데이터 있을 시--%>
                                        <c:out value="${judgeKind.codeName}"/></option>
                                    <%-- judgeKind의 code값을 가진, codeName을 띄우는?...--%>
                                </c:forEach>
                            </select>
                            <%-- 검색부분 체크할 것 --%>
                        </li>
                        <li>
                            <input type="text" id="searchArea" name="searchArea" class="input-text" style="width:140px"
                                   placeholder="이름 또는 심판번호" value="<c:out value="${searchVO.searchArea}"/>">
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
                        <th style="width: 210px;">이름</th>
                        <th>종목번호</th>
                        <th>심판종목</th>
                        <th>사용여부</th>
                        <th>등록일</th>
                        <th>비고</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="judge" items="${judgeList}" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="chk${judge.judgeNo}" name="chk"
                                       value="<c:out value="${judge.judgeNo}"/>"></td>
                            <td><c:out value="${judge.judgeNo}"></c:out></td>
                            <td style="width: 210px;"><c:out value="${judge.judgeName}"></c:out></td>
                            <td><c:out value="${judge.judgeKind}"></c:out></td>

                            <td><%--judgeCon-confirm에서 judgeKindList 내용들 추가 --%>
                                <c:forEach var="kind" items="${judgeKindList}" varStatus="status">
                                    <c:if test="${kind.code eq judge.judgeKind}">
                                        <c:out value="${kind.codeName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>

                            <td><c:out value="${judge.judgeState}"></c:out></td>
                            <td><fmt:formatDate value="${judge.regDate}" pattern="yyyy-MM-dd"/></td>
                            <td colspan="3">
                                <c:out value="${judge.judgeEtc}" default="-"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //table -->
            </div>
            <!-- btn area-->
            <div class="btn-wrap">
                <button type="button" id="btn_register" class="btn2 btn-blue">신규심판등록</button>
                <button type="button" id="btn_change_state_Y" class="btn2 btn-blue">계정사용</button>
                <button type="button" id="btn_change_state_N" class="btn2 btn-gray">계정미사용</button>
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

<%--계정상태 변경(Y)--%>
<!-- popup 03-1 --><%-- judgeState == Y --%>
<div class="modal no_close" id="pop_change_state_Y">
    <div class="popup-content">
        <p class="pop-text">계정을 사용하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_pop_change_state_Y" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 03-1-->

<!-- popup 03-2 -->
<div class="modal no_close" id="pop_change_state_Y_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_change_state_Y_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-2 -->

<!-- popup 03-3 -->
<div class="modal no_close" id="pop_change_state_Y_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_change_state_Y_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-3 -->

<%-- 계정상태 변경(N)--%>
<!-- popup 03-1 --><%-- judgeState == Y --%>
<div class="modal no_close" id="pop_change_state_N">
    <div class="popup-content">
        <p class="pop-text">계정을 미사용하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_pop_change_state_N" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 03-1-->

<!-- popup 03-2 -->
<div class="modal no_close" id="pop_change_state_N_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_change_state_N_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-2 -->

<!-- popup 03-3 -->
<div class="modal no_close" id="pop_change_state_N_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_change_state_N_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-3 -->


<%--상세화면으로 가기 위한 파라미터 --%>
<form id="detailView" method="post">
    <input type="hidden" id="judgeNo" name="judgeNo">
    <input type="hidden" id="viewSearchChkValue" name="viewSearchChkValue" value="<c:out value="${searchVO.searchChkValue}"/>">
    <input type="hidden" id="viewSearchArea" name="viewSearchArea" value="<c:out value="${searchVO.searchArea}"/>">
    <%--기존 searchChkValue id값이 존재하므로 앞에 view를 붙여줌.--%>
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
                "emptyTable": "심판이 없습니다 ㅎㅎ",
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
                /*{className: "dt-body-right", "targets": [5, 6]}, 우측정렬*/
                {
                    targets: [2],
                    render: function (data, type, row, meta) {
                        if (type === 'display') { //detail.jsp 열어야함.
                            data = '<a href="javascript:fn_detailPage(' + row[1] + ');">' + data + '</a>';
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

<%-- 계정사용 상태변경 관련 --%>
<script>
    <%-- 사용(Y) 처리하시겠습니까? --%>
    $('#btn_change_state_Y').click(function () {
        <%-- 체크한 값이 있는지 확인 --%>
        if ($("input[name=chk]:checked").length < 1) {
            alert("계정사용으로 변경할 데이터를 선택해주세요.");
            return false;
        } else {
            var judgeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var judgeChkNo = $(this).val();
                judgeNoArr += judgeChkNo + ",";
            });

            judgeNoArr = {
                "judgeChkNo": judgeNoArr,
            };
        }
    });
    <%-- 계정상태변경 (Y) 성공 --%>
    $("#btn_change_state_Y_success").click(function () {
        $('#pop_change_state_Y_success').bPopup().close();
        location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeList'/>";
    });
    <%-- 계정상태변경 (Y) 실패 --%>
    $("#btn_change_state_Y_fail").click(function () {
        $('#pop_change_state_Y_fail').bPopup().close();
    });


    <%-- 미사용(N) 처리하시겠습니까? --%>
    $('#btn_change_state_N').click(function () {
        <%-- 체크한 값이 있는지 확인 --%>
        if ($("input[name=chk]:checked").length < 1) {
            alert("계정미사용으로 변경할 데이터를 선택해주세요.");
            return false;
        } else {
            var judgeNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var judgeChkNo = $(this).val();
                judgeNoArr += judgeChkNo + ",";
            });

            judgeNoArr = {
                "judgeChkNo": judgeNoArr,
            };
        }
    });
    <%-- 계정상태변경 (N) 성공 --%>
    $("#btn_change_state_N_success").click(function () {
        $('#pop_change_state_N_success').bPopup().close();
        location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeList'/>";
    });
    <%-- 계정상태변경 (N) 실패 --%>
    $("#btn_change_state_N_fail").click(function () {
        $('#pop_change_state_N_fail').bPopup().close();
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

        <%-- 신규 심판 등록화면으로 이동? --%>
        $('#btn_register').click(function () {
            location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/registerPage'/>";
        });

        <%-- 삭제 성공 --%>
        $("#btn_delete_success").click(function () {
            $('#pop_delete_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeList'/>";
            console.log("삭제성공")
        });

        <%-- 삭제 실패 --%>
        $("#btn_delete_fail").click(function () {
            $('#pop_delete_fail').bPopup().close();
            console.log("삭제실패")
        });

        <%-- 검색 --%>
        $('#btn_search').click(function () { //body의 btn_search 버튼 누를시 실행되는 함수
            $('#searchForm').attr("method", "post"); //method에 post형식을 담아감
            $('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/judge/admin/judgeList'/>");
            $('#searchForm').submit();
            console.log("검색!")
        });
    });
</script>
<%-- 팝업 및 버튼, 검색 관련 --%>
</body>
</html>