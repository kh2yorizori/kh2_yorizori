<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>요리조리 - 세상의 모든 레시피</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <style>
        /* ====== 기본 스타일 ====== */
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fffaf7;
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        /* ====== 헤더 (기존과 동일) ====== */
        header {
            display: flex; align-items: center; justify-content: space-between;
            padding: 15px 60px; background-color: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            position: sticky; top: 0; z-index: 1000;
        }
        .header-left h1 {
            font-size: 1.5rem; color: #ff6f61; font-weight: 800; margin: 0; white-space: nowrap;
        }
        .header-center {
            display: flex; justify-content: center; align-items: center;
            flex-wrap: wrap; gap: 15px; flex: 1;
        }
        .header-center a {
            padding: 8px 14px; border-radius: 20px; font-size: 14px; background-color: #f3f3f3;
            transition: background-color 0.3s, color 0.3s; white-space: nowrap;
        }
        .header-center a:hover { background-color: #2e7d32; color: white; }
        .header-right { display: flex; align-items: center; gap: 18px; }
        .header-right i {
            font-size: 1.5rem; cursor: pointer; color: #333; transition: color 0.2s ease;
        }
        .header-right i:hover { color: #2e7d32; }
        .search-box { display: flex; align-items: center; }
        .search-input {
            width: 0; padding: 0; border: none; outline: none; opacity: 0; transition: all 0.4s ease;
            border-bottom: 2px solid transparent; font-size: 14px;
        }
        .search-box.active .search-input {
            width: 150px; opacity: 1; padding: 5px; border-bottom: 2px solid #333; margin-right: 8px;
        }
        .login-menu {
            position: fixed; /* [수정] absolute -> fixed로 변경 */
            top: 75px; right: 30px; background-color: white; border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15); overflow: hidden; max-height: 0;
            transition: max-height 0.4s ease-out, padding 0.4s ease-out; padding: 0; z-index: 1001;
        }
        .login-menu.show { max-height: 300px; padding: 10px 0; }
        .login-menu form { margin: 0; }
        .login-menu button {
            display: block; width: 100%; padding: 12px 25px; font-size: 15px; white-space: nowrap;
            border: none; background-color: transparent; cursor: pointer; text-align: left; color: #333;
        }
        .login-menu button:hover { background-color: #f5f5f5; }
        @media (max-width: 768px) {
            header { padding: 10px 30px; }
            .header-right i { font-size: 1.2rem; }
        }

        /* 이하 나머지 스타일은 기존과 동일합니다 */
        .hero-section { position: relative; height: 60vh; display: flex; align-items: center; justify-content: center; text-align: center; color: white; overflow: hidden; }
        .hero-section .slider { position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 1; }
        .hero-section .slides { display: flex; height: 100%; transition: transform 1s ease-in-out; }
        .hero-section .slide { min-width: 100%; height: 100%; }
        .hero-section .slide img { width: 100%; height: 100%; object-fit: cover; filter: brightness(0.6); }
        .hero-content { position: relative; z-index: 2; padding: 20px; background: rgba(0,0,0,0.2); border-radius: 15px; }
        .hero-content h2 { font-size: 2.8rem; font-weight: 800; margin-bottom: 20px; text-shadow: 2px 2px 8px rgba(0,0,0,0.7); }
        .main-search { display: flex; max-width: 600px; margin: 0 auto; border-radius: 30px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        .main-search input { flex-grow: 1; border: none; padding: 15px 25px; font-size: 1rem; outline: none; }
        .main-search button { border: none; background-color: #ff6f61; color: white; padding: 0 25px; cursor: pointer; font-size: 1.2rem; transition: background-color 0.3s; }
        .main-search button:hover { background-color: #e65a4c; }
        .quick-tags { margin-top: 20px; }
        .quick-tags a { display: inline-block; background: rgba(255,255,255,0.2); border: 1px solid white; padding: 8px 15px; margin: 5px; border-radius: 20px; font-size: 0.9rem; transition: background-color 0.3s; }
        .quick-tags a:hover { background: rgba(255,255,255,0.4); }
        .section-title { text-align: center; font-size: 2rem; font-weight: 700; margin-bottom: 40px; color: #333; }
        .recipe-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; }
        .recipe-card { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); overflow: hidden; transition: transform 0.3s, box-shadow 0.3s; }
        .recipe-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.12); }
        .recipe-card img { width: 100%; height: 200px; object-fit: cover; }
        .card-content { padding: 20px; }
        .card-title { font-size: 1.2rem; font-weight: 700; margin-bottom: 10px; }
        .card-desc { font-size: 0.9rem; color: #666; }
        .category-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 25px; }
        .category-card { position: relative; border-radius: 12px; overflow: hidden; display: block; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .category-card:hover { transform: scale(1.05); }
        .category-card img { width: 100%; height: 150px; object-fit: cover; display: block; }
        .category-card .name { position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.8), transparent); color: white; padding: 20px 15px 10px; font-size: 1.1rem; font-weight: 600; text-align: right; }
        footer { text-align: center; padding: 30px 50px; margin-top: 40px; border-top: 1px solid #e0e0e0; color: #888; font-size: 14px; }
    </style>
</head>
<body>

<header>
    <div class="header-left">
        <a href="home"><h1>요리조리</h1></a>
    </div>
    <nav class="header-center">
        <a href="home">메인화면</a>
        <a href="select_result">레시피 보기</a>
        <a href="category_view">레시피 분류</a>
        <a href="https://www.dogumaster.com/select/menu">메뉴 선택해줘</a>
        <a href="#">WOW이벤트</a>
    </nav>
    <div class="header-right">
        <div class="search-box">
            <input type="text" class="search-input" placeholder="검색...">
            <i class="bi bi-search" id="search-icon"></i>
        </div>
        <i class="bi bi-list" id="menu-toggle"></i>
    </div>
</header>

<div class="login-menu" id="login-menu">
    <%-- 
        JSTL의 choose 태그를 사용해 조건 분기 시작
        - test="${empty sessionScope.id}" : 세션에 'id'라는 값이 비어있는지(로그아웃 상태인지) 확인합니다.
        - 'id'는 MemController에서 session.setAttribute("id", ...)로 저장한 이름과 일치해야 합니다.
    --%>
    <c:choose>
        <%-- ✅ 1. 세션에 'id'가 없을 때 (로그아웃 상태) 보여줄 메뉴 --%>
        <c:when test="${empty sessionScope.id}">
            <%-- 로그인 페이지로 이동하는 버튼 --%>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
            
            <%-- 회원가입 페이지로 이동하는 버튼 --%>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
        </c:when>

        <%-- ✅ 2. 세션에 'id'가 있을 때 (로그인 상태) 보여줄 메뉴 --%>
        <c:otherwise>
            <%-- 세션에 저장된 'name'을 이용해 환영 메시지 출력 --%>
            <p style="padding: 12px 25px; margin: 0; font-weight: bold; text-align: left;">
                ${sessionScope.name}님 환영합니다!
            </p>
            
            <%-- 마이페이지로 이동하는 버튼 --%>
            <button type="button" onclick="location.href='<c:url value="/list"/>'">마이페이지</button>

            <%-- 로그아웃을 처리하는 form (GET 방식보다 안전) --%>
            <form method="post" action="${pageContext.request.contextPath}/logout" style="margin: 0;">
                <button type="submit">로그아웃</button>
            </form>
        </c:otherwise>
    </c:choose>
     <c:if test="${sessionScope.admin == 1}">
    
    <form method="get" action="write_recipe">
        <button type="submit">레시피 등록</button>
    </form>
    <form method="get" action="role">
        <button type="submit">관리자페이지</button>
    </form>
</c:if>
     <c:if test="${sessionScope.admin == 0}">
    <form method="get" action="write_recipe">
        <button type="submit">레시피 등록</button>
    </form>
</c:if>
</div>
</div>

<main>
    <!-- 히어로 섹션 -->
    <section class="hero-section">
        <div class="slider">
            <div class="slides">
                <div class="slide"><img src="data:image/jpeg;base64,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" alt="연어 요리"></div>
            </div>
        </div>
        <div class="hero-content">
            <h2>오늘, 어떤 요리를 해볼까요?</h2>
            <form action="search_result" method="get" class="main-search">
                <input type="text" name="query" placeholder="요리, 재료, 테마로 검색해보세요">
                <button type="submit"><i class="bi bi-search"></i></button>
            </form>
            <div class="quick-tags">
                <a href="#">#간단한 저녁</a>
                <a href="#">#집들이 음식</a>
                <a href="#">#제철 요리</a>
                <a href="#">#아이 간식</a>
            </div>
        </div>
    </section>

    <!-- 오늘의 추천 레시피 섹션 -->
	<section class="container">
        <h2 class="section-title">오늘의 추천 레시피</h2>
        <div class="recipe-grid">
            
            <c:forEach var="recipe" items="${randomRecipes}">
                
                <%-- 
                  [수정] 링크의 파라미터 값을 ${recipe.recipeId} (카멜 케이스)로 변경
                --%>
                <a href="detail.do?recipe_Id=${recipe.recipeId}" class="recipe-card">
                    
                    <%-- [수정] 이미지 소스도 ${recipe.mainImage} (카멜 케이스)로 변경 --%>
                    <img src="${recipe.mainImage}" alt="${recipe.title}">
                    
                    <div class="card-content">
                        <%-- title과 description은 DTO와 이름이 일치하므로 그대로 둡니다. --%>
                        <h3 class="card-title">${recipe.title}</h3>
                        <p class="card-desc">${recipe.description}</p>
                    </div>
                </a>
            </c:forEach>

            <c:if test="${empty randomRecipes}">
                <p style="text-align: center; grid-column: 1 / -1; color: #777;">
                    추천 레시피를 준비 중입니다. 🧑‍🍳
                </p>
            </c:if>

        </div>
    </section>

    <!-- 카테고리별 레시피 섹션 -->
    <section class="container">
        <h2 class="section-title">카테고리별 레시피</h2>
        <div class="category-grid">
            <a href="select_result?category=1" class="category-card">
                <img src="https://cdn.pixabay.com/photo/2017/08/08/09/44/food-2610864_1280.jpg" alt="한식">
                <span class="name">한식</span>
            </a>
            <a href="select_result?category=3" class="category-card">
                <img src="https://cdn.pixabay.com/photo/2016/03/05/22/50/appetite-1238255_1280.jpg" alt="양식">
                <span class="name">양식</span>
            </a>
            <a href="select_result?category=2" class="category-card">
                <img src="https://cdn.pixabay.com/photo/2017/02/01/19/46/food-2030999_1280.jpg" alt="중식">
                <span class="name">중식</span>
            </a>
             <a href="select_result?category=4" class="category-card">
                <img src="https://cdn.pixabay.com/photo/2017/05/23/21/57/sushi-2338573_1280.jpg" alt="일식">
                <span class="name">일식</span>
            </a>
            <a href="select_result?category=5" class="category-card">
                <img src="https://cdn.pixabay.com/photo/2016/03/27/22/38/cake-1284548_1280.jpg" alt="디저트">
                <span class="name">디저트</span>
            </a>
        </div>
    </section>

</main>

<footer>
    © 2025 요리조리 - 쉽고 맛있는 요리 아이디어의 시작.
</footer>

<script>
    // 슬라이드 기능
    const slides = document.querySelector('.slides');
    const slideCount = document.querySelectorAll('.hero-section .slide').length;
    let currentIndex = 0;
    
    function showNextSlide() {
        currentIndex = (currentIndex + 1) % slideCount;
        slides.style.transform = `translateX(-${currentIndex * 100}%)`;
    }
    setInterval(showNextSlide, 4000); // 4초마다 자동 슬라이드

    // 헤더 아이콘 기능
    const searchIcon = document.getElementById('search-icon');
    const searchBox = document.querySelector('.search-box');
    const searchInput = document.querySelector('.search-input');
    const menuToggle = document.getElementById('menu-toggle');
    const loginMenu = document.getElementById('login-menu');

    searchIcon.addEventListener('click', () => {
        searchBox.classList.toggle('active');
        if (searchBox.classList.contains('active')) {
            searchInput.focus();
        }
    });

    menuToggle.addEventListener('click', () => {
        loginMenu.classList.toggle('show');
        if (menuToggle.classList.contains('bi-list')) {
            menuToggle.classList.remove('bi-list');
            menuToggle.classList.add('bi-x');
        } else {
            menuToggle.classList.remove('bi-x');
            menuToggle.classList.add('bi-list');
        }
    });
</script>

</body>
</html>
