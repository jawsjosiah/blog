<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// boardList 페이지 실행하면 최근 10개의 목록을 보여주고 1page로 설정 
	
	int currentPage = 1;
	// 현재 페이지의 기본 값은 1페이지 
	if(request.getParameter("currentPage") != null) {
	// 이전, 다음 링크를 통해서 들어왔다면 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// 어디서 currentPage를 문자열로 받을까? 
	}
	System.out.println(currentPage+ "<-- currentPage(boardList.jsp)");
	// 디버깅 코드 
	
	//  String categoryName = request.getParameter("categoryName"); // 
	
	// 이전, 다음 링크에서 null값을 넘기는 것이 불가능해 null은 공백으로 치환해서 코드를 처리한다고 한다...
	String categoryName = "";
	if(request.getParameter("categoryName") != null) {
	// 요청받은 categoryName의 값 null이 아니면 
		categoryName = request.getParameter("categoryName");
		// 요청받은 categoryName의 값을 문자열 변수 categoryName에 저장한다. 
	}
	System.out.println(categoryName+ "<-- categoryName(boardList.jsp)");
	// 디버깅 코드 
	
	// 페이지만 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다. 
	/*
		알고리즘 
		select ... LIMIT ?,10
				
		currentPage beginRow
		1			0
		2			10
		3			20
		
		? <-- (currentPage-1)*10
	*/
	
	int rowPerPage = 10; 
	// 한 페이지당 행의 갯수 
	int beginRow = (currentPage-1)*rowPerPage;
	// 현재 페이지가 변경되면 beginRow도 바뀌어야 한다. 
	System.out.println(beginRow+ "<-- beginRow(boardList.jsp)");
	// 디버깅 코드 

	//----------------------------------------------------------------------------------------------
	
	BoardDao boardDao = new BoardDao();
	
	// categoryName, cnt 결과값을 받아온다. 
	ArrayList<HashMap<String, Object>> categoryList = boardDao.selectCategoryCount();
	
	ArrayList<Board> boardList = boardDao.selectBoardList(rowPerPage, beginRow, categoryName);
	
			
	int totalRow = boardDao.selectTotalRow(); // select count(*) from board; 
	
	int lastPage = 0;
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

</head>
<body>
	<!-- 메인 메뉴 시작-->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명(프로젝트명)을  명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	
	<div class="container p-3 text-center my-3 bg-primary text-white">
	  <h1>게시판</h1>
	  <p>목록</p>
	</div>
	
	<div class="row">
		<!-- category별 게시글 링크 메뉴 -->
		<div class="col-sm-2">
			<ul class="list-group">
				<%
					for(HashMap<String, Object> m : categoryList) {
				%>
						<li class="list-group-item list-group-item-action">
							<button type="button" class="btn btn-light ">
								<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>
									<button type="button" class="btn btn-primary">
										(<%=m.get("cnt")%>)
									</button>
								</a>
							</button>
						</li>
				<%		
					}
				%>
			</ul>
		</div>
		
		<!-- 게시글 리스트 -->
		<div class="col-sm-10">
			<h1>게시글 목록(total : <%=totalRow%>)</h1>
			
			<div >
				<button type="button" class="btn btn btn-outline-primary">
					<a href="<%=request.getContextPath() %>/board/insertBoardForm.jsp">게시글 입력</a>
				</button>
			</div>
		
		
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>categoryName</th>
						<th>boardTitle</th>
						<th>createDate</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Board b : boardList) {
					%>
							<tr>
								<td><%=b.getCategoryName()%></td>
								<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
								<td><%=b.getCreateDate()%></td>
							</tr>
					<%		
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	
	<div>
		<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
		<% 
			if(currentPage > 1) { // 현재 페이지가 1이면 이전 페이지가 존재해서는 안된다 
		%>
			<button type="button" class="btn btn btn-outline-primary">
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
			</button>
		<%
			}
		%>
		<!-- 
			전체행	마지막 페이지 ?
			10개			1 
			11~20		2
			21~30		3
			31~40		4 
			
			마지막 페이지 = 전체행 / rowPerPage  
		 -->
		 
		 		
		 
		<%
		
			if(currentPage < lastPage) {
		%>
			<button type="button" class="btn btn btn-outline-primary">
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>
			</button>
		<%		
			}
		%> 
		
	</div>
</body>
</html>