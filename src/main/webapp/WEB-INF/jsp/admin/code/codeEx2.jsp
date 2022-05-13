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
        // listTable
        var table = $('#listTable').DataTable({
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

            // 페이징처리
            "fnDrawCallback": function () {
                if (Math.ceil((this.fnSettings().fnRecordsDisplay()) / this.fnSettings()._iDisplayLength) > 1) {
                    $('.dataTables_paginate').css("display", "block");
                } else {
                    $('.dataTables_paginate').css("display", "none");
                    $('.table-wrap+.btn-wrap').css("bottom", "-25px");
                }
            }
        })


        ajax1CodeList();

        $('#btn_search').click(function () {
            console.log("조회버튼 클릭");
            //$('#listTable2').text('ㅎㅎ');
            var param = {
                "search1": "${search.searchChkValue}",
                "search2": "${search.searchArea}"
            }
            console.log(param);
            ajax1CodeList(param);

        })

        $('#certbtn').click(function () {
            console.log("cert 😉");
            alert("cert 😉");
            $('#listTable').hide();
            $('#listTable4').show();
            $('#searchForm1').hide();
            $('#searchForm2').show();
            ajax2CertList();
        })

        $('#codebtn').click(function () {
            console.log("code 😉");
            alert("code 😉");
            $('#listTable4').hide();
            $('#listTable').show();
            $('#searchForm1').show();
            $('#searchForm2').hide();
            ajax1CodeList();
        })
    })

    /* 코드 ajax */
    function ajax1CodeList() {
        var param = {}; //흑흑 뭘 어떻게 넣어야 data를 가져올 수 있는걸까... 어디서부터 잘못된건지 비교해보고, 찾기

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
                        output += '<td>' + list[i].regDate + '</td>';
                        output += '<td>' + list[i].etcInfo + '</td>';
                        output += '<td>' + list[i].useState + '</td>';
                        output += '</tr>';

                    }
                    $('#listTable2').append(output);

                    /*console.log("data::", JSON.stringify(param)); 뭐야 왜 공백이지*/
                    /*console.log("data::", this.data); 뭐야 왜 공백이지*/
                } else {
                    alert("통신은 성공했는데...2");
                }
            },
            error: function () {
                alert("ajax ajax 아작 아작 😫");
            }

        })

    }

    /* 수료 ajax */
    function ajax2CertList() {
        var param = {"year":$('#year').val()};
        alert('수료관리 페이지를 ajax로 불러오기');
        $.ajax({
            type: "post",
            url: "<c:out value="${pageContext.request.contextPath}/code/admin/codeEx3"/>",
            data: JSON.stringify(param),
            dataType: "json",
            contentType: "application/json;charset=UTF-8",
            success: function (data) {
                if(data.result > 0) {
                    console.log("data.result:: ",data.result);
                    $('#listTable3').text('');
                    console.log("data::", JSON.stringify(param));
                    console.log("data::", this.data);
                    var list1 = data.certList;
                    var list2 = data.adminList;
                    var output = '';
                    console.log(list1.length);
                    console.log(list2);
                    for (let i = 0; i < list1.length; i++){
                        output+='<tr>';
                        output += '<td>' + '<input type="checkbox" id="chk${certList.eduApplyInfoNo}" name="chk" value="<c:out value="${certList.acEduCertInfoNo}"/>">' + '</td>';
                        output+='<td>'+list1[i].acEduScheduleNo+'</td>';//번호 이게 아니야...
                        output+='<td>'+list1[i].acEduTitle+'</td>';//과정명
                        output+='<td>'+list1[i].judgeKind+'</td>';//종목
                        output+='<td>'+list1[i].judgeNo+'</td>';//심판번호
                        output+='<td>'+list1[i].judgeName+'</td>';//이름
                        output+='<td>'+list1[i].acEduStartDate+'~'+list1[i].acEduEndDate+'</td>';//수료기간
                    //state
                        var state = list1[i].state;
                        if(state.match('02')){
                            output+='<td>'+'신청확정'+'</td>';//수료확정
                        }   else if(state.match('03')){
                            output+='<td>'+'수료확정'+'</td>';//수료확정
                        }   else if(state.match('05')) {
                            output += '<td>' + '미수료' + '</td>';//수료확정
                        }
                        /*else if($("list1[i].state:contains('03')")){
                            output+='<td>'+'수료확정'+'</td>';//수료확정
                        }  else if($("list1[i].state:contains('05')")) {
                            output += '<td>' + '미수료' + '</td>';//수료확정
                        }*/
                    //state
                        //output+='<td>'+list1[i].state+'</td>';//수료확정
                    //수료증 상황
                        //var certFile = list1[i].acEduCertFilePath;
                        if(state.match('03') && $("list1[i].acEduCertFilePath:empty")){ //03:수료확정
                            output+='<td>'+'등록전'+'</td>';//수료증
                        } else if(state.match('03') && $("list1[i].acEduCertFilePath:not empty")){ //03:수료확정
                            output+='<td>'+'등록완료'+'</td>';//수료증
                        }
                        else {
                            output+='<td>'+'-'+'</td>';//수료증
                        }
                        /*if($("list1[i].acEduCertFilePath:empty")){ //03:수료확정
                        output+='<td>'+'등록전'+'</td>';//수료증
                        } else {
                        output+='<td>'+'등록완료'+'</td>';//수료증
                        }*/
                    //수료증 상황
                    //확정일시 출력
                        //var applyDate = list1[i].applyConfirmDate;
                        //var applyDate = new Date($("list1[i].applyConfirmDate"));
                        var applyDate = new Date(list1[i].applyConfirmDate);
                        //var applyDate = new Date();
                        var year = applyDate.getFullYear();
                        var month = ('0'+(applyDate.getMonth()+1)).slice(-2);
                        var day = ('0'+applyDate.getDate()).slice(-2);
                        var applyDate2 = year+"/"+month+"/"+day;

                        output+='<td>'+applyDate2+'</td>';//확정일시

                        //output+='<td>'+applyDate.getFullYear()+"/"+(applyDate.getMonth()+1)+"/"+applyDate.getDate()+'</td>';//3.확정일시
                        //output+='<td>'+applyDate+'</td>';//2.확정일시
                        //output+='<td>'+list1[i].applyConfirmDate+'</td>';//1.확정일시
                    //확정자 출력
                       if(list1[i].certConfirmId ==null){
                            output+='<td>'+'-'+'</td>';
                        } else {
                            output+='<td>'+list1[i].certConfirmId+'</td>';//기존 확정자
                        }
                        //output+='<td>'+'<if(list1[i].certConfirmId ==null)>{" "}' +'<else>{list1[i].certConfirmId}</else>'+'</td>';//확정자
                        //output+='<td>'+'<if(list1[i].certConfirmId ==null)>{" "}' +'<else>{list1[i].certConfirmId}</else>'+'</td>';//확정자
                        //output+='<td>'+list1[i].certConfirmId+'</td>';
                    // 기존 확정자
                    // 등록일시
                        if(list1[i].certConfirmDate ==null){
                            output+='<td>'+'-'+'</td>';
                        } else {
                        output+='<td>'+list1[i].certConfirmDate+'</td>';
                        }
                    // 등록일시
                        output+='<td>'+'등록자'+'</td>';//등록자
                        output+='</tr>';
                    }
                    $('#listTable3').append(output);
                }
                else {
                    console.log("data.result = 0");
                }

            },
            error: function () {
                console.log("ajax ajax 아작 아작 😫");
            }
        })
        alert("ajax 요청 끝");

    }

</script>
<body>
<%--이 위치는 상관없는건가?--%>
<br>
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
                <%-- searchForm1 --%>
                <form id="searchForm1" name="searchForm">
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
                <%-- searchForm1 --%>
                <%--------------------------------------------------------------------%>
                <%-- searchForm2 --%>
                <form id="searchForm2" name="searchForm" style="display: none">
                    <ul class="filter-row">
                        <li>
                            <label for="year">조회기간</label>
                            <input type="text" id="year" name="year" value="<c:out value='${searchVO.year}'/>"
                                   class="input-text year icon_calendar" style="width:100px" placeholder="년도"/>
                        </li>
                        <li>
                            <label for="eduTitle">과정명</label>
                            <input type="text" id="eduTitle" name="eduTitle" class="input-text" style="width:300px"
                                   value="<c:out value="${search.eduTitle}"/>" placeholder="과정명 입력"/>
                        </li>
                        <li>
                            <label for="applyState">수료확정</label>
                            <select id="applyState" name="applyState" class="wd_140">
                                <option value="">전체</option>
                                <c:forEach var="applyState" items="${applyStateList}" varStatus="Status">
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
                            <button type="button" id="btn_search2" class="btn2 btn-search">
                                <span>조회</span>
                            </button>
                        </li>
                    </ul>
                </form>
                <%-- searchForm2 --%>
            </div>
        </div>
        <!-- //search area -->
    </div>

    <div class="content-wrap">
        <div class="ajaxBtnArea" align="right">
            <input type="button" id="codebtn" name="codebtn" class="btn2 btn-search" value="코드 ajax"/>
            <input type="button" id="certbtn" name="certbtn" class="btn2 btn-search" value="수료 ajax"/>
        </div>
        <div class="table-wrap" style="margin-top: 30px">
            <%--코드관리--%>
            <table id="listTable" class="cell-border hover dataTable" width="100%">
                <thead>
                <tr>
                    <th><input name="select_all" value="1" class="select-all" type="checkbox"/></th>
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
            <%--코드관리--%>

            <%--수료관리--%>
            <table id="listTable4" class="cell-border hover dataTable" width="100%" style="display: none">
                <thead>
                <tr>
                    <th><input name="select_all" value="1" class="select-all" type="checkbox"/></th>
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
                <tbody id="listTable3">
                </tbody>
            </table>
            <%--수료관리--%>
        </div>
        <br>
        <div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
<script>

</script>
</html>