<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head><meta charset="UTF-8"><title>로그인</title></head>
<body>
    <form method="post" action="${pageContext.request.contextPath}/login_yn">
        <table border="1" align="center">
            <tr>
                <td>사용자ID</td>
                <td><input type="text" name="MEMBER_ID" required></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="PASSWORD" required></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="로그인">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="color:red">
                    ${msg}
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
