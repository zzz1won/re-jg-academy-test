<%--
  Created by IntelliJ IDEA.
  User: home
  Date: 2022-04-27
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>심판아카데미 운영 Admin-deepDive 연습</title>
</head>
<%--Failed to load resource: the server responded with a status of 404 ()--%>
<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%--아이콘 없다고 404뜨길래, 추가했더니 되었다 ^^--%>
<script type="text/javascript">
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
</script>
<script>
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

    function createH(){
        let tagArea = document.getElementById('tagArea');
        let newHTag = document.createElement('h');

        newHTag.setAttribute('class','tag');
        newHTag.innerHTML = hCount+
    }

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
</script>
<body>
얄루

<span id="FnTest1"> 원래는 FnText1 이었던 곳 </span>

<div id="tagArea1">
    우하하
</div>
<input type="button" value="ㅋㅋㅋ" onclick="createK()">
<input type="button" value="ㅎㅎㅎ" onclick="createH()">

<div id = "tagArea"></div>
<input type="button" value="add_hTag" onclick="create_hTag();">
<input type="button" value="add_pTag" onclick="create_pTag();">

</body>
</html>
