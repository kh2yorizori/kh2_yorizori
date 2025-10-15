<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 - 요리조리</title>

    <!-- Bootstrap & Google Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa; /* 밝은 웹 느낌 배경 */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* 헤더 */
        header.site-header {
            background-color: #5563DE;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        header .site-logo {
            font-size: 32px;
            font-weight: 700;
        }
        header .site-subtitle {
            font-size: 14px;
            margin-top: 4px;
            font-weight: 400;
        }

        /* 로그인 섹션 */
        main.login-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 60px 20px;
        }

        .login-card {
            background: white;
            border-radius: 10px;
            padding: 40px 30px;
            width: 400px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); /* 웹 느낌은 그림자 약하게 */
        }

        .login-card h2 {
            margin-bottom: 30px;
            font-weight: 600;
            color: #333;
            text-align: center;
        }

        .form-control {
            border-radius: 6px;
            padding: 10px;
            font-size: 14px;
        }

        .btn-login, .btn-register {
            width: 100%;
            border-radius: 6px;
            padding: 10px;
            font-size: 15px;
            font-weight: 600;
            border: none;
        }

        .btn-login {
            background-color: #5563DE;
            color: white;
            margin-bottom: 10px;
        }
        .btn-login:hover {
            background-color: #3b49b0;
        }

        .btn-register {
            background-color: #e9ecef;
            color: #333;
        }
        .btn-register:hover {
            background-color: #dee2e6;
        }

        .msg {
            text-align: center;
            color: #e74c3c;
            margin-top: 12px;
            font-weight: 500;
        }

        footer {
            text-align: center;
            padding: 20px 0;
            font-size: 13px;
            color: #6c757d;
        }
    </style>
</head>

<body>

    <header class="site-header">
        <div class="site-logo">🍳 요리조리</div>
        <div class="site-subtitle">맛있는 레시피를 한번에 확인하세요!</div>
    </header>

    <main class="login-section">
        <div class="login-card">
            <h2>로그인</h2>
            <form method="post" action="${pageContext.request.contextPath}/login_yn">
                <div class="mb-3">
                    <label for="MEMBER_ID" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="MEMBER_ID" name="MEMBER_ID" placeholder="아이디를 입력하세요" required>
                </div>

                <div class="mb-3">
                    <label for="PASSWORD" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력하세요" required>
                </div>

                <button type="submit" class="btn-login">로그인</button>
                <button type="button" class="btn-register" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
				
				 <div style="text-align: center; margin-top: 15px; font-size: 10px">
  				<a href="javascript:history.back()">뒤로가기</a>
				
                <div class="msg">${msg}</div>
            </form>
        </div>
    </main>

    <footer>
        &copy; 2025 요리조리. All Rights Reserved.
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
