<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 - 요리조리</title>

    <!-- Bootstrap + Google Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* 헤더 영역 */
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

        /* 메인 영역 */
        main.register-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 60px 20px;
        }

        .register-card {
            background: #fff;
            border-radius: 10px;
            width: 480px;
            padding: 40px 35px 35px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .register-card h2 {
            text-align: center;
            font-weight: 600;
            color: #333;
            margin-bottom: 30px;
        }

        label {
            font-weight: 500;
            margin-bottom: 6px;
        }

        .form-control, .form-select {
            border-radius: 6px;
            padding: 10px;
            font-size: 14px;
        }

        .form-check-label {
            font-weight: 400;
        }

        .btn-register {
            width: 100%;
            border-radius: 6px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            background: #5563DE;
            color: white;
            border: none;
            margin-top: 15px;
            transition: all 0.2s ease;
        }
        .btn-register:hover {
            background: #3b49b0;
        }

        footer {
            text-align: center;
            padding: 20px 0;
            font-size: 13px;
            color: #6c757d;
        }
        .btn-back{
        	text-align:center;
        }
    </style>
</head>

<body>

    <header class="site-header">
        <div class="site-logo">🍳 요리조리</div>
        <div class="site-subtitle">맛있는 레시피를 한번에 확인하세요!</div>
    </header>

    <main class="register-section">
        <div class="register-card">
            <h2>회원가입</h2>

            <form method="post" action="registerOk">
                <div class="mb-3">
                    <label for="MEMBER_ID" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="MEMBER_ID" name="MEMBER_ID" placeholder="아이디를 입력하세요" required>
                </div>

                <div class="mb-3">
                    <label for="NAME" class="form-label">이름</label>
                    <input type="text" class="form-control" id="NAME" name="NAME" placeholder="이름을 입력하세요" required>
                </div>

                <div class="mb-3">
                    <label for="PASSWORD" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력하세요" required>
                </div>

                <div class="mb-3">
                    <label for="NICKNAME" class="form-label">닉네임</label>
                    <input type="text" class="form-control" id="NICKNAME" name="NICKNAME" placeholder="닉네임을 입력하세요">
                </div>

                <div class="mb-3">
                    <label for="EMAIL" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="EMAIL" name="EMAIL" placeholder="example@email.com">
                </div>

                <div class="mb-3">
                    <label for="PROFILE_IMAGE" class="form-label">프로필 이미지</label>
                    <input type="file" class="form-control" id="PROFILE_IMAGE" name="PROFILE_IMAGE" accept="image/*">
                </div>

                <div class="mb-3">
                    <label for="PHONE_NUMBER" class="form-label">휴대폰 번호</label>
                    <input type="text" class="form-control" id="PHONE_NUMBER" name="PHONE_NUMBER" placeholder="010-1234-5678">
                </div>

                <div class="mb-3">
                    <label for="BIRTHDATE" class="form-label">생년월일</label>
                    <input type="date" class="form-control" id="BIRTHDATE" name="BIRTHDATE">
                </div>

                <div class="mb-4">
                    <label class="form-label d-block">성별</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="GENDER" id="male" value="1" required>
                        <label class="form-check-label" for="male">남성</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="GENDER" id="female" value="2">
                        <label class="form-check-label" for="female">여성</label>
                    </div>
                </div>

                <button type="submit" class="btn-register">등록하기</button>
                <div style="text-align: right; margin-top: 15px; font-size: 10px">
  				<a href="javascript:history.back()">이미 아이디가 있어요</a>
				</div>
            </form>
        </div>
    </main>

    <footer>
        &copy; 2025 요리조리. All Rights Reserved.
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
