<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="select_result" id="categoryForm">
    <table>
        <tr>
            <td>카테고리</td>
            <td>
                <input type="checkbox" name="category" value="1"> 한식
                <input type="checkbox" name="category" value="2"> 중식
                <input type="checkbox" name="category" value="3"> 양식
                <input type="checkbox" name="category" value="4"> 일식
                <input type="checkbox" name="category" value="5"> 디저트
            </td>
        </tr>
        <tr>
            <td>정렬 방법</td>
            <td>
                <input type="radio" name="order" value="hit" id="hitRadio" checked> 인기순
                <input type="radio" name="order" value="rating" id="ratingRadio"> 평점순
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="전송">
                <input type="reset" value="취소">
            </td>
        </tr>
    </table>
</form>
</body>
</html>