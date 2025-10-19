<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>마이페이지 수정 - 요리조리</title>
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

        /* ---------------- 헤더 (다른 페이지와 동일) ---------------- */
        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 60px;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .header-left h1 {
            font-size: 1.5rem; color: #ff6f61; font-weight: 800; margin: 0; white-space: nowrap;
        }
        .header-center {
            display: flex; justify-content: center; align-items: center; flex-wrap: wrap; gap: 15px; flex: 1;
        }
        .header-center a {
            padding: 8px 14px; border-radius: 20px; font-size: 14px; background-color: #f3f3f3; transition: background-color 0.3s, color 0.3s; white-space: nowrap;
        }
        .header-center a:hover {
            background-color: #2e7d32; color: white;
        }
        .header-right {
            display: flex; align-items: center; gap: 18px;
        }
        .header-right i {
            font-size: 1.5rem; cursor: pointer; color: #333; transition: color 0.2s ease;
        }
        .header-right i:hover {
            color: #2e7d32;
        }
        .search-box {
            display: flex; align-items: center;
        }
        .search-input {
            width: 0; padding: 0; border: none; outline: none; opacity: 0; transition: all 0.4s ease; border-bottom: 2px solid transparent; font-size: 14px;
        }
        .search-box.active .search-input {
            width: 150px; opacity: 1; padding: 5px; border-bottom: 2px solid #333; margin-right: 8px;
        }
        .login-menu {
            position: fixed; top: 75px; right: 30px; background-color: white; border-radius: 8px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            overflow: hidden; max-height: 0; transition: max-height 0.4s ease-out, padding 0.4s ease-out; padding: 0; z-index: 101;
        }
        .login-menu.show {
            max-height: 200px; padding: 10px 0;
        }
        .login-menu form { margin: 0; }
        .login-menu button {
            display: block; width: 100%; padding: 12px 25px; font-size: 15px; white-space: nowrap;
            border: none; background-color: transparent; cursor: pointer; text-align: left; color: #333;
        }
        .login-menu button:hover { background-color: #f5f5f5; }
        .login-menu .welcome-message {
            padding: 12px 25px; font-size: 15px; color: #333; border-bottom: 1px solid #f0f0f0;
            margin-bottom: 5px; padding-bottom: 10px;
        }
        
        /* ---------------- 메인 영역 (정보 수정 폼 전용 스타일) ---------------- */
        main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }
        .edit-form-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        .edit-form-container h2 {
            text-align: center;
            font-size: 2rem;
            color: #333;
            margin-bottom: 30px;
            border-bottom: 2px solid #ff6f61;
            padding-bottom: 15px;
        }
        .form-content {
            display: flex;
            gap: 40px;
        }
        .profile-image-section {
            flex-shrink: 0;
            text-align: center;
        }
        .profile-image-section img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }
        .form-fields {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-weight: 600;
            color: #555;
            margin-bottom: 5px;
            font-size: 15px;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="date"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box; /* padding이 너비에 포함되도록 설정 */
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #2e7d32;
            box-shadow: 0 0 0 2px rgba(46, 125, 50, 0.2);
        }
        .gender-group {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .gender-group label {
            margin: 0;
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        .gender-group input[type="radio"] {
            margin-right: 8px;
        }
        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .form-actions button, .form-actions input[type="submit"] {
            font-family: "Noto Sans KR", sans-serif;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit { background-color: #2e7d32; color: white; }
        .btn-submit:hover { background-color: #1b5e20; }
        .btn-cancel { background-color: #f0f0f0; color: #333; }
        .btn-cancel:hover { background-color: #e0e0e0; }

        /* ---------------- 푸터 (다른 페이지와 동일) ---------------- */
        footer {
            text-align: center;
            padding: 20px 50px;
            margin-top: auto;
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
    <c:choose>
        <c:when test="${not empty sessionScope.id}">
            <div class="welcome-message"><strong>${sessionScope.name}</strong>님 반갑습니다.</div>
            <button type="button" onclick="location.href='<c:url value="/list"/>'">마이페이지</button>
            <button type="button" onclick="location.href='<c:url value="/logout"/>'">로그아웃</button>
        </c:when>
        <c:otherwise>
            <form method="post" action="login_view"><button type="submit">로그인</button></form>
            <button type="button" onclick="location.href='<c:url value="/register"/>'">회원가입</button>
        </c:otherwise>
    </c:choose>
</div>

<main>
    <div class="edit-form-container">
        <h2>마이페이지 수정</h2>
        
        <%-- [수정] 모든 ${member.속성} 을 ${user.속성} 으로 변경 --%>
        <form action="<c:url value='/modify'/>" method="post" class="form-content">
            <input type="hidden" name="memberId" value="${user.memberId}" />

            <div class="profile-image-section">
                <c:choose>
                    <c:when test="${not empty user.profileImage}">
                         <img src="<c:url value='/resources/uploads/${user.profileImage}'/>" alt="프로필 이미지"/>
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/150" alt="기본 프로필 이미지"/>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="form-fields">
                <div class="form-group">
                    <label for="nickname">닉네임</label>
                    <input type="text" id="nickname" name="nickname" value="${user.nickname}" />
                </div>
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" value="${user.name}" />
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" value="${user.email}" />
                </div>
                <div class="form-group">
                    <label for="phoneNumber">전화번호</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" />
                </div>
                <div class="form-group">
                    <label for="birthdate">생년월일</label>
                    <input type="date" id="birthdate" name="birthdate" value="<fmt:formatDate value="${user.birthdate}" pattern="yyyy-MM-dd"/>" />
                </div>
                <div class="form-group">
                    <label>성별</label>
                    <div class="gender-group">
                        <label><input type="radio" name="gender" value="1" ${user.gender == 1 ? 'checked' : ''}> 남자</label>
                        <label><input type="radio" name="gender" value="2" ${user.gender == 2 ? 'checked' : ''}> 여자</label>
                    </div>
                </div>
                
                <div class="form-actions">
                    <input type="submit" value="수정 완료" class="btn-submit" />
                    <button type="button" class="btn-cancel" onclick="location.href='<c:url value="/list"/>'">취소</button>
                </div>
            </div>
        </form>
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