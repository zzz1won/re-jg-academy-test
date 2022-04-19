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
    var state;

    $(function () {
        <%-- 수료확정 --%>
        $("#btn_cert_confirm").click(function () {
            state = "cert";
            fn_cert(state);
        });

        <%-- 미수료 --%>
        $("#btn_no_cert_confirm").click(function () {
            state = "noCert";
            fn_cert(state);
        });

        <%-- 확정취소 --%>
        $("#btn_cancel_cert_confirm").click(function () {
            $('#pop_cancel_cert_confirm').bPopup().close();

            var certNoArr = "";
            var applyNoArr = "";
            $("input[name=chk]:checked").each(function () {
                var certNo = $(this).val();
                var applyNo = $(this).attr("id");
                applyNo = applyNo.split("chk")[1];

                certNoArr += certNo + ",";
                applyNoArr += applyNo + ",";
            });

            certNoArr = {
                "certNo": certNoArr,
                "applyNo": applyNoArr
            };

            <%-- 확정취소 --%>
            $.ajax({
                type: "post",
                url: "<c:out value='${pageContext.request.contextPath}/cert/cancel/cert'/>",
                data: JSON.stringify(certNoArr),
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    if (data.result > 0) {
                        $('#pop_cert_success').bPopup();
                    } else {
                        $('#pop_cert_fail').bPopup();
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
            $('#applyExcelForm').attr("action", "<c:out value='${pageContext.request.contextPath}/cert/admin/excel'/>");
            $('#applyExcelForm').submit();
        });

        <%-- 파일 업로드(수료증 등록) --%>
        $("#btn_uploadFile_confirm").click(function () {
            $('#pop_uploadFile_confirm').bPopup().close();

            $.ajax({
                type: "post",
                enctype: "multipart/form-data",
                url: "<c:out value='${pageContext.request.contextPath}/file/upload/cert'/>",
                data: new FormData($('#fileForm')[0]),
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data.result > 0) $('#pop_cert_success').bPopup();
                    else $('#pop_cert_fail').bPopup();
                },
                error: function () {
                    $('#pop_cert_fail').bPopup();
                }
            });
        });
    });

    <%-- 수료 확정 및 미수료 처리 --%>

    function fn_cert(state) {
        if (state == "cert") $('#pop_cert_confirm').bPopup().close();
        else if (state == "noCert") $('#pop_no_cert_confirm').bPopup().close();

        var certNoArr = "";
        var applyNoArr = "";
        $("input[name=chk]:checked").each(function () {
            var certNo = $(this).val();
            var applyNo = $(this).attr("id");
            applyNo = applyNo.split("chk")[1];

            certNoArr += certNo + ",";
            applyNoArr += applyNo + ",";
        });

        certNoArr = {
            "certNo": certNoArr,
            "state": state,
            "applyNo": applyNoArr
        };

        $.ajax({
            type: "post",
            url: "<c:out value='${pageContext.request.contextPath}/cert/admin/decide'/>",
            data: JSON.stringify(certNoArr),
            dataType: "json",
            contentType: "application/json;charset=UTF-8",
            success: function (data) {
                <%-- 0: 성공, 1: 실패 --%>
                if (data.result == 0) {
                    $('#pop_cert_success').bPopup();
                } else {
                    $('#pop_cert_fail').bPopup();
                }
            },
            error: function () {
                alert("fail ajax !!!");
            }
        });

        flag = 0;
    }

    <%-- 수료증 업로드 및 등록하지 않은 수료증 미리보기(미등록된 상태)  --%>

    function fn_register_cert(certInfo, applyNo, judgeNo) {
        $('#acEduCertInfoNo').val(certInfo);

        // 20201124 관리자용 수료증 팝업(미등록)
        $('#pop_no_certFile').bPopup({
            speed: 450,
        });
    }

    <%-- 수료증 업로드 및 등록된 수료증 미리보기(등록된 상태) --%>

    function fn_view_cert(certNo) {
        // 20201124 관리자용 수료증 - 프레임 불러오는것
        $('#pop_certFile').bPopup({
            content: 'iframe',
            contentContainer: '.content-print',
            loadUrl: '<c:out value="${pageContext.request.contextPath}/cert/popup/view"/>' + '?certNo=' + certNo,
            iframeAttr: 'scrolling="no" frameborder="0" style="height:1280px;width:800px;"',
        });
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
                <div class="tab-wrap tab5">
                    <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                    <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                    <a href="javascript:fn_certList();" class="tablinks active"> 수료 관리</a>
                    <%-- 220408 4개로 추가--%>
                    <a href="javascript:fn_codeList();" class="tablinks"> 코드 관리</a>
                    <%-- 220408 5개로 추가--%>
                    <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
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
                            <label for="applyState">수료확정</label>
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
                        <th>종목</th>
                        <th>심판번호</th>
                        <th>이름</th>
                        <th>수료기간</th>
                        <th>수료확정</th>
                        <th>수료증</th>
                        <th>확정일시</th>
                        <th>확정자</th>
                        <th>등록일시</th>
                        <th>등록자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="cert" items="${certList}" varStatus="status">
                        <tr>
                            <td>
                                <input type="checkbox" id="chk${cert.eduApplyInfoNo}" name="chk"
                                       value="<c:out value="${cert.acEduCertInfoNo}"/>">
                            </td>
                            <td><c:out value="${cert.rownum}"/></td>
                            <td><c:out value="${cert.acEduTitleMask}"/></td>
                            <td>
                                <c:forEach var="kind" items="${judgeKindList}" varStatus="status">
                                    <c:if test="${kind.code eq cert.judgeKind}">
                                        <c:out value="${kind.codeName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td><c:out value="${cert.judgeNo}"/></td>
                            <td><c:out value="${cert.judgeName}"/></td>
                            <td>
                                <fmt:formatDate value="${cert.applyConfirmDate}" pattern="yyyy/MM/dd"/> ~
                                <fmt:formatDate value="${cert.certConfirmDate}" pattern="yyyy/MM/dd"/>
                            </td>
                            <td>
                                <c:forEach var="applyState" items="${applyStateList}" varStatus="status">
                                    <c:if test="${applyState.code eq cert.state}">
                                        <c:out value="${applyState.codeName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${cert.state eq '03'}">
                                        <%-- 수료증 등록되어있는 경우 --%>
                                        <c:choose>
                                            <c:when test="${not empty cert.acEduCertFilePath}">
                                                <a href="javascript:fn_view_cert('<c:out value="${cert.acEduCertInfoNo}"/>');"
                                                   class="btn-num">등록완료</a>
                                            </c:when>
                                            <%-- 수료증 미등록되어있는 경우 --%>
                                            <c:otherwise>
                                                <a href="javascript:fn_register_cert('<c:out value="${cert.acEduCertInfoNo}"/>', '<c:out value="${cert.eduApplyInfoNo}"/>', '<c:out value="${cert.judgeNo}"/>');"
                                                   class="btn-num">등록전</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <%-- 수료상태 아님 --%>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${cert.certConfirmDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                            <td>
                                <c:forEach var="admin" items="${adminList}" varStatus="status">
                                    <c:if test="${admin.adminId eq cert.certConfirmId}">
                                        <c:out value="${admin.adminName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td><fmt:formatDate value="${cert.fileDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                            <td>
                                <c:forEach var="admin" items="${adminList}" varStatus="status">
                                    <c:if test="${admin.adminId eq cert.fileId}">
                                        <c:out value="${admin.adminName}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td><c:out value="${cert.acEduScheduleNo}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //table -->
            </div>
            <!-- btn area-->
            <div class="btn-wrap">
                <button type="button" id="btn_cert" class="btn2 btn-blue">수료확정</button>
                <button type="button" id="btn_cancel_cert" class="btn2 btn-blue">확정취소</button>
                <button type="button" id="btn_no_cert" class="btn2 btn-gray">미수료</button>
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

<!-- popup 01-->
<div class="modal no_close" id="pop_cert_confirm">
    <div class="popup-content">
        <p class="pop-text">수료확정 처리 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cert_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 01-->

<!-- popup 02-->
<div class="modal no_close" id="pop_no_cert_confirm">
    <div class="popup-content">
        <p class="pop-text">미수료 처리 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_no_cert_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 02 -->

<!-- popup 03-->
<div class="modal no_close" id="pop_cert_success">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리되었습니다.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cert_success" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 03-->

<!-- popup 04-->
<div class="modal no_close" id="pop_cert_fail">
    <div class="popup-content">
        <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cert_fail" class="btn2 btn-blue">확인</button>
        </div>
    </div>
</div>
<!-- //popup 04-->

<!-- popup 01-->
<div class="modal no_close" id="pop_cancel_cert_confirm">
    <div class="popup-content">
        <p class="pop-text">확정취소 처리 하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_cancel_cert_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 01-->

<!-- popup 05-->
<div class="modal" id="pop_detail" style="width: 900px;"></div>
<!-- //popup 05-->

<!-- popup 07-->
<div class="modal" id="pop_certFile" style="width: 900px;">
    <span class="button close-modal b-close"><span>X</span></span>
    <!-- content -->
    <h1 class="popup_tit no_margin">수료증</h1>
    <div class="popup-content">
        <div class="content-print"></div>
    </div>
    <!-- //content -->
</div>
<!-- //popup 07-->

<!-- 20201124 관리자용 수료증 popup 08-->
<div class="modal" id="pop_no_certFile" style="width: 900px;">
    <span class="button close-modal b-close"><span>X</span></span>
    <!-- content -->
    <h1 class="popup_tit no_margin">수료증</h1>
    <div class="popup-content">
        <div class="popup_file_find">
            <form id="fileForm" name="fileForm">
                <div class="file-box">
                    <input type="text" class="fileName input-text" value="파일이름" readonly="readonly">
                    <label for="uploadFile" class="btn btn-file">찾기</label>
                    <input type="file" id="uploadFile" name="uploadFile" class="upload-name">
                    <button type="button" id="btn_uploadFile" class="btn btn-file btn_bk">등록</button>
                    <input type="hidden" id="acEduCertInfoNo" name="acEduCertInfoNo">
                </div>
            </form>
        </div>
        <div class="certificate_no_file">
            업로드된 파일이 없습니다.
        </div>
    </div>
    <!-- //content -->
</div>
<!-- //20201124 popup 08-->

<!-- popup 09-->
<div class="modal no_close" id="pop_excel_confirm">
    <div class="popup-content">
        <p class="pop-text">엑셀 파일로 저장하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_excel_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 09-->

<!-- popup 10-->
<div class="modal no_close" id="pop_uploadFile_confirm">
    <div class="popup-content">
        <p class="pop-text">해당 파일로 수료증을 등록하시겠습니까?</p>
        <div class="btn-wrap">
            <button type="button" id="btn_uploadFile_confirm" class="btn2 btn-blue">확인</button>
            <button type="button" class="btn2 b-close">닫기</button>
        </div>
    </div>
</div>
<!-- //popup 10-->

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
                "emptyTable": "수료 대상이 없습니다.",
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
                {className: "dt-body-right", "targets": [4, 5]},
                {
                    targets: [2],
                    render: function (data, type, row, meta) {
                        if (type === 'display') {
                            data = '<a href="javascript:fn_detail(' + row[13] + ');">' + data + '</a>';
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
                    targets: [13],
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

<%-- 팝업 및 검색 --%>
<script type="text/javascript">
    $(document).ready(function () {
        <%-- 검색 --%>
        $('#btn_search').click(function () {
            $('#searchForm').attr("method", "post");
            $('#searchForm').attr("action", "<c:out value='${pageContext.request.contextPath}/cert/admin/confirm'/>");
            $('#searchForm').submit();
        });

        <%-- 수료확정 처리하시겠습니까? --%>
        $('#btn_cert').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("수료확정할 데이터를 선택해주세요.");
                return false;
            } else {
                var applyNoArr = "";
                $("input[name=chk]:checked").each(function () {
                    var applyNo = $(this).attr("id");
                    applyNo = applyNo.split("chk")[1];

                    applyNoArr += applyNo + ",";
                });

                applyNoArr = {
                    "state": "03,05",
                    "applyNo": applyNoArr
                };

                <%--
                    수료확정을 위해 신청확정인 값만 있는지 확인
                    * 선택한 값에서 수료확정(03), 미수료(05)값이 있을 경우, 수료확정을 못하도록 설정
                --%>
                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/apply/count/state'/>",
                    data: JSON.stringify(applyNoArr),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if (data.result > 0) {
                            <%-- 선택한 값에 수료확정 혹은 미수료 값이 존재하므로 stop --%>
                            alert("선택한 값에 수료확정 혹은 미수료 값이 있습니다. \n다시 한 번 선택해주세요.");
                            return false;

                        } else {
                            $('#pop_cert_confirm').bPopup({
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

        <%-- 미수료 처리하시겠습니까? --%>
        $('#btn_no_cert').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("미수료 처리할 데이터를 선택해주세요.");
                return false;
            } else {
                var applyNoArr = "";
                $("input[name=chk]:checked").each(function () {
                    var applyNo = $(this).attr("id");
                    applyNo = applyNo.split("chk")[1];

                    applyNoArr += applyNo + ",";
                });

                applyNoArr = {
                    "state": "03,05",
                    "applyNo": applyNoArr
                };

                <%--
                    미수료 처리를 위해 신청확정인 값만 있는지 확인
                    * 선택한 값에서 수료확정(03), 미수료(05)값이 있을 경우, 미수료 처리를 못하도록 설정
                --%>
                $.ajax({
                    type: "post",
                    url: "<c:out value='${pageContext.request.contextPath}/apply/count/state'/>",
                    data: JSON.stringify(applyNoArr),
                    dataType: "json",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if (data.result > 0) {
                            <%-- 선택한 값에 수료확정 혹은 미수료 값이 존재하므로 stop --%>
                            alert("선택한 값에 수료확정 혹은 미수료 값이 있습니다. \n다시 한 번 선택해주세요.");
                            return false;

                        } else {
                            $('#pop_no_cert_confirm').bPopup({
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

        <%-- 수료 처리 성공 --%>
        $("#btn_cert_success").click(function () {
            $('#pop_cert_success').bPopup().close();
            location.href = "<c:out value='${pageContext.request.contextPath}/cert/admin/confirm'/>";
        });
        <%-- 수료 처리 실패 --%>
        $("#btn_cert_fail").click(function () {
            $('#pop_cert_fail').bPopup().close();
        });

        <%-- 확정취소 처리하시겠습니까? --%>
        $('#btn_cancel_cert').click(function () {
            <%-- 체크한 값이 있는지 확인 --%>
            if ($("input[name=chk]:checked").length < 1) {
                alert("확정취소할 데이터를 선택해주세요.");
                return false;
            } else {
                var applyNoArr = "";
                $("input[name=chk]:checked").each(function () {
                    var applyNo = $(this).attr("id");
                    applyNo = applyNo.split("chk")[1];

                    applyNoArr += applyNo + ",";
                });

                applyNoArr = {
                    "state": "02",
                    "applyNo": applyNoArr
                };

                <%--
                    확정취소를 위해 현재 신청확정인 값이 있는지 확인
                    * 선택한 값에서 신청확정(02)값이 있을 경우, 확정취소를 못하도록 설정
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
                            $('#pop_cancel_cert_confirm').bPopup({
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

        <%-- 엑셀 저장 확인 팝업 --%>
        $('#btn_excel').click(function () {
            var certListCnt = '<c:out value="${certListCnt}"/>';
            if (certListCnt < 1) {
                alert("데이터가 없어 엑셀 파일로 다운받으실 수 없습니다.");
                return false;
            }

            $('#pop_excel_confirm').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
        });

        <%-- 해당 파일로 수료증을 등록하시겠습니까? --%>
        $('#btn_uploadFile').click(function () {
            $('#pop_uploadFile_confirm').bPopup({
                speed: 450,
            });
        });
    });

</script>
</body>
</html>