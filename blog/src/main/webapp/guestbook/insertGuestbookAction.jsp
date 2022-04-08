<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Guestbook"%>
<%@ page import = "dao.GuestbookDao" %>
<%
	request.setCharacterEncoding("utf-8");
	// 인코딩 설정 

	String guestbookContent = request.getParameter("guestbookContent");
	// 문자열 변수 guestbookContent에 전달받은 guestbookContent값을 넣는다. 
	System.out.println(guestbookContent+ "<-- guestbookContent(insertGuestbookAction.jsp)");
	// 디버깅 코드 
	
	String writer = request.getParameter("writer");
	// 문자열 변수 writer에 전달받은 writer값을 넣는다.
	System.out.println(writer+ "<-- writer(insertGuestbookAction.jsp)");
	// 디버깅 코드 
	
	String guestbookPw = request.getParameter("guestbookPw");
	// 문자열 변수 guestbookPw 전달받은 guestbookPw 넣는다.
	System.out.println(guestbookPw+ "<-- guestbookPw(insertGuestbookAction.jsp)");
	// 디버깅 코드 
	
	// 요청에서 넘겨진 값들을 가공해서 하나의 변수로 만든다. 
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookContent = guestbookContent;
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	
	
	GuestbookDao guestbookDao = new GuestbookDao();
	// GuestbookDao의 객체 guestbookDao 생성
	guestbookDao.insertGuestbook(guestbook);
	// GuestbookDao클래스의 메소드 호출 
	// void 타입이면 리턴 타입 있는 메소드처럼 값을 받는 변수 안써도 되는지? 
	
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	// 입력 작업이 끝나면 guestbookList.jsp 페이지로 돌아간다.  
%>
