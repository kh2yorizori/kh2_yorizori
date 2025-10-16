<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSTL의 core 라이브러리를 사용하기 위해 선언합니다. (prefix="c") --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>
    <%-- 
        c:if 태그를 사용하여 세션에 id가 있는지(로그인 상태인지) 확인합니다.
        EL(Expression Language)인 ${}를 사용하여 sessionScope에 저장된 값에 접근합니다.
        test="${not empty sessionScope.id}" : 세션에 저장된 id가 비어있지 않다면 (true)
    --%>
    <c:if test="${not empty sessionScope.id}">
        <h1>로그인 성공!</h1>
        <%-- 세션에 저장된 이름과 아이디를 화면에 출력합니다. --%>
        <h3><strong>${sessionScope.name}</strong> (${sessionScope.id})님, 환영합니다.</h3>
        <br>
        <a href="logout">로그아웃</a>
    </c:if>

    <%-- 
        만약 로그인을 하지 않고 이 페이지에 직접 접근한 경우를 대비한 코드입니다.
        test="${empty sessionScope.id}" : 세션에 저장된 id가 비어있다면 (true)
    --%>
    <c:if test="${empty sessionScope.id}">
        <h1>접근 오류</h1>
        <h3>로그인이 필요합니다.</h3>
        <br>
        <a href="login">로그인 페이지로 이동</a>
    </c:if>
    
    <td><button type="button" onclick="location.href='list?member_Id=${sessionScope.id}'">마이페이지</button></td>

		

</body>
</html>