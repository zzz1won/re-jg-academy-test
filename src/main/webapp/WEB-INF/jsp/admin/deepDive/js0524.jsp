<%--
  Created by IntelliJ IDEA.
  User: home
  Date: 2022-04-27
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
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
    <title>심판아카데미 운영 Admin-deepDive 연습</title>
</head>
<%--Failed to load resource: the server responded with a status of 404 ()--%>
<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>
<%--아이콘 없다고 404뜨길래, 추가했더니 되었다 ^^--%>

<script>
    $(function () { //document ready~
        arrToString();
        arrJoin();
        arrPop();
        arrPush();
        arrShift();
        arrConcat();
        arrSplice();
        //
        arrSort();
        arrSort2();
        //
        arrIteration();
    })

    function arrToString() {
        $('#arrToStringBtn').click(function () {
            var fruits = ["바나나", "사과", "딸기", "망고", "토마토"];
            $('#arrToStringArea').text(fruits.toString());
        })
        console.log('click to arrayToString btn');
    }

    function arrJoin() {
        $('#arrayJoinBtn').click(function () {
            var fruits = ["바나나", "사과", "딸기", "망고", "토마토"]; //다시 적어줘야만 하는건가? //그런가보군
            //$('#arrToStringArea').join("--"); //문법이 이게 아니다.
            $('#arrToStringArea').text(fruits.join("💕"));
        })
    }

    function arrPop() {
        //The pop() method removes the last element from an array!
        var fruits = ["바나나", "사과", "딸기", "망고", "토마토"];
        $('#arrayPopBtn1').click(function () {
            $('#arrPopArea').text(fruits);
        })

        $('#arrayPopBtn2').click(function () {
            fruits.pop();
            $('#arrPopArea').text(fruits);
        })

        $('#arrayPopBtn3').click(function () {
            $('#arrPopArea2').text(fruits.pop()); //pop() 을 통해 지워진 element 출력
            $('#arrPopArea3').text(fruits); //pop()을 통해 지워진 후의 array data 출력
        })
    }

    function arrPush() {
        var maraTang = ["청경채", "푸주", "두부", "목이버섯버섯", "소고기"];
        $('#arrayPushBtn1').click(function () {
            //$('#arrPushArea1').text(maraTang.push('백목이버섯'));
            maraTang.push('연근');
            $('#arrPushArea1').text(maraTang);
            $('#arrPushArea2').text(maraTang.push('백목이버섯')); //length 나오네?
            //어쨌든 add(append) new element to an array
            $('#arrPushArea3').text(maraTang);
        })
    }

    function arrShift() {
        var maraTang = ["청경채", "푸주", "두부", "목이버섯버섯", "소고기"];
        $('#arrayShiftBtn1').click(function () {
            $('#arrShiftArea1').text(maraTang);
            maraTang.shift();
            $('#arrShiftArea2').text(maraTang);
        })
    }

    function arrConcat(){
        var fruits = ["바나나", "사과", "딸기", "망고", "토마토"];
        var maraTang = ["청경채", "푸주", "두부", "목이버섯버섯", "소고기"];
        $('#arrayConcatBtn1').click(function(){

            //$('#arrConcatArea1').text("오늘 "+maraTang.concat(fruits)+"먹을거야");
            $('#arrConcatArea1').text("오늘 "+maraTang.join('🍙').concat(fruits.join('😉'))+"먹을거야");
        })
    }

    function arrSplice(){
        var fruits = ["바나나", "사과", "딸기", "망고", "토마토"];
        var maraTang = ["청경채", "푸주", "두부", "목이버섯버섯", "소고기"];
        $('#arraySpliceBtn1').click(function(){
            $('#arrSArea').text(fruits);
            $('#arrSpliceArea').text(fruits.splice(1,0,"레몬","키위"));
            $('#arrSpliceArea').text(fruits);
        });

        $('#arraySliceBtn1').click(function(){
            $('#arrSArea').text(fruits);
            $('#arrSliceArea').text(fruits.slice(2)); //1개를 잘라내면 사과,딸기,망고,토마토
            //2개 잘라내면 딸기,망고,토마토 만 출력
            $('#arrSArea').text(fruits);
            //새로운 배열을 출력하는 모양이다!
        });

        $('#arraySliceBtn2').click(function(){
            $('#arrSArea').text(maraTang);
            $('#arrSliceArea2').text(maraTang.slice(2,4));
            //$('#arrSlice').text(maraTang);
            console.log("arr.slice(start(포함),end(미포함)) 작동");
        });

    }

    function arrSort(){
        var lunchMenu=["오지상돈카츠","홍콩반점","그김에","신도세기","한촌설렁탕","육대장"];
        $('#arraySortBtn').click(function(){
            $('#arrSortBase').text(lunchMenu);
            lunchMenu.sort();
            $('#arrSortArea').text(lunchMenu);
        })

        $('#arrayReverseBtn').click(function (){
            $('#arrSortBase').text(lunchMenu);
            lunchMenu.reverse();
            $('#arrReverseArea').text(lunchMenu);
        })
    }

    function arrSort2(){
        var numArr = [1,553,279,82,33,100,1009,7];
        $('#arrSortNumericZone1').text(numArr);

        $('#arraySortAlphabetBtn').click(function(){
           console.log("알파벳순으로 정렬");
           numArr.sort();
            $('#arrSortNumericZone2').text(numArr);

        });

        $('#arraySortNumericBtn').click(function(){
            console.log("숫자순으로 정렬");
            numArr.sort(function(a,b){return a-b});
            $('#arrSortNumericZone2').text(numArr);
        });

        $('#arraySortHigherBtn').click(function(){
            console.log('높은숫자를 찾아서');
            numArr.sort(function(a,b){return b-a});
            $('#arrSortHigher').text(numArr[0]);
        })

        $('#arraySortLowBtn').click(function(){
            console.log('낮은숫자를 찾아서');
            numArr.sort()
        })
    }

    function arrIteration(){
            var iter=['달빛천사','천사소녀','카드캡터','웨딩피치','슈가슈가','베리베리'];
            var output = "";

        $('#arrayIterationBtn').click(function(){
            console.log('arrayIterationBtn 누름');
            iter.forEach(fn_iter);
            $('#arrIterationArea').html(output);
            //태그요소이기때문에 text가 아니라 html로 써줘야한다.
            function fn_iter(value){
                output += value + '<br>';
            }
            console.log(output);
        })
    }

</script>
<body>
<div id="wrapper">
    <jsp:include page="/WEB-INF/jsp/include/adminHeader.jsp"/>
    <div class="sub-tit-wrap">
        <div class="sub-tit-container">
            <!-- menu: 3개->6개 -->
            <div class="tab-wrap tab6">
                <a href="javascript:fn_scheduleList();" class="tablinks">교육 일정 관리</a>
                <a href="javascript:fn_applyList();" class="tablinks">신청 관리</a>
                <a href="javascript:fn_certList();" class="tablinks"> 수료 관리</a>
                <%-- 220408 4개로 추가--%>
                <a href="javascript:fn_codeList();" class="tablinks active"> 코드 관리</a>
                <%-- 220408 5개로 추가--%>
                <a href="javascript:fn_judgeList();" class="tablinks"> 심판 관리</a>
                <%-- 220510 6개로 추가--%>
                <%-- adminHeader.jsp 파일에 선언해두었기 때문에 파일마다 일일히 function~ 할 필요 없음.--%>
                <a href="javascript:fn_codingEx();" class="tablinks"> 지원 관리</a>
            </div>
            <!-- //menu -->
        </div>
    </div>
    <%-- 상단바 --%>
    <div class="content-wrap" style="height: 400px">
        <div class="arrayMethod">
            <div class="array_toString">
                <input type="button" id="arrToStringBtn" value="🍎"/>
                <p id="arrToStringArea"></p>
                <input type="button" id="arrayJoinBtn" value="🧀"/>
                <p id="arrJoinArea">치즈버튼을 누르면 join처리 됩니다</p>
            </div>
            <div class="array_pop">
                <input type="button" id="arrayPopBtn1" value="🍊"/>
                <input type="button" id="arrayPopBtn2" value="🍊🍊"/>
                <input type="button" id="arrayPopBtn3" value="🍊🍊🍊"/>
                <p id="arrPopArea"></p>
                <p id="arrPopArea2"></p>
                <p id="arrPopArea3"></p>
            </div>
            <div class="array_push">
                <input type="button" id="arrayPushBtn1" value="🙄"/>
                <p id="arrPushArea1"></p>
                <p id="arrPushArea2"></p>
                <p id="arrPushArea3"></p>
            </div>
            <div class="array_shifting">
                <input type="button" id="arrayShiftBtn1" value="🍙"/>
                <p id="arrShiftArea1"></p>
                <p id="arrShiftArea2"></p>
            </div>
            <div class="array_concat">
                <input type="button" id="arrayConcatBtn1" value="😎"/>
                <p id="arrConcatArea1"></p>
            </div>
            <div class="array_splice_slice">
                <input type="button" id="arraySpliceBtn1" value="🍔"/>
                <input type="button" id="arraySliceBtn1" value="🍟"/>
                <input type="button" id="arraySliceBtn2" value="🍟🍟"/>
                <p id="arrSArea"></p>
                <p id="arrSpliceArea"></p>
                <p id="arrSliceArea"></p>
                <p id="arrSliceArea2"></p>
            </div>

        </div>
        <div class="arraySort">
            <div class="array_Sort">
                <input type="button" value="🔴" id="arraySortBtn">
                <input type="button" value="🟠" id="arrayReverseBtn">
                <p id="arrSortBase"></p>
                <p id="arrSortArea"></p>
                <p id="arrReverseArea"></p>
            </div>
            <div class="array_numeric">
                <input type="button" id="arraySortAlphabetBtn" value="alphabet">
                <input type="button" id="arraySortNumericBtn" value="numeric">
                <input type="button" id="arraySortHigherBtn" value="higher">
                <input type="button" id="arraySortLowBtn" value="lower">
                <p id="arrSortNumericZone1"></p>
                <p id="arrSortNumericZone2"></p>
                <p id="arrSortHigher"></p>
                <p id="arrSortlower"></p>
            </div>
        </div>
        <div class="arrayIteration">
            <div class="array_forEach">
                <input type="button" id="arrayIterationBtn" value="😉">
                <span id="arrIterationArea"></span>
            </div>
        </div>

    </div>
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</div>
</body>
</html>
