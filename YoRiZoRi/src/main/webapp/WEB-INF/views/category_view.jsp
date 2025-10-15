<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 	<table width="500" border="1"> -->
<!-- 		<tr> -->
<!-- 			<td>상품명</td> -->
<!-- 			<td>가격</td> -->
<!-- 			<td>설명</td> -->
<!-- 		</tr> -->
<%-- 		<c:forEach var="dto" items="${content_view}"> --%>
<!-- 			<tr> -->
<%-- 				<td>${dto.name}</td> --%>
<%-- 				<td>${dto.price}</td> --%>
<%-- 				<td>${dto.description}</td> --%>
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
<!-- 	</table> -->



<!-- 	<table width="500" border="1"> -->
<!-- 		<tr> -->
<!-- 			<td>이미지 링크</td> -->
<!-- 			<td>제목</td> -->
<!-- 			<td>작성 일자</td> -->
<!-- 			<td>조회수</td> -->
<!-- 		</tr> -->
<%-- 		<c:forEach var="dto" items="${content_view}"> --%>
<!-- 			<tr> -->
<%-- 				<td>${dto.main_image}</td> --%>
<%-- 				<td>${dto.title}</td> --%>
<%-- 				<td>${dto.created_at}</td> --%>
<%-- 				<td>${dto.hit}</td> --%>
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
<!-- 	</table> -->

	<table width="500" border="1">
		<tr>
			<td>이미지 링크</td>
			<td>제목</td>
			<td>별점</td>
			<td>조회수</td>
			<td>조리 시간</td>
			<td>요리 양</td>
			<td>난이도</td>
		</tr>
		<c:forEach var="dto" items="${category_view}">
			<tr>
				<td><img src="${dto.main_image}" alt="Image" width="150" height="100"></td>
				<td>${dto.title}</td>
				<td>${dto.rating}</td>
				<td>${dto.hit}</td>
				<td>${dto.created_at}</td>
				<td>${dto.serving_size}</td>
				<td>${dto.difficulty}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>