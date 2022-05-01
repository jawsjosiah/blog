<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int currentPage = 1;
	// 현재 페이지 설정 
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 이전, 다음을 통해 값이 오면 그 값으로 바꾼다. 
	
	int beginRow = 0;
	// 시작 행 초기화 
	int rowPerPage = 10;
	// 페이지당 보여줄 행의 갯수 
	
	PdfDao pdfDao = new PdfDao(); 
	// PdfDao 객체 생성 
	ArrayList<Pdf> list = pdfDao.selectPdfListByPage(beginRow, rowPerPage);
	// 메서드 호출 
	
	int lastPage = 0;
	int totalCount = pdfDao.selectPdfTotalRow();
	// 총 행의 갯수를 반환하는 메서드 호출 
	
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 마지막 페이지 알고리즘 구현 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdfList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명(프로젝트명)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<ul></ul>
	
	<h1>자료 목록</h1>
	<table class="table">
		<%
			for(Pdf p : list) {
		%>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/pdf/pdfOne.jsp?pdfNo=<%=p.getPdfNo()%>"><%=p.getPdfName()%>
							
						</a>
					</td>
				</tr>
				
				
			</table>
			
			<button class="btn btn btn-outline-primary">
				<div>
					<a href="<%=request.getContextPath()%>/pdf/deletePdfForm.jsp?pdfNo=<%=p.getPdfNo()%>">삭제</a>
				</div>
			</button>
		<%
			}
		%>
			<button class="btn btn btn-outline-primary">
				<div>
					<a href="<%=request.getContextPath()%>/pdf/insertPdfForm.jsp?">삽입</a>
					<!-- 이미지 있어야만 버튼 나오도록 만들었는데 나중에 수정해야함.  -->
				</div>
			</button>
		<%
			if(currentPage > 1) {
				
		%>
				<button class="btn btn btn-outline-primary">
					<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				</button>
		<%		
			}
			
			if(currentPage < lastPage) { 
		%>
				<button class="btn btn btn-outline-primary">
					<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				</button>
		<%
			}
		%>
</body>
</html>