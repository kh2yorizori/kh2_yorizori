<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>레시피 목록</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #fafafa;
        padding: 2rem;
    }

    .grid-container {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        overflow: hidden;
        display: flex;
        flex-direction: column;
        transition: transform 0.2s ease;
        cursor: pointer;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .card img {
        width: 100%;
        height: 140px;
        object-fit: cover;
    }

    .card-content {
        padding: 12px 16px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .card-title {
        font-weight: 700;
        font-size: 1.1rem;
        margin-bottom: 8px;
        color: #333;
    }

    .card-info {
        font-size: 0.9rem;
        color: #555;
        margin-bottom: 4px;
    }

    .card-info strong {
        color: #000;
    }
</style>
</head>
<body>

<div class="grid-container">
    <c:forEach var="dto" items="${category_view}">
        <div class="card">
            <img src="${dto.main_image}" alt="${dto.title}">
            <div class="card-content">
                <div class="card-title">${dto.title}</div>
                <div class="card-info"><strong>별점:</strong> ${dto.rating}</div>
                <div class="card-info"><strong>조회수:</strong> ${dto.hit}</div>
                <div class="card-info"><strong>조리 시간:</strong> ${dto.created_at}</div>
                <div class="card-info"><strong>요리 양:</strong> ${dto.serving_size}</div>
                <div class="card-info"><strong>난이도:</strong> ${dto.difficulty}</div>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>
