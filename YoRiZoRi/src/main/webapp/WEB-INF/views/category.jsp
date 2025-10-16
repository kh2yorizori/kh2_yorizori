<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>요리연구소 | 레시피 분류</title>
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
    font-size: 1.5rem;
    color: #ff6f61;
    font-weight: 800;
    margin: 0;
    white-space: nowrap;
  }

  .header-center {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
    flex: 1;
  }

  .header-center a {
    padding: 8px 14px;
    border-radius: 20px;
    font-size: 14px;
    background-color: #f3f3f3;
    transition: background-color 0.3s, color 0.3s;
    white-space: nowrap;
  }

  .header-center a:hover {
    background-color: #2e7d32;
    color: white;
  }

  .header-right {
    display: flex;
    align-items: center;
    gap: 18px;
  }

  .header-right i {
    font-size: 1.3rem;
    cursor: pointer;
    color: #333;
    transition: color 0.2s ease;
  }

  .header-right i:hover {
    color: #2e7d32;
  }

  @media (max-width: 768px) {
    .header-center {
      gap: 10px;
      font-size: 13px;
    }
    header {
      padding: 10px 30px;
    }
    .header-right i {
      font-size: 1.2rem;
    }
  }

  /* ====== 레시피 폼 영역 ====== */
  .container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 80vh;
  }

  .form-box {
    background-color: #ffffff;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    padding: 40px 50px;
    width: 480px;
    text-align: center;
    transition: transform 0.3s ease;
  }

  .form-box:hover {
    transform: translateY(-3px);
  }

  h2 {
    font-size: 1.8rem;
    font-weight: 700;
    margin-bottom: 1.5rem;
    color: #ff6f61;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 1.5rem;
  }

  td {
    padding: 12px 8px;
    vertical-align: middle;
    text-align: left;
  }

  td:first-child {
    font-weight: 600;
    width: 30%;
    color: #555;
  }

  label {
    margin-right: 15px;
    font-size: 1rem;
    cursor: pointer;
  }

  input[type="checkbox"],
  input[type="radio"] {
    margin-right: 6px;
    accent-color: #ff6f61;
    transform: scale(1.2);
    cursor: pointer;
  }

  .btn-area {
    text-align: center;
    margin-top: 20px;
  }

  input[type="submit"],
  input[type="reset"] {
    background-color: #ff6f61;
    border: none;
    color: white;
    font-weight: 600;
    font-size: 1rem;
    padding: 10px 28px;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.25s ease;
    margin: 0 10px;
  }

  input[type="submit"]:hover,
  input[type="reset"]:hover {
    background-color: #e85c4c;
  }

  footer {
    background-color: #fff;
    text-align: center;
    padding: 20px 0;
    color: #aaa;
    font-size: 0.9rem;
    border-top: 1px solid #eee;
    margin-top: 50px;
  }
</style>

<!-- 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>

</head>
<body>

<header>
  <div class="header-left">
    <h1>요리연구소</h1>
  </div>

  <nav class="header-center">
    <a href="home">메인화면</a>
    <a href="select_result">레시피 보기</a>
    <a href="category_view">레시피 분류</a>
    <a href="https://www.dogumaster.com/select/menu">메뉴 선택해줘</a>
    <a href="#">WOW이벤트</a>
  </nav>

  <div class="header-right">
    <i class="bi bi-search"></i>
    <i class="bi bi-list"></i>
  </div>
</header>

<!-- ===== 본문 영역 ===== -->
<div class="container">
  <div class="form-box">
    <h2>레시피 분류 선택</h2>
    <form method="post" action="select_result" id="categoryForm">
      <table>
        <tr>
          <td>카테고리</td>
          <td>
            <label><input type="checkbox" name="category" value="1" />한식</label>
            <label><input type="checkbox" name="category" value="2" />중식</label>
            <label><input type="checkbox" name="category" value="3" />양식</label>
            <label><input type="checkbox" name="category" value="4" />일식</label>
            <label><input type="checkbox" name="category" value="5" />디저트</label>
          </td>
        </tr>
        <tr>
          <td>정렬 방법</td>
          <td>
            <label><input type="radio" name="order" value="hit" checked />인기순</label>
            <label><input type="radio" name="order" value="rating" />평점순</label>
          </td>
        </tr>
      </table>
      <div class="btn-area">
        <input type="submit" value="전송" />
        <input type="reset" value="취소" />
      </div>
    </form>
  </div>
</div>

<footer>
  <p>© 2025 요리연구소 | All rights reserved.</p>
</footer>

</body>
</html>
