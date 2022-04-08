<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
	int currentPage = 1;
	// 현재 페이지를 1로 초기화 
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 이전, 다음 버튼으로 currentPage 변수가 바뀌면 바뀐값으로 대체 
	
	int rowPerPage = 5;
	// 페이지당 보여줄 행의 갯수 5개 
	int beginRow = (currentPage-1)*rowPerPage;
	// 시작 행 알고리즘 
	
	GuestbookDao guestbookDao = new GuestbookDao();
	// GuestbookDao 객체 생성 
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	// 메서드 호출 
	
	int lastPage = 0;
	// 마지막 페이지 0으로 초기화 
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	// 행의 총 갯수 구하기 
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
	// 마지막 페이지 알고리즘 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 시작-->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명(프로젝트명)을  명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<ul></ul>

<% 
	for(Guestbook g : list) {
%>
		<table class = "table table-striped table-hover">
			<tr>
				<td><%=g.writer%></td>
				<td><%=g.createDate%></td>
			</tr>
			<tr>
				<td colspan="2"><%=g.guestbookContent%></td>
			</tr>
		</table>
		
		<div>
			<button type="button" class="btn btn btn-outline-primary">
				<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">수정</a>
			</button>
			<button type="button" class="btn btn btn-outline-primary">
				<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">삭제</a>
			</button>
		</div>
		<ul></ul>
<%	
	}
	
	if(currentPage > 1) {
%>
	<button type="button" class="btn btn-outline-info ">
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
	</button>
<%		
	}
	
	if(currentPage < lastPage) {
%>
	<button type="button" class="btn btn-outline-info ">
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
	</button>
<%
	}
%>
	
	<!-- 방명록 입력 -->
	<h2>글입력</h2>
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
		<table class="table table-bordered">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>
			</tr>
			<tr>
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-outline-info">입력</button>
	</form>
	
</body>
</html>
