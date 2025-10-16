<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>레시피 목록 | 요리연구소</title>
<style>
    /* ====== 공통 스타일 ====== */
    body {
        font-family: "Noto Sans KR", sans-serif;
        margin: 0;
        padding: 0;
        background-color: #fffaf7;
        color: #333;
    }

    a {
        text-decoration: none;
        color: inherit;
    }

    /* ====== 헤더 ====== */
    header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 15px 60px;
        background-color: #fff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .header-left h1 {
        font-size: 1.5rem;
        color: #ff6f61;
        font-weight: 800;
        margin: 0;
        white-space: nowrap;
    }

    .header-center {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        flex: 1;
    }

    .header-center a {
        padding: 8px 14px;
        border-radius: 20px;
        font-size: 14px;
        background-color: #f3f3f3;
        transition: background-color 0.3s, color 0.3s;
        white-space: nowrap;
    }

    .header-center a:hover {
        background-color: #2e7d32;
        color: white;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 18px;
    }

    .header-right i {
        font-size: 1.3rem;
        cursor: pointer;
        color: #333;
        transition: color 0.2s ease;
    }

    .header-right i:hover {
        color: #2e7d32;
    }

    @media (max-width: 768px) {
        .header-center {
            gap: 10px;
            font-size: 13px;
        }
        header {
            padding: 10px 30px;
        }
        .header-right i {
            font-size: 1.2rem;
        }
    }

    /* ====== 레시피 카드 그리드 ====== */
	   /* ====== 레시피 카드 그리드 ====== */
		.grid-container {
		    display: grid;
		    grid-template-columns: repeat(3, 1fr); /* 3열 고정 */
		    grid-auto-rows: auto; /* 카드 높이 자동 */
		    gap: 20px;
		    max-width: 1200px;
		    margin: 40px auto;
		    padding: 0 20px;
		    /* overflow 제거 → 컨테이너가 자동으로 늘어나도록 */
		}
		
		.card {
		    background: #fff;
		    border-radius: 12px;
		    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
		    overflow: hidden;
		    display: flex;
		    flex-direction: column;
		    transition: transform 0.3s ease, box-shadow 0.3s ease;
		    cursor: pointer;
		}
		
		.card img {
		    width: 100%;
		    height: 250px; /* 고정 */
		    object-fit: cover;
		}
		
		.card-content {
		    padding: 14px 16px;
		    flex-grow: 1;
		    display: flex;
		    flex-direction: column;
		}

    .card-title {
        font-weight: 700;
        font-size: 1.1rem;
        margin-bottom: 8px;
        color: #ff6f61;
    }

    .card-info {
        font-size: 0.9rem;
        color: #555;
        margin-bottom: 4px;
    }

    .card-info strong {
        color: #333;
    }

    footer {
        text-align: center;
        padding: 20px 0;
        margin-top: 50px;
        border-top: 1px solid #eee;
        color: #888;
        font-size: 0.9rem;
    }
</style>
<!-- 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
</head>
<body>

<header>
  <div class="header-left">
    <h1>요리연구소</h1>
  </div>

  <nav class="header-center">
    <a href="home">메인화면</a>
    <a href="select_result">레시피 보기</a>
    <a href="category_view">레시피 분류</a>
    <a href="https://www.dogumaster.com/select/menu">메뉴 선택해줘</a>
    <a href="#">WOW이벤트</a>
  </nav>	

  <div class="header-right">
    <i class="bi bi-search"></i>
    <i class="bi bi-list"></i>
  </div>
</header>

<div class="grid-container">
    <c:forEach var="dto" items="${category_view}">
        <div class="card">
            <img src="${dto.mainImage}" alt="${dto.title}">
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

<footer>
    © 2025 요리연구소 | All rights reserved.
</footer>

</body>
</html>
