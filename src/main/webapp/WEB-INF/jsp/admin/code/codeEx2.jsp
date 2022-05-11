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
    <%-- jquery cdn을 포함하고 있기 때문에 script보다 위에 위치해야한다. --%>
    <jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
</head>
<script>
    $(function () {
        alert("지원관리 입장");
        ajax1CodeList();

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

        $('#btn_search').click(function () {
            console.log("조회버튼 클릭");
            $('#listTable2').text('ㅎㅎ');
            var param = {
                "search1": "${search.searchChkValue}",
                "search2": "${search.searchArea}"
            }
            console.log(param);
            //ajax1CodeList(param);

        })

        $('#certbtn').click(function () {
            console.log("cert버튼누름");
            ajax2CertList();
        })
    })


    var param = {}; //흑흑 뭘 어떻게 넣어야 data를 가져올 수 있는걸까... 어디서부터 잘못된건지 비교해보고, 찾기
    function ajax1CodeList() {

        $.ajax({
            type: "post",
            url: "<c:out value='${pageContext.request.contextPath}/code/admin/codeEx2'/>",
            dataType: "json",
            data: JSON.stringify(param),
            contentType: "application/json;charset=UTF-8",
            success: function (data) {
                if (data.result != 0) {
                    alert("ajax성공했음");
                    $('#listTable2').text(""); //공백으로 두기
                    var list = data.codeList;
                    var output = '';
                    console.log(list.length);

                    for (let i = 0; i < list.length; i++) {
                        output += '<tr>';
                        output += '<td>' + '<input type="checkbox" id="chk${code.commonCodeNo}" name="chk" value="<c:out value="${code.commonCodeNo}"/>">' + '</td>';
                        output += '<td>' + list[i].commonCodeNo + '</td>';
                        output += '<td>' + list[i].codeName + '</td>';
                        output += '<td>' + list[i].code + '</td>';
                        output += '<td>' + list[i].displayOrder + '</td>';
                        output += '<td>' + list[i].groupCodeName + '</td>';
                        output += '<td>' + list[i].groupCode + '</td>';
                        output += '<td>' + list[i].redDate + '</td>';
                        /*output += '<td>' + list[i].regDate + '</td>';*/
                        output += '<td>' + list[i].etcInfo + '</td>';
                        output += '<td>' + list[i].useState + '</td>';
                        output += '</tr>';
                    }
                    $('#listTable2').append(output);
                } else {
                    alert("통신은 성공했는데...2");
                }
            },
            error: function () {
                alert("ajax ajax 아작 아작 😫");
            }

        })

    }

    function ajax2CertList() {
        alert('수료관리 페이지를 ajax로 불러오기');
        $.ajax({
            type: "post",
            url: "<c:out value="${pageContext.request.contextPath}/code/admin/codeEx4"/>",
            data: JSON.stringify(param),
            dataType: "json",
            contentType: "application/json;charset=UTF-8",
            success: function(data){

            },
            error: function(){

            }
        })
            alert("ajax 요청 끝");

    }

</script>
<body>
<%--이 위치는 상관없는건가?--%>
<div id="wrapper">
    <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>
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
                    <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
                    <%-- 220510 6개로 추가--%>
                    <%-- adminHeader.jsp 파일에 선언해두었기 때문에 파일마다 일일히 function~ 할 필요 없음.--%>
                    <a href="javascript:fn_codingEx();" class="tablinks active"> 지원 관리</a>
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
                            <select name="searchChkValue" id="searchChkValue" class="wd_120">
                                <option value="00">전체</option>
                                <option value="01" <c:if
                                        test="${search.searchChkValue eq '01'}"> selected="selected"</c:if>>그룹코드명
                                </option>
                                <option value="02" <c:if
                                        test="${search.searchChkValue eq '02'}"> selected="selected"</c:if>>코드명
                                </option>
                                <%-- 검색부분 체크할 것 --%>
                            </select>
                        </li>
                        <li>
                            <input type="text" id="searchArea" name="searchArea" class="input-text" style="width:140px"
                                   placeholder="그룹 혹은 코드명"
                                   value="<c:out value="${search.searchArea}"/>"/>
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
    </div>

    <div class="content-wrap">
        <div class="table-wrap">
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
                <tbody id="listTable2">
                </tbody>
            </table>
        </div>
        <br>
        <div>
            <input type="button" id="certbtn" name="certbtn" value="수료 ajax"/>
        </div>
    </div>


</div>
<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
<script>

</script>
</html>