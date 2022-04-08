<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	// photoList.jsp에서 photoNo값을 넘겨받음. 
	System.out.println(pdfNo + "<-- pdfNo(pdfOne.jsp)");
	// 디버깅 코드 
	
	PdfDao pdfDao = new PdfDao();
	// dao의 pdfDao 객체 생성 
	Pdf pdf = new Pdf();
	// vo의 pdf 객체 생성 
	
	pdf = pdfDao.selectPdfOne(pdfNo);
	// 메서드 호출 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdfOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>pdf 상세보기</h1>
	<table class="table table-hover">
		<tr>
			<td>pdfNo</td>
			<td><%=pdf.pdfNo%></td>
		</tr>
		<tr>
			<td>pdfName</td>
			<td><%=pdf.pdfName%></td>
		</tr>
	</table>
</body>
</html>