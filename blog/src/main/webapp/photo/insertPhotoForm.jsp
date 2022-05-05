<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPhotoForm.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1>이미지 등록</h1>
	<!-- 
		(1) form 태그안에 값을 넘기는 기본값(enctype속성)은 문자열이다. 
		(2) 파일을 넘길 수 없다. 기본값(application/x-www-form-urlencoded)을 변경해야 한다.  
		(3) 기본값 "multipart/form-data"로 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다. 
		(4) 같은 폼안에 모든 값이 바이너리로 넘어간다. 글자를 넘겨받는 request.getParameter()를 사용할 수 없다.
		(5) 복잡한 코드를 통해서만 바이너리 내용을 넘겨 받을 수 있다. 
		(6) 외부 라이브러리(cos.jar)를 사용해서 복잡한 코드를 간단하게 구현하자.  -> 역할?
		-->
	<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<td>이미지파일</td>
				<td><input type="file" name="photo"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="photoPw"></td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-info">이미지 등록</button>
		<button type="button" class="btn btn-outline-primary">
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp">목록</a>
		</button>
	</form>
</body>
</html>