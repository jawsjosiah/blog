<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	// 한글도 받겠다 

	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	// updateGuestbookForm.jsp에서 이런 값들을 받아온다. 
	
	System.out.println("수정할  번호(updateGuestbookAction.jsp) : " + guestbookNo);
	System.out.println("수정할 내용(updateGuestbookAction.jsp) : " + guestbookContent);
	System.out.println("입력한 비밀번호(updateGuestbookAction.jsp) : " + guestbookPw);
	// 디버깅 코드 
	
	Guestbook guestbook = new Guestbook();
	// 위에서 받아온 값들(No,Content,Pw)을 담기위해 Guestbook 객체 하나 생성 
	guestbook.guestbookNo = guestbookNo;
	guestbook.guestbookContent = guestbookContent;
	guestbook.guestbookPw = guestbookPw;
	// 객체에 담는다. 
		
	GuestbookDao guestbookDao = new GuestbookDao();
	// 메소드 호출을 위해 객체 생성 
	
	int row = guestbookDao.updateGuestbook(guestbook);
	// 리턴값 담을 변수 row 만든다. 
	
	if(row==0) {
		System.out.println("수정 실패"); 
		// 디버깅 코드 
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo=" + guestbookNo);
		// 수정 실패시 updateGuestbookForm.jsp 페이지를 벗어나지 않는다. 
		// 경로 유의해서 보자. 
	} else if(row==1) {
		System.out.println("수정 성공");
		// 디버깅 코드 
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookOne.jsp?guestbookNo=" + guestbookNo);
		// 수정 성공시 guestbookOne.jsp 페이지로 이동한다 
	} else {
		System.out.println("에러");
		// 디버깅 코드 
	}
	
	
	
%>
