<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page session="true" %>
<%@ page import="java.io.*, java.time.*, java.util.*"%>

<%!
	public void writeLog(HttpServletRequest request, HttpSession session)
	{
		try 
		{
			// 로그 파일 : ex) /var/lib/tomcat8/webapps/ROOT/book/jsp/log.txt, /usr/local/tomcat/webapps/ROOT/book/jsp/log.txt
			final String logFileName = "/var/lib/tomcat10/webapps/ROOT/WebServer_BTeam/JSP/log.txt";	 
			BufferedWriter writer = new BufferedWriter( new FileWriter( logFileName, true ) );
			String searchValue = request.getParameter("searchValue");
			
			// 로그 데이터 출력	
			writer.append( "\nTime:\t" + LocalDate.now() + " " + LocalTime.now() 	// 접속 시간	
				+ "\tSessionID:\t" + session.getId()				// 접속 ID
				+ "\tUserID:\t" + (String)session.getAttribute("login") // 회원 ID
				+ "\tURI:\t" + request.getRequestURI()				// 현재 페이지 
				+ "\tPrevious:\t" + request.getHeader("referer") 		// 접속 경로(이전페이지)
				+ "\tBrowser:\t" + request.getHeader("User-Agent") 		// 접속 브라우저	
				+ "\tMessage:\t" + searchValue );
			
			writer.close();
		} 
		// 예외 처리
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
%>

<% String id = null; %>
<%
    // 호출 위치
    writeLog(request, session);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>야경명소</title>
  <style>
    body {
  		background-color:#f5f5f5;
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
    </style>
</head>
<body>
    <a href="Main.jsp" style="text-decoration:none;"> <!-- 로고(클릭시 메인 화면으로 이동) -->
      <div class="top-left-box" style="cursor:pointer; padding:0; background:transparent; box-shadow:none;">
        <img src="https://drive.google.com/thumbnail?id=1ZmRjZh33NOS-L9Anxc-DLavyhiOOIbgg&sz=w1000" style="height:120px; display:block;">
      </div>
    </a>

  <!-- 로그인/회원가입 radio 버튼 -->
  <input type="radio" name="popup" id="popup-close" class="hidden-toggle" checked>
  <input type="radio" name="popup" id="popup-login" class="hidden-toggle">
  <input type="radio" name="popup" id="popup-signup" class="hidden-toggle">

  <!-- 상단 오른쪽 버튼 그룹 -->
  <div class="top-buttons">
  <% if(session.getAttribute("login") != null) { %>
    <a href="PickListForm.jsp" class="favorite-link">
      즐겨찾기 목록
    </a>
  <% } %>
    <% if(session.getAttribute("login") == null) { %>
    <label for="popup-login" class="top-right-box">로그인/회원가입</label>
    <% }
    else { %>
    	<label for="popup-login" class="top-right-box"> <%= session.getAttribute("login") %> </label>
    <% } %>
  </div>

  <!-- 로그인 폼 -->
  <div class="form-popup login-form">
  	
  	<% if(session.getAttribute("login") == null) { %>
    <form autocomplete="off" action="LoginProcess.jsp" method="post">
      <label for="login-id">아이디</label>
      <input type="text" id="login-id" name="login-id" autocomplete="username">
      <label for="login-pw">비밀번호</label>
      <input type="password" id="login-pw" name="login-pw" autocomplete="current-password">
      <button type="submit">로그인</button>
      <label for="popup-signup" style="background:#444; margin-bottom:0; margin-top:8px; cursor:pointer;">회원가입</label>
      <label for="popup-close" style="background:#888; margin-bottom:0; margin-top:8px; cursor:pointer;">닫기</label>
    </form>
    <% }
  	else { %>
  	<form autocomplete="off" action="Logout.jsp" method="post">
      <button type="submit">로그아웃</button>
      <label for="popup-close" style="background:#888; margin-bottom:0; margin-top:8px; cursor:pointer;">닫기</label>
    </form>
  	<% } %>
  </div>

  <!-- 회원가입 폼 -->
  <div class="form-popup signup-form">
    <form autocomplete="off" action="RegisterProcess.jsp" method="post">
      <label for="signup-id">아이디</label>
      <input type="text" id="signup-id" name="signup-id" autocomplete="username">
      <label for="signup-pw">비밀번호</label>
      <input type="password" id="signup-pw" name="signup-pw" autocomplete="new-password">
      <label for="signup-pw-confirm">비밀번호 확인</label>
      <input type="password" id="signup-pw-confirm" name="signup-pw-confirm" autocomplete="new-password">
      <button type="submit" style="background:#444; margin-bottom:0; margin-top:8px; cursor:pointer;">회원가입</button>
      <label for="popup-close" style="background:#888; margin-bottom:0; margin-top:8px; cursor:pointer;">닫기</label>
    </form>
  </div>
</body>
</html>