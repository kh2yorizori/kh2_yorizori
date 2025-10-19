<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>레시피 목록 | 요리조리</title>
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
            position: fixed; top: 75px; right: 30px; background-color: white; border-radius: 8px;
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
    <h1>요리조리</h1>
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

<div class="grid-container">
    <c:forEach var="dto" items="${category_view}">
        <%-- **수정된 부분: div에 onclick 이벤트 추가** --%>
        <div class="card" 
             onclick="location.href='detail.do?recipe_Id=${dto.recipeId}'"
             style="cursor: pointer;">
             
            <img src="${dto.mainImage}" alt="${dto.title}">
            <div class="card-content">
                <div class="card-title">${dto.title}</div>
                <div class="card-info"><strong>별점:</strong> ${dto.rating}</div>
                <div class="card-info"><strong>조회수:</strong> ${dto.hit}</div>
                <div class="card-info"><strong>조리 시간:</strong> ${dto.cookingTime}</div>
                <div class="card-info"><strong>요리 양:</strong> ${dto.servingSize}인분</div>
                <div class="card-info"><strong>난이도:</strong> ${dto.difficulty}</div>
            </div>
        </div>
    </c:forEach>
</div>

<footer>
    © 2025 요리조리 | All rights reserved.
</footer>
<script>
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
        // 아이콘 모양 변경 (bi-list <=> bi-x)
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
