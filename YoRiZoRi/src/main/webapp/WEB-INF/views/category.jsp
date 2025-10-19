<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>요리조리 | 레시피 분류</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
<style>
  /* ====== 공통 스타일 ====== */
  body {
    font-family: "Noto Sans KR", sans-serif;
    margin: 0;
    padding: 0;
    background-color: #fffaf7;
    color: #333;
  }
  a { text-decoration: none; color: inherit; }

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


  /* ====== 레시피 폼 영역 (디자인 개선) ====== */
  .container {
    display: flex; justify-content: center; align-items: center; min-height: calc(100vh - 150px);
  }
  .form-box {
    background-color: #ffffff; border-radius: 16px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    padding: 40px 50px; width: 100%; max-width: 550px; /* 너비 확장 */
    transition: transform 0.3s ease;
  }
  .form-box:hover { transform: translateY(-5px); }
  .form-box h2 {
    font-size: 2rem; font-weight: 800; margin-bottom: 35px;
    color: #ff6f61; text-align: center;
  }

  .form-group {
    display: flex;
    align-items: flex-start; /* 상단 정렬 */
    margin-bottom: 30px;
  }
  .group-label {
    font-weight: 700;
    width: 100px;
    color: #444;
    flex-shrink: 0;
    padding-top: 5px; /* 체크박스와 높이 맞춤 */
    font-size: 1.1rem;
  }
  .category-options {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3열 그리드 */
    gap: 15px 20px; /* 행, 열 간격 */
    width: 100%;
  }
  .sort-options {
    display: flex;
    gap: 20px;
    align-items: center;
    padding-top: 5px;
  }
  .category-options label, .sort-options label {
    margin: 0;
    font-size: 1rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    transition: color 0.2s;
  }
   .category-options label:hover, .sort-options label:hover {
     color: #ff6f61;
   }

  input[type="checkbox"], input[type="radio"] {
    margin-right: 8px;
    accent-color: #ff6f61;
    transform: scale(1.2);
    cursor: pointer;
  }
  .btn-area {
    text-align: center;
    margin-top: 30px;
    border-top: 1px solid #eee;
    padding-top: 30px;
  }
  input[type="submit"], input[type="reset"] {
    background-color: #ff6f61; border: none; color: white;
    font-weight: 700; font-size: 1.1rem; padding: 12px 35px;
    border-radius: 8px; cursor: pointer; transition: 0.25s ease;
    margin: 0 10px;
  }
  input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #e85c4c;
    transform: translateY(-2px);
  }
   input[type="reset"] {
     background-color: #e0e0e0;
     color: #333;
   }
   input[type="reset"]:hover {
     background-color: #bdbdbd;
   }

  /* ====== 푸터 ====== */
  footer {
    text-align: center; padding: 20px 0; color: #aaa;
    font-size: 0.9rem; border-top: 1px solid #eee;
  }
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

<div class="container">
  <div class="form-box">
    <h2>레시피 상세 검색</h2>
    <form method="post" action="select_result" id="categoryForm">
      
      <!-- 카테고리 선택 (Grid 레이아웃으로 변경) -->
      <div class="form-group">
        <label class="group-label">카테고리</label>
        <div class="category-options">
          <label><input type="checkbox" name="category" value="1" />한식</label>
          <label><input type="checkbox" name="category" value="2" />일식</label>
          <label><input type="checkbox" name="category" value="3" />중식</label>
          <label><input type="checkbox" name="category" value="4" />양식</label>
          <label><input type="checkbox" name="category" value="5" />디저트</label>
          <label><input type="checkbox" name="category" value="6" />분식</label> <!-- 예시 항목 추가 -->
        </div>
      </div>
      
      <!-- 정렬 방법 -->
      <div class="form-group">
        <label class="group-label">정렬 방법</label>
        <div class="sort-options">
          <label><input type="radio" name="order" value="hit" checked />인기순</label>
          <label><input type="radio" name="order" value="rating" />평점순</label>
          <label><input type="radio" name="order" value="latest" />최신순</label>
        </div>
      </div>
      
      <div class="btn-area">
        <input type="submit" value="레시피 찾기" />
        <input type="reset" value="초기화" />
      </div>

    </form>
  </div>
</div>

<footer>
  <p>© 2025 요리조리 | All rights reserved.</p>
</footer>

<script>
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
