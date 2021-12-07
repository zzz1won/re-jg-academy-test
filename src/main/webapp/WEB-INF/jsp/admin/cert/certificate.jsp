<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="kr.disable.jugd.academy.domain.CertVO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	FileInputStream fis = null;
	BufferedOutputStream bos = null;
	 
	try{
		CertVO certInfo = (CertVO) request.getAttribute("certInfo");
		String filePath = (String) request.getAttribute("filePath");
	    File file = new File(filePath);
	    
	    // 보여주기
	    response.setContentType("application/pdf");
	    response.setHeader("Content-Description", "JSP Generated Data");
	    // 다운로드
	    //response.addHeader("Content-Disposition", "attachment; filename = " + file.getName() + ".pdf");
	 
	    fis = new FileInputStream(file);
	    int size = fis.available();
	    
	    byte[] buf = new byte[size];
	    int readCount = fis.read(buf);
	 
	    response.flushBuffer();
	    
	    // getOutpuStream() 충돌 방지
	    out.clear();
	    out = pageContext.pushBody();
	 
	    bos = new BufferedOutputStream(response.getOutputStream());
	    bos.write(buf, 0, readCount);
	    bos.flush();
	} catch(Exception e) {
	    response.setContentType("text/html;charset=utf-8");
	    out.println("<script type='text/javascript'>");
	    out.println("alert('미리보기 중 오류가 발생하였습니다.');");
	    out.println("</script>");
	    //e.printStackTrace();
	} finally{
	    try{
	        if(fis != null) fis.close();
	        if(bos != null) bos.close();
	    } catch(IOException e){
	       //e.printStackTrace();
	    }    
	}
%>

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
<body>
</body>
</html>