<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="registerOk">
			<tr height="50">
				<td colspan="2">
					<h1>회원 가입 신청</h1>
				</td>
			</tr>
			<tr height="30">
				<td>User ID</td>
				<td><input type="text" name="MEMBER_ID" required></td>
			</tr>
			<tr height="30">
				<td>이름</td>
				<td><input type="text" name="NAME" required></td>
			</tr>
			<tr height="30">
				<td>암호</td>
				<td><input type="password" name="PASSWORD" required></td>
			</tr>
			<tr height="30">
				<td>닉네임</td>
				<td><input type="text" name="NICKNAME"></td>
			</tr>
			<tr height="30">
				<td>이메일</td>
				<td><input type="email" name="EMAIL"></td>
			</tr>
			<tr height="30">
				<td>이미지</td>
				<td><input type="file" name="PROFILE_IMAGE"></td>
			</tr>
			<tr height="30">
				<td>휴대폰번호</td>
				<td><input type="text" name="PHONE_NUMBER"></td>
			</tr>
			<tr height="30">
				<td>생일</td>
				<td><input type="date" name="BIRTHDATE"></td>
			</tr>
			<tr height="30">
				<td>성별</td>
				<td>
					<label><input type="radio" name="GENDER" value=1 required> 남자</label>
					<label><input type="radio" name="GENDER" value=2> 여자</label>
				</td>
			</tr>
			<tr height="30">
				<td colspan="2" align="center">
					<input type="submit" value="등록">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>
