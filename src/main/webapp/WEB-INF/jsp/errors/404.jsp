<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
        <title>페이지를 찾을 수가 없습니다.</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        
        <%-- js --%>
		<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>

		<%-- icon --%>
		<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
		
    <style type="text/css">
        /* reset */
        body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,textarea,p,blockquote,th,td,input,select,button{margin:0;padding:0}
        fieldset,img{border:0 none}
        dl,ul,ol,menu,li{list-style:none}
        blockquote, q{quotes: none}
        blockquote:before, blockquote:after,q:before, q:after{content:'';content:none}
        input,select,textarea,button{vertical-align:middle}
        button{border:0 none;background-color:transparent;cursor:pointer}
        body{background:#f2f7fb}
        body,th,td,input,select,textarea,button{font-size:14px;line-height:1.5;font-family:'Malgun Gothic','맑은 고딕',dotum,'돋움',sans-serif;color:#222;letter-spacing:-0.5px}
        a{color:#333;text-decoration:none}
        a:active, a:hover{text-decoration:underline}
        a:active{background-color:transparent}
        address,caption,cite,code,dfn,em,var{font-style:normal;font-weight:normal}

        /* error */
        .error-wrap{width:660px; margin:180px auto 0; box-shadow: 2.5px 4.33px 6px 0px rgba(0, 0, 0, 0.1); background: #fff url('${pageContext.request.contextPath}/resources/images/common/img-error.png') no-repeat top center; border-radius: 3px;}
        .error-wrap .error-top{overflow:hidden;}
        .error-wrap .error-top h1{float:left;}
        .error-wrap .error-content{position:relative;min-height:180px;padding:230px 0 70px;border-top:5px solid #2b70cc; text-align: center; border-radius: 3px;}
        .error-wrap .tit_error{margin-bottom:20px;font-weight:bold;font-size:33px;line-height:50px;letter-spacing:-3px}
        .error-wrap .tit_error span{color:#2b70cc;}
        .error-wrap .error-txt{margin-top:6px;font-size:17px;line-height:24px;}
        .error-footer{padding-top:15px; margin: 0 auto; text-align: center;}
        .copyright{font-size:13px;color:#888;}
        .btn {overflow: hidden; display: inline-block; text-align: center; white-space: nowrap; border: 1px solid #2b70cc; background: #2b70cc; vertical-align: middle; padding: 14px 85px 15px; font-size: 20px; line-height: 1.2; border-radius: 3px; box-shadow: 0px 5px 4.75px 0.25px rgba(75, 77, 185, 0.19); font-weight: bold; transition: all .2s ease-out; color: #fff; margin-top: 40px;}
        .btn:hover, .btn:active{text-decoration: none; background: #16349a;}
    </style>
    
<script type="text/javascript">
$(function(){
	var requestUrl = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}"/>';
	
	if(requestUrl.indexOf('admin') != -1){
		$('#moveIndex').attr("href", "${pageContext.request.contextPath}/admin/index");
	} else{
		$('#moveIndex').attr("href", "${pageContext.request.contextPath}/judge/index");
	}
});
</script>
</head>

<body>
    <div class="error-wrap">
        <div class="error-content">
            <h2 class="tit_error">이용에 불편을 드려 <span>대단히 죄송합니다.</span></h2>
            <p class="error-txt">
                인터넷 창을 다시 띄우시거나 잠시 후 다시 접속하여 주시기 바랍니다. 
            </p>
            <p class="error-txt">
                이용에 불편을 드려 대단히 죄송합니다.
            </p>
        <a id="moveIndex" class="btn">홈화면 이동</a>
        </div>
    </div>
    <div class="error-footer">
        <p class="copyright">Copyright ©2018 KPC, ALL RIGHT RESERVED.</p>
    </div>
</body>
</html>
