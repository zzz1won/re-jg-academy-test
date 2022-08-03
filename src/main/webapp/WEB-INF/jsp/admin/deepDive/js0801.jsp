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
</body>
