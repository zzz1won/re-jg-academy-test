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
    $(function () {
        /*        $("button").click(function(){
                    $("*").hide();
                })*/

        $(".tagArea12").mouseenter(function () {
            alert("😂");
            //실행하려면 #tagArea1으로 변경
        })

        $('.tagArea12').mouseleave(function () {
            alert("😎");
            //실행하려면 #tagArea1으로 변경
        })

        //위처럼 mouseenter, mouseleave를 같이 줄거면 hover() 를 이용해 진행하는것이 좋다.
        $('.tagArea1').hover(function () {
            $(".tagArea1").css("color", 'orange');
        }, function () {
            $(".tagArea1").css("color", 'green');
        })

        var modify = $('#TT-area');
        $('.TT').click(function () {
            //alert('ㅋㅋㅋㅋㅋㅋ클릭');
            modify.append('클릭<br>');
        })

        $('.TT').mousedown(function () {
            modify.append('mousedown!<br>');
        })

        $('.TT').mouseup(function () {
            modify.append('mouseup!<br>');
        })

        $('.TT').dblclick(function () {
            modify.append('더블클릭!<br>');
        })

        $('input:button').click(function () {
            modify.text('');
        })


        //focus && blur
        $("input").focus(function () {
            $(this).css("background-color", "pink");
        })
        $('input').blur(function () {
            $(this).css("background-color", "orange");
        })


        /*$(".FnTest1").on(function () {
            $(".FnTest1").mouseenter(function () {
                $(this).css("background-color", "peach");
            }),
                $(".FnTest1").mouseleave(function () {
                    $(this).css("background-color", "white");
                }),
                $(".FnTest1").click(function () {
                    $(this).css("font-color", "red");
                })
        })*/

        $(".FnTest1").on({
            mouseenter: function () {
                $(this).css("background-color", "lightblue");
            },
            mouseleave: function () {
                $(this).css("background-color", "lightgray");
            },
            click: function () {
                $(this).css("background-color", "pink");
            }
        })

        //keyboard event
        $("#input1").keypress(function () {
            $("#input2").val($(this).val())
        });

        $("#input2").keyup(function () {
            $("#input3").val($(this).val())
        });

        $("#input3").keydown(function () {
            $("#input4").val($(this).val())
        });

        $(".togglebtn").click(function () {
            $(".toggleArea").toggle();
        });

        /*$(".showHide").click(function(){
            $("#show1").hide(1000);
            $("#hide2").show(500);
        });*/

        $(".showHide").on({
            click: function () {
                $("#show1").text("개봉박두!");
                //$("#show1").hide(500);
                $("#hide1").show(300);
            },
            dblclick: function () {
                $("#hide1").show(300);
                $("#show1").text("ㅋㅋㅋㅋㅋㅋㅋㅋ");
            }
        });

        $(".callback-chk").click(function () {
            console.log("callback-chk버튼 누름")
            $("#cbchk").hide("slow", function () {
                console.log("cbchk alert 뜨기전")
                alert("callback 실행완");
                console.log("cbchk alert 뜸")
            });
        });

        $("#apWonder").click(function () {
            console.log("apWonder 누름")
            apTest();
        })

        $("#jsToJquery1").click(function () {
            console.log("jsToJquery1 누름")
            jsToJqueryEx1();
        })

        $("#jsToJquery2").click(function () {
            jsToJqueryEx2();
        });

        $("#jsToJquery3_1").click(function () {
            jsToJqueryEx3_1();
        });

        $("#jsToJquery3_2").click(function () {
            jsToJqueryEx3_2();
        });

        $("#0517_1").click(function () {
            test1_0517();
        })

        $('#0520_2').click(function(){
            console.log('replaceBtn1 누름');
            padStartTest();
            split1();
            $('#substitute').text(may23Test);
            $('#htmlTemplate').text(html);
            infTest();
            arrPer();
            //console.log(html);
            //document.getElementById('htmlTemplate').innerHTML = html;
            //myFunction();
            //$('#replace1').replaceWith('<p>폴댄스는 멍멍쟁이가 된다.</p>');
            //$('#replace1').replaceWith($('#replace2').show());
            //$('#replace1').replaceAll('p');
        })

    })

    //일반함수는 도큐레디 밖에 써주는걸로.
    function apTest() {  //attr() prop()의 차이
        //attr() : 속성 값 그 자체! prop() : 속성 값을 다루는 용도로 쓰인다.
        alert("attr checked: " + $("#aptest1").attr("checked") + "\nprop checked: " + $("#aptest1").prop("checked"));
        alert("attr checked: " + $("#aptest2").attr("checked") + "\nprop checked: " + $("#aptest2").prop("checked"));
    };

    function jsToJqueryEx1() { //javascript를 jquery로 변형
        $("#jTOj1").append("🍕🍔🍟🌭🍿🧂🥓🥚<br>");
        $("#jTOj1").append(Date() + "<br>");
    };

    function jsToJqueryEx2() {
        $('#jToj2').text("돼! 😎");
    };

    //이미지 다루기는 attr()로
    function jsToJqueryEx3_1() {
        $("#jjImage").attr("src", "https://www.w3schools.com/js/pic_bulbon.gif");
    }

    function jsToJqueryEx3_2() {
        $("#jjImage").attr("src", "https://www.w3schools.com/js/pic_bulboff.gif");
    }

    function test1_0517() {
        alert("뭐꼬");
        window.alert("73*88"); //같은거?? you can skip the window keyword
        document.write(6111 * 1812891352132 / 44);
        window.print(); //브라우저에 메소드를 이용해 프린트 가능 ㅋㅋㅋ 개신기
        let x = 16 + 4 + "Volvo";
        console.log(x); //20Volvo
        let y = "Volvo" + 16 + 4;
        console.log(y); //Volvo164

    };
    // 0518 그냥 바로 출력된다.
    const person = {
        name: "지원짱",
        height: 180
    };
    alert(person.name + "은 무려" + person.height + "cm");

    //220520 얌디저트 라는 단어를 핸드크림으로 바꿔보기
    /*function myFunction0(){
        let text = $('#replace1').innerHTML;
        $('#replace1').text = text.replace("얌 디저트","핸드크림");
         //이렇게 쓰는게 아니었나보다.
    }*/

    /*var re = $('#replace1');
    re = re.replace("얌 디저트", "핸드크림");
    console.log(re);
    var re = '내가 쓰는 얌 디저트';
    re = re.replace("얌 디저트", "핸드크림");
    console.log(re);*/

    //selector를 사용하면 안되나보다. 전부 문자열로 하시네... replaceAll예제 나왔다.


    var re = "가나다라 마바사"
    re = re.replace("다", "크"); // 이렇게 선언하면 "다"라는 문자를 "크"라는 문자로 변경 해줍니다.
    console.log(re);

    function myFunction(){
        let text = document.getElementById("replace1").innerHTML;
        document.getElementById('replace1').innerHTML = text.replace('얌 디저트','핸드크림');
    }

    let Text1 = "         과일나라        ";
    let Text2 = '얌 디저트';
    let Text3 = '핸드크림         ';
    let Text4 = Text1.concat(" "+Text2 +" "+Text3);
    console.log(Text4);

    let Text5 = Text1.trim().concat(" "+Text2 +" ")+Text3.trim();
    console.log(Text5);
    console.log("Text5.length:",Text5.length);

    function padStartTest (){
    let Text6 = '사쿠라';
    console.log(Text6);
    document.getElementById('padded1').innerHTML = Text6.padStart(8,"꾸라");
    //$('#padded1').innerHTML = Text6.padStart(8,"장꾸");
    }

    //220520 2 점심먹고 ^^
    function split1(){
    let text = '보라매아카데미타워 4층';
    const testArray = text.split("");

    text = "";
    for(let i=0; i<testArray.length; i++){
        text+= testArray[i] + "\t"
    }
    console.log(text);
    alert(text);

    $('#splitsTest').append(text);
    }

    //220523 아침공부
    let may23 = "오늘은 5/23";
    let hello1 = "안녕하세'뇨리따";

    let may23Test = `하이루 $(may23), $(hello1)`;
    console.log(may23Test);
    //안되는데? console에 찍으면 안되나보군...
    //???? 안되는데???
    //expression subtitution도 안됨 ㄲㄲ;

    //html template
    let storeName = "오니기리와 버거";
    let mainMenu = ['🍙','🍕','🌭'];
    let html = `<h3>${storeName}</h3><ul>`;

    for (let x of mainMenu){
        console.log(mainMenu);
    }

    /*for(const x of mainMenu) {
        html += `<li>${mainMenu}</li>`;
    }
    html+= `</ul>`;*/

    //number
    let x = 10;
    let y = 20;
    let q = "30";
    let z = x + y;
    console.log(x+y+q);
    console.log("z result: "+z);
    console.log("x+y result: "+x+y);

    //NaN
    let x2 = 100 / "hello";
    console.log(x2);
    var x3 = 100 / "25";
    console.log(x3);
    console.log("x2 isNaN: ",(isNaN(x2)));
    console.log("x3 isNaN: ",isNaN(x3));
    x4 = NaN;
    x5 = "8";
    x6 = 8;
    console.log("x4+x5:", x4+x5);
    console.log("x4+x6:", x4+x6);
    console.log(typeof x4);

    //infinity
    function infTest(){
    var inf = 2;
    var txt = "";
    while (inf != Infinity) {
        inf = inf * inf;
        txt = txt + inf + "<br>";
    }
    $('#infinity').append(txt);
    }

    //기본적으로 10진법을 사용하지만 다른 진법으로 사용도 가능하다.
    var num1 = 32;
    console.log("32진법",num1.toString(32));
    console.log("16진법",num1.toString(16));
    console.log("12진법",num1.toString(12));
    console.log("10진법",num1.toString(10));
    console.log("8진법",num1.toString(8));
    console.log("2진법",num1.toString(2));

    //number object
    var nm = 123;
    var ob = new Number(123);
    console.log(typeof nm); //number
    console.log(typeof ob); //object

    //number methods
    var no1 = 777;
    console.log("no1.toString(): ", no1.toString()+"<br>");
    console.log("(8405).toString(): ", ((8405).toString())+"<br>");
    console.log("(732+11).toString(): ", ((732+11).toString()));

    var no2 = 7.3881;
    console.log("no2.toExponential(2):", no2.toExponential(2));
    console.log("no2.toExponential(4):", no2.toExponential(4));
    console.log("no2.toExponential(6):", no2.toExponential(6));
    console.log("no2.toExponential():", no2.toExponential());

    var no3 = 9.2745;
    console.log("no3.toFixed(0): ",no3.toFixed(0));
    console.log("no3.toFixed(2): ",no3.toFixed(2));
    console.log("no3.toFixed(4): ",no3.toFixed(4));
    console.log("no3.toFixed(6): ",no3.toFixed(6));

    var no4 = 4.85122;
    console.log("no4.toPrecision(): ", no4.toPrecision());
    console.log("no4.toFixed(0): ",no4.toFixed(0));
    console.log("no4.toPrecision(2): ", no4.toPrecision(2));
    console.log("no4.toFixed(2): ",no4.toFixed(2));
    console.log("no4.toPrecision(4): ", no4.toPrecision(4));
    console.log("no4.toFixed(4): ",no4.toFixed(4));
    console.log("no4.toPrecision(6): ", no4.toPrecision(6));
    console.log("no4.toFixed(6): ",no4.toFixed(6));

    (4300 + 23).valueOf(); //4323

    console.log("parseFloat('32'): ", parseFloat("32"))+"\n";
    console.log("parseFloat('32.888'): ", parseFloat("32.888"))+"\n";
    console.log("parseFloat('32 8'): ", parseFloat("32 8"))+"\n";
    console.log("parseFloat('32 hi'): ", parseFloat("32 hi"))+"\n";
    console.log("parseFloat('hi 32'): ", parseFloat("hi 32"))+"\n";

    //220523 오후공부 js Array
    var vvg = ["Eunha","Sinbi","Eomji"];
    console.log(vvg);
    var bvg = [];
    bvg[0]="메보";
    bvg[1]="꼬북";
    bvg[2]="왕눈";
    bvg[3]="단발";
    //alert(bvg); //alert : 메보,꼬북,왕눈,단발
    //alert(bvg[3]); //alert : 단발
    console.log(bvg);
    console.log(bvg[2]);
    bvg[1]="유정";
    console.log(bvg); // 메보,유정,왕눈,단발
    console.log(typeof bvg); //object
    var rvt=["아이린","슬기","웬디",'조이','예리',5];
    console.log(rvt[5]);
    var gg={메보:"태연",메댄:"효연",센터:"윤아",개그:"수영"};
    console.log(gg.개그);
    const fruits = ["banana","apple","grape","waterMelon"];
    //let fruit = fruits[3];
    //console.log(fruit);
    let fruit = fruits[fruits.length-1];
    console.log(fruit);

    let fLen = fruits.length;
    let text = '\n';
    for (let i=0; i<fLen; i++){
        text+= fruits[i]+'\n';
    }
    console.log("text: ",text);
    //이걸 forEach처럼 사용 할 수 있다.

    let text1 ='<ul>';
    fruits.forEach(myFunction1);
    text1 += '</ul>';
    $('#arrFruits').text=text1;

    function myFunction1(value){
      text1 += '<li>'+value+'</li>';
    };

    fruits[6] = "lemon";
    console.log(fruits);

    function arrPer() {
        const person = [];
        person[0] = "jane";
        person[1] = 'Cat';
        person[2] = '331';

        $('#arrPerson').text(person[0] + " "+ person.length);
    }




</script>
<%--<script type="text/javascript">




    //jsStudy220427 예제 10-01
    var person = {
        name: 'Lee',
        sayHello: function (){
            console.log('Hello, my name is ${this.name}.');
        }
    };
    console.log(typeof person); //object
    console.log(person); //{name:'Lee', sayHello:f}

    //jsStudy220427 예제 10-02
    var empty = {}; //빈객체
    console.log(typeof empty);
    console.log(empty);

    //jsStudy220427 예제 10-04
    var person2 = {
        firstName: 'jiwon',
        lastName: 'park',
        //middle-Name: 'zzang' 네이밍규칙을 따르지 않았을 경우.
        'middleName':'zzang' //따옴표를 생략하지 않는다면 기재 가능하다.
    };
    console.log(person2);

/*    var persen3 = {
        firstName: 'jiwon',
        last-name: 'park' //SyntaxError:Unexpected token...
    };*/

    //jsStudy220427 예제 10-06
    var obj = {};
    var key = 'keyName';

    obj[key] = '와하하';
    console.log(obj);

    //jsStudy220427 예제 10-07
    var foo1 = {
        '' : ''
    };
    console.log(foo1);

    //jsStudy220427 예제 10-08
    var foo2 = {
        0:1,
        1:2,
        2:3
    }
    console.log("foo2:",foo2);

    //jsStudy220427 예제 12-01
    function add(x,y){
        return x+y;
    }
    /* 구리구리하게 console.log 찍는 것 보다 */
    console.log(add(2,5));

    /* 인수를 통해 값을 반환해주는게 더 깔끔하다. */
    var result = add(2,5);
    console.log(result);

    result = add(10,2);
    console.log(result);
    result = add(16,8804);
    console.log(result);

    //jsStudy220427 예제 12-05
    function add(x,y) {
        return x+y;
    }

    console.dir(add);
    console.log("log: ",add);
    console.log("log: ",(add(2,5)));

    // jsStudy220427 예제 12-06
    // 함수 선언문은 함수 이름을 생략할 수 없다.
    function fnName(x,y) {
        return x+y;
    }

    // jsStudy220427 예제 12-07
    // 함수 선언문은 표현식이 아닌 문이므로 변수에 할당할 수 없다.
    // 하지만 함수 선언문이 변수에 할당되는 것처럼 보인다.
    var add = function add(x,y) {
        return x + y;
    };

    console.log(add(2,5));

    // jsStudy220427 예제 12-08
    // 기명 함수 리터럴을 단독으로 사용하면 함수 선언문으로 해석된다.
    // 함수 선언문에서는 함수 이름을 생략할 수 없다.
    function foo() {
        console.log('foo');
    }
    foo(); // foo() 를 실행함

/*    (function bar(){
        console.log('bar');
    });
    bar();*/

    console.log(new Date());
    console.log(new Date(86400000));
    console.log(Date(3));

    console.log(new Date(2022, 3, 27, 15,9,0));    //month는 0부터 시작...
    console.log(new Date('2022/4/28/14:00:00:00'));

    const today = new Date('2022/4/23/14:00:00:00');

    console.log(today);
    console.log("오늘은 몇 월: ",today.getMonth()+1);
    console.log("오늘은 며칠: ",today.getDate()); //???
    console.log("오늘은 몇번째 요일: ",today.getDay()); //???
    console.log("지금은 몇 시: ",today.getHours());
    console.log("지금은 몇 분: ", today.getMinutes());
    console.log(today.setMonth(11));
    console.log(today.getMonth());
    /* 근데 잘 안쓰는 표현이라고 하셨다. */
    /* 브라우저 기준이 아니라 서버 시간 기준으로 돌리기때문에, 개념만 알아두는게 좋을 듯 */
</script>--%> <%-- js 연습 --%>
<%--<script>
    $(function(){
        let kCount = 1;
        let hCount = 1;

/*        function createK(){
            let tagArea = document.getElementById('tagArea');
            let newKTag = document.createElement('tag');

            newKTag.setAttribute('class','tag');
            newKTag.innerHTML = kCount+".K추가 되었읍니당";
            tagArea.appendChild(newKTag);

            kCount++;
        }*/
        function createK(){
            let tagArea = document.getElementById('tagArea');
            let newKTag = document.createElement('tag'+kCount);

            newKTag.innerHTML =  "추가된 K태그"+kCount+"호";
            tagArea.appendChild(newKTag);
        }
    })
    let kCount = 1;
    let hCount = 1;

    /*        function createK(){
                let tagArea = document.getElementById('tagArea');
                let newKTag = document.createElement('tag');

                newKTag.setAttribute('class','tag');
                newKTag.innerHTML = kCount+".K추가 되었읍니당";
                tagArea.appendChild(newKTag);

                kCount++;
            }*/
    function createK(){
        let tagArea = document.getElementById('tagArea');
        let newKTag = document.createElement('k');

        newKTag.setAttribute('class', 'kTag');
        newKTag.innerHTML =  "추가된 K"+kCount+"호";
        tagArea.appendChild(newKTag);
        kCount++;
    }

    /*function createH(){
        let tagArea = document.getElementById('tagArea');
        let newHTag = document.createElement('h');

        newHTag.setAttribute('class','tag');
        newHTag.innerHTML = hCount+
    }*/

    let pTagCount = 1;
    let hTagCount = 1;
    function create_pTag(){
        let tagArea = document.getElementById('tagArea');
        let new_pTag = document.createElement('p');

        new_pTag.setAttribute('class', 'pTag');
        new_pTag.innerHTML = pTagCount+". 추가된 p태그";

        tagArea.appendChild(new_pTag);

        pTagCount++;
    }

    function create_hTag(){
        let tagArea = document.getElementById('tagArea');
        let new_hTag = document.createElement('h'+hTagCount);

        new_hTag.innerHTML = "추가된 h"+hTagCount+"태그";

        tagArea.appendChild(new_hTag);

        if(hTagCount < 6)
            hTagCount++;
    }

</script>--%> <%--버튼 js 연습--%>
<style>
    .TT {
        width: 100px;
        height: 100px;
        background-color: #9a54ce;
    }

</style>
<body>
얄루

<span class="FnTest1"> 원래는 FnText1 이었던 곳 </span>
<div class="tagArea1" style="display: block">
    오늘 저녁은 소곱창
</div>
<div class="TT">
</div>
<div id="TT-area"></div>
<input id="clear-btn" type="button" value="clear"/>

<div class="focus-blur">
    할말있어: <input type="text" id="input1">
    머라고?: <input type="text" id="input2">
    뭐라고?: <input type="text" id="input3">
    뭐라는거야: <input type="text" id="input4">

    <%-- keyboard event 값 출력하는 --%>
</div>

<div>
    <input type="button" value="토글버튼" class="togglebtn">
    <div class="toggleArea">
        <p>토글1 우하하 </p>
        <p>토글2 우하하 </p>
        <p>토글3 우하하 </p>
    </div>
    <br>
    <div class="showHide">
        <p id="show1">빠밤</p>
        <p id="hide1" style="display: none">😎</p>
    </div>
    <%--<div class="callback-chk">
    </div>--%>

    <br>
    <button class="callback-chk">버튼</button>
    <p id="cbchk">천재가 되고싶어</p>
    <br>
    <div class="attr-prop">
        <input type="button" id="apWonder" value="궁금해"/>
        <input type="checkbox" id="aptest1" checked="checked"/>체크박스1
        <input type="checkbox" id="aptest2"/>체크박스2
    </div>
</div>
<br>
<br>
<div class="jsJquery">
    <div class="jj1">
        <input type="button" id="jsToJquery1" value="click me to display Date and Time"/>
        <p id="jTOj1"></p>
    </div>
    <br>
    <div class="jj2">
        <input type="button" id="jsToJquery2" value="click!">
        <p id="jToj2"> 클릭버튼을 누르면 안돼! </p>
    </div>
    <div class="jj3">
        <input type="button" class="jj3btn" id="jsToJquery3_1" src="https://www.w3schools.com/js/pic_bulbon.gif"
               value="똑">
        <img id="jjImage" src="https://www.w3schools.com/js/pic_bulboff.gif" style="width:100px">
        <input type="button" class="jj3btn" id="jsToJquery3_2" src="https://www.w3schools.com/js/pic_bulboff.gif"
               value="딱">
        <div class="0517test1"><input type="button" value="😉띠용 window.alert() 띠용😀" id="0517_1"/> asd</div>
        <div calss="0520test1"><input type="button" value="replace!" id="0520_2"/>
            <p id="replace1">내가 쓰는 얌 디저트</p></div>
        <p id="replace2" style="display: none"> 어유 왼쪽분들 정말... 친하구나... </p>
        <p id="replace3"> 뚜두뚜두뚜두 </p>
        <p id="575"> 줄리엣 호우 </p>
        <p id="576"> 후루뚜루뚜 </p>
        <p id="padded1"></p>
        <p id="splitsTest"></p>
    </div>
    <div class="may23">
        <div class="stringTemplate">
            <p id="substitute"> ㅎㅎ </p>
            <p id="htmlTemplate"> </p>
            <p id="infinity"> Infinity is returned if you calculate a number outside the largest possible number:
            <p id="arrFruits">과일배열</p>
            <p id="arrPerson">사람배열</p>
            </p>
        </div>
    </div>
</div>


<%--<div id = "tagArea">
<input type="button" value="ㅎㅎㅎ" onclick="createH()">
<input type="button" value="ㅋㅋㅋ" onclick="createK()">
<input type="button" value="add_hTag" onclick="create_hTag();">
<input type="button" value="add_pTag" onclick="create_pTag();">
<button>dsdsfsdfss</button>
</div>--%>
</body>
</html>
