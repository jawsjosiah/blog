<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	// 한글이 깨지지 않게 하기 위한 인코딩 설정
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	// 수정할 학생 정보를 updateBoardForm.jsp에서 받아옴. 
	
	System.out.println("수정할  번호 : " + boardNo);
	System.out.println("수정할 항목 이름 : " + categoryName);
	System.out.println("수정할 제목 : " + boardTitle);
	System.out.println("수정할 내용 : " + boardContent);
	System.out.println("입력한 비밀번호 : " + boardPw);
	// 디버깅 코드 
	
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	// board 객체를 새로 생성하고 받아온 값을 저장한다  
	
	
	BoardDao boardDao = new BoardDao();
	int row = boardDao.updateBoard(board);
	
	if(row==0) {
		System.out.println("수정 실패"); 
		// 디버깅 코드 
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo=" + board.getBoardNo());
		// 수정 실패시 updateBoardForm.jsp 페이지를 벗어나지 않는다. 
	} else if(row==1) {
		System.out.println("수정 성공");
		// 디버깅 코드 
		response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo=" + board.getBoardNo());
		// 수정 성공시 boardOne.jsp 페이지로 이동한다 
	} else {
		System.out.println("에러");
		// 디버깅 코드 
	}
	
%>