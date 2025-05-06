<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>replit</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>
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
    .hidden-toggle {
      display: none;
    }
    .form-popup {
      position: fixed;
      top: 60px;
      right: 20px;
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
  <!-- 로그인/회원가입 radio 버튼 -->
  <input type="radio" name="popup" id="popup-close" class="hidden-toggle" checked>
  <input type="radio" name="popup" id="popup-login" class="hidden-toggle">
  <input type="radio" name="popup" id="popup-signup" class="hidden-toggle">

  <!-- 상단 오른쪽 버튼 그룹 -->
  <div class="top-buttons">
    <a href="file:///c:/WebServer_BTeam/HTML/PickList.html" class="favorite-link">
      즐겨찾기 목록
    </a>
    <label for="popup-login" class="top-right-box">로그인/회원가입</label>
  </div>

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

  <!-- section-with-background 및 나머지 컨텐츠는 아래에 둡니다 -->
  <div class="section-with-background">
    <a href="file:///c%3A/WebServer_BTeam/HTML/test_information.html" style="text-decoration:none;">
      <div class="top-left-box" style="cursor:pointer; padding:0; background:transparent; box-shadow:none;">
        <img src="https://drive.google.com/thumbnail?id=1ZmRjZh33NOS-L9Anxc-DLavyhiOOIbgg&sz=w1000" style="height:120px; display:block;">
      </div>
    </a>
  </div>

  <!-- 푸터 -->
  <footer class="site-footer">
    <div class="footer-content">
      <span>Websever_B</span>
      <span>상명대 게임전공 웹서버개발</span>
    </div>
  </footer>
</body>
</html>