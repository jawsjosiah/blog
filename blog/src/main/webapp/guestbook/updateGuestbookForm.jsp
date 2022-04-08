<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	// guestbookList.jsp 페이지에서 넘긴 guestbookNo값 받는다. 
	System.out.println(guestbookNo+ "<-- guestbookNo(updateGuestbookForm.jsp)");
	// 디버깅 코드 
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
	<table class="table table-hover">
			<tr>
				<td>guestbookNo</td>
				<td><input type="text" name="guestbookNo" value="<%=guestbookNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>guestbookContent</td>
				<td>
					<textarea rows="5" cols="50" name="guestbookContent"></textarea>
				</td>
			</tr>
			<tr>	
				<td>guestbookPw</td>
				<td><input type="password" name="guestbookPw" value=""></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-info">수정</button>
	</form>
</body>
</html>