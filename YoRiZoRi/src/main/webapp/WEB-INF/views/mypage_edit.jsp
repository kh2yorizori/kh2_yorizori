<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>마이페이지 수정</title>
</head>
<body>
    <h2>마이페이지 수정</h2>
    
    <!-- 기존 정보를 보여주기 위해서, model에서 myPage 라는 이름으로 MyPageDTO를 받는다고 가정 -->
    <form action="modify" method="post">
        <input type="hidden" name="member_Id" value="${myPageList.member_Id}" />
        ㅎㅇ
<!--         <label>비밀번호: </label> -->
<%--         <input type="password" name="password" value="${myPageList.password}" required /><br/><br/> --%>
        
<!--         <label>닉네임: </label> -->
<%--         <input type="text" name="nickname" value="${myPageList.nickname}" required /><br/><br/> --%>
        
<!--         <label>이메일: </label> -->
<%--         <input type="email" name="email" value="${myPageList.email}" required /><br/><br/> --%>
        
<!--         <label>프로필 이미지 URL: </label> -->
<%--         <input type="text" name="profile_image" value="${myPageList.profile_image}" /><br/><br/> --%>
        
<!--         <label>전화번호: </label> -->
<%--         <input type="text" name="phone_number" value="${myPageList.phone_number}" /><br/><br/> --%>
        
<!--         <label>생년월일 (YYYY-MM-DD): </label> -->
<%--         <input type="text" name="birthDate" value="${myPageList.birthDate}" placeholder="예: 1990-01-01" /><br/><br/> --%>
        
<!--         <label>성별: </label> -->
<!--         <select name="gender" required> -->
<%--             <option value="1" ${myPageList.gender == 1 ? "selected" : ""}>남성</option> --%>
<%--             <option value="2" ${myPageList.gender == 2 ? "selected" : ""}>여성</option> --%>
<!--         </select><br/><br/> -->
        
        <input type="submit" value="수정하기" />
    </form>
    
    <br/>
    <a href="list">목록으로 돌아가기</a>
</body>
</html>
