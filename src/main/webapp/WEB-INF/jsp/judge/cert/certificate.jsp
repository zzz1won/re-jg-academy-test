<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>수료증</title>
</head>

<%-- js --%>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.bpopup.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/html2canvas.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bluebird.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jspdf.min.js"></script>

<%-- css --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/print.css">

<script type="text/javascript">
$(function(){
	
});
</script>

<body>
    <div class="book">
        <%-- <div class="btn-wrap">
            <button type="button" id="btn_print" class="btn2 btn-blue">인쇄하기</button>
            <button type="button" id="btn_save" class="btn2 btn-gray">저장하기</button>
        </div> --%>
        <div class="page">
            <div class="subpage_admin" id="content">
                <embed src="<c:out value="${pageContext.request.contextPath}/file/view/cert?certNo=${certInfo.acEduCertInfoNo}"/>" width="780" height="1100" type="application/pdf">
            </div>
        </div>
    </div>

    <script>
    $(function(){
    	<%-- 인쇄하기 --%>
    	 $('#btn_print').click(function() {
             window.print();
         });
    	 
    	 <%-- 해당 수료증을 저장하시겠습니까? --%>
         $('#btn_save').click(function(){
         	if(confirm("해당 수료증을 저장하시겠습니까?")){
         		
         	 // http://html2canvas.hertzen.com/configuration/ : 옵션 설명
       		 html2canvas($('.page'), {
       			allowTaint: true,
       			useCORS: true,
       			logging: false,
       			height: window.outerHeight + window.innerHeight,
       			windowHeight: window.outerHeight + window.innerHeight,
       		 }).then(function(canvas){
       			 // 캔버스를 이미지로 변환
       			 var imgData = canvas.toDataURL('image/png');
       			 
       			 var imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
       			 var pageHeight = imgWidth * 1.414; // 출력 페이지 세로 길이 계산 A4 기준
       			 var imgHeight = canvas.height * imgWidth / canvas.width;
       			 var heightLeft = imgHeight;
       			 var doc = new jsPDF('p', 'mm', 'a4');
       			 var position = 0;
       			 
       			 // 첫 페이지 출력
       			 doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
       			 heightLeft -= pageHeight;
       			 
       			 // 한 페이지 이상일 경우 루프 돌면서 출력
       			 /* while(heightLeft >= 20){
       				 position = heightLeft - imgHeight;
       				 doc.addPage();
       				 doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
       				 heightLeft -= pageHeight;
       			 } */
       			 
       			 // 파일 저장
       			 doc.save("Certificate_<c:out value='${fileName}'/>.pdf");
       			 
       			 // 이미지로 표현
       			 //document.write('<img src="'+imgData+'"/>');
       		 })
       		 
         	}
         });
    	 
    });
    </script>
</body>
</html>