<%@ page contentType="text/html; charset=UTF-8"
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
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <title>심판아카데미 운영 Admin-deepDive 연습</title>
</head>
<%--Failed to load resource: the server responded with a status of 404 ()--%>
<script type="text/javascript">

    $(function () {
        fn_btnClick(); //버튼 클릭시 show hide
        sortTest();
        hillsQuestion();
    })


    function fn_btnClick() {
        $('#catBtn').click(function () {
            $('#chkBoxTest').show();
            $('#bloodTest').hide();
            $('#mbtiTest').hide();
            $('#foodTest').hide();
        });
        $('#bloodBtn').click(function () {
            //$('div.testArea:not(#bloodTest)').hide();
            //$('div.testArea:not(div.testArea#bloodTest)').hide();
            $('#bloodTest').show();
            $('#chkBoxTest').hide();
            $('#mbtiTest').hide();
            $('#foodTest').hide();
            //$('div.testArea').not('div#bloodTest').hide();
            //흠 안되는구만.

        });
        $('#mbtiBtn').click(function () {
            $('#chkBoxTest').hide();
            $('#bloodTest').hide();
            $('#mbtiTest').show();
            $('#foodTest').hide();
        });
        $('#foodBtn').click(function () {
            $('#chkBoxTest').hide();
            $('#bloodTest').hide();
            $('#mbtiTest').hide();
            $('#foodTest').show();
        })
    }

    function fn_802() {
        $('#chkBoxTest input:checkBox').bind('click', chkTest);

        function chkTest() {
            var txt = "";
            $('#chkBoxTest input:checkbox:checked').each(function () {
                //txt += $('this').val() + '\n';
                txt += $(this).val() + '\n';
                console.log(txt);
            });
            $('#chkBoxTest textarea').val(txt);
        };

        $('#bloodTest [type=radio]').bind('click', bldTest);

        function bldTest() {
            var txt = "";
            /*$('#bloodTest [type=radio]:checked').each(function(){
                //txt += $(this).val();
                console.log(txt+"누름");
            })*/
            txt = $('#bloodTest [type=radio]:checked').val();
            console.log(txt);
            $('#bloodTest textarea').val(txt + '형');
        }
    }

    //var dtdt = [3,4,580,676,71]
    /*let x = a.toUpperCase(),
            y = b.toUpperCase();
        x == y ? 0 : x > y ? -1 : 1 ;*/

    function sortTest() {
        //https://developer-talk.tistory.com/73 참고
        //sort를 이용한 날짜 정렬 js test
        $('#date_btn').click(function () {
            var dateArray = ['April 1, 2013', 'August 10, 1994', 'May 11 2002', 'july 28, 1994'];

            dateArray.sort(function compare(a, b) {
                let x = new Date(a),
                    y = new Date(b); //date 아니고 Date
                return x - y;

            });
            console.log(dateArray);
            $('.date1').text(dateArray);
        })
    }

    var num = 20;
    var answer = '리리카SOS';
    let asw = $('#answerIpt').val();

    function hillsQuestion() {
        $('#hill_btn').click(function () {
            console.log(asw);
            //도전 횟수
            if (num >= 1) {
                num--;
                $('#chanceInt').text(num);
            } else {
                $('#chanceArea').text("모든 기회를 사용해버리셨네용 ㅋㅋ");
            }

            //정답 확인
            if(asw == ""){
                alert("빈칸!");
            } else {
                console.log("땡");
            }
        })

    }


</script>
<style>
    #chkBoxTest {
        width: 500px;
        margin: 0 auto;
    }

    #chkBoxTest textarea {
        width: 100%;
        height: 170px;
    }

    .test220804 {
        width: 500px;
        margin: auto;
        padding-top: 10px;
    }
</style>
<body>
<%-- 220802 --%>
<div class="btnBox">
    <input type="button" value="고양이" id="catBtn"/>
    <input type="button" value="혈액형" id="bloodBtn"/>
    <input type="button" value="mbti" id="mbtiBtn"/>
    <input type="button" value="점심뭐먹지" id="foodBtn"/>
</div>

<div class="testArea">
    <div id="chkBoxTest">
        <h3><p>checkBox Test 고양이🐱 </p></h3>
        <input type="checkbox" value="내가 젤 좋아하는 코리안숏헤어"/> 코리안숏헤어<br>
        <input type="checkbox" value="친화적인 러시안블루"/> 러시안블루<br>
        <input type="checkbox" value="조금 사나운 아비니시안"/> 아비니시안<br>
        <input type="checkbox" value="맨들맨들 스핑크스"/> 스핑크스<br>
        <input type="checkbox" value="조금 커다란 아메리칸숏헤어"/> 아메리칸숏헤어<br>
        <input type="checkbox" value="동글동글 브리티쉬숏헤어"/> 브리티쉬숏헤어<br>
        <input type="checkbox" value="크다란 메인쿤"/> 메인쿤<br>
        <br>
        <textarea></textarea>
    </div>

    <div id="bloodTest" style="display: none">
        <h3><p> radio 혈액형 </p></h3>
        <input type="radio" name='bt' value="A형"> A<BR>
        <input type="radio" name='bt' value="B형"> B<BR>
        <input type="radio" name='bt' value="O형"> O<BR>
        <input type="radio" name='bt' value="AB형"> AB<BR>
        <br>
        <textarea></textarea>
    </div>
    <div id="mbtiTest" style="display: none">
        *^^*
    </div>
    <div id="foodTest" style="display: none">
        😀
    </div>
</div>

<div class="test220804">
    <span>날짜순 정렬을 보기위해 </span>
    <input type="button" value="날짜순 정렬 버튼" id="date_btn">
    <p class="date1">날짜1</p>
    <%--<p class="date1">날짜2</p>--%>

    <h4>몇살인가요?</h4>
    <input type="number" name="testNumber" min="1" max="110">
    <h4> 오늘의 기분은? </h4>
    <p> 저조할 수록 1, 좋을 수록 10에 가까이 놔주세요.</p>
    <span>    1 <input type="range" name="testNumber" min="1" max="25"> 10 </span> <%--오 신기하잖아; --%>
    <h4> 좋아하는 색은? </h4>
    <p><input type="color" name="testIptColor"></p> <%-- 헐퀴헐퀴 신퀴방퀴 --%>

    <div class="hills20">
        <h3>🍙🐱💕 여긴 스무고개 존 💕🐱🍙</h3>
        <h5> 정답이 뭘까요?</h5>
        <input type="text" id="answerIpt"> <input type="button" value="제출" id="hill_btn">
        <div id="chanceArea"> 잔여횟수 : <span id="chanceInt"> 20 </span> / <span> 20 </span>
        </div>
    </div>
</div>
</body>
