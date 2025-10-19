<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 | 요리조리</title>
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
    
    <style>
        /* ====== 공통 스타일 ====== */
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

        /* ====== 헤더 (다른 페이지와 동일하게 적용) ====== */
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
            position: fixed; top: 75px; right: 30px; background-color: white; border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15); overflow: hidden; max-height: 0;
            transition: max-height 0.4s ease-out, padding 0.4s ease-out; padding: 0; z-index: 101;
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
        
        @media (max-width: 768px) {
            header { padding: 10px 30px; }
            .header-right i { font-size: 1.2rem; }
        }

        /* ====== 로그인 폼 영역 (새롭게 디자인) ====== */
        .login-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }
        .login-box {
            background: white;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 420px;
            text-align: center;
        }
        .login-box h2 {
            font-size: 2rem;
            font-weight: 800;
            color: #ff6f61;
            margin-bottom: 30px;
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 1.1rem;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box; /* 패딩 포함해서 너비 계산 */
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #ff6f61;
            box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2);
            outline: none;
        }
        .btn-login {
            width: 100%;
            background-color: #ff6f61;
            color: white;
            border: none;
            padding: 14px;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn-login:hover {
            background-color: #e65a4c;
            transform: translateY(-2px);
        }
        .links-area {
            margin-top: 20px;
            font-size: 0.9rem;
            color: #777;
        }
        .links-area a {
            color: #555;
            margin: 0 10px;
            transition: color 0.2s;
        }
        .links-area a:hover {
            color: #ff6f61;
        }
        .msg {
            color: #e74c3c;
            margin-top: 15px;
            font-weight: 600;
            height: 20px; /* 메시지 영역 항상 확보 */
        }

        /* ====== 푸터 ====== */
        footer {
            text-align: center;
            padding: 20px 0;
            margin-top: auto;
            color: #888;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <!-- 다른 페이지와 동일한 헤더 -->
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

    <!-- 헤더 메뉴 클릭 시 나오는 드롭다운 메뉴 (기능상 필요) -->
    <div class="login-menu" id="login-menu">
        <form method="post" action="login_view">
            <button type="submit">로그인</button>
        </form>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
    </div>

    <!-- 새롭게 디자인된 로그인 폼 -->
    <main class="login-container">
        <div class="login-box">
            <h2>로그인</h2>
            <form method="post" action="${pageContext.request.contextPath}/login_yn">
                <div class="input-group">
                    <i class="bi bi-person-fill"></i>
                    <input type="text" class="form-control" id="MEMBER_ID" name="MEMBER_ID" placeholder="아이디" required>
                </div>
                <div class="input-group">
                    <i class="bi bi-lock-fill"></i>
                    <input type="password" class="form-control" id="PASSWORD" name="PASSWORD" placeholder="비밀번호" required>
                </div>
                
                <div class="msg">${msg}</div>

                <button type="submit" class="btn-login">로그인</button>
                
                <div class="links-area">
                    <a href="${pageContext.request.contextPath}/register">회원가입</a> |
                    <a href="javascript:history.back()">뒤로가기</a>
                </div>
            </form>
        </div>
    </main>

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
