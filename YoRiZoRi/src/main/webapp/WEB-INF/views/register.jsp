<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 | 요리조리</title>

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>

    <style>
        /* ====== Common Styles ====== */
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

        /* ====== Header (Same as other pages) ====== */
        header {
            display: flex; align-items: center; justify-content: space-between;
            padding: 15px 60px; background-color: #fff; box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            position: sticky; top: 0; z-index: 100;
        }
        .header-left h1 {
            font-size: 1.5rem; color: #ff6f61; font-weight: 800; margin: 0; white-space: nowrap;
        }
        .header-center {
            display: flex; justify-content: center; align-items: center; flex-wrap: wrap; gap: 15px; flex: 1;
        }
        .header-center a {
            padding: 8px 14px; border-radius: 20px; font-size: 14px; background-color: #f3f3f3;
            transition: background-color 0.3s, color 0.3s; white-space: nowrap;
        }
        .header-center a:hover { background-color: #2e7d32; color: white; }
        .header-right { display: flex; align-items: center; gap: 18px; }
        .header-right i { font-size: 1.5rem; cursor: pointer; color: #333; transition: color 0.2s ease; }
        .header-right i:hover { color: #2e7d32; }
        .search-box { display: flex; align-items: center; }
        .search-input {
            width: 0; padding: 0; border: none; outline: none; opacity: 0;
            transition: all 0.4s ease; border-bottom: 2px solid transparent; font-size: 14px;
        }
        .search-box.active .search-input {
            width: 150px; opacity: 1; padding: 5px; border-bottom: 2px solid #333; margin-right: 8px;
        }
        .login-menu {
            position: fixed; top: 75px; right: 30px; background-color: white; border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15); overflow: hidden; max-height: 0;
            transition: max-height 0.4s ease-out, padding 0.4s ease-out; padding: 0; z-index: 101;
        }
        .login-menu.show { max-height: 200px; padding: 10px 0; }
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

        /* ====== Registration Form Area ====== */
        .register-container {
            flex: 1; display: flex; justify-content: center; align-items: center; padding: 50px 20px;
        }
        .register-box {
            background: white; padding: 40px 50px; border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1); width: 100%; max-width: 500px;
        }
        .register-box h2 {
            font-size: 2rem; font-weight: 800; color: #ff6f61; margin-bottom: 10px; text-align: center;
        }
        .required-info {
            text-align: right; font-size: 0.8rem; color: #888; margin-bottom: 25px;
        }
        .input-group {
            position: relative;
        }
        .input-group i {
            position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
            color: #aaa; font-size: 1.1rem;
        }
        .form-control {
            width: 100%; padding: 12px 15px 12px 45px; border: 1px solid #ddd; border-radius: 8px;
            font-size: 1rem; box-sizing: border-box; transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #ff6f61; box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2); outline: none;
        }
        
        /* Validation message and spacing styles */
        .validation-msg { 
            font-size: 0.85em; 
            padding-left: 5px; 
            display: block; 
            min-height: 1.2em; /* Reserve space for message */
            margin-top: 4px;
            margin-bottom: 14px; /* Consistent bottom margin for spacing */
        }
        .success { color: #28a745; }
        .fail { color: #dc3545; }
        
        .gender-group {
            text-align: left; padding: 10px 0;
            margin-bottom: 10px; /* Spacing for gender group */
        }
        .gender-group label {
            margin-right: 20px; font-size: 1rem; cursor: pointer;
        }
        .gender-group input[type="radio"] {
            margin-right: 6px; accent-color: #ff6f61; transform: scale(1.2); cursor: pointer;
        }
        .btn-register {
            width: 100%; background-color: #ff6f61; color: white; border: none; padding: 14px;
            font-size: 1.1rem; font-weight: 700; border-radius: 8px; cursor: pointer;
            transition: background-color 0.3s, transform 0.2s; margin-top: 15px;
        }
        .btn-register:hover {
            background-color: #e65a4c; transform: translateY(-2px);
        }
        .links-area {
            margin-top: 20px; font-size: 0.9rem; color: #777; text-align: center;
        }
        .links-area a {
            color: #555; margin: 0 10px; transition: color 0.2s;
        }
        .links-area a:hover { color: #ff6f61; }
        
        /* ====== Footer ====== */
        footer {
            text-align: center; padding: 20px 0; margin-top: auto; color: #888; font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <!-- Header -->
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

    <!-- Header dropdown menu -->
    <div class="login-menu" id="login-menu">
        <form method="post" action="login">
            <button type="submit">로그인</button>
        </form>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
    </div>

    <!-- Registration form -->
    <main class="register-container">
        <div class="register-box">
            <h2>회원가입</h2>
            <p class="required-info">* 표시된 항목은 필수 입력사항입니다.</p>
            <form id="registerForm" method="post" action="registerOk" enctype="multipart/form-data">
                <!-- 일반 사용자는 admin_ck = 0 -->
                <input type="hidden" name="ADMIN_CK" value="0">
                
                <div class="input-group">
                    <i class="bi bi-person-fill"></i>
                    <input type="text" id="memberId" class="form-control" name="MEMBER_ID" placeholder="아이디*" required>
                </div>
                <div class="validation-msg" id="idMsg"></div>

                <div class="input-group">
                    <i class="bi bi-person-badge"></i>
                    <input type="text" class="form-control" name="NAME" placeholder="이름*" required>
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->

                <div class="input-group">
                    <i class="bi bi-lock-fill"></i>
                    <input type="password" class="form-control" name="PASSWORD" placeholder="비밀번호*" required>
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->

                <div class="input-group">
                    <i class="bi bi-emoji-smile-fill"></i>
                    <input type="text" id="nickname" class="form-control" name="NICKNAME" placeholder="닉네임*" required>
                </div>
                <div class="validation-msg" id="nicknameMsg"></div>

                <div class="input-group">
                    <i class="bi bi-envelope-fill"></i>
                    <input type="email" id="email" class="form-control" name="EMAIL" placeholder="이메일*" required>
                </div>
                <div class="validation-msg" id="emailMsg"></div>
                
                <div class="input-group">
                    <i class="bi bi-telephone-fill"></i>
                    <input type="tel" id="phoneNumber" class="form-control" name="PHONE_NUMBER" placeholder="휴대폰 번호 (- 없이 입력)*" required>
                </div>
                <div class="validation-msg" id="phoneMsg"></div>
                
                <div class="input-group">
                    <i class="bi bi-calendar-event-fill"></i>
                    <input type="date" class="form-control" name="BIRTHDATE" required>
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->
                
                <div class="input-group">
                    <i class="bi bi-image-fill"></i>
                    <input type="file" class="form-control" name="PROFILE_IMAGE" accept="image/*">
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->
                
                <div class="gender-group">
                    <strong>성별*</strong>&nbsp;&nbsp;&nbsp;
                    <label><input type="radio" name="GENDER" value="1" required> 남성</label>
                    <label><input type="radio" name="GENDER" value="2"> 여성</label>
                </div>

                <button type="submit" class="btn-register">가입하기</button>
                
                <div class="links-area">
                    <a href="${pageContext.request.contextPath}/login">이미 회원이신가요?</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        © 2025 요리조리 | All rights reserved.
    </footer>

    <script>
        // Header functionality
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
            menuToggle.classList.toggle('bi-list');
            menuToggle.classList.toggle('bi-x');
        });

        // ===================================================
        //            Real-time Duplicate Check Script
        // ===================================================

        const validationStatus = {
            id: false,
            nickname: false,
            email: false,
            phone: false
        };

        async function checkDuplicate(fieldType, value) {
            const msgElement = document.getElementById(fieldType + 'Msg');
            if (!value.trim()) {
                msgElement.textContent = '';
                validationStatus[fieldType] = false;
                return;
            }

            const formData = new URLSearchParams({ fieldType, value });

            try {
                const response = await fetch('checkDuplicate', {
                    method: 'POST',
                    body: formData
                });
                const result = await response.text();
                
                let message = '';
                
                if (result === 'SUCCESS') {
                    validationStatus[fieldType] = true;
                    msgElement.className = 'validation-msg success';
                    if (fieldType === 'id') message = '사용 가능한 아이디입니다.';
                    else if (fieldType === 'nickname') message = '멋진 닉네임이네요!';
                    else if (fieldType === 'email') message = '사용 가능한 이메일입니다.';
                    else if (fieldType === 'phone') message = '사용 가능한 전화번호입니다.';
                } else {
                    validationStatus[fieldType] = false;
                    msgElement.className = 'validation-msg fail';
                    if (fieldType === 'id') message = '이미 사용 중인 아이디입니다.';
                    else if (fieldType === 'nickname') message = '이미 사용 중인 닉네임입니다.';
                    else if (fieldType === 'email') message = '이미 등록된 이메일입니다.';
                    else if (fieldType === 'phone') message = '이미 등록된 전화번호입니다.';
                }
                msgElement.textContent = message;

            } catch (error) {
                console.error('Error:', error);
                msgElement.className = 'validation-msg fail';
                msgElement.textContent = '확인 중 오류가 발생했습니다.';
            }
        }

        document.getElementById('memberId').addEventListener('blur', (e) => checkDuplicate('id', e.target.value));
        document.getElementById('nickname').addEventListener('blur', (e) => checkDuplicate('nickname', e.target.value));
        document.getElementById('email').addEventListener('blur', (e) => checkDuplicate('email', e.target.value));
        document.getElementById('phoneNumber').addEventListener('blur', (e) => checkDuplicate('phone', e.target.value));

        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const checks = [
                {key: 'id', name: '아이디', element: 'memberId'}, 
                {key: 'nickname', name: '닉네임', element: 'nickname'},
                {key: 'email', name: '이메일', element: 'email'}, 
                {key: 'phone', name: '전화번호', element: 'phoneNumber'}
            ];

            for (const check of checks) {
                if (!validationStatus[check.key]) {
                    e.preventDefault();
                    alert(`${check.name} 중복 확인이 필요하거나, 사용할 수 없는 값입니다.`);
                    document.getElementById(check.element).focus();
                    return;
                }
            }
        });
    </script>
</body>
</html>

