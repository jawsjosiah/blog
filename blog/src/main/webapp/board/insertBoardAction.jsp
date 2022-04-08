<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "vo.Board" %>
<%@ page import = "dao.*" %>

<%
	request.setCharacterEncoding("utf-8");
	// 한글도 받을 수 있도록 인코딩 설정 
	
	String categoryName = request.getParameter("categoryName");
	// 문자열 변수 categoryName에 전달받은 categoryName값을 넣는다. 
	System.out.println(categoryName + " <-- categoryName");
	// 디버깅 코드 
	
	String boardTitle = request.getParameter("boardTitle");
	System.out.println(boardTitle + " <-- boardTitle");
	
	String boardContent = request.getParameter("boardContent");
	System.out.println(boardContent + " <-- boardContent");
	
	String boardPw = request.getParameter("boardPw");
	System.out.println(boardPw + " <-- boardPw");
	
	// 요청에서 넘겨진 값들을 가공해서 하나의 변수로 만든다. 
	Board board = new Board();
	board.categoryName = categoryName;
	board.boardTitle = boardTitle;
	board.boardContent = boardContent;
	board.boardPw = boardPw;
	
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	// 입력 작업이 끝나면 boardList.jsp 페이지로 돌아간다.  
%>