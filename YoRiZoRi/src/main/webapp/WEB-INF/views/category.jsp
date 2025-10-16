<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>레시피 분류</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #fefefe;
        color: #333;
        padding: 2rem;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 80vh;
    }

    form#categoryForm {
        background-color: #fff;
        padding: 2rem 3rem;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        max-width: 450px;
        width: 100%;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    td {
        padding: 12px 8px;
        vertical-align: middle;
        font-weight: 600;
        font-size: 1.1rem;
    }

    td:nth-child(2) {
        font-weight: 400;
        font-size: 1rem;
    }

    input[type="checkbox"],
    input[type="radio"] {
        margin-right: 8px;
        transform: scale(1.2);
        cursor: pointer;
    }

    /* 각 카테고리와 라디오 항목 간격 */
    td:nth-child(2) > input {
        margin-right: 15px;
        margin-left: 5px;
    }

    /* 버튼 스타일 */
    input[type="submit"],
    input[type="reset"] {
        background-color: #ff6f61;
        border: none;
        color: white;
        font-weight: 700;
        font-size: 1rem;
        padding: 10px 25px;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin: 0 10px;
        min-width: 90px;
    }
    input[type="submit"]:hover,
    input[type="reset"]:hover {
        background-color: #e85c4c;
    }

    /* 가운데 정렬 */
    td[colspan="2"] {
        text-align: center;
        padding-top: 20px;
    }
</style>
</head>
<body>

<form method="post" action="select_result" id="categoryForm">
    <table>
        <tr>
            <td>카테고리</td>
            <td>
                <label><input type="checkbox" name="category" value="1">한식</label>
                <label><input type="checkbox" name="category" value="2">중식</label>
                <label><input type="checkbox" name="category" value="3">양식</label>
                <label><input type="checkbox" name="category" value="4">일식</label>
                <label><input type="checkbox" name="category" value="5">디저트</label>
            </td>
        </tr>
        <tr>
            <td>정렬 방법</td>
            <td>
                <label><input type="radio" name="order" value="hit" id="hitRadio" checked>인기순</label>
                <label><input type="radio" name="order" value="rating" id="ratingRadio">평점순</label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="전송">
                <input type="reset" value="취소">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
