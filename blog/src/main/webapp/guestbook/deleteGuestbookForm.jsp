<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	// guestbookList.jsp에서 guestbookNo값을 받는다. 
	System.out.println(guestbookNo+" <-- guestbookNo(deleteGuestbookForm.jsp)");
	// 디버깅 코드 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>글 삭제</h1>
	
	<form method="post" action="<%=request.getContextPath() %>/guestbook/deleteGuestbookAction.jsp">
			글 번호 :
			<input type="text" name="guestbookNo" readonly="readonly" value="<%=guestbookNo %>">
		
		<div>
			비밀번호 : 
			<input type="password" name="guestbookPw">
		</div>
		
		<div>
			<button type="submit" class="btn btn-info">삭제</button>
			<button type="button" class="btn btn-outline-primary">
				<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">목록</a>
			</button>
		</div>
		
		<!-- name="*"에서 *의 값을 넘긴다. -->
	</form>
</body>
</html>