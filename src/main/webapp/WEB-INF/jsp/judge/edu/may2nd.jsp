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
    //$(document).ready(function () {
    $(function (){
        console.log("document ready~");

        ajaxEduSchedule(); //지저분하니... ajax는 함수 만들어서 부르기
        alert('ajaxEduSchedule 함수 호출');
        /* ready 함수 끝내는 괄호... ^^ */
    }) // end

    /* edu Schedule Ajax */
    function ajaxEduSchedule() {
        var param = {"year":$('#year').val()};  //data:Json.stringify(data) 얘가 기준이 되어 쿼리문을 타는 듯...?
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
                    $("#listTable2").text(''); //공백으로 만들어주고...
                    //console.log("data::", JSON.stringify(data.eduList));
                    //json.stringify로 데이터가 나오는데 이 데이터를 jsonformatter 에서 확인하면 더 좋은 결과값을 확인 할 수 있다.

                    /*테이블 추가*/
                    var list = data.eduList;
                    //paramMap에는 다양한 데이터가 들어있으므로 eduList를 가져오겠다고 명확히 선언, 값은 list에 담긴다.
                    var output = '';
                    console.log(list.length)
                    for (let i = 0; i < list.length; i++) { //i는 list의 length가 다할 때 까지 반복!
                        output += '<tr>';
                        //output += '<td>'+paramMap.eduList[i].judgeNo + '</td><td>' + paramMap.eduList[i].acEduScheduleNo + '</td>' 기존내용
                        output += '<td>' + list[i].acEduScheduleNo + '</td>';
                        //output += '<td> <a href="javascript:fn_detail1('list[i].acEduScheduleNo')">' + list[i].acEduTitle + '</td>'; //밑줄이 그어져도 실제로 나오는지 직접 확인 해 보자!
                        output += '<td class="eduTitleHere">' + '<a onclick="javascript:fn_detailAjax(' + list[i].acEduScheduleNo + ')">' + list[i].acEduTitle + '</td>'; //밑줄이 그어져도 실제로 나오는지 직접 확인 해 보자!
                        output += '<td>' + list[i].acEduStartDate + '~' + list[i].acEduEndDate + '</td>';
                        output += '<td>' + list[i].acEduPlace + '</td>';
                        output += '<td>' + list[i].acApplyLimitCount + '</td>';
                        output += '<td>' + list[i].acApplyStartDate + '~' + list[i].acApplyEndDate + '</td>';
                        output += '</tr>';
                    }

                    $("#listTable2").append(output);
                    /*테이블 추가*/

                    /* 0504 추가! */
                    //$('#listTable2 > tr:eq(0)').find('a').click();
                    //찾아가는 함수를 사용하기보다, class를 줘서 간단히 작성하는것이 좋다.
                    $('.table-write-wrap').show();
                    $('.eduTitleHere:eq(0)').find('a').click();
                    console.log('eduScheduleAjax 호출 완료')

                    yearCheck();

                } else {
                    $("#listTable2").append('<td class="dataTables_empty" colspan="7">개설된 과정이 없습니다.</td>');
                    //else가 떴을 때 detail 부분도 - 로 띄워주기
                    //$(".table-write-wrap").text('아놔');
                    $('#detail_Title').text('-');
                    $('#detail_url').text('-');
                    $('#detail_institute').text('-');
                    $('#detail_place').text('-');
                    $('#detail_limit').text('-');

                    console.log("데이터 없음");
                }
            },
            error: function () {
                // 신청 실패시
                alert("ajax 통신 실패");
            }
        });

            /*$("button").click(function(){
                $("*").hide();
            });*/
    }


    $(function (){
        $('.test123').append('append는 A뒤에 추가로 붙는다.');
        $('.test123').after('after 뭐가 많이 다른가?');
        $('.test123').before('before를 사용했을 때!');
        $('.test123').prepend('prepend는 어떻게 나오는가?');
        $('<p>insertAfter😎 p태그 안붙이니까 안나온다 대박~</p>').insertAfter($('.test123'));
        $('<span>우우우우우우 나의 향기가</span>').insertBefore($('.test123'));
        $($('.pearl')).insertBefore($('.test123')); //문구밖에 안 써지나?
        //$('.test123').insertBefore('insertBefore 을 구현시에, 휘낭시에'); 어? 안되네

        $('.pearl').show();
    })

    nums = Array(20).fill().map((_, i) => i) //함수생성

    nums.splice(5,3) //nums의 인덱스5가 가리키는 값부터 3개의 값을 삭제
    nums.splice(5,0, -5,6,-7) //nums의 인덱스5가 가리키는 값부터 아무 값도 삭제하지않고 데이터를 추가
    nums.splice(10,2, -10,-111) //nums의 인덱스 10이 가리키는 값부터 2개의 값을 -10, -111로 변경


    $(function(){
        $('.tttt').click(function(){
           //var test1 = $('h2', this).text();
           var test1 = $('h2').text();
           var test2 = $('span', this).text();

           alert(test1+'\n'+test2);
        });
    })
    /* edu Schedule Ajax */
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
                    console.log("data::", JSON.stringify(param));
                    console.log("data::", JSON.stringify(data.eduInfo.acEduTitle));

                    var eduDetail = data.eduInfo;
                    $('#detail_Title').text(eduDetail.acEduTitle); //jquery를 이용한.
                    $('#detail_url').text(eduDetail.acEduUrl); //jquery를 이용한.
                    $('#detail_institute').text(eduDetail.acEduInstitute); //jquery를 이용한.
                    $('#detail_place').text(eduDetail.acEduPlace); //jquery를 이용한.
                    $('#detail_limit').text(eduDetail.acApplyLimitCount); //jquery를 이용한.
            },
            error: function () {
                alert("ajax 통신 실패");
            }
        });
    }
    /* 상세화면 부르기 */
    $(function (){
        $('#btn-search').click(function () {
            console.log('test 함수 호출');
            console.log($('#year').val());
            $("#listTable2").text('');
            yearCheck();
            ajaxEduSchedule();
            //fn_detailAjax(eduNo);
        });
    })

    function yearCheck(){
        console.log('yearCheck 호출');
        $('.yearBlock').show();
        $('.yearBlock').text($('#year').val()+'수강 검색결과입니다.');
    }



    //12345실행하는 queue 시나리오
    $('#start').click(animateBox);

    $('#reset').click(function() {
        $('div').queue('fx', []);
    });

    $('#add').click(function() {
        $('div').queue( function(){
            $(this).animate({ height : '-=25'}, 2000);
            $(this).dequeue();
        });
    });

    function animateBox() {
        $('div').slideUp(2000)
            .slideDown(2000)
            .hide(2000)
            .show(2000, animateBox);
    }

    //220509 w3 ㅎㅎ
    $("button").click(function(){
        $("*").hide();
    });
    //? 안되는데



</script>
<style>
    .yearBlock {
        margin-top: 30px;
        text-align: center;
    }
    .scheduleView {
        margin-top: 40px;
        margin-left: auto;
        margin-right: auto;
        display: flex;
        text-align: center;
        width: 80%;
    }

    .table-wrap {
        display: inline-block;
        margin: 0 auto;
        width: 55%;
    }

    .table-write-wrap {
        align-items: start;
        margin: 0 auto;
        display: inline-block;
        width: 40%;
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
        <div class="yearBlock" style="display: none" >
            안보이지롱
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
                    <col width="120px">
                    <col width="">
                    <col width="120px">
                    <col width="">
                </colgroup>
                <tbody>
                <tr>
                    <th>과 정 명</th>
                    <td colspan="3" id="detail_Title">-</td>
                </tr>
                <tr>
                    <th>교육사이트</th>
                    <td colspan="3" id="detail_url">-</td>
                </tr>
                <tr>
                    <th>주관기관</th>
                    <td colspan="3" id="detail_institute">-</td>
                </tr>
                <tr>
                    <th>장 소</th>
                    <td id="detail_place">-</td>
                    <th>인원제한</th>
                    <td id="detail_limit">-</td>
                </tr>
                <tr></tr>

                </tbody>
            </table>
        </div>
    </div>
        <div class="test123">
            <button> gg </button>
            <p id="ppp"></p>
            <p id="pppp"><span>ㅁㄴㅇㅁㄴㅇ</span></p>
            <p onclick="fn_detailAjax()">s</p>
            <div class="tttt">
                <p>포포포포포</p>
                <span>asdasdasd</span>
                <h2>하이 hi</h2>
            </div>
        </div>
        <div class="pearl" style="display: none">
            ZOO
            <h2>893482794823</h2>
            <h2>꿀먹은바나나</h2>
        </div>
        <div class="12345">
            <ul>
                <li id="start">Start Animating</li>
                <li id="reset">Stop Animating</li>
                <li id="add">Add to Queue</li>
            </ul>
            <div style="width:150px; height:150px; background:#ececec;"></div>
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
