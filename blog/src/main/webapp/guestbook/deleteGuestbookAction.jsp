<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	//deleteGuestbookForm.jsp에서 받아온 순서값이다. 
	System.out.println(guestbookNo+"<-- guestbookNo(deleteGuestbookNo)");
	// 디버깅 코드
	String guestbookPw = request.getParameter("guestbookPw");
	// deleteGuestbookForm.jsp에서 받아온 패스워드값이다. 
	System.out.println(guestbookPw+"<-- guestbookPw(deleteGuestbookNo)");
	// 디버깅 코드
	
	GuestbookDao guestbookDao = new GuestbookDao();
	// 쿼리를 모아둔 GuestbookDao 객체를 생성 
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);
	// 필요한 쿼리를 실행하고 리턴값을 받는다. 
	
	if(row==0) { // 삭제 실패 
		System.out.println("삭제 실패");
		// 디버깅 코드
		response.sendRedirect("./deleteGuestbookForm.jsp?guestbookNo="+guestbookNo);
		// 실패하면 deleteGuestbookForm.jsp로 간다. 
	} else if(row ==1 ) { // 삭제 성공 
		System.out.println("삭제 성공");
		// 디버깅 코드 
		response.sendRedirect("./guestbookList.jsp");
		// 성공하면 guestbookList.jsp로 간다. 
	} else { // 여러행이 삭제? 뭐지? 
		System.out.println("에러...");
	}
%>
