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
    
</script>
<body>
얄루


</body>
</html>
