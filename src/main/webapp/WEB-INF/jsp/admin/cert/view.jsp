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

<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>

<script type="text/javascript">
$(function(){
	$('.file-box .fileName').val('<c:out value="${certInfo.acEduCertFilePath}"/>');
	
	//파일올리기
	var uploadFile = $('.file-box .upload-name');
	uploadFile.on('change', function() {
	    if (window.FileReader) {
	    	if($(this)[0].files[0] == null){
	    		$(this).siblings('.fileName').val('<c:out value="${certInfo.acEduCertFilePath}"/>');
	    	} else{
	    		var filename = $(this)[0].files[0].name;
	    	}
	    } else {
	        var filename = $(this).val().split('/').pop().split('\\').pop();
	    }
	    
	    $(this).siblings('.fileName').val(filename);
	    
	});
});
</script>

<body>
    <div id="container_file">
        <div class="popup_file_find">
            <form id="fileForm" name="fileForm">
                <div class="file-box">
                    <input type="text" class="fileName input-text" value="파일이름" readonly="readonly">
                    <label for="uploadFile" class="btn btn-file">찾기</label>
                    <input type="file" id="uploadFile" name="uploadFile" class="upload-name">
                    <button type="button" id="btn_uploadFile" class="btn btn-file btn_bk">등록</button>
                    <input type="hidden" id="acEduCertInfoNo" name="acEduCertInfoNo" value="<c:out value="${certNo}"/>">
                </div>
            </form>
        </div>
        <div class="page">
            <div class="subpage_admin" id="content">
 	           <embed src="<c:out value="${pageContext.request.contextPath}/file/view/cert?certNo=${certNo}"/>" width="780" height="1100" type="application/pdf">
            </div>
        </div>
    </div>
    
    <!-- popup 03-->
    <div class="modal no_close" id="pop_cert_success">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리되었습니다.</p>
            <div class="btn-wrap">
              	<button type="button" id="btn_cert_success" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 03-->
    
    <!-- popup 04-->
    <div class="modal no_close" id="pop_cert_fail">
        <div class="popup-content">
            <p class="pop-text">정상적으로 처리하지 못했습니다. <br>관리자에게 문의해주세요.</p>
            <div class="btn-wrap">
                <button type="button" id="btn_cert_fail" class="btn2 btn-blue">확인</button>
            </div>
        </div>
    </div>
    <!-- //popup 04-->
    
    <!-- popup 10-->
    <div class="modal no_close" id="pop_uploadFile_confirm">
        <div class="popup-content">
            <p class="pop-text">해당 파일로 수료증을 등록하시겠습니까?</p>
            <div class="btn-wrap">
                <button type="button" id="btn_uploadFile_confirm" class="btn2 btn-blue">확인</button>
                <button type="button" class="btn2 b-close">닫기</button>
            </div>
        </div>
    </div>
    <!-- //popup 10-->
    
    <script>
	    <%-- 해당 파일로 수료증을 등록하시겠습니까? --%>
	    $('#btn_uploadFile').click(function(){
	    	/* $('#pop_uploadFile_confirm').bPopup({
	    		speed: 450,
	    	}); */
	    	
	    	<%-- 파일 업로드(수료증 수정) --%>
	    	if(confirm("해당 파일로 수료증을 등록하시겠습니까?")){
	    		$('#pop_uploadFile_confirm').bPopup().close();
	    		
	    		$.ajax({
	    			type: "post",
	    			enctype: "multipart/form-data",
	    			url: "<c:out value='${pageContext.request.contextPath}/file/upload/cert'/>",
	    			data: new FormData($('#fileForm')[0]),
	    			cache: false,
	    			contentType: false,
	    			processData: false,
	    			success: function(data){
	    				if(data.result > 0)		$('#pop_cert_success').bPopup();
	    				else					$('#pop_cert_fail').bPopup();
	    			},
	    			error: function(){
	    				$('#pop_cert_fail').bPopup();
	    			}
	    		});
	    	}
	    });
	    
	    <%-- 파일 업로드 성공 --%>
        $("#btn_cert_success").click(function(){
            $('#pop_cert_success').bPopup().close();
            window.parent.$('#pop_certFile').bPopup().close(); // 수료증 업로드 팝업창 닫기
            window.parent.location.href = "<c:out value='${pageContext.request.contextPath}/cert/admin/confirm'/>";
        });
        <%-- 파일 업로드 실패 --%>
        $("#btn_cert_fail").click(function(){
            $('#pop_cert_fail').bPopup().close();
        });
    </script>
</body>
</html>