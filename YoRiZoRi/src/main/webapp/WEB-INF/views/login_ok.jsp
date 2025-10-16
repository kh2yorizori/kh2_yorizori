<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>

    <%-- 로그인 상태일 때 보여줄 내용 --%>
    <c:if test="${not empty sessionScope.id}">
        <h1>로그인 성공!</h1>
        <h3><strong>${sessionScope.name}</strong> (${sessionScope.id})님, 환영합니다.</h3>
        <br>
        
        <%-- [수정] 마이페이지 버튼을 로그인 성공 블록 안으로 이동 --%>
        <%-- [수정] c:url 태그로 경로를 감싸고, 파라미터 이름을 'memberId'로 통일 --%>
        <button type="button" onclick="location.href='<c:url value="/list"/>'">마이페이지</button>
        <button type="button" onclick="location.href='<c:url value="/logout"/>'">로그아웃</button>
        <button type="button" onclick="location.href='<c:url value="/"/>'">메인으로</button>
    </c:if>

    <%-- 로그아웃 상태일 때 보여줄 내용 --%>
    <c:if test="${empty sessionScope.id}">
        <h1>접근 오류</h1>
        <h3>로그인이 필요합니다.</h3>
        <br>
        <a href="<c:url value='/login'/>">로그인 페이지로 이동</a>
    </c:if>

</body>
</html>