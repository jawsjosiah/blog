<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "dao.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
 	// boardList.jsp에서 넘어온 boardNo값을 받아서 정수형 변수 boardNo에 저장한다. 
	System.out.println(boardNo + "<-- boardNo");
	// 디버깅 코드 
	
	BoardDao boardDao = new BoardDao();
	// boardDao 객체 생성 
	ArrayList<HashMap<String, Object>> categoryList = boardDao.selectCategoryCount();
	// categoryName과 총 갯수를 가져오는 메서드 호출 
	// -----------------------------------------------
	/*
	
	*/
	Board board = boardDao.selectBoardOne2(boardNo);
	// boardOne을 다른 조건으로 보는 메서드 호출 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="col-sm-2">
		<ul class="list-group">
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					<li class="list-group-item list-group-item-action">
						<button type="button" class="btn btn-light ">
							<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>
								<button type="button" class="btn btn-primary">
									(<%=m.get("cnt")%>)
								</button>
							</a>
						</button>
					</li>
			<%		
				}
			%>
		</ul>
	</div>
	
	<h1>board 상세보기</h1>
	<table class="table table-striped">
		<tr>
			<td>boardNo</td>
			<td><%= board.getBoardNo()%></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td><%= board.getCategoryName()%></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td><%= board.getBoardTitle()%></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td><%= board.getBoardContent()%></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%= board.getCreateDate()%></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%= board.getUpdateDate()%></td>
		</tr>
	</table>
	 <div>
	 	<button type="button" class="btn btn btn-outline-primary">
			<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>">수정</a>
		</button>
		<button type="button" class="btn btn btn-outline-primary">
			<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo() %>">삭제</a>
		</button>
    </div>
</body>
</html>