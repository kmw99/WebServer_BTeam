<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>야경명소</title>
  <style>
    .title {
      text-align: center;
      font-size: 60px;
      font-weight: bold;
      color: white;
      margin-top: 20px;
    }
    .subtitle {
      text-align: center;
      font-size: 20px;
      font-weight: bold;
      color: white;
    }

    /* 배경 이미지 슬라이드 구조 */
    .section-with-background {
      position: relative;
      height: 100vh;
      margin-top: 0px;
      overflow: hidden;
    }
    .bg-fade-img {
      position: absolute;
      width: 100%; height: 100%;
      background-size: cover;
      background-position: center;
      opacity: 0;
      animation: bgfade 15s infinite;
      animation-timing-function: ease-in-out;
      z-index: 1;
      transition: opacity 1.5s ease-in-out;
    }
    .bg-fade-img.img1 {
      background-image: url('https://drive.google.com/thumbnail?id=1GtfyRlxmoHKhcS3ltBQyeMGSSOluDq7z&sz=w1000');
      animation-delay: 0s;
    }
    .bg-fade-img.img2 {
      background-image: url('https://drive.google.com/thumbnail?id=1bDUMbrH3kZxhpWbB15O8B9nQiyQyFeiN&sz=w1000');
      animation-delay: 5s;
    }
    .bg-fade-img.img3 {
      background-image: url('https://drive.google.com/thumbnail?id=1Kyw0Sl-A1h_RG1y9aIK5mCRS7033jwDg&sz=w1000');
      animation-delay: 10s;
    }
    @keyframes bgfade {
      0%   { opacity: 0; }
      5%   { opacity: 1; }
      33%  { opacity: 1; }
      43%  { opacity: 0; }
      100% { opacity: 0; }
    }

    .top-left-box {
      position: fixed;
      background: rgba(0,0,0,0.5);
      top: 8px;
      left: 8px;
      color: #fff;
      padding: 18px 28px;
      border: none;
      border-radius: 4px;
      font-size: 1.5rem;
      z-index: 10;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .top-buttons {
      position: fixed;
      top: 8px;
      right: 8px;
      display: flex;
      align-items: center;
      gap: 12px;
      z-index: 10;
    }
    .favorite-link {
      color: #fff;
      font-size: 1.2rem;
      cursor: pointer;
      padding: 18px 28px; /* 로그인 버튼과 동일한 패딩 */
      border-radius: 4px;
      background: rgba(0,0,0,0.5); /* 로그인 버튼과 동일한 배경 */
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      display: flex;
      align-items: center;
      height: 44px; /* 로그인 버튼과 동일한 높이 */
      text-decoration: none;
      user-select: none;
    }
    .favorite-link:hover {
      background: rgba(0,0,0,0.7); /* hover 시 배경 진하게 */
    }
    .top-right-box {
      background: rgba(0,0,0,0.5);
      color: #fff;
      padding: 18px 28px;
      border: none;
      border-radius: 4px;
      font-size: 1.2rem;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      text-align: center;
      cursor: pointer;
      user-select: none;
      display: flex;
      align-items: center;
      height: 44px;
      transition: background 0.15s;
    }
    .top-right-box:hover {
      background: rgba(0,0,0,0.7);
    }

    .bottom-center-box {
      position: absolute;
      left: 50%;
      bottom: 40px;
      transform: translateX(-50%);
      background: rgba(0,0,0,0.5);
      color: #fff;
      padding: 12px 48px;
      border: none;
      border-radius: 4px;
      font-size: 1.2rem;
      z-index: 10;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      text-align: center;
    }

    #search-form {
      display: flex;
      justify-content: center;
      align-items: flex-end;
      width: 350px;
      margin: 100px auto 0 auto;
      border-bottom: 2px solid #222; /* 두꺼운 밑줄 */
      padding-bottom: 10px;
      background: transparent;
    }

    #search-input {
      border: none;
      outline: none;
      background: transparent;
      font-size: 18px;
      margin-right: auto;
      color: #555;
      width: 120px;
      text-align: left;
    }

    #search-form button {
      border: none;
      background: transparent;
      font-size: 18px;
      color: #555;
      cursor: pointer;
      margin-left: auto;
    }

    #search-results {
      margin-top: 20px;
      border-top: 2px solid white;
    }

    #search-results div {
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }

    #search-results h3 {
      margin-top: 0;
    }

    #data-list {
      display: block;
    }

    .gallery-container {
      width: 90%;
      max-width: 1200px;
      margin: 120px auto 140px auto;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 40px;
    }

    .photo-card {
      position: relative;
      width: 240px;
      height: 240px;
      background: #17607a;
      border-radius: 4px;
      overflow: hidden;
      cursor: pointer;
      transition: transform 0.18s;
      display: flex;
      align-items: center;      
      justify-content: center;  
    }

    .photo-card img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
    }

    .photo-overlay {
      position: absolute;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.7);
      color: #fff;
      display: flex;
      align-items: center;      
      justify-content: center;  
      opacity: 0;
      font-size: 20px;
      font-weight: 400;
      text-align: center;
      transition: opacity 0.25s;
      padding: 0px;
      pointer-events: none;    
    }

    .photo-card:hover .photo-overlay {
      opacity: 1;
      pointer-events: auto;
    }

    .photo-card:hover {
      transform: scale(1.03);
    }

    .photo-card-wrap {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .photo-desc {
      margin-top: 12px;
      font-size: 18px;
      color: #888;
      text-align: center;
      font-family: 'Noto Sans KR', sans-serif;
      letter-spacing: -1px;
    }

    /* 로그인/회원가입 radio 토글 숨김 */
    .hidden-toggle {
      display: none;
    }

    /* 로그인/회원가입 폼 공통 스타일 */
    .form-popup {
      position: fixed;
      top: 90px;
      right: 10px;
      width: 280px;
      background: rgba(0,0,0,0.92);
      color: #fff;
      border-radius: 8px;
      padding: 24px 20px 20px 20px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.18);
      z-index: 100;
      display: none;
      transition: opacity 0.2s;
    }
    .form-popup label {
      display: block;
      margin-bottom: 6px;
      font-size: 15px;
    }
    .form-popup input[type="text"],
    .form-popup input[type="password"] {
      width: 100%;
      padding: 7px 10px 7px 10px;
      margin-bottom: 14px;
      border: none;
      border-radius: 4px;
      font-size: 15px;
      box-sizing: border-box;
    }
    .form-popup button,
    .form-popup label[for="popup-signup"],
    .form-popup label[for="popup-login"],
    .form-popup label[for="popup-close"] {
      width: 100%;
      padding: 9px 0;
      border: none;
      border-radius: 4px;
      background: #2186ae;
      color: #fff;
      font-size: 16px;
      margin-bottom: 10px;
      cursor: pointer;
      text-align: center;
      display: block;
      transition: background 0.15s;
    }
    .form-popup label[for="popup-close"] {
      background: #888;
      margin-top: 0;
      margin-bottom: 0;
    }
    .form-popup button:hover,
    .form-popup label[for="popup-signup"]:hover,
    .form-popup label[for="popup-login"]:hover,
    .form-popup label[for="popup-close"]:hover {
      background: #17607a;
    }
    #popup-login:checked ~ .form-popup.login-form { display: block; }
    #popup-signup:checked ~ .form-popup.signup-form { display: block; }
    #popup-close:checked ~ .form-popup.login-form,
    #popup-close:checked ~ .form-popup.signup-form { display: none; }
    
    .site-footer {
      width: 100%;
      background: #222;
      color: #fff;
      padding: 18px 0;
      position: relative;
      margin-top: 60px;
      font-size: 1rem;
      letter-spacing: 1px;
    }

    .footer-content {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: center;
      gap: 32px;
      align-items: center;
      text-align: center;
    }
  </style>
</head>
<body>
	<%@ include file="Header.jsp" %> <!-- 헤더 -->

  <!-- section-with-background 및 나머지 컨텐츠는 아래에 둡니다 -->
  <div class="section-with-background">
    <div class="bg-fade-img img1"></div>
    <div class="bg-fade-img img2"></div>
    <div class="bg-fade-img img3"></div>
    <div class="bottom-center-box">서울의 야경 명소를 구경하세요</div>
  </div>

  <!--검색창 있는 섹션-->
  <form id="search-form" action="SearchListForm.jsp" method="get">
    <select name="searchKey" id="search-key">
      <option value="name">장소명</option>
      <option value="address">주소</option>
    </select>
    <input type="search" name="searchValue" id="search-input" placeholder="검색어 입력" />
    <button type="submit">검색</button>
  </form>

  <div class="gallery-container">
    <div class="photo-card-wrap">
      <div class="photo-card">
        <img src="https://drive.google.com/thumbnail?id=1hMuBSOaMERmYrWJSYSICH_Ppec9wJBaq&sz=w1000" alt="광화문" />
        <div class="photo-overlay">광화문 광장</div>
      </div>
    </div>
    <div class="photo-card-wrap">
      <div class="photo-card">
        <img src="https://drive.google.com/thumbnail?id=1ay1mO0_LzfuWaNseZjQOKzPKd_68yMh6&sz=w1000" alt="DDP" />
        <div class="photo-overlay">DDP</div>
      </div>
    </div>
    <div class="photo-card-wrap">
      <div class="photo-card">
        <img src="https://drive.google.com/thumbnail?id=1_gmBPieuK-4U4JdeYGI0iFZ6NiEi3F61&sz=w1000" alt="숭례문" />
        <div class="photo-overlay">숭례문</div>
      </div>
    </div>
    <div class="photo-card-wrap">
      <div class="photo-card">
        <img src="https://drive.google.com/thumbnail?id=1qrkiHIggGdhr_R5mPYSA614yIgBedW3o&sz=w1000" alt="남산공원" />
        <div class="photo-overlay">남산 공원</div>
      </div>
    </div>
  </div>
  
  <%@ include file="Footer.jsp" %> <!-- 푸터 -->
</body>
</html>