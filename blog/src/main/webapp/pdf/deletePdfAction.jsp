<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.PdfDao" %>
<%@ page import = "java.io.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	//deletePdfForm.jsp에서 받아온 순서값이다. 
	System.out.println(pdfNo+"<-- pdfNo(deletePdfAction.jsp)");
	// 디버깅 코드
	String pdfPw = request.getParameter("pdfPw");
	// deletePdfForm.jsp에서 받아온 패스워드값이다. 
	System.out.println(pdfPw+"<-- pdfPw(deletePdfAction.jsp)");
	// 디버깅 코드
	
	PdfDao pdfDao = new PdfDao();
	// 쿼리를 모아둔 GuestbookDao 객체를 생성 
	String pdfName = pdfDao.selectPdfName(pdfNo);
	// upload 디렉토리의 pdf 파일을 지우기 위해 사용 
	
	int row = pdfDao.deletePdf(pdfNo, pdfPw);
	// 필요한 쿼리를 실행하고 리턴값을 받는다. 
	
	if(row==0) { // 삭제 실패 
		System.out.println("삭제 실패");
		// 디버깅 코드
		response.sendRedirect("./deletePdfForm.jsp?pdfNo="+pdfNo);
		// 실패하면 deletePdfForm.jsp로 간다. 
	} else if(row ==1 ) { // 삭제 성공 
		String path = application.getRealPath("upload"); // application(현재 프로젝트)안의 upload 폴더안의 실제 폴더 경로를 
		System.out.println(path+"<--path");
		// 디버깅 코드 
		File file = new File(path+"\\"+pdfName); // 잘못 저장된 파일을 불러온다. java.io.File  
		file.delete(); // 잘못 업로드된 파일을 삭제
		System.out.println("삭제 성공");
		// 디버깅 코드 
		response.sendRedirect("./pdfList.jsp");
		// 성공하면 pdfList.jsp로 간다. 
	} else { // 여러행이 삭제? 뭐지? 
		System.out.println("에러...");
	}
%>
