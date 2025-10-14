<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>마이페이지 목록</title>
</head>
<body>
    <h2>마이페이지 목록</h2>
  <form action="modify" method="post">

    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>닉네임</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>생년월일</th>
                <th>성별</th>
                <th>프로필 이미지</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${myPageList}">
                <tr>
                    <td>${user.member_Id}</td>
                  <td>  <input type="text" name="nickname" value="${user.nickname}">
                  </td>
                  <td>  
                  <input type="text" name="email" value="${user.email}">
                  </td>
                  <td>  
                  <input type="text" name="phone_number" value="${user.phone_number}">
                  </td>
                  <td>  
                  <input type="text" name="birthDate" value="${user.birthDate}">
             
             <td>
                        <c:choose>
                            <c:when test="${user.gender == 1}">남성</c:when>
                            <c:when test="${user.gender == 2}">여성</c:when>
                            <c:otherwise>기타</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty user.profile_image}">
                            <img src="${user.profile_image}" alt="프로필 이미지" width="50" height="50"/>
                        </c:if>
                    </td>
                    		<td>
					
                   <input type="submit" value="수정">
				</td>
                              <td>
                        <form action="delete" method="post" style="margin:0;">
                            <input type="hidden" name="member_Id" value="${user.member_Id}" />
                            <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
                  
                        </form>
                    </td>
		
		
			
          
                </tr>
            </c:forEach>
        </tbody>
        </form>
    </table>
</body>
</html>
