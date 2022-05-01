<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
 	// boardOne.jsp에서 넘겨받은 boardNo 값 저장 
	System.out.println(boardNo+" <-- boardNO");
	// 디버깅 코드 
	
	BoardDao boardDao = new BoardDao();
	// BoardDao 객체 생성 
	ArrayList<String> categoryList = boardDao.selectCategoryName();	
	// categoryName을 가져오는 메서드 호출 
	
	Board board = boardDao.selectBoardOne(boardNo);
	// 메서드 호출 
	//----------------------------------------------------------------------------------------------
		
	//----------------------------------------------------------------------------------------------
	
	/*
		UDATE board SET
			category_name = ?,
			board_title = ?,
			board_content = ?,
			update_date = NOW()
		WHERE board_no = ? AND board_pw = ?
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
	<!-- 유연하게 경로 설정 -->
		<table class="table table-bordered">
			<tr>
				<td>boardNo</td>
				<td><input type="text" name="boardNo" value="<%=board.setBoardNo(boardNo)%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<%
							for(String s : categoryList) { 
							// foreach문을 사용하는데 
								if(s.equals(board.getCategoryName())) {
								// 문자열 s가 board.categoryName과 같다면 
						%>
									<option selected="selected" value="<%=s%>"><%=s%></option>
						<%
								} else {
								// 다르다면 
						%>
									<option value="<%=s%>"><%=s%></option>
						<%		
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea>
				</td>
			<tr>	
				<td>boardPw</td>
				<td><input type="password" name="boardPw" value=""></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-info">수정</button>
	</form>
</body>
</html>