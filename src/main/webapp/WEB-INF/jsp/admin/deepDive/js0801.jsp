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
        toggleTestJiwon();
        todoSample();
        todoList();
        ccPlay();
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
        //input에서 값 안넘어오는거 val() 써서 도전 해보기...!!
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

    function toggleTestJiwon() {
        $('#toggleTJ').click(function () {
            $('.testJiwon').toggle('300');
        })
    }

    function strBtnClick() {
        $('#testStrt').click(function () {
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
                if (prbCrt == false) { // false 값 그대로라면 초기값 = 즉 문제가 만들어지지 않은 상태이므로 문제를 만들어준다.
                    chkArray(); // 배열생성
                    prbCrt = true; // false -> true 문제가 생성되었다.

                    $('#testStrt').slideDown(); //설문지 펼침
                    $('#testEnd').show(); //종료버튼 표시, 원래 안보였나?

                    for (var i = 0; i < numOfTest; i++) {
                        var newText = document.createTextNode(prbText[problem]); //질문 텍스트를 가져와 저장

                        for (var j = 0; j <= 3; j++) {
                            //각 질문마다 라디오버튼 생성 (0점~3점 총4개)
                            var radioInput = document.createElement("input");

                            //각 속성 지정
                            radioInput.setAttribute("type", "radio");
                            radioInput.setAttribute("name", "problem" + problem);
                            radioInput.setAttribute("value", "answer" + j); //answer anser라고 침

                            $('#btnArea').appendChild(radioInput); //속성을 추가한 input(라디오버튼)을 출력
                        }
                        problem++; //출력이 끝난 후 다음 문제로 넘어 감

                        // 문제 출력이 끝나고 나면 줄바꿈
                        // 텍스트와 라디오 버튼에 각각 따로 지정해야 레이아웃 오류가 발생하지 않음
                        var hr1 = document.createElement("hr");
                        $('textArea').appendChild(hr1);

                        var hr2 = document.createElement("hr");
                        $('btnArea').appendChild(hr2);
                    }
                } else { //문제가 만들어져있다면 - 생성X
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

    function todoSample() {
        document.getElementById("btnAdd1").addEventListener("click", addList);
// html에서 id가 btnAdd인 요소를 찾고 클릭 시 동작할 addList 함수 연결

        document.getElementById("btnDelAll").addEventListener("click", delAllElement);
// html에서 id가 btnDelAll인 요소를 찾고 클릭 시 동작할 addList 함수 연결

        document.getElementById("btnDelLast").addEventListener("click", delLastElement);
// html에서 id가 btnDelLast인 요소를 찾고 클릭 시 동작할 addList 함수 연결

        document.getElementById("DeleteSel").addEventListener("click", delSelected);

// html에서 id가 DeleteSel인 요소를 찾고 클릭 시 동작할 addList 함수 연결

        function addList() {
            var contents = document.querySelector(".text-basic");
            // 입력창에 접근

            if (!contents.value) // 입력창에 값이 없으면
            {
                alert("데이터를 입력해주세요."); // 경고창 출력

                contents.focus();
                // 입력창에 포커스 (활성화)

                return false;
                // 함수 종료
            }

            // ***** 데이터 추가 *****
            var tr = document.createElement("tr"); // 추가할 테이블 <tr> 생성
            var input = document.createElement("input"); // 테이블 <tr> 안에 들어갈 체크박스의 <input> 생성

            // 여기서 생성된 <tr> 안에는
            // <td>체크박스</td>
            // <td>텍스트<td>
            // 이렇게 두 가지의 요소가 들어가야 함

            // 체크박스 만들기
            input.setAttribute("type", "checkbox"); // <input type="checkbox">
            input.setAttribute("class", "btn-chk"); // <input type="checkbox" class="btn-chk">

            var td01 = document.createElement("td"); // 첫 번째 <td> 생성 (체크박스를 담음)
            td01.appendChild(input); // 첫 번째 <td> 안에 <input> 추가

            var td02 = document.createElement("td"); // 두 번째 <td> 생성 (텍스트를 담음)
            td02.innerHTML = contents.value; // 두 번째 <td> 안에 입력창의 텍스트를 저장

            tr.appendChild(td01);
            tr.appendChild(td02); // 생성된 <tr> 안에 체크박스 td와 텍스트 td를 넣음

            document.getElementById("listBody1").appendChild(tr); // tbody의 #listBody에 접근하여 tr을 자식요소로 추가

            contents.value = ""; // 입력창의 내용이 추가되었으므로 입력창 지우기

            contents.focus(); // 입력창 포커스 (활성화)
        }

// 전체 삭제
        function delAllElement() {
            var list = document.getElementById("listBody1"); // listBody에 접근

            var listChild = list.children; // listBody의 자식요소 정보가 들어옴

            for (var i = 0; i < listChild.length; i++) // 자식요소 개수만큼 반복하며 제거
            {
                list.removeChild(listChild[i]); // list의 자식요소 0번째, 1번째, 2번째 ... 제거

                i--;
            }

        }

// 마지막 항목 삭제
        function delLastElement() {
            var list = document.getElementById("listBody1"); // listBody에 접근

            var listChild = list.children;

            if (listChild.length > 0) {
                var lastIdx = listChild.length - 1; // listBody의 자식요소 정보가 들어옴

                list.removeChild(listChild[lastIdx]);
            } else {
                alert("삭제할 항목이 없습니다.");
            }

        }

// 선택 항목 삭제
        function delSelected() {
            var list = document.getElementById("listBody1"); // listBody에 접근

            var chkbox = document.querySelectorAll("#listBody .btn-chk"); // listBody 하위의 체크박스 모두 선택

            for (var i in chkbox) // i에 체크박스 인덱스 들어옴
            {
                if (chkbox[i].checked) // 체크박스가 체크되었으면
                {
                    list.removeChild(chkbox[i].parentNode.parentNode); //체크박스 i번째의 부모(<td>)의 부모(<tr>) 제거
                }

            }
        }
    }

    function todoList() {
        //btnAdd 추가 버튼 누르면 addList 리스트 추가되는 함수 실행 할 것것
        $('#btnAdd').click(function () {
            addList();
        });
        $('#delSel').click(function () {
            delSelectList();
        });
        $('#delLast').click(function () {
            delLastList();
        });
        $('#delAll').click(function () {
            delAllList();
        });

        function addList() {
            alert("addList()");
            var contents = $('#textBasic'); //입력창 접근
            if (!contents.val()) { //입력창에 값이 없으면 뜬다.
                // value() 말고 val()로 하니까 추가 됨
                alert("내용을 입력해주세요. 입력하신 값: ", contents);
                contents.focus(); //포커스 활성화
                return false;
            }
            /* 기존 js 방식 구현 방법을 일단 따르자 */
            var tr = document.createElement("tr"); // 추가할 테이블 <tr> 생성
            var input = document.createElement("input"); // 테이블 <tr> 안에 들어갈 체크박스의 <input> 생성

            // 체크박스 만들기
            input.setAttribute("type", "checkbox"); // <input type="checkbox">
            input.setAttribute("class", "btn-chk"); // <input type="checkbox" class="btn-chk">

            var td01 = document.createElement("td"); // 첫 번째 <td> 생성 (체크박스를 담음)
            td01.appendChild(input); // 첫 번째 <td> 안에 <input> 추가

            var td02 = document.createElement("td"); // 두 번째 <td> 생성 (텍스트를 담음)
            //td02.innerHTML = contents.value; // 두 번째 <td> 안에 입력창의 텍스트를 저장
            td02.innerHTML = contents.val(); // 두 번째 <td> 안에 입력창의 텍스트를 저장

            tr.appendChild(td01);
            tr.appendChild(td02); // 생성된 <tr> 안에 체크박스 td와 텍스트 td를 넣음

            document.getElementById("listBody").appendChild(tr); // tbody의 #listBody에 접근하여 tr을 자식요소로 추가

            contents.value = "";
            //contents.clean // 입력창의 내용이 추가되었으므로 입력창 지우기

            contents.focus(); // 입력창 포커스 (활성화)
        }

        //전체삭제
        function delAllList() {
            alert("전체삭제 누름");
            $("#listBody").remove(); //이야 드뎌 됐다 ㅠ 근데 되게 바보같구나... 이리 단순한 것을..
        }

        /* 220808 마지막항목 삭제 */
        function delLastList() {
            alert("마지막 항목을 삭제합니다.");

            var list = $("#listBody").children();
            console.log(list);

            if (list.length > 0) {
                var listLast = list.length - 1;
                var delLa = list[listLast];
                console.log("list.listLast: ", delLa); /* <tr> <td><input type="checkbox" class="btn-chk"></td> <td> 고구마 희경언니네 가져가서 구워먹기</td> </tr> */
                delLa.remove();

            } else {
                alert("L(");
            }
        }

        function delSelectList() {
            alert("선택 항목 삭제");

            var chkBox = $("#listBody .btn-chk:checked");
            var selList = chkBox.parent().parent();
            console.log("selList: ",selList);
            selList.remove();
        }
    }

    function ccPlay(){

        var sign = $("#calSign");

        $(".calSign#sum").click(function(){
           alert("+누름");
           $("input[type=text][name=calSign]").val("+"); //input 부분에 + 출력
            sign.text("-"); //sign 값을 + 로 저장,변경

            //$("#calSign").value("안녕");
        });
        $(".calSign#subt").click(function(){
            alert("-누름");
            $("input[type=text][name=calSign]").val("-"); //input 부분에 - 출력
            sign.text("-"); //sign 값을 - 로 저장,변경
        });
        $(".calSign#mult").click(function(){
            alert("X누름");
            $("input[type=text][name=calSign]").val("x"); //input 부분에 x 출력
            sign.text("x"); //sign 값을 x 로 저장,변경
        });
        $(".calSign#divi").click(function(){
            alert("÷누름");
            $("input[type=text][name=calSign]").val("/"); //input 부분에 / 출력
            sign.text("/"); //sign 값을 ÷ 로 저장,변경
        });


        var vv = null;

        $(".calBtn").click(function(){

            switch (sign.val()) {
                case '+':
                    vv = parseInt($("#num1").val())+parseInt($("#num2").val());
                    $("#calVal").val(vv);
                    break;
                case '-':
                    alert("빼기");
                    vv = parseInt($("#num1").val())-parseInt($("#num2").val());
                    $("#calVal").val(vv);
                    break;
                case 'x':
                    alert("곱하기");
                    vv = parseInt($("#num1").val())*parseInt($("#num2").val());
                    $("#calVal").val(vv);
                    break;
                case '/':
                    alert("나누기");
                    vv = parseInt($("#num1").val())/parseInt($("#num2").val());
                    $("#calVal").val(vv);
                    break;
                default:
                    alert("한입약과");
                    break;
            }
        });
    }

    /*    var problem = 1; // 몇 번 문제인지를 설정하는 인덱스 변수
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
        }*/

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

    /* 계산기 */
    .calculator {
        width: 500px;
        margin: 0 auto;
    }

    .ccSignPack {
        padding: 10px;
    }

    .calSign {
        height: 30px;
        width: 30px;
        background-color: #d0d0d0;
        border-radius: 6px;
    }

    .iptArea {
        width: 50px;
        height: 30px;
    }
    /* 계산기 */

    /* 우울증 자가진단 테스트 style */


    /* to do list */
    /*html, body, input {
        margin: 0;
        padding: 0;
        box-sizing: border-box; !* 박스의 크기를 박스의 테두리까지 포함시킴 *!
        font-family: 'Gamja Flower', 'cursive'; !* 설정해놓은 웹 폰트 지정, cursive는 필기체 *!
    }

    button {
        font-family: 'Gamja Flower', 'cursive';
        background: cornflowerblue;
        color: white;
        font-size: 18px;
        cursor: pointer;
    }

    .list-box {
        width: 500px;
        margin: 100px auto; !* 위, 아래는 100px / 좌, 우는 중앙으로 정렬 *!
        border: 1px solid white;
        padding: 20px 30px 50px; !* 위 20 오른쪽, 왼쪽 30 아래 50 *!
        background: #999;
    }

    .list-box h1 {
        text-align: center;
        color: royalblue;
        border-bottom: 1px solid gray;
        padding-bottom: 10px;
    }

    .write-box {
        width: 100%;
        height: 35px;
    }

    !* 입력창 *!
    .write-box input {
        width: 300px;
        font-size: 20px;
        border: none;
        padding: 0 10px;
        height: 100%;
    }

    .write-box button {
        width: 20%;
        border: none;
        height: 100%;
    }

    .list-table {
        border-spacing: 0px; !* 셀 테두리 간격 없음 *!
        border-collapse: collapse; !* 셀 테두리 선 겹쳐서 표현 *!
        width: 100%;
        margin: 20px 0;
    }

    th, td {
        font-size: 20px;
        border: 1px solid lightgray;
        padding: 10px 20px;
    }

    th {
        background: lightblue;
    }

    td {
        background: white;
    }

    tbody td:first-child {
        text-align: center;
    }

    .btn-area {
        text-align: center;
    }

    .btn-area button {
        height: 35px;
        padding: 0 10px;
        border: none;
    }*/

    /* to do list */

</style>
<body>
<%-- 220802 --%>
<div class="btnBox">
    <input type="button" value="고양이" id="catBtn"/>
    <input type="button" value="혈액형" id="bloodBtn"/>
    <input type="button" value="mbti" id="mbtiBtn"/>
    <input type="button" value="점심뭐먹지" id="foodBtn"/>
    <input type="button" value="내가누구게" id="whoRU"/>
    <input type="button" value="테스트 안보임" id="toggleTJ"/>
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

<div class="list-box">
    <h1>To Do List</h1>

    <div class="write-box">
        <input type="text" class="text-basic">
        <button type="button" id="btnAdd1">추가</button>
    </div>

    <table class="list-table">
        <!--
            위에서 추가한 To Do 내용이
            동적으로 추가되는 테이블
        -->

        <colgroup>
            <!-- column을 1:9로 나눔 -->
            <col width="15%">
            <col width="85%">
        </colgroup>

        <thead>
        <tr>
            <!-- table row -->
            <!-- 제목 줄 -->
            <th>확인</th>
            <th>목록</th>
        </tr>
        </thead>

        <tbody id="listBody1">
        <!-- 테이블 몸체 -->
        <!-- td 태그 포함 -->
        <tr>
            <td><input type="checkbox" class="btn-chk"></td>
            <td>HTML+CSS 공부하기</td>
        </tr>
        <tr>
            <td><input type="checkbox" class="btn-chk"></td>
            <td>장보기</td>
        </tr>
        <tr>
            <td><input type="checkbox" class="btn-chk"></td>
            <td>운동하기</td>
        </tr>
        </tbody>
    </table>

    <div class="btn-area">
        <!-- 삭제 기능 -->
        <button type="buton" id="DeleteSel">선택 삭제</button>
        <button type="buton" id="btnDelLast">마지막 항목 삭제</button>
        <button type="buton" id="btnDelAll">전체 삭제</button>
    </div>
</div>
<%-- to do list 예시 --%>

<%-- 직접 해보는 to do list --%>
<div class="tdlBox">
    <h1>To Do List</h1>
    <div class="writeBox"> <%--텍스트 입력창과 버튼 영역--%>
        <input type="text" id="textBasic">
        <input type="button" value="추가" id="btnAdd">
    </div>
    <table class="listTable">
        <%-- 위에서 추가한 to do 내용이 동적으로 추가되는 테이블 --%>
        <colgroup>
            <col width="15%">
            <col width="85%">
        </colgroup>

        <thead>
        <tr>
            <th>확인</th>
            <th>목록</th>
        </tr>
        </thead>
        <tbody id="listBody">
        <tr>
            <td><input type="checkbox" class="btn-chk"></td>
            <td> 김밥+소고기 해치우기</td>
        </tr>
        <tr>
            <td><input type="checkbox" class="btn-chk"></td>
            <td> 치킨 살 발라 볶음밥 해먹기</td>
        </tr>
        <tr>
            <td><input type="checkbox" class="btn-chk"></td>
            <td> 고구마 희경언니네 가져가서 구워먹기</td>
        </tr>
        </tbody>
    </table>

    <div class="tdlBtnArea">
        <%--삭제기능--%>
        <input type="button" value="선택삭제" id="delSel">
        <input type="button" value="마지막 항목삭제" id="delLast">
        <input type="button" value="전체 삭제" id="delAll">
    </div>

    <div class="calculator">
        <div class="ccSignPack">
            <input type="button" class="calSign" id="sum" value="+">
            <input type="button" class="calSign" id="subt" value="-">
            <input type="button" class="calSign" id="mult" value="x">
            <input type="button" class="calSign" id="divi" value="/">
        </div>
        <input type="text" class="iptArea" id="num1" value="">
        <%--<p id="calSign"> 히히 </p>--%>
        <input type="text" id="calSign" name="calSign" value="" style="width:20px; height: 30px; color: #1b7ccc;"> <%-- 기호 --%>
        <input type="text" class="iptArea" id="num2" value="">
    <input type="button" class="calBtn" value="계산하기" style="background-color: hotpink">
    <input type="text" id="calVal" style="width:80px; height: 30px;">
    </div>

</div>
<%-- 직접 해보는 to do list --%>

</body>
