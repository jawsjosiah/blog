<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// boardOne.jsp에서 넘겨받은 boardNo값이다. 
	System.out.println(boardNo +" <-- deleteBoardForm.jsp");
	// 디버깅 코드 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>글 삭제</h1>
	<!-- 
		boardNo를 사용자가 수정하지 못하도록 하는 방법 
		1) action="./deleteBoardAction.jsp?boardNo=값   
		2) input type="hidden" name="boardNo" value=값
		3) input type="text" name="boardNo" readonly="readonly" value=값
	 -->
	<form method="post" action="<%=request.getContextPath() %>/board/deleteBoardAction.jsp">
		<div class="p-2">
				글 번호 : 
				<input type="text" name="boardNo" readonly="readonly" value="<%=boardNo %>">
		
			<div>
				비밀번호 : 
				<input type="password" name="boardPw">
			</div>
			
			<div>
				<button type="submit" class="btn btn-info">삭제</button>
				<button type="button" class="btn btn btn-outline-primary">
					<a href="<%=request.getContextPath()%>/board/boardList.jsp">목록</a>
				</button>
			</div>
		</div>
		
	</form>
</body>
</html>