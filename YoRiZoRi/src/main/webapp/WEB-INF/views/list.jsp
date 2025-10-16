<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>마이페이지 목록</title>
</head>
<body>
    <h2>마이페이지 목록</h2>

    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>닉네임</th>
                <th>이름</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>생년월일</th>
                <th>성별</th>
                <th>프로필 이미지</th>
                <th>수정</th>
                <th>내 게시물</th>
                <th>탈퇴</th>
            </tr>
        </thead>
        <tbody>
                <tr>
                    <td>${user.memberId}</td>
                    <td>${user.nickname}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>${user.phoneNumber}</td>
                    <td>${user.birthdate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.gender == 1}">남성</c:when>
                            <c:when test="${user.gender == 2}">여성</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty user.profileImage}">
                            <img src="${user.profileImage}" alt="프로필 이미지" width="50" height="50"/>
                        </c:if>
                    </td>
                    <td>
                        <button type="button" onclick="location.href='mypage_edit?memberId=${user.memberId}'">수정</button>
                    </td>
                    <td>
                        <button type="button" onclick="location.href='myrecipe'">보기</button>
                    </td>
                    <td>
                        <form action="delete" method="post" style="margin:0;">
                            <input type="hidden" name="memberId" value="${user.memberId}" />
                            <input type="submit" value="탈퇴" onclick="return confirm('정말 탈퇴하시겠습니까?');" />
                        </form>
                    </td>
                </tr>
        </tbody>
    </table>
</body>
</html>
