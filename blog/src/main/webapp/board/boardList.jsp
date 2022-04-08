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
	Class.forName("org.mariadb.jdbc.Driver");
	// 마리아 DB 드라이버 로딩 
	System.out.println("드라이버 로딩 성공(boardList.jsp)");
	// 디버깅 코드 
	
	Connection conn = null;
	// DB와 연결하는 객체 선언 
	String dburl = "jdbc:mariadb://localhost:3307/blog";
	// 연결하려는 DB의 IP 주소를 문자열 변수에 저장 
	String dbuser = "root";
	// 연결하려는 DB의 아이디를 문자열 변수에 저장 
	String dbpw = "java1234";
	// 연결하려는 DB의 패스워드를 문자열 변수에 저장 
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	// DB에 연결
	System.out.println(conn + " <-- conn(boardList.jsp)");
	// 디버깅 코드
	
	/*
		SELECT category_name categoryName, COUNT(*) cnt
		FROM board
		GROUP BY category_name
	*/
	
	String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	// 카테고리 이름과 총합을 board테이블에서 가져오는데 카테고리 이름으로 묶어서 가져온다. 
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	// 쿼리를 실행하기 위해 쿼리를 적절한 타입에 저장한다. 
	ResultSet categoryRs = categoryStmt.executeQuery();
	// 쿼리를 실행한다. 실행한 결과는 테이블 형태의 변수에 저장한다. 
	
	// 쿼리 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	// ... 
	while(categoryRs.next()) {
	// 테이블 형태의 변수를 한줄씩 읽는다. 값이 있으면 반복문 게속 진행한다. 
		HashMap<String, Object> map = new HashMap<String, Object>();
		// ... 
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	
	// boardList
	String boardSql = null;
	// 쿼리를 저장할 문자열 변수 선언 후 null로 초기화 
	PreparedStatement boardStmt = null;
	// 쿼리를 저장할 문자열 변수 선언 후 null로 초기화 
	if(categoryName.equals("")) { 
	// categoryName이 null값인 경우 
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		// 생성일 컬럼을 기준으로 오름차순 정렬 
		boardStmt = conn.prepareStatement(boardSql);
		// 불러온 쿼리문 저장 
		boardStmt.setInt(1, beginRow);
		boardStmt.setInt(2, rowPerPage);
	} else {
	// categoryName이 null 아닌 경우 
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
		// categoryName의 값에 해당하는 쿼리문 불러오기 
		boardStmt = conn.prepareStatement(boardSql);
		// 불러온 쿼리문 저장 
		boardStmt.setString(1, categoryName);
		// ?에 들어가는 값 대입 
		boardStmt.setInt(2, beginRow);
		boardStmt.setInt(3, rowPerPage);
	}
	ResultSet boardRs = boardStmt.executeQuery();
	// 실행한 쿼리를 테이블 형태 변수에 저장 
	ArrayList<Board> boardList = new ArrayList<Board>();
	// vo 동적 배열 생성 
	while(boardRs.next()) {
	// 한줄씩 읽는다 
		Board b = new Board();
		b.boardNo = boardRs.getInt("boardNo");
		b.categoryName = boardRs.getString("categoryName");
		b.boardTitle = boardRs.getString("boardTitle");
		b.createDate = boardRs.getString("createDate");
		// 쿼리에서 읽어온 값을 vo 객체가 가진 변수에 저장 
		boardList.add(b);
	}
	// 윗 부분은 페이징하기가 애매하지 않나? 
			
	int totalRow = 0; // select count(*) from board; 
	String totalRowSql = "select count(*) cnt from board";
	PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql); 
	ResultSet totalRowRs = totalRowStmt.executeQuery();
	if(totalRowRs.next()) {
		totalRow = totalRowRs.getInt("cnt");
		System.out.println(totalRow+" <-- totalRow(1000)");
	}
	
	int lastPage = 0;
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
	
	// 행의 총 갯수는 나눌만 할 것 같기는 한데 
	conn.close();
	// DB와 연결 종료 
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
	<h1>게시글 목록(total : <%=totalRow%>)</h1>
	
	<div class="col-sm-2">
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
						<td><%=b.categoryName%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>"><%=b.boardTitle%></a></td>
						<td><%=b.createDate%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	
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