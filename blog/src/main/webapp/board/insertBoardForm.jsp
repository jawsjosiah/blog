<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.BoardDao" %>
<%
	BoardDao boardDao = new BoardDao();
	ArrayList<String> list = boardDao.selectCategoryName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>글 입력</h1>
	<form method="post" action="<%=request.getContextPath() %>/board/insertBoardAction.jsp">
	<!-- 프로젝트명이 바뀌어도 유연하게 대처가 가능하게 패스 설정을 한 부분이다.  -->
		<table class="table table-striped">
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<%
							for(String s : list) {
						%>
							<option value="<%=s%>"><%=s%></option>
							<!-- 동적 배열 list에 있는 값들을 문자열 변수 s에 저장하고 그 값들을 출력한다. -->
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td>
					<input type="text" name="boardTitle">
				</td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea name="boardContent" rows="5" cols="80"></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
					<input name="boardPw" type="password">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type = "submit" class="btn btn-info">board 입력</button>
					<button type="button" class="btn btn btn-outline-primary">
						<a href="<%=request.getContextPath()%>/board/boardList.jsp">목록</a>
					</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>