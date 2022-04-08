<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.PhotoDao" %>
<%@ page import = "java.io.*" %>
<%
	// (1) 테이블 데이터 삭제 <- photoNo 필요 
	// (2) upload 폴더의 이미지 삭제 <- photoName
	
	request.setCharacterEncoding("utf-8");
	
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	//deleteGuestbookForm.jsp에서 받아온 순서값이다. 
	System.out.println(photoNo+"<-- photoNo(deletePhotoAction.jsp)");
	// 디버깅 코드
	String photoPw = request.getParameter("photoPw");
	// deleteGuestbookForm.jsp에서 받아온 패스워드값이다. 
	System.out.println(photoPw+"<-- photoPw(deletePhotoAction.jsp)");
	// 디버깅 코드

	PhotoDao photoDao = new PhotoDao();
	// PhotoDao 객체 생성 
	String photoName = photoDao.selectPhotoName(photoNo);
	// 메서드 호출 
	
	// (1) 테이블 데이터 삭제 
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	// 업데이트된 쿼리 행 반환 
	
	// (2) 폴더 이미지 삭제 
	if(delRow==1) { // 테이블 데이터 삭제 성공 
		String path = application.getRealPath("upload"); // application(현재 프로젝트)안의 upload 폴더안의 실제 폴더 경로를 
		File file = new File(path+"\\"+photoName); // 잘못 저장된 파일을 불러온다. java.io.File  
		file.delete(); // 잘못 업로드된 파일을 삭제
		// 이동 
		System.out.println("삭제 성공");
		// 디버깅 코드 
		response.sendRedirect("./photoList.jsp");
		// 성공하면 guestbookList.jsp로 간다. 
	} else {
		System.out.println("삭제 실패!");
		// 이동 
		response.sendRedirect("./deletePhotoForm.jsp?photoNo="+photoNo);
		// 실패하면 deleteGuestbookForm.jsp로 간다. 
	}
%>
