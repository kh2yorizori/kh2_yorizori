<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 수정</title>
</head>
<body>
    <h2>마이페이지 수정</h2>

    <form action="<c:url value='/modifyOk'/>" method="post">
    
        <input type="hidden" name="memberId" value="${member.memberId}" />
        
        <p><img src="<c:url value='/resources/uploads/${member.profileImage}'/>" alt="프로필 이미지" width="50" height="50"/></p>
        
        <p>닉네임: <input type="text" name="nickname" value="${member.nickname}" /></p>
        <p>이름: <input type="text" name="name" value="${member.name}" /></p>
        <p>이메일: <input type="text" name="email" value="${member.email}" /></p>
        <p>전화번호: <input type="text" name="phoneNumber" value="${member.phoneNumber}" /></p>
        
        <p>생년월일: 
            <input type="date" name="birthdate" value="<fmt:formatDate value="${member.birthdate}" pattern="yyyy-MM-dd"/>" />
        </p>
        
        <p>성별:
            <label><input type="radio" name="gender" value="1" ${member.gender == 1 ? 'checked' : ''}> 남자</label>
            <label><input type="radio" name="gender" value="2" ${member.gender == 2 ? 'checked' : ''}> 여자</label>
        </p>
        
        <input type="submit" value="수정 완료" />
    </form>
</body>
</html>