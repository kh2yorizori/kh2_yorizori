<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>요리연구소</title>
  <style>
    /* 기본 스타일 */
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
	
	/* ---------------- 헤더 ---------------- */
	header {
	  display: flex;
	  align-items: center;
	  justify-content: space-between; /* 좌·중·우 3등분 */
	  padding: 15px 60px;
	  background-color: #fff;
	  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	  position: sticky;
	  top: 0;
	  z-index: 100;
	}
	
	/* 왼쪽 로고 */
	.header-left h1 {
	  font-size: 1.5rem;
	  color: #ff6f61;
	  font-weight: 800;
	  margin: 0;
	  white-space: nowrap;
	}
	
	/* 중앙 메뉴 */
	.header-center {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-wrap: wrap;
	  gap: 15px;
	  flex: 1; /* 가운데 영역이 자동 확장 */
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
	
	/* 오른쪽 아이콘 */
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
	
	/* 반응형: 화면 줄여도 오른쪽 고정 */
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
	
	/* ---------------- 메인 영역 ---------------- */
	main {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  justify-content: center;
	  height: 80vh;
	  position: relative;
	  overflow: hidden;
	}
	
	/* 슬라이드 컨테이너 */
	.slider {
	  width: 80%;
	  max-width: 900px;
	  height: 500px;
	  position: relative;
	  overflow: hidden;
	  border-radius: 20px;
	  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	}
	
	.slides {
	  display: flex;
	  width: 100%;
	  height: 100%;
	  transition: transform 1s ease-in-out;
	}
	
	.slide {
	  min-width: 100%;
	  height: 100%;
	}
	
	.slide img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	}
	
	/* 네비게이션 버튼 */
	.prev,
	.next {
	  position: absolute;
	  top: 50%;
	  transform: translateY(-50%);
	  background-color: rgba(0, 0, 0, 0.4);
	  color: #fff;
	  border: none;
	  font-size: 24px;
	  padding: 10px 15px;
	  border-radius: 50%;
	  cursor: pointer;
	  transition: background-color 0.3s;
	}
	
	.prev:hover,
	.next:hover {
	  background-color: rgba(0, 0, 0, 0.7);
	}
	
	.prev {
	  left: 15px;
	}
	
	.next {
	  right: 15px;
	}
	
	/* 점 네비게이션 */
	.dots {
	  position: absolute;
	  bottom: 15px;
	  display: flex;
	  justify-content: center;
	  width: 100%;
	}
	
	.dot {
	  height: 12px;
	  width: 12px;
	  margin: 0 6px;
	  background-color: #bbb;
	  border-radius: 50%;
	  display: inline-block;
	  transition: background-color 0.3s;
	  cursor: pointer;
	}
	
	.dot.active {
	  background-color: #2e7d32;
	}
	
	/* ---------------- 푸터 ---------------- */
	footer {
	  text-align: center;
	  padding: 20px 50px;
	  margin-top: 20px;
	  border-top: 1px solid #e0e0e0;
	  color: #888;
	  font-size: 14px;
	}
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
	
	/* ---------------- 헤더 ---------------- */
	header {
	  display: flex;
	  align-items: center;
	  justify-content: space-between; /* 좌·중·우 3등분 */
	  padding: 15px 60px;
	  background-color: #fff;
	  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	  position: sticky;
	  top: 0;
	  z-index: 100;
	}
	
	/* 왼쪽 로고 */
	.header-left h1 {
	  font-size: 1.5rem;
	  color: #ff6f61;
	  font-weight: 800;
	  margin: 0;
	  white-space: nowrap;
	}
	
	/* 중앙 메뉴 */
	.header-center {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-wrap: wrap;
	  gap: 15px;
	  flex: 1; /* 가운데 영역이 자동 확장 */
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
	
	/* 오른쪽 아이콘 */
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
	
	/* 반응형: 화면 줄여도 오른쪽 고정 */
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
	
	/* ---------------- 메인 영역 ---------------- */
	main {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  justify-content: center;
	  height: 80vh;
	  position: relative;
	  overflow: hidden;
	}
	
	/* 슬라이드 컨테이너 */
	.slider {
	  width: 80%;
	  max-width: 900px;
	  height: 500px;
	  position: relative;
	  overflow: hidden;
	  border-radius: 20px;
	  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	}
	
	.slides {
	  display: flex;
	  width: 100%;
	  height: 100%;
	  transition: transform 1s ease-in-out;
	}
	
	.slide {
	  min-width: 100%;
	  height: 100%;
	}
	
	.slide img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	}
	
	/* 네비게이션 버튼 */
	.prev,
	.next {
	  position: absolute;
	  top: 50%;
	  transform: translateY(-50%);
	  background-color: rgba(0, 0, 0, 0.4);
	  color: #fff;
	  border: none;
	  font-size: 24px;
	  padding: 10px 15px;
	  border-radius: 50%;
	  cursor: pointer;
	  transition: background-color 0.3s;
	}
	
	.prev:hover,
	.next:hover {
	  background-color: rgba(0, 0, 0, 0.7);
	}
	
	.prev {
	  left: 15px;
	}
	
	.next {
	  right: 15px;
	}
	
	/* 점 네비게이션 */
	.dots {
	  position: absolute;
	  bottom: 15px;
	  display: flex;
	  justify-content: center;
	  width: 100%;
	}
	
	.dot {
	  height: 12px;
	  width: 12px;
	  margin: 0 6px;
	  background-color: #bbb;
	  border-radius: 50%;
	  display: inline-block;
	  transition: background-color 0.3s;
	  cursor: pointer;
	}
	
	.dot.active {
	  background-color: #2e7d32;
	}
	
	/* ---------------- 푸터 ---------------- */
	footer {
	  text-align: center;
	  padding: 20px 50px;
	  margin-top: 20px;
	  border-top: 1px solid #e0e0e0;
	  color: #888;
	  font-size: 14px;
	</style>
  <!-- 아이콘용 CDN -->
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
/>
</head>
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
 

<main>
  <div class="slider">
    <div class="slides">
      <div class="slide"><img src="https://cdn.pixabay.com/photo/2016/03/05/19/02/salmon-1238248_1280.jpg" alt="연어 요리"></div>
      <div class="slide"><img src="https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg" alt="샐러드"></div>
      <div class="slide"><img src="https://cdn.pixabay.com/photo/2017/03/10/11/40/spaghetti-2131623_1280.jpg" alt="파스타"></div>
      <div class="slide"><img src="https://cdn.pixabay.com/photo/2016/03/05/22/50/appetite-1238255_1280.jpg" alt="스테이크"></div>
      <div class="slide"><img src="https://cdn.pixabay.com/photo/2016/11/18/15/58/pancakes-1839131_1280.jpg" alt="팬케이크"></div>
    </div>

    <!-- 네비게이션 버튼 -->
    <button class="prev">&#10094;</button>
    <button class="next">&#10095;</button>

    <!-- 점 네비게이션 -->
    <div class="dots"></div>
  </div>
</main>

  

<footer>
  © 2025 요리조리 - 쉽고 맛있는 요리 아이디어의 시작.  
  오늘은 무엇을 요리해볼까요?
</footer>

<script>
  const slides = document.querySelector('.slides');
  const slideCount = document.querySelectorAll('.slide').length;
  const prevBtn = document.querySelector('.prev');
  const nextBtn = document.querySelector('.next');
  const dotsContainer = document.querySelector('.dots');
  let currentIndex = 0;
  let autoSlide;

  // 점 생성
  for (let i = 0; i < slideCount; i++) {
    const dot = document.createElement('span');
    dot.classList.add('dot');
    if (i === 0) dot.classList.add('active');
    dot.addEventListener('click', () => goToSlide(i));
    dotsContainer.appendChild(dot);
  }

  const dots = document.querySelectorAll('.dot');

  function showSlide(index) {
    slides.style.transform = `translateX(-${index * 100}%)`;
    dots.forEach(dot => dot.classList.remove('active'));
    dots[index].classList.add('active');
  }

  function goToSlide(index) {
    currentIndex = (index + slideCount) % slideCount;
    showSlide(currentIndex);
  }

  prevBtn.addEventListener('click', () => goToSlide(currentIndex - 1));
  nextBtn.addEventListener('click', () => goToSlide(currentIndex + 1));

  function startAutoSlide() {
    autoSlide = setInterval(() => goToSlide(currentIndex + 1), 4000);
  }

  function stopAutoSlide() {
    clearInterval(autoSlide);
  }

  document.querySelector('.slider').addEventListener('mouseenter', stopAutoSlide);
  document.querySelector('.slider').addEventListener('mouseleave', startAutoSlide);

  startAutoSlide();
</script>

</body>
</html>
