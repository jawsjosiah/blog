<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	// updateGuestbookAction.jsp에서 guestbookNo값을 넘겨받음. 
	System.out.println(guestbookNo + "<-- guestbookNo(guestbookOne.jsp)");
	// 디버깅 코드 
	
	GuestbookDao guestbookDao = new GuestbookDao();
	// 메소드 호출을 위해서 guestbookDao 객체 생성 
	
	Guestbook guestbook = new Guestbook();
	// Guestbook 객체를 새로 생성한다. 
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
	// Guestbook 객체의 변수명 guestbook에 guestbookDao.selectGuestbookOne의 결과를 담는다. 
	// *.close 어디에 해야 하는지?
	// guestbookDao.jsp에는 주석 처리 했는데 
	// return 받기 전에 해야할 듯 ?
	// 결론은 상관 없음. 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbookOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>guestbook 상세보기</h1>
	<table>
		<tr>
			<td>guestbookNo</td>
			<td><%=guestbook.guestbookNo%></td>
		</tr>
		<tr>
			<td>guestbookContent</td>
			<td><%=guestbook.guestbookContent%></td>
		</tr>
	</table>
</body>
</html>