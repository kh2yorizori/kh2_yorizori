<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>요리조리 | ${recipe.title} - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <style>
        /* ====== 기본 & 헤더 스타일 (메인 페이지와 동일) ====== */
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7; /* 배경색 변경: 더 밝은 톤 */
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        .container {
            max-width: 900px; /* 레시피 컨테이너와 일치 */
            margin: 0 auto;
            padding: 40px 20px;
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

        /* ====== 레시피 컨텐츠 스타일 (중앙 스타일) ====== */
        .recipe-container { 
            max-width: 900px; 
            margin: 30px auto; 
            padding: 40px; 
            background-color: white; 
            border-radius: 15px; /* 더 부드러운 모서리 */
            box-shadow: 0 8px 30px rgba(0,0,0,0.1); 
        }
        
        .recipe-title {
            font-size: 2.5rem; 
            color: #333; 
            font-weight: 700;
            padding-bottom: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ff6f61; /* 헤더 컬러와 통일 */
        }
        
        .recipe-meta { 
            background-color: #fff8f7; /* 부드러운 배경 */
            padding: 15px 25px; 
            margin-bottom: 30px; 
            border-radius: 10px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            font-size: 0.95rem;
            border: 1px solid #ffe0d5;
        }
        .meta-item { 
            display: flex; 
            align-items: center; 
            gap: 5px;
            color: #555;
        }
        .meta-item strong { color: #ff6f61; font-weight: 600; }
        .meta-icon { color: #ff6f61; font-size: 1.2rem; }

        .main-image { 
            width: 100%; 
            max-height: 400px; /* 높이 조정 */
            object-fit: cover; 
            border-radius: 10px; 
            margin-bottom: 30px; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        .section-header { 
            font-size: 1.6rem; 
            font-weight: 700;
            color: #2e7d32; /* 포인트 색상 */
            margin-top: 40px; 
            margin-bottom: 20px;
            padding-left: 10px;
            border-left: 5px solid #ff6f61;
        }

        /* 레시피 요약 */
        .recipe-description {
            background-color: #f0f8ff;
            padding: 20px;
            border-radius: 8px;
            line-height: 1.6;
            margin-bottom: 30px;
            border: 1px dashed #c0e0ff;
        }
        
        /* 재료 목록 */
        .ingredient-list {
            list-style: none;
            padding: 0;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 10px 20px;
        }
        .ingredient-list li {
            background-color: #fff;
            padding: 10px 15px;
            border-radius: 5px;
            border-left: 4px solid #2e7d32;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .ingredient-list li strong { color: #2e7d32; }


        /* 조리 순서 */
        .step-item { 
            background: #fff; 
            border: 1px solid #e0e0e0; 
            padding: 20px; 
            margin-bottom: 25px; 
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .step-item h3 {
            font-size: 1.3rem;
            color: #ff6f61;
            margin-top: 0;
            margin-bottom: 15px;
            border-bottom: 1px dashed #ff6f6130;
            padding-bottom: 5px;
        }
        .step-img { 
            max-width: 100%; 
            height: auto; 
            margin-top: 15px; 
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        /* 댓글 및 후기 */
        .comment-review-box { 
            padding-top: 30px; 
            margin-top: 40px; 
            border-top: 2px solid #eee; 
        }
        .review-item, .comment-item {
            margin-bottom: 20px; 
            padding: 15px; 
            border: 1px solid #f0f0f0; 
            border-radius: 8px;
            background-color: #fafafa;
        }

        .review-rating { 
            color: gold; 
            font-size: 1.2em; 
            letter-spacing: 2px;
        }
        .review-header, .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }
        .review-header strong, .comment-header strong {
            font-size: 1.1rem;
            color: #333;
        }
        .review-content, .comment-content {
            margin-top: 10px;
            line-height: 1.5;
        }
        .comment-item {
            margin-bottom: 10px;
        }
        .reply-item {
            margin-left: 20px;
            border-left: 3px solid #ccc;
            padding-left: 10px;
            background-color: #fcfcfc;
        }

        /* 푸터 */
        footer {
            text-align: center; padding: 30px 50px; margin-top: 40px;
            border-top: 1px solid #e0e0e0; color: #888; font-size: 14px;
        }

        @media (max-width: 600px) {
            .recipe-container { padding: 20px; margin: 20px auto; }
            .recipe-title { font-size: 2rem; }
            .recipe-meta { flex-direction: column; gap: 10px; align-items: flex-start; }
            .section-header { font-size: 1.4rem; }
        }
        /* ====== 수정/삭제 버튼 스타일 ====== */
		.action-buttons {
		    text-align: right;
		    margin: 10px 0 20px 0; /* 위아래 여백 추가 */
		}
		
		.action-buttons a {
		    display: inline-block;
		    padding: 8px 18px; /* 버튼 크기 조정 */
		    border-radius: 5px;
		    font-size: 0.9rem;
		    font-weight: 500;
		    color: #fff;
		    text-decoration: none;
		    margin-left: 10px; /* 버튼 사이 간격 */
		    transition: all 0.3s ease;
		    border: none;
		    cursor: pointer;
		}
		
		.btn-modify {
		    background-color: #2e7d32; /* 초록색 계열 */
		}
		.btn-modify:hover {
		    background-color: #246b28;
		    transform: translateY(-2px); /* 살짝 떠오르는 효과 */
		    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
		}
		
		.btn-delete {
		    background-color: #d32f2f; /* 붉은색 계열 */
		}
        .btn-delete:hover {
            background-color: #b71c1c;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        /* 별점 입력 스타일 */
        .rating-input {
            display: flex;
            flex-direction: row-reverse;
            gap: 5px;
        }
        .rating-input input[type="radio"] {
            display: none;
        }
        .rating-input label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        .rating-input input[type="radio"]:checked ~ label,
        .rating-input label:hover,
        .rating-input label:hover ~ label {
            color: #ffc107;
        }
    </style>
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
<div class="recipe-container">

    <c:if test="${sessionScope.id == recipe.memberId}">
	    <div class="action-buttons">
	        <%-- 수정 페이지로 이동하는 버튼 --%>
	        <a href="<c:url value='/modifyRecipe?recipeId=${recipe.recipeId}'/>" class="btn-modify">수정</a>
	        
	        <%-- 삭제를 확인하는 자바스크립트와 함께 삭제 처리를 요청하는 버튼 --%>
	        <a href="<c:url value='/deleteRecipe?recipeId=${recipe.recipeId}'/>" class="btn-delete" onclick="return confirm('정말로 이 레시피를 삭제하시겠습니까?');">삭제</a>
	    </div>
	</c:if>
    <h1 class="recipe-title">${recipe.title}</h1>
    
    <div class="recipe-meta">
        <span class="meta-item"><i class="bi bi-person-fill meta-icon"></i> 작성자: <strong>${recipe.memberId}</strong></span>
        <span class="meta-item"><i class="bi bi-eye-fill meta-icon"></i> 조회수: <strong>${recipe.hit}</strong></span>
        <span class="meta-item"><i class="bi bi-star-fill meta-icon"></i> 평균 별점: <strong><c:out value="${recipe.average_rating}" default="0.0"/>점</strong></span>
        <span class="meta-item"><i class="bi bi-chat-dots-fill meta-icon"></i> 댓글: <strong>${recipe.commentList.size()}개</strong></span>
        <span class="meta-item"><i class="bi bi-calendar-check meta-icon"></i> 작성일: <strong><fmt:formatDate value="${recipe.createdat}" pattern="yyyy.MM.dd"/></strong></span>
    </div>
    
    <img src="${recipe.mainImage}" alt="${recipe.title}" class="main-image">

    <h2 class="section-header"><i class="bi bi-book"></i> 레시피 요약</h2>
    <p class="recipe-description">${recipe.description}</p>
    
    <div class="recipe-meta" style="justify-content: space-evenly; background-color: #f5fcf5; border-color: #d8f5d8;">
        <span class="meta-item"><i class="bi bi-speedometer2 meta-icon"></i> 난이도: <strong>${recipe.difficulty}</strong></span>
        <span class="meta-item"><i class="bi bi-alarm-fill meta-icon"></i> 조리 시간: <strong>${recipe.cookingTime}</strong></span>
        <span class="meta-item"><i class="bi bi-person-badge-fill meta-icon"></i> 요리 양: <strong>${recipe.servingSize}인분</strong></span>
    </div>

    <h2 class="section-header"><i class="bi bi-basket-fill"></i> 필요한 재료 (${recipe.servingSize}인분 기준)</h2>
    <ul class="ingredient-list">
        <c:choose>
            <c:when test="${empty recipe.ingredientList}">
                <li>등록된 재료가 없습니다.</li>
            </c:when>
            <c:otherwise>
                <c:forEach var="ing" items="${recipe.ingredientList}">
                    <li>${ing.name}: <strong>${ing.quantity}</strong></li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
    
<h2 class="section-header"><i class="bi bi-tools"></i> 조리 순서</h2>
<c:choose>
    <c:when test="${empty recipe.stepList}">
        <p>등록된 조리 단계가 없습니다.</p>
    </c:when>
    <c:otherwise>
        <%-- [수정] varStatus="loop" 추가 --%>
        <c:forEach var="step" items="${recipe.stepList}" varStatus="loop">
            <div class="step-item">
                <%-- STEP 번호 표시 --%>
                <h3>STEP ${loop.count}</h3> 
                
                <%-- [수정] ${step.instruction} 사용 --%>
                <p>${step.instruction}</p>
                
                <%-- [수정] ${step.imageUrl} 사용 --%>
                <c:if test="${not empty step.imageUrl}">
                    <img src="<c:url value='/${step.imageUrl}'/>" alt="조리 단계 이미지" class="step-img">
<%--                     <img src="${step.imageUrl}" alt="조리 단계 이미지" class="step-img"> --%>
                </c:if>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
    
    <div class="comment-review-box">
        <h2 class="section-header" style="margin-top: 0;"><i class="bi bi-pencil-square"></i> 사용자 후기 및 평점 (${recipe.reviewList.size()}개)</h2>
        
        <c:choose>
            <c:when test="${empty recipe.reviewList}">
                <p>아직 등록된 후기가 없습니다. 첫 후기를 남기고 별점을 평가해주세요!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="rvw" items="${recipe.reviewList}">
                    <div class="review-item">
                        <div class="review-header">
                            <strong>${rvw.memberId}</strong> 
                            <span class="review-rating">
                                <c:forEach begin="1" end="${rvw.rating}">★</c:forEach>
                                <c:forEach begin="${rvw.rating + 1}" end="5">☆</c:forEach>
                                (${rvw.rating}점)
                            </span>
                        </div>
                        <p style="font-size: 0.85rem; color: #999; margin-bottom: 10px;">
                            <fmt:formatDate value="${rvw.createdat}" pattern="yy.MM.dd"/> 작성
                        </p>
                        <p class="review-content">${rvw.content}</p>
                        <c:if test="${not empty rvw.image}">
                            <img src="${rvw.image}" alt="후기 이미지" style="max-width: 200px; border-radius: 5px; margin-top: 10px;">
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        
        <!-- 후기 작성 폼 (로그인한 사용자만) - 목록 아래로 이동 -->
        <c:if test="${not empty sessionScope.id}">
            <div class="write-form" style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-top: 20px;">
                <h4 style="margin-top: 0; color: #2e7d32;">후기 작성</h4>
                <form id="reviewForm">
                    <input type="hidden" name="recipeId" value="${recipe.recipeId}">
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">평점:</label>
                        <div class="rating-input">
                            <input type="radio" name="rating" value="5" id="star5">
                            <label for="star5">★</label>
                            <input type="radio" name="rating" value="4" id="star4">
                            <label for="star4">★</label>
                            <input type="radio" name="rating" value="3" id="star3">
                            <label for="star3">★</label>
                            <input type="radio" name="rating" value="2" id="star2">
                            <label for="star2">★</label>
                            <input type="radio" name="rating" value="1" id="star1">
                            <label for="star1">★</label>
                        </div>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">후기 내용:</label>
                        <textarea name="content" rows="4" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: vertical;" placeholder="후기를 작성해주세요..."></textarea>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">이미지 URL (선택사항):</label>
                        <input type="text" name="image" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;" placeholder="이미지 URL을 입력해주세요...">
                    </div>
                    <button type="submit" style="background-color: #2e7d32; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">후기 작성</button>
                </form>
            </div>
        </c:if>
    </div>

    <div class="comment-review-box">
        <h2 class="section-header" style="margin-top: 0;"><i class="bi bi-chat-left-text-fill"></i> 댓글 (${recipe.commentList.size()}개)</h2>
        
        <c:choose>
            <c:when test="${empty recipe.commentList}">
                <p>아직 등록된 댓글이 없습니다. 첫 댓글을 남겨보세요!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="cmt" items="${recipe.commentList}">
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>${cmt.memberId}</strong> 
                            <span style="font-size: 0.8rem; color: #999;"><fmt:formatDate value="${cmt.createdat}" pattern="yy.MM.dd HH:mm"/></span>
                        </div>
                        <p class="comment-content" style="margin-top: 5px;">${cmt.content}</p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        
        <!-- 댓글 작성 폼 (로그인한 사용자만) - 목록 아래로 이동 -->
        <c:if test="${not empty sessionScope.id}">
            <div class="write-form" style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-top: 20px;">
                <h4 style="margin-top: 0; color: #2e7d32;">댓글 작성</h4>
                <form id="commentForm">
                    <input type="hidden" name="recipeId" value="${recipe.recipeId}">
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">댓글 내용:</label>
                        <textarea name="content" rows="3" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: vertical;" placeholder="댓글을 작성해주세요..."></textarea>
                    </div>
                    <button type="submit" style="background-color: #2e7d32; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">댓글 작성</button>
                </form>
            </div>
        </c:if>
    </div>

</div>

<footer>
    © 2025 요리조리 - 쉽고 맛있는 요리 아이디어의 시작.
</footer>

<script>
    // 헤더 아이콘 기능 (메인 페이지의 스크립트 재사용)
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

    // 댓글 작성 폼 처리
    document.getElementById('commentForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const recipeId = formData.get('recipeId');
        const content = formData.get('content');
        
        if (!content.trim()) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        
        fetch('/YoRiZoRi/comment/write', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `recipeId=` + recipeId + `&content=` + encodeURIComponent(content)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload(); // 페이지 새로고침으로 댓글 목록 업데이트
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('댓글 작성 중 오류가 발생했습니다.');
        });
    });

    // 후기 작성 폼 처리
    document.getElementById('reviewForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const recipeId = formData.get('recipeId');
        const content = formData.get('content');
        const rating = formData.get('rating');
        const image = formData.get('image');
        
        if (!content.trim()) {
            alert('후기 내용을 입력해주세요.');
            return;
        }
        
        if (!rating) {
            alert('평점을 선택해주세요.');
            return;
        }
        
        fetch('/YoRiZoRi/review/write', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `recipeId=` + recipeId + `&content=` + encodeURIComponent(content) + `&rating=` + rating + `&image=` + encodeURIComponent(image)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload(); // 페이지 새로고침으로 후기 목록 업데이트
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('후기 작성 중 오류가 발생했습니다.');
        });
    });
</script>

</body>
</html>