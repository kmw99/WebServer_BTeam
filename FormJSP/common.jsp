<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>replit</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>
    .top-left-box {
      position: fixed;
      background: rgba(0,0,0,0.5);
      color: #fff;
      padding: 18px 28px;
      border: none;
      border-radius: 4px;
      font-size: 1.5rem;
      z-index: 10;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .top-right-box {
      position: fixed;
      background: rgba(0,0,0,0.5);
      right: 8px;
      color: #fff;
      padding: 18px 28px;
      border: none;
      border-radius: 4px;
      font-size: 1.2rem;
      z-index: 10;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      text-align: center;
      cursor: pointer;
      user-select: none;
    }
    .hidden-toggle { display: none; }
    .form-popup { /* ...생략: 기존 스타일 복사 ... */ }
    /* ...생략: 기존 스타일 복사 ... */
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
  <!-- 로그인/회원가입 radio 버튼 -->
  <input type="radio" name="popup" id="popup-close" class="hidden-toggle" checked>
  <input type="radio" name="popup" id="popup-login" class="hidden-toggle">
  <input type="radio" name="popup" id="popup-signup" class="hidden-toggle">

  <!-- 로그인/회원가입 버튼 -->
  <label for="popup-login" class="top-right-box">로그인/회원가입</label>

  <!-- 로그인 폼 -->
  <div class="form-popup login-form">
    <form autocomplete="off" onsubmit="return false;">
      <label for="login-id">아이디</label>
      <input type="text" id="login-id" name="login-id" autocomplete="username">
      <label for="login-pw">비밀번호</label>
      <input type="password" id="login-pw" name="login-pw" autocomplete="current-password">
      <button type="submit">로그인</button>
      <label for="popup-signup" style="background:#444; margin-bottom:0; margin-top:8px; cursor:pointer;">회원가입</label>
      <label for="popup-close" style="background:#888; margin-bottom:0; margin-top:8px; cursor:pointer;">닫기</label>
    </form>
  </div>

  <!-- 회원가입 폼 -->
  <div class="form-popup signup-form">
    <form autocomplete="off" onsubmit="return false;">
      <label for="signup-id">아이디</label>
      <input type="text" id="signup-id" name="signup-id" autocomplete="username">
      <label for="signup-pw">비밀번호</label>
      <input type="password" id="signup-pw" name="signup-pw" autocomplete="new-password">
      <label for="signup-pw-confirm">비밀번호 확인</label>
      <input type="password" id="signup-pw-confirm" name="signup-pw-confirm" autocomplete="new-password">
      <label for="popup-login" style="background:#444; margin-bottom:0; margin-top:8px; cursor:pointer;">회원가입 완료</label>
      <label for="popup-close" style="background:#888; margin-bottom:0; margin-top:8px; cursor:pointer;">닫기</label>
    </form>
  </div>

  <!-- 푸터 -->
  <footer class="site-footer">
    <div class="footer-content">
      <span>Websever_B</span>
      <span>상명대 게임전공 웹서버개발</span>
    </div>
  </footer>
</body>