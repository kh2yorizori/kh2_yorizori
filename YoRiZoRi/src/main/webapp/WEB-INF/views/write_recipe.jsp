<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>레시피 등록 - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 기본 스타일 */
        body {
            font-family: "Noto Sans KR", sans-serif; margin: 0; padding: 0;
            background-color: #fffaf7; color: #333;
        }
        a { text-decoration: none; color: inherit; }

        /* ---------------- 헤더 ---------------- */
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
        	display: flex;
            justify-content: center; align-items: center;
            flex-wrap: wrap; gap: 15px;
            flex: 1; /* 이 속성이 가운데 영역을 확장시켜 레이아웃 깨짐을 방지합니다. */
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

        /* 검색창, 로그인 메뉴 스타일 */
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

        /* ---------------- 메인 & 폼 스타일 ---------------- */
        main { padding: 40px 20px; }
        .form-container { width: 90%; max-width: 800px; margin: 0 auto; padding: 40px; background-color: #fff; border-radius: 15px; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08); }
        .form-container h2 { text-align: center; color: #ff6f61; margin-top: 0; margin-bottom: 40px; font-size: 2rem; }
        fieldset { border: none; padding: 0; margin: 0 0 35px 0; border-bottom: 1px solid #eee; padding-bottom: 25px; }
        fieldset:last-of-type { border-bottom: none; }
        legend { font-size: 1.4rem; font-weight: 600; color: #2e7d32; margin-bottom: 25px; width: 100%; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 0.95rem; }
        input[type="text"], input[type="number"], textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 1rem; transition: border-color 0.3s, box-shadow 0.3s; }
        input[type="text"]:focus, input[type="number"]:focus, textarea:focus { outline: none; border-color: #ff6f61; box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2); }
        textarea { resize: vertical; min-height: 120px; }
        input[type="file"] { font-size: 0.95rem; }
        .category-group label { display: inline-flex; align-items: center; margin-right: 20px; cursor: pointer; }
        .category-group input[type="checkbox"] { margin-right: 8px; }
        .dynamic-item { display: flex; gap: 10px; align-items: center; margin-bottom: 10px; }
        .dynamic-item input[type="text"] { flex-grow: 1; }
        button { padding: 12px 20px; border-radius: 8px; border: none; cursor: pointer; font-size: 1rem; font-weight: 600; transition: background-color 0.3s, transform 0.2s; }
        button:hover { transform: translateY(-2px); }
        .btn-add { background-color: #e0e0e0; color: #333; }
        .btn-add:hover { background-color: #d0d0d0; }
        .btn-remove { background-color: #fbe9e7; color: #ff6f61; padding: 8px 12px; font-size: 0.9rem; }
        .btn-remove:hover { background-color: #ffccbc; }
        .btn-submit { display: block; width: 100%; padding: 15px; font-size: 1.2rem; background-color: #ff6f61; color: white; margin-top: 20px; }
        .btn-submit:hover { background-color: #e65a50; }
        footer { text-align: center; padding: 20px 50px; margin-top: 20px; border-top: 1px solid #e0e0e0; color: #888; font-size: 14px; }
    </style>
</head>
<body>

<header>
    <div class="header-left">
        <h1><a href="<c:url value='/home'/>">요리조리</a></h1>
    </div>
    <nav class="header-center">
        <a href="<c:url value='/home'/>">메인화면</a>
        <a href="<c:url value='/select_result'/>">레시피 보기</a>
        <a href="<c:url value='/category_view'/>">레시피 분류</a>
        <a href="https://www.dogumaster.com/select/menu" target="_blank">메뉴 선택해줘</a>
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
        <c:when test="${empty sessionScope.id}">
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
        </c:when>
        <c:otherwise>
            <p style="padding: 12px 25px; margin: 0; font-weight: bold; text-align: left;">
                ${sessionScope.name}님 환영합니다!
            </p>
            <button type="button" onclick="location.href='<c:url value="/list"/>'">마이페이지</button>
            <form method="post" action="${pageContext.request.contextPath}/logout" style="margin: 0;">
                <button type="submit">로그아웃</button>
            </form>
        </c:otherwise>
    </c:choose>
     <c:if test="${not empty sessionScope.id}">
        <form method="get" action="${pageContext.request.contextPath}/recipe/write">
            <button type="submit">레시피 등록</button>
        </form>
    </c:if>
    <c:if test="${sessionScope.admin == 1}">
        <form method="get" action="${pageContext.request.contextPath}/role">
            <button type="submit">관리자페이지</button>
        </form>
    </c:if>
</div>
    
<main>
    <div class="form-container">
        <form action="${pageContext.request.contextPath}/submit" method="post" enctype="multipart/form-data">
            <h2>레시피 등록</h2>

            <fieldset>
                <legend>레시피 정보</legend>
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">설명</label>
                    <textarea id="description" name="description" required></textarea>
                </div>
                <div class="form-group">
                    <label for="servingSize">인분 수</label>
                    <input type="number" id="servingSize" name="servingSize">
                </div>
                <div class="form-group">
                    <label for="difficulty">난이도 (1~5)</label>
                    <input type="number" id="difficulty" name="difficulty" min="1" max="5">
                </div>
                <div class="form-group">
                    <label for="cookingTime">조리 시간</label>
                    <input type="text" id="cookingTime" name="cookingTime">
                </div>
                <div class="form-group">
                    <label for="mainImageFile">메인 이미지</label>
                    <input type="file" id="mainImageFile" name="mainImageFile">
                </div>
            </fieldset>

            <fieldset>
          <legend>카테고리</legend>
	          <div class="form-group category-group">
	              <c:forEach items="${categories}" var="category">
	                  <label>
	                      <%-- ✅ type="radio", name="categoryId"로 변경 --%>
	                      <input type="radio" name="categoryId" value="${category.categoryId}"> ${category.name}
	                  </label>
	              </c:forEach>
	          </div>
	      </fieldset>

            <fieldset>
                <legend>재료</legend>
                <div id="ingredients">
                    <div class="ingredient dynamic-item">
                        <input type="text" name="ingredients[0].name" placeholder="재료명" required>
                        <input type="text" name="ingredients[0].quantity" placeholder="양" required>
                        <button type="button" class="removeIngredientBtn btn-remove">삭제</button>
                    </div>
                </div>
                <button type="button" id="addIngredientBtn" class="btn-add">재료 추가</button>
            </fieldset>

            <fieldset>
                <legend>조리 순서</legend>
                <div id="steps">
                    <div class="step dynamic-item">
                        <input type="text" name="steps[0].stepNumber" value="1" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
                        <input type="text" name="steps[0].instruction" placeholder="설명" required>
                        <input type="file" name="steps[0].imageFile" style="flex-grow:0;">
                        <button type="button" class="removeStepBtn btn-remove">삭제</button>
                    </div>
                </div>
                <button type="button" id="addStepBtn" class="btn-add">조리 순서 추가</button>
            </fieldset>

            <button type="submit" class="btn-submit">등록하기</button>
        </form>
    </div>
</main>

<footer>
    © 2025 요리조리 - 쉽고 맛있는 요리 아이디어의 시작. 오늘은 무엇을 요리해볼까요?
</footer>

<div id="ingredient-template" style="display: none;">
    <div class="ingredient dynamic-item">
        <input type="text" name="ingredients[__INDEX__].name" placeholder="재료명" required>
        <input type="text" name="ingredients[__INDEX__].quantity" placeholder="양" required>
        <button type="button" class="removeIngredientBtn btn-remove">삭제</button>
    </div>
</div>
<div id="step-template" style="display: none;">
    <div class="step dynamic-item">
        <input type="text" name="steps[__INDEX__].stepNumber" value="__STEP_NUMBER__" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
        <input type="text" name="steps[__INDEX__].instruction" placeholder="설명" required>
        <input type="file" name="steps[__INDEX__].imageFile" style="flex-grow:0;">
        <button type="button" class="removeStepBtn btn-remove">삭제</button>
    </div>
</div>

<%-- [v8 - 헤더 JS 분리] 이 <script> 블록으로 전체를 교체하세요. --%>
<script>
    // ========== 헤더 기능 Javascript ( 순수 JS로 변경, ready() 밖으로 이동) ==========
    // recipeDetail.jsp와 동일한, 애니메이션이 작동하는 코드입니다.
    const searchIcon = document.getElementById('search-icon');
    const searchBox = document.querySelector('.search-box');
    const searchInput = document.querySelector('.search-input');
    const menuToggle = document.getElementById('menu-toggle');
    const loginMenu = document.getElementById('login-menu');

    if (searchIcon) { // 요소가 존재하는지 확인 (안전성)
        searchIcon.addEventListener('click', (e) => {
            searchBox.classList.toggle('active');
            if (searchBox.classList.contains('active')) {
                searchInput.focus();
            }
            e.stopPropagation(); // jQuery의 stopPropagation과 동일
        });
    }

    if (menuToggle) { // 요소가 존재하는지 확인 (안전성)
        menuToggle.addEventListener('click', (e) => {
            loginMenu.classList.toggle('show');
            if (menuToggle.classList.contains('bi-list')) {
                menuToggle.classList.remove('bi-list');
                menuToggle.classList.add('bi-x');
            } else {
                menuToggle.classList.remove('bi-x');
                menuToggle.classList.add('bi-list');
            }
            e.stopPropagation(); // jQuery의 stopPropagation과 동일
        });
    }

    // 화면의 다른 곳을 클릭하면 열려있는 메뉴들이 닫히도록 설정
    document.addEventListener('click', function() {
        if (searchBox && searchBox.classList.contains('active')) {
            searchBox.classList.remove('active');
        }
        if (loginMenu && loginMenu.classList.contains('show')) {
            loginMenu.classList.remove('show');
            if(menuToggle) { // 아이콘 원래대로
                 menuToggle.classList.remove('bi-x');
                 menuToggle.classList.add('bi-list');
            }
        }
    });

    // 메뉴나 검색창 안쪽을 클릭했을 때는 닫히지 않도록 이벤트 전파를 막음
    if (loginMenu) {
        loginMenu.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    }
    if (searchBox) {
        searchBox.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    }
    // (헤더 기능 끝)
    // ===========================================


    // ===========================================
    // ✅ 재료/순서 로직은 jQuery를 사용하므로 $(document).ready() 안에 남겨둡니다.
    // ===========================================
    $(document).ready(function() {
        
        // 1. 재료 추가 로직 (기존과 동일)
        $('#addIngredientBtn').click(function () {
            const newIndex = $('#ingredients .ingredient').length;
            const template = $('#ingredient-template').html();
            const newHtml = template.replace(/__INDEX__/g, newIndex);
            $('#ingredients').append(newHtml);
        });

        // 2. 재료 삭제 로직 (v7 - 순서 기반)
        $('#ingredients').on('click', '.removeIngredientBtn', function () {
            if ($('#ingredients .ingredient').length <= 1) {
                 alert("최소 1개의 재료는 필요합니다.");
                 return;
            }
            $(this).closest('.ingredient').remove();
            $('#ingredients .ingredient').each(function (index) {
                const inputs = $(this).find('> input');
                if (inputs.length >= 2) {
                    inputs.eq(0).attr('name', 'ingredients[' + index + '].name');
                    inputs.eq(1).attr('name', 'ingredients[' + index + '].quantity');
                } else {
                     console.error("[오류] 재료 " + index + ": 예상과 달리 input이 " + inputs.length + "개 발견됨");
                }
            });
        }); // 재료 삭제 로직 끝

        // 3. 조리 순서 추가 로직 (기존과 동일)
        $('#addStepBtn').click(function () {
            const newIndex = $('#steps .step').length;
            const newStepNumber = newIndex + 1;
            const template = $('#step-template').html();
            let newHtml = template.replace(/__INDEX__/g, newIndex);
            newHtml = newHtml.replace(/__STEP_NUMBER__/g, newStepNumber);
            $('#steps').append(newHtml);
        });

        // 4. 조리 순서 삭제 로직 (v7 - 순서 기반)
        $('#steps').on('click', '.removeStepBtn', function () {
            if ($('#steps .step').length <= 1) {
                alert("최소 1개의 조리 순서는 필요합니다.");
                return;
            }
            $(this).closest('.step').remove();
            $('#steps .step').each(function (index) {
                const stepNumber = index + 1;
                const inputs = $(this).find('input');
                if (inputs.length >= 3) {
                    inputs.eq(0).val(stepNumber);
                    inputs.eq(0).attr('name', 'steps[' + index + '].stepNumber');
                    inputs.eq(1).attr('name', 'steps[' + index + '].instruction');
                    inputs.eq(2).attr('name', 'steps[' + index + '].imageFile');
                } else {
                     console.error("[오류] 조리 순서 " + index + ": 예상과 달리 input이 " + inputs.length + "개 발견됨");
                }
            });
        }); // 조리 순서 삭제 로직 끝

    }); // $(document).ready 끝
</script>
</body>
</html>