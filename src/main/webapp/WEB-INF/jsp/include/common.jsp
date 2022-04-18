<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- js --%>
<script src="${pageContext.request.contextPath}/resources/js/modernizr-custom.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.bpopup.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.nice-select.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>

<%-- icon --%>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">

<%-- css --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/print.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">

<%--<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fullcalendar/lib/main.css">--%>
<%--<script src="${pageContext.request.contextPath}/resources/fullcalendar/lib/main.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/resources/fullcalendar/lib/locales/ko.js"></script>--%>

<script type="text/javascript">
var doubleSubmitFlag = false;
var click = true;

<%-- 중복 클릭 방지 --%>
function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    } else {
        doubleSubmitFlag = true;
        return false;
    }
}

<%-- 다중 클릭 방지 --%>
function fn_overClick() {
     if (click) {
        //console.log("클릭됨");
        click = !click;
        
        // 타이밍 추가
        setTimeout(function () {
            click = true;
        }, 3000)
        
     } else {
        //console.log("중복됨");
     }
     
     return click;
}

<%-- form json으로 전달하기 위한 함수 --%>
$(function(){
	$.fn.serializeObject = function(){
	    var o = {};
	    var a = this.serializeArray();
	    $.each(a, function() {
	    	var name = $.trim(this.name),
	    		value = $.trim(this.value);
	    	
	        if (o[name]) {
	            if (!o[name].push) {
	                o[name] = [o[name]];
	            }
	            o[name].push(value || '');
	        } else {
	            o[name] = value || '';
	        }
	    });
	    return o;
	};
});

<%-- split --%>
function fn_split(str){
	var returnStr = "";
	var splitStr = str.split('/');
	
	for(var i in splitStr){
		returnStr += splitStr[i];
	}
	
	return returnStr; 
}

<%-- String(yyyyMMdd) to date --%>
function fn_stringToDate(str){
	var year   = str.substring(0,4);
	var month  = str.substring(4,6);
	var day    = str.substring(6,8);
	
	return new Date(year, month-1, day);
}

<%-- 교육과정 상세 팝업 --%>
function fn_detail(eduNo){
	var data = {
			"acEduScheduleNo" : eduNo
	}
	
	$.ajax({
		type: "post",
		url: "<c:out value='${pageContext.request.contextPath}/edu/judge/detail'/>",
		data: JSON.stringify(data),
		dataType: "text",
		contentType: "application/json;charset=UTF-8",
		success: function(data){
			$('#pop_detail').html(data);
			
			$('#pop_detail').bPopup({
                speed: 450,
                // transition: 'slideDown'
            });
		},
		error: function(){
			alert("ajax error");
		}
	});
}




</script>