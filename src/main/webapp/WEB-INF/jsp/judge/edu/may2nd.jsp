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
    <title>심판아카데미 운영시스템</title>

    <jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
</head>

<script>
    $(document).ready(function () {
        console.log("document ready~");

        var param = {"year": ${searchVO.year}};  //data:Json.stringify(data) 얘가 기준이 되어 쿼리문을 타는 듯...?
        //직접 입력한 값이 아닌 searchVO의 year을 가져왔다.
        $.ajax({
            type: "post", //전송방식, 통신 type
            url: "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule2Ajax'/>", //요청할 url
            dataType: "json",   //요청 할 파라미터 타입
            data: JSON.stringify(param),
            //요청할 파라미터, var data= 의 data와 짝, year="무슨값"을 기준으로 진행...
            contentType: "application/json;charset=UTF-8",  //헤더값 설정(?)
            success: function (data) {                      //이 곳의 data가 실행되는 것
                if (data.result > 0) {
                    console.log("schedule ajax 성공");
                    //console.log("data::", JSON.stringify(data.eduList));
                    //json.stringify로 데이터가 나오는데 이 데이터를 jsonformatter 에서 확인하면 더 좋은 결과값을 확인 할 수 있다.

                    /*테이블 추가*/
                    var list = data.eduList;
                    //paramMap에는 다양한 데이터가 들어있으므로 eduList를 가져오겠다고 명확히 선언, 값은 list에 담긴다.
                    var output = '';
                    for (let i = 0; i < list.length; i++) { //i는 list의 length가 다할 때 까지 반복!
                        output += '<tr>'
                        //output += '<td>'+paramMap.eduList[i].judgeNo + '</td><td>' + paramMap.eduList[i].acEduScheduleNo + '</td>' 기존내용
                        output += '<td>' + list[i].acEduScheduleNo + '</td>';
                        //output += '<td> <a href="javascript:fn_detail1('list[i].acEduScheduleNo')">' + list[i].acEduTitle + '</td>'; //밑줄이 그어져도 실제로 나오는지 직접 확인 해 보자!
                        output += '<td>' + '<a onclick="javascript:fn_detailAjax(' + list[i].acEduScheduleNo + ')">' + list[i].acEduTitle + '</td>'; //밑줄이 그어져도 실제로 나오는지 직접 확인 해 보자!
                        output += '<td>' + list[i].acEduStartDate + '~' + list[i].acEduEndDate + '</td>';
                        output += '<td>' + list[i].acEduPlace + '</td>';
                        output += '<td>' + list[i].acApplyLimitCount + '</td>';
                        output += '<td>' + list[i].acApplyStartDate + '~' + list[i].acApplyEndDate + '</td>';
                        output += '</tr>'
                    }

                    $("#listTable2").append(output);
                    /*테이블 추가*/
                } else {
                    $('#pop_register_fail').bPopup({
                        speed: 450
                    })
                    console.log("data::", paramMap);
                    console.log("할수있어...!");
                }
            },
            error: function () {
                // 신청 실패시
                alert("ajax 통신 실패");
            }
        });
        /* ready 함수 끝내는 괄호... ^^ */
    }) // end

    /* 상세화면 부르기 */
    <%-- 교육과정 상세 팝업 --%>

    function fn_detailAjax(eduNo) {
        var param = {
            "acEduScheduleNo": eduNo
        }
        $.ajax({
            type: "post",
            url: "<c:out value='${pageContext.request.contextPath}/edu/judge/detailAjax'/>",
            data: JSON.stringify(param),
            dataType: "json",
            contentType: "application/json;charset=UTF-8",
            success: function (data) {
                console.log('detailAjax 호출은 완료')
                console.log("data::", JSON.stringify(param.acEduScheduleNo));
                console.log("data::", JSON.stringify(data.eduInfo.acEduTitle));

                var eduDetail = data.eduInfo;
                $('#detail_Title').text(eduDetail.acEduTitle); //jquery를 이용한.
                $('#detail_url').text(eduDetail.acEduUrl); //jquery를 이용한.
                $('#detail_institute').text(eduDetail.acEduInstitute); //jquery를 이용한.
                $('#detail_place').text(eduDetail.acEduPlace); //jquery를 이용한.
                $('#detail_limit').text(eduDetail.acApplyLimitCount); //jquery를 이용한.
                /**/

                /*테이블 추가*/
            },
            error: function () {
                alert("ajax 통신 실패");
            }
        });
    }

    /* 상세화면 부르기 */

</script>
<script>

</script>

<style>
    .scheduleView {
        height: 300px;
        display: inline-flex;
        width: 80%;
    }

    .table-wrap {
        display: block;
        width: 50%;
    }

    .table-write-wrap {
        display: block;
        width: 50%;
    }

</style>
<body>

<div id="wrapper">

    <jsp:include page="/WEB-INF/jsp/include/judgeHeader.jsp"/>

    <!-- container -->
    <div id="container">
        <div class="sub-tit-wrap">
            <div class="sub-tit-container">
                <!-- tab: 2개-->
                <div class="tab-wrap tab3">
                    <a href="javascript:fn_scheduleList();" class="tablinks">수강신청</a>
                    <a href="javascript:fn_scheduleList2();" class="tablinks active">수강신청2</a>
                    <a href="javascript:fn_applyList();" class="tablinks">수강내역</a>
                </div>
                <!-- //tab -->
            </div>
        </div>

        <!-- search area -->
        <div class="search-wrap">
            <div class="search-container">
                <form id="searchForm" name="searchForm">
                    <ul class="filter-row">
                        <li>
                            <label for="year">조회기간</label>
                            <input type="text" id="year" name="year" value="<c:out value='${searchVO.year}'/>"
                                   class="input-text year icon_calendar" style="width:100px" placeholder="년도"/>
                        </li>
                        <li>
                            <button type="button" id="btn-search" class="btn2 btn-search">
                                <span>조회</span>
                            </button>
                        </li>
                    </ul>
                </form>
            </div>
        </div>
        <!-- //search area -->
    </div>
    <div class="scheduleView">
        <div class="table-wrap">
            <!-- table -->
            <table id="listTable" class="cell-border hover dataTable" width="100%">
                <thead>
                <tr>
                    <th>No</th>
                    <th>과정명</th>
                    <th>수강기간</th>
                    <th>장소</th>
                    <th>인원</th>
                    <th>신청기간</th>
                </tr>
                </thead>
                <tbody id="listTable2">
                </tbody>
            </table>
        </div>
        <div class="table-write-wrap">
            <table>
                <caption>과정상세 정보 테이블</caption>
                <colgroup>
                    <col width="110px">
                    <col width="">
                    <col width="110px">
                    <col width="">
                </colgroup>
                <tbody>
                <tr>
                    <th>과 정 명</th>
                    <td id="detail_Title">양꼬치</td>
                </tr>
                <tr>
                    <th>교육사이트</th>
                    <td id="detail_url">떡꼬치</td>
                </tr>
                <tr>
                    <th>주관기관</th>
                    <td id="detail_institute">닭꼬치</td>
                </tr>
                <tr>
                    <th>장 소</th>
                    <td id="detail_place">은행꼬치</td>
                    <th>인원제한</th>
                    <td id="detail_limit">어묵탕</td>
                </tr>
                <tr></tr>

                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

    <!-- popup 02-->
    <div class="modal no_close" id="pop_register_success">
        <div class="popup-content">
            <p class="pop-text">신청이 완료 되었습니다.<br>교육신청이 확정되면 학습 가능 합니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_register_success" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 02-->
    <!-- popup 03-->
    <div class="modal no_close" id="pop_register_fail">
        <div class="popup-content">
            <p class="pop-text">신청에 실패하였습니다.<br>관리자에게 문의해주시기 바랍니다.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_register_fail" class="btn2 btn-blue b-close">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 03-->
</body>
</html>
