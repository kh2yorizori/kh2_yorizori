<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>마이페이지 - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <style>
        /* 기본 스타일 */
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fffaf7;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
        
        /* ---------------- 메인 영역 (마이페이지 전용 스타일) ---------------- */
        main {
            flex-grow: 1; /* 푸터를 맨 아래에 고정시키기 위함 */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }
        .mypage-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        .mypage-container h2 {
            text-align: center;
            font-size: 2rem;
            color: #333;
            margin-bottom: 30px;
            border-bottom: 2px solid #ff6f61;
            padding-bottom: 15px;
        }
        .profile-content {
            display: flex;
            align-items: center;
            gap: 40px;
        }
        .profile-image-section {
            flex-shrink: 0;
        }
        .profile-image-section img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-details {
            flex-grow: 1;
        }
        .info-list .info-item {
            display: flex;
            margin-bottom: 12px;
            font-size: 16px;
            border-bottom: 1px solid #eee;
            padding-bottom: 12px;
        }
        .info-list .info-item:last-child {
            border-bottom: none;
        }
        .info-list .label {
            width: 100px;
            font-weight: 600;
            color: #555;
        }
        .info-list .value {
            color: #333;
        }

        /* 버튼 영역 스타일 */
        .action-buttons {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .action-buttons button, .action-buttons input[type="submit"] {
            font-family: "Noto Sans KR", sans-serif;
            padding: 10px 20px;
            font-size: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-primary {
            background-color: #2e7d32;
            color: white;
        }
        .btn-primary:hover {
            background-color: #1b5e20;
        }
        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        .btn-secondary:hover {
            background-color: #e0e0e0;
        }
        .btn-danger {
            background-color: #d32f2f;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c62828;
        }

        /* ---------------- 푸터 (메인과 동일) ---------------- */
        footer {
            text-align: center;
            padding: 20px 50px;
            margin-top: auto; /* 내용이 적어도 항상 하단에 위치 */
            border-top: 1px solid #e0e0e0;
            color: #888;
            font-size: 14px;
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

<main>
    <div class="mypage-container">
        <h2>마이페이지</h2>
        
        <div class="profile-content">
            <div class="profile-image-section">
                <c:choose>
                    <c:when test="${not empty user.profileImage}">
                        <img src="${user.profileImage}" alt="프로필 이미지"/>
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/150" alt="기본 프로필 이미지"/>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-details">
                <div class="info-list">
                    <div class="info-item">
                        <span class="label">닉네임</span>
                        <span class="value">${user.nickname}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">이름</span>
                        <span class="value">${user.name}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">아이디</span>
                        <span class="value">${user.memberId}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">이메일</span>
                        <span class="value">${user.email}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">전화번호</span>
                        <span class="value">${user.phoneNumber}</span>
                    </div>
                     <div class="info-item">
                        <span class="label">성별</span>
                        <span class="value">
                             <c:choose>
                                 <c:when test="${user.gender == 1}">남성</c:when>
                                 <c:when test="${user.gender == 2}">여성</c:when>
                                 <c:otherwise>미지정</c:otherwise>
                             </c:choose>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="action-buttons">
<button type="button" class="btn-primary" onclick="location.href='mypage_edit?member_Id=${user.memberId}'">정보 수정</button>
    <button type="button" class="btn-secondary" onclick="location.href='myrecipe?member_Id=${user.memberId}'">내 게시물 보기</button>
            <form action="delete" method="post" style="margin:0;">
                <input type="hidden" name="memberId" value="${user.memberId}" />
                <input type="submit" class="btn-danger" value="회원 탈퇴" onclick="return confirm('정말 탈퇴하시겠습니까?');" />
            </form>
        </div>
    </div>
</main>

<footer>
    © 2025 요리조리 - 쉽고 맛있는 요리 아이디어의 시작.
    오늘은 무엇을 요리해볼까요?
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