<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>마이페이지 수정</title>
</head>
<body>
<h2>마이페이지 수정</h2>
<!--    <p> -->
<%--   <img src="/images/${user.profile_image}" alt="프로필 이미지" style="width:150px; height:150px; cursor:pointer;" id="profileImg" /> --%>
<!-- </p> -->
<form action="modify" method="post">
    <input type="hidden" name="member_Id" value="${user.member_Id}" />
	
   <p><input type="text" name="profile_image" value="${user.profile_image}" /></p>
    <p>닉네임: <input type="text" name="nickname" value="${user.nickname}" /></p>
    <p>이름: <input type="text" name="name" value="${user.name}" /></p>
    <p>이메일: <input type="text" name="email" value="${user.email}" /></p>
    <p>전화번호: <input type="text" name="phone_number" value="${user.phone_number}" /></p>
    <p>생년월일: <input type="date" name="birthDate" value="${user.birthDate}" /></p>
			<tr height="30">
				<td>성별</td>
				<td>
					<label><input type="radio" name="gender" value=1 required> 남자</label>
					<label><input type="radio" name="gender" value=2> 여자</label>
				</td>
			</tr>

			<tr height="30">
				<td>이미지</td>
				
<!-- 				<td><input type="file" name="PROFILE_IMAGE"></td> -->
			</tr>
			
    <input type="submit" value="수정" />
</form>
</body>
</html>