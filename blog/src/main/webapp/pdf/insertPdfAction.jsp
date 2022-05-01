<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
//insertPhotoAction.jsp

	/*
	form태그의 enctype="multipart/form-data"로 넘겨져서 request.getParameter() API를 사용할 수 없다. 		
	String writer = request.getParameter("writer");
	System.out.println(writer);
	request.getParameter() API 대신 다른 API를 사용해야 하는데 너무 복잡--
	--> request를 단순하게 사용하게 해주는 cos.jar같은 API(외부라이브리)를 사용하자.
	*/

	request.setCharacterEncoding("utf-8");
	// DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();
	String path = application.getRealPath("upload"); // application변수 톰켓을 가르키는 변수
	// System.out.println(path); 
	

	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	// 2^10 byte = 1 kbyte 1024 byte = 1 kbte
	// 2^10 kbyte = 1 mbyte
	// 100 mbyte = 1024*1024*100 byte = 104857600 byte 곱셈을 계산해서 코딩하면 가독성이 떨어진다.  ex) 24*60*60 하루에 대한 초
	// 1번째 매개 변수 request, 2번째 매개 변수 path 각각 어떤 의미일지? 
	String pdfPw = multiReq.getParameter("pdfPw");
	String writer = multiReq.getParameter("writer");
	
	// input type="file" name="photo" 
	String pdfOriginalName = multiReq.getOriginalFileName("pdf"); // 파일 업로드시 원본의 이름
	String pdfName = multiReq.getFilesystemName("pdf"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String pdfType = multiReq.getContentType("pdf");
	
	System.out.println(pdfPw + " <-- pdfPw");
	System.out.println(writer + " <-- writer");
	System.out.println(pdfOriginalName + " <-- pdfOriginalName");
	System.out.println(pdfName + " <-- pdfName");
	System.out.println(pdfType + " <-- pdfType");
	// 디버깅 코드 
	
	// 파일업로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpeg 3가지 이미지만  허용
	if(pdfType.equals("application/pdf")) {
	// 구글링 해봐야 함. 
		System.out.println("db 고고!");
		PdfDao pdfDao = new PdfDao();
		Pdf pdf = new Pdf();
		pdf.setPdfName(pdfName);
		pdf.setPdfOriginalName(pdfOriginalName);
		pdf.setPdfType(pdfType);
		pdf.setPdfPw(pdfPw);
		pdf.setWriter(writer);
		
		pdfDao.insertPdf(pdf); // 메서드 구현
		
		response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");
	} else {
		System.out.println("pdf 파일만 업로드!");
		// 잘못들어온 파일이므로 업로드된 파일 지우고 폼으로...이동
		File file = new File(path+"\\"+pdfName); // 잘못 저장된 파일을 불러온다. java.io.File  
		file.delete(); // 잘못 업로드된 파일을 삭제
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp");
	}
%>
