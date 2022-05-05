<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	// photoList.jsp에서 photoNo값을 넘겨받음. 
	System.out.println(photoNo + "<-- photoNo(guestbookOne.jsp)");
	// 디버깅 코드 
	
	PhotoDao photoDao = new PhotoDao();
	// PhotoDao 객체 새로 생성 
	Photo photo = new Photo();
	// vo의 Photo 새로운 객체 생성 
	photo = photoDao.selectPhotoOne(photoNo);
	// 메서드 호출. 자세하게 보려면  ctrl + 마우스 좌클릭 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>photo 상세보기</h1>
	<table class="table table-bordered">
		<tr>
			<td>photoNo</td>
			<td><%=photo.getPhotoNo()%></td>
		</tr>
		<tr>
			<td>photoName</td>
			<td><%=photo.getPhotoName()%></td>
		</tr>
	</table>
	<button type="button" class="btn btn-outline-primary">
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp">목록</a>
	</button>
</body>
</html>