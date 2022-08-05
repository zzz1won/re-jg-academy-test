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
        toggle220804();
        strBtnClick();
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
    let asw = $('#answerIpt').text(); //val() 이었다가 text()로 변경!

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
            if (asw == "") {
                alert("빈칸!");
            } else if (asw === answer) {
                alert("정답!");
            } else {
                console.log("땡");
            }
        })
    }

    function toggle220804() {
        $('#whoRU').click(function () {
            $('.test220804').toggle('slow');
        })
    }
    function strBtnClick(){
    $('#testStrt').click(function (){
        alert("진단시작 누름");
        crtPrb();
        test0805();

        /* 자가진단 테스트 */
        var problem = 1; //몇 번 문제인지 판단하는 용
        var numOfTest = 20; // 문제의 총 개수 파악용
        var total = 0; //점수 저장용

        var testCheck = null; //문제 체크 여부 확인, * 문제의 개수만큼 배열로 동적 할당 *
        var prbCrt = false; //문제가 모두 만들어져쓴가
        /* 자가진단 테스트 */

        //뭐여 왜 안되는디
        function test0805() {
             var prbText = [ //인덱스 관리 1부터 20까지 하려고 0번 비움
                [""],
                ["1."],
                ["2."],
                ["3."],
                ["4."],
                ["5."],
                ["6."],
                ["7."],
                ["8."],
                ["9."],
                ["10."],
                ["11."],
                ["12."],
                ["13."],
                ["14."],
                ["15."],
                ["16."],
                ["17."],
                ["18."],
                ["19."],
                ["20."] //헐 여기 콤마들어가있었음.
            ];
        }

        // 문제 개수만큼 배열을 할당하기 위해, 이 배열은 각 문제가 체크 되었는지 확인용으로 사용
        function chkArray() {
            testCheck = new Array();

            for (var i = 1; i <= numOfTest + 1; i++) { //1부터 데이터가 들어있으므로 최대 숫자 + 1 까지...!
                testCheck.push(false); //배열 추가
            }
        }

        //문제 생성 함수
        function crtPrb() {
            if(prbCrt == false) { // false 값 그대로라면 초기값 = 즉 문제가 만들어지지 않은 상태이므로 문제를 만들어준다.
                chkArray(); // 배열생성
                prbCrt = true; // false -> true 문제가 생성되었다.

                $('#testStrt').slideDown(); //설문지 펼침
                $('#testEnd').show(); //종료버튼 표시, 원래 안보였나?

                for(var i=0; i < numOfTest; i++) {
                    var newText = document.createTextNode(prbText[problem]); //질문 텍스트를 가져와 저장

                    for(var j=0; j<=3; j++){
                        //각 질문마다 라디오버튼 생성 (0점~3점 총4개)
                        var radioInput = document.createElement("input");

                        //각 속성 지정
                        radioInput.setAttribute("type", "radio");
                        radioInput.setAttribute("name", "problem" + problem);
                        radioInput.setAttribute("value","answer"+j); //answer anser라고 침

                        $('#btnArea').appendChild(radioInput); //속성을 추가한 input(라디오버튼)을 출력
                    }
                    problem++; //출력이 끝난 후 다음 문제로 넘어 감

                    // 문제 출력이 끝나고 나면 줄바꿈
                    // 텍스트와 라디오 버튼에 각각 따로 지정해야 레이아웃 오류가 발생하지 않음
                    var hr1 = document.createElement("hr");
                    $('textArea').appendChild(hr1);

                    var hr2= document.createElement("hr");
                    $('btnArea').appendChild(hr2);
                }
            }
            else { //문제가 만들어져있다면 - 생성X
                alert("이미있음")
            }
        }

        function checkGloomy() {
            //total =0;
            for (var i = 1; i <= problem; i++) {
                var radioBtn = document.getElementsByName("problem" + i);
                for (var j = 0; j < radioBtn.length; j++) {
                    if (radioBtn[j].checked) {
                        total += j;

                        //배열에 표시
                        testCheck[i] = true; //해당 문제 체크여부 저장
                    }
                }
            }
            if (all_problem_check() == true) { // test_check 배열을 통해 모든 문제가 체크되었는지 확인함
                alert("총점 : " + total); // 총점 표시

                // 각 점수의 구간에 따라 우울증의 정도를 출력
                if (total >= 0 && total <= 20) {
                    alert("정상적인 우울감.");
                } else if (total >= 21 && total <= 40) {
                    alert("주의가 필요한 우울감.");
                } else if (total >= 41 && total <= 60) {
                    alert("심각한 우울증.");
                }
            } else { // 체크되지 않은 문제가 있으면 오류 출력
                alert("확인하지 않은 문항이 있습니다.");
            }
            //if - else 가 function을 벗어나있었음.
        }



        // test_check 배열을 통해 모든 문제가 체크되었는지 확인함
        function all_problem_check() {
            for (var i = 1; i < numOfTest + 1; i++) {
                if (testCheck[i] == false) {
                    return false;
                }
            }
            return true;
        }


    });
    }


    var problem = 1; // 몇 번 문제인지를 설정하는 인덱스 변수
    var total = 0; // 점수를 저장하는 변수

    var test_check = null; // 문제가 모두 체크되었는지 확인하는 변수 (문제의 개수만큼 배열로 동적할당됨)
    var num_of_test = 20; // 문제의 총 개수를 저장하는 변수

    var all_problem_created = false; // 문제가 모두 만들어졌는지 여부를 확인하는 boolean 변수

    // 문자열 배열을 선언하여 각 문항들을 저장함
    // 첫 번째 데이터가 공백인 이유는 배열 인덱스 관리를 1부터 20까지 직관적으로 하기 위함
    var test_text = [
        [" "],
        ["1.평소에는 아무렇지도 않던 일들이 귀찮았다."],
        ["2.입맛도 없었고, 먹고 싶지도 않았다."],
        ["3.가족이나 친구가 도와줘도 우울한 기분이 나아지지 않았다."],
        ["4.나도 다른 사람들만큼 능력 있다고 느꼈다."],
        ["5.어떤 일을 하든 집중하기 힘들었다."],
        ["6.우울했다."],
        ["7.하는 일마다 힘들다고 느껴졌다."],
        ["8.앞일이 암담하게 느껴졌다."],
        ["9.내 인생은 실패작이라고 느꼈다."],
        ["10.두려웠다."],
        ["11.잠을 설쳤다, 잠이 안 왔다."],
        ["12.비교적 잘 지냈다."],
        ["13.평소보다 말을 적게 했다, 말수가 줄었다."],
        ["14.세상에 홀로 있는 것처럼 외로웠다."],
        ["15.사람들이 나를 차갑게 대하는 것 같았다."],
        ["16.생활에 큰 불만이 있었다."],
        ["17.갑자기 울음이 나왔다."],
        ["18.슬펐다."],
        ["19.사람들이 나를 싫어하는 것 같았다."],
        ["20.도무지 뭘 시작할 기운이 안 났다."]
    ];

    // 문제의 개수만큼 배열을 동적할당
    // 이 배열은 각 문제가 체크되었는지를 확인하는 용도
    function create_check_array() {
        test_check = new Array();

        for (var i = 1; i <= num_of_test + 1; i++) {
            test_check.push(false);
        }
    }

    function create_radio_button() {
        if (all_problem_created == false) { // 문제가 만들어져있지 않다면 -> 문제 생성
            create_check_array();
            all_problem_created = true;

            $("#radio_area").slideDown(); // 설문지를 펼침
            $("#end_btn").show(); // 종료 버튼을 표시함

            for (var i = 0; i < num_of_test; i++) { // 문제의 개수만큼 반복
                var newText = document.createTextNode(test_text[problem]); // 질문 텍스트를 가져와서 저장함
                document.getElementById("text_area").appendChild(newText); // 질문을 출력

                for (var j = 0; j <= 3; j++) {
                    // 각 질문마다 라디오 버튼 생성 (0점 ~ 3점 총 4개)

                    var radioInput = document.createElement("input"); // <input>을 만들고 변수에 지정함

                    // 각 속성들을 지정함
                    radioInput.setAttribute("type", "radio"); // = radioInput.type = "radio";
                    radioInput.setAttribute("name", "problem" + problem);
                    radioInput.setAttribute("value", "answer" + j);

                    document.getElementById("btn_area").appendChild(radioInput); // 속성을 지정한 <input>을 출력 (라디오 버튼 출력)
                }
                problem++; // 각 문제의 출력이 끝나면 다음 문제로 넘어감

                // 문제 출력이 끝나고 나면 줄바꿈
                // 텍스트와 라디오 버튼에 각각 따로 지정해야 레이아웃 오류가 발생하지 않음
                var hr1 = document.createElement("hr");
                document.getElementById("text_area").appendChild(hr1);

                var hr2 = document.createElement("hr");
                document.getElementById("btn_area").appendChild(hr2);
            }
        } else { // 문제가 만들어져 있다면 -> 생성하지 않음
            alert("진행 중인 진단이 있습니다.");
        }
    }

    function check_gloomy() { // 총점 체크
        total = 0;

        for (var i = 1; i <= problem; i++) { // 문제의 개수만큼 반복
            var radio_btn = document.getElementsByName("problem" + i); // 문제의 개수만큼 라디오 버튼을 저장함

            for (var j = 0; j < radio_btn.length; j++) { // 저장된 라디오 버튼의 체크 여부 확인
                if (radio_btn[j].checked) { // 버튼이 체크되었다면 해당 점수만큼을 총점에 더함
                    total += j;

                    // 배열에 표시
                    test_check[i] = true; // 해당 문제 체크 여부를 저장함
                }
            }
        }

        if (all_problem_check() == true) { // test_check 배열을 통해 모든 문제가 체크되었는지 확인함
            alert("총점 : " + total); // 총점 표시

            // 각 점수의 구간에 따라 우울증의 정도를 출력
            if (total >= 0 && total <= 20) {
                alert("정상적인 우울감.");
            } else if (total >= 21 && total <= 40) {
                alert("주의가 필요한 우울감.");
            } else if (total >= 41 && total <= 60) {
                alert("심각한 우울증.");
            }
        } else { // 체크되지 않은 문제가 있으면 오류 출력
            alert("확인하지 않은 문항이 있습니다.");
        }
    }

    // test_check 배열을 통해 모든 문제가 체크되었는지 확인함
    function all_problem_check() {
        for (var i = 1; i < num_of_test + 1; i++) {
            if (test_check[i] == false) {
                return false;
            }
        }
        return true;
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

    /* 우울증 자가진단 테스트 style */
    #radio_area {
        width: 600px;
        height: 820px;
        background-color: lightgray;
        padding: 10px;

        display: none;
    }

    #text_area {
        width: 80%;
        float: left;
        display: block;
    }

    #btn_area {
        width: 20%;
        float: right;
        text-align: right;
        display: block;
    }

    .display_score {
        float: right;
        font-size: 0.7em;
        font-style: italic;
        text-align: right;
    }

    #end_btn {
        display: none;
    }
    /* 우울증 자가진단 테스트 style */
</style>
<body>
<%-- 220802 --%>
<div class="btnBox">
    <input type="button" value="고양이" id="catBtn"/>
    <input type="button" value="혈액형" id="bloodBtn"/>
    <input type="button" value="mbti" id="mbtiBtn"/>
    <input type="button" value="점심뭐먹지" id="foodBtn"/>
    <input type="button" value="내가누구게" id="whoRU"/>
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

<div class="test220804" style="display: none">
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

<div class="testJiwon">
    <h4> 테슷흐 </h4>
    <div id="radioArea">
    <%--<input type="button" value="진단시작" id="testStrt">--%>
        <button id="testStrt" onclick="crtPrb()">진단 시작</button>
    <br>
        <div class="displayScore">
            * 답변 방법<br>
            전혀 아니다(0) / 아니다(1) / 그렇다(2) / 매우 그렇다(3)
        </div>
        <br>
        <div id="textArea"></div>
        <%-- 문제 출력 div --%>
        <div id="btnArea"></div>
        <%--라디오 버튼 출력--%>
        <br>
        <button id="testEnd"> 결과 보기</button>
        <%--input type 말고 button으로 ㅎ --%>
    </div>


        <button id="start_btn" onclick="create_radio_button()">진단 시작</button>
        <br><br>
        <div id="radio_area">
            <div class="display_score">
                * 답변 방법<br>
                전혀 아니다(0) / 아니다(1) / 그렇다(2) / 매우 그렇다(3)
            </div>
            <br><br>
            <div id="text_area"></div> <!-- 문제 출력 div -->
            <div id="btn_area"></div> <!-- 라디오 버튼 출력 div -->
        </div>
        <br>
        <button id="end_btn" onclick="check_gloomy()">결과 보기</button>

</div>
</body>
