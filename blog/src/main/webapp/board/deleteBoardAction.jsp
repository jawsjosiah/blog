<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// deleteBoardForm.jsp에서 넘겨받은 boardNo값이다. 
	System.out.println(boardNo + "<-- boardNo(deleteBoardAction.jsp)");
	// 디버깅 코드 
	String boardPw = request.getParameter("boardPw");
	// deleteBoardForm.jsp에서 넘겨받은 boardPw값이다. 
	System.out.println(boardPw + "<-- boardPw(deleteBoardAction.jsp)");
	// 디버깅 코드 
	
	Board board = new Board();
	board.boardNo = boardNo;
	board.boardPw = boardPw;
	// Board 객체 생성 
	
	BoardDao boardDao = new BoardDao();
	// BoardDao 겍체 생성 
	int row = boardDao.deleteBoard(board.boardNo, board.boardPw);
	// 게시판 삭제하는 메서드 호출 
	
	if(row==0) { // 삭제 실패 
		System.out.println("삭제 실패");
		// 디버깅 코드
		response.sendRedirect("./deleteBoardForm.jsp?boardNo="+board.boardNo);
	} else if(row ==1 ) { // 삭제 성공 
		System.out.println("삭제 성공");
		// 디버깅 코드 
		response.sendRedirect("./boardList.jsp");
	} else { // 여러행이 삭제? 뭐지? 
		System.out.println("에러...");
	}
		
%>